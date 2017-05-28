package com.service.company;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bean.Company;
import com.bean.Shares;
import com.dao.CompanyDao;
import com.dao.CustomerDao;
import com.dao.SharesDao;
import com.mysql.*;
import com.myvariables.Myvariables;

/**
 * Servlet implementation class change_share_rate_check
 */
public class change_share_rate_check extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public change_share_rate_check() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession s = request.getSession();
		String email = s.getAttribute("comp_login").toString();
		Company c = new Company();
		Shares sh = new Shares();
		
		
		String newprice = request.getParameter("newprice");
		c = CompanyDao.getDetails(email); // getting Cysmbol
		String csymbol = c.getCsymbol();
		
		String cprice = request.getParameter("cprice");
		String perchange  = "";
		Double np = Double.parseDouble(newprice);
		Double cp = Double.parseDouble(cprice);
		
		DecimalFormat price = new DecimalFormat("0.00");
		newprice = price.format(Double.parseDouble(newprice));
		
		int eff = CompanyDao.changeShareRate(newprice, email); //update share price
		
		Date tdate = new Date();
		SimpleDateFormat ft = new SimpleDateFormat("dd/MM/yyy");
		
		perchange = String.valueOf(((np-cp)/cp)*100); 
		
		if(cp == 0)
		{
			perchange = "0";
		}	
		
		perchange = price.format(Double.parseDouble(perchange));
		
		
		//inserting into shareratedetails
		int effrows = SharesDao.shareratedetails(csymbol, newprice, perchange,String.valueOf(ft.format(tdate)));
		
		if(eff>0)
		{	
			
			c = CompanyDao.getDetails(email);
			csymbol = c.getCsymbol();
			
			ResultSet rs = SharesDao.getAllPendingShares(csymbol);
			
			String lrate="",rrate="";
			int sno = 0;
			
			try {
				while(rs.next())
				{
					sno = rs.getInt("sno");
					lrate = rs.getString("lrate");
					rrate = rs.getString("rrate");
					
					if((Double.parseDouble(lrate) <= Double.parseDouble(newprice)) && (Double.parseDouble(rrate) >= Double.parseDouble(newprice)))
					{
						sh.setCustemail(rs.getString("custemail"));
						sh.setCsymbol(rs.getString("csymbol"));
						sh.setSrate(newprice);
						sh.setNoofshares(rs.getString("noofshares"));
						
						double val = Double.parseDouble(sh.getSrate()) * Double.parseDouble(sh.getNoofshares());
						
						val = Double.parseDouble(price.format(val));
						
						sh.setTvalue(String.valueOf(val));
						
						sh.setTdate(ft.format(tdate));
						sh.setStatus("buy");
						
						String credit = CustomerDao.getcreditmoney(sh.getCustemail()); // calculate wallet balance
						String debit = CustomerDao.getdebitmoney(sh.getCustemail());
						String amt = "";

						
						if(credit == null)
							credit="0";	
						if(debit == null)
							debit="0";	
						
						double a = Double.parseDouble(credit);
						double b = Double.parseDouble(debit);
						double w = a - b;
						
						
						if(w >= val) // check value of wallet
						{
							String no = CompanyDao.getShareNo2(csymbol); //gets shares count
							
							if(Integer.parseInt(no) > 0)
							{
								int ef = SharesDao.insert(sh); // insert into livemarket
								
								CustomerDao.addmoney(sh.getCustemail(),String.valueOf(val),"debit");
								
								CompanyDao.addmoney(email,String.valueOf(val),"credit");
							}
							else
							{
								int effrows1 = SharesDao.deletePendingShares(sno); // delete from pendingmarket
								
								request.setAttribute(Myvariables.comp_msg,"Not Enough shares left !!");
								RequestDispatcher rd = request.getRequestDispatcher("change_share_rate.jsp");
								rd.forward(request, response);
								
							}
							
							int effrows2 = SharesDao.deletePendingShares(sno); // delete from pendingmarket
							
						}
						
					}
					
					
				}
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			request.setAttribute(Myvariables.comp_msg,"Share Price Changed Successfully.");
			RequestDispatcher rd = request.getRequestDispatcher("change_share_rate.jsp");
			rd.forward(request, response);
		}
		else
		{
			request.setAttribute(Myvariables.comp_msg,"Share Price Changed Successfully");
			RequestDispatcher rd = request.getRequestDispatcher("change_share_rate.jsp");
			rd.forward(request, response);
		}
		
	}

}
