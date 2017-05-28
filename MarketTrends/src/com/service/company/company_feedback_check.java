package com.service.company;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.CompanyDao;
import com.myvariables.Myvariables;

/**
 * Servlet implementation class company_feedback_check
 */
public class company_feedback_check extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public company_feedback_check() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession s = request.getSession();
		String semail = s.getAttribute("comp_login").toString();
		
		String remail = request.getParameter("remail");
		String feedback = request.getParameter("feedback");
		
		int eff = CompanyDao.add_feedback(semail,remail,feedback);
		
		if(eff>0)
		{
			request.setAttribute(Myvariables.comp_msg,"Feedback sent successfully");
			RequestDispatcher rd = request.getRequestDispatcher("company_feedback.jsp");
			rd.forward(request, response);	
		}
		else
		{
			request.setAttribute(Myvariables.comp_msg,"Error");
			RequestDispatcher rd = request.getRequestDispatcher("company_feedback.jsp");
			rd.forward(request, response);
			
		}
		
		
	}

}
