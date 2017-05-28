package com.service.company;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.CompanyDao;
import com.dao.CustomerDao;
import com.dao.SharesDao;
import com.mysql.*;
import com.myvariables.Myvariables;

/**
 * Servlet implementation class give_dividend_check
 */
public class give_dividend_check extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public give_dividend_check() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession s = request.getSession();
		String str = s.getAttribute("comp_login").toString();
		if(str.equals(""))
		{
			response.sendRedirect("company_login.jsp");
		}
		
		String credit = "0",debit = "0";
		
		credit = CompanyDao.getcreditmoney(str);
		debit = CompanyDao.getdebitmoney(str);
		String amt = "";
			
		if(credit == null)
			credit = "0";
		if(debit == null)
			debit = "0";
		
		double a = Double.parseDouble(credit);
		double b = Double.parseDouble(debit);
		
		double c = a - b; //calculates difference 
		
		if(c> 0)
		{
			amt = String.valueOf(c);
		}
		else
		{
			amt = "0";
		}
		
		String dividend_amt = request.getParameter("amt"); //gets divident_amt 
		double d_amt = Double.parseDouble(dividend_amt);
		
		DecimalFormat ft = new DecimalFormat("0.00");
		d_amt = Double.parseDouble(ft.format(d_amt));

		if(d_amt > c)
		{
			request.setAttribute(Myvariables.comp_msg,"Wallet amount less than dividend amount !!");
			RequestDispatcher rd = request.getRequestDispatcher("company_wallet.jsp");
			rd.forward(request, response);
		}
		else
		{
			String csymbol = CompanyDao.getCsymbol(str); //finding csymbol
		
			int t_comp_shares = SharesDao.companyTotalShares(csymbol); //sum of all company shares
			
			if(t_comp_shares <=0)
			{
				request.setAttribute(Myvariables.comp_msg,"No share holders found !!");
				RequestDispatcher rd = request.getRequestDispatcher("give_dividend.jsp");
				rd.forward(request, response);
			}
			
			
			ResultSet rs = SharesDao.custTotalShares(csymbol); //sum of shares owned by customers
			
			int t_cust_shares = 0;
			
			try {
				while(rs.next())
				{
					t_cust_shares = Integer.parseInt(rs.getString("no"));
					String custemail = rs.getString("custemail"); 
					
					double per = (double)t_cust_shares/t_comp_shares; //calculates %age of shares per person
					per = Double.parseDouble(ft.format(per));
					
					double cust_d_amt = per * d_amt;
					
					CustomerDao.addmoney(custemail, String.valueOf(cust_d_amt),"credit"); //credit to customerwallet
					
				}
				CompanyDao.addmoney(str,String.valueOf(d_amt),"debit"); //debit from company wallet
				
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			request.setAttribute(Myvariables.comp_msg,"Successfully distributed dividend amount !!");
			RequestDispatcher rd = request.getRequestDispatcher("give_dividend.jsp");
			rd.forward(request, response);
			
		}

		
	}

}
