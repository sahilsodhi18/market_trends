package com.service.customer;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bean.Shares;
import com.dao.CustomerDao;
import com.dao.SharesDao;
import com.myvariables.Myvariables;

/**
 * Servlet implementation class cust_buy_shares_form2_check
 */
public class cust_buy_shares_form2_check extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public cust_buy_shares_form2_check() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String button = request.getParameter("button");
		
		HttpSession s = request.getSession();
		String email = s.getAttribute("cust_login").toString();
		
		String id = request.getParameter("id");
		String csymbol = request.getParameter("csymbol");
		String srate = request.getParameter("srate");
		String no = request.getParameter("noofshares");
		double tv = (Double.parseDouble(srate) * Double.parseDouble(no));
		String tvalue = String.valueOf(tv);
		String sleft = request.getParameter("sleft");
		Date tdate = new Date();
		SimpleDateFormat ft = new SimpleDateFormat("dd/MM/yyy");
		
		String selleremail = request.getParameter("cemail");
		
		if((Integer.parseInt(no) > Integer.parseInt(sleft)) || Integer.parseInt(no) == 0  )
		{
			Myvariables.cust_msg="No of shares cannot be greater than shares left";
			response.sendRedirect("buy_shares.jsp");
		}
		else if(button.equals("buynow"))
		{
			Shares sh = new Shares();
			
			sh.setCustemail(email);
			sh.setCsymbol(csymbol);
			sh.setSrate(srate);
			sh.setNoofshares(no);
			sh.setTvalue(tvalue);
			sh.setTdate(ft.format(tdate));
			sh.setStatus("buy");
			
			int newno = Integer.parseInt(sleft) - Integer.parseInt(no);
			
			String credit = CustomerDao.getcreditmoney(email);
			String debit = CustomerDao.getdebitmoney(email);
			String amt = "";
			
			double a = Double.parseDouble(credit);
			double b = Double.parseDouble(debit);
			
			double c = a - b;
			
			double val = Double.parseDouble(String.valueOf(newno)) * Double.parseDouble(srate);
			System.out.println(val);
			if(c>=Double.parseDouble(tvalue))
			{
				SharesDao.updateSellerSharesNo(id,String.valueOf(newno),String.valueOf(val));
				
				int eff = SharesDao.insert(sh);
			
				CustomerDao.addmoney(email,tvalue,"debit");
				
				CustomerDao.addmoney(selleremail,tvalue,"credit");
				
				request.setAttribute(Myvariables.cust_msg,"Shares Bought Successfully !!");
				RequestDispatcher rd = request.getRequestDispatcher("buy_shares.jsp");
				rd.forward(request, response);
								
			}
			else
			{
				request.setAttribute(Myvariables.cust_msg,"Not Enough money in wallet.");
				RequestDispatcher rd = request.getRequestDispatcher("buy_shares.jsp");
				rd.forward(request, response);
			}
			
			
			
		}
		

		
	}

}
