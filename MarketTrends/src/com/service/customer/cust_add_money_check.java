package com.service.customer;

import java.io.IOException;
import java.text.DecimalFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.CompanyDao;
import com.dao.CustomerDao;
import com.myvariables.Myvariables;
import com.utility.Validations;

/**
 * Servlet implementation class add_money_check
 */
public class cust_add_money_check extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public cust_add_money_check() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
		String button = request.getParameter("button");

		if(button.equals("add"))
		{
			HttpSession s = request.getSession();
			String email = s.getAttribute("cust_login").toString();
			
			String amt = request.getParameter("amt");
			
			DecimalFormat ft = new DecimalFormat("0.00");
			
			if(Double.parseDouble(amt) > 0)
			{
				CustomerDao.addmoney(email, ft.format(Double.parseDouble(amt)),"credit");
				
				request.setAttribute(Myvariables.cust_msg,"Money Added Successfully !!");
				RequestDispatcher rd = request.getRequestDispatcher("customer_wallet.jsp");
				rd.forward(request, response);
			}
			else
			{
				request.setAttribute(Myvariables.cust_msg,"Amount should be greater than ZERO");
				RequestDispatcher rd = request.getRequestDispatcher("customer_wallet.jsp");
				rd.forward(request, response);	
			}
			
		}

			}
}
