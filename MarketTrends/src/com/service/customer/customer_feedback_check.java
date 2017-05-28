package com.service.customer;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.CustomerDao;
import com.myvariables.Myvariables;

/**
 * Servlet implementation class customer_feedback_check
 */
public class customer_feedback_check extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public customer_feedback_check() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		

		HttpSession s = request.getSession();
		String semail = s.getAttribute("cust_login").toString();
		
		String remail = request.getParameter("remail");
		String feedback = request.getParameter("feedback");
		
		int eff = CustomerDao.add_feedback(semail,remail,feedback);
		
		if(eff>0)
		{
			request.setAttribute(Myvariables.cust_msg,"Feedback sent successfully");
			RequestDispatcher rd = request.getRequestDispatcher("customer_feedback.jsp");
			rd.forward(request, response);	
		}
		else
		{
			request.setAttribute(Myvariables.cust_msg,"Error");
			RequestDispatcher rd = request.getRequestDispatcher("customer_feedback.jsp");
			rd.forward(request, response);
			
		}
		
		
		
	}

}
