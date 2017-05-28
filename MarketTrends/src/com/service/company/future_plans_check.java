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
 * Servlet implementation class future_plans_check
 */
public class future_plans_check extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public future_plans_check() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession s = request.getSession();
		String email = s.getAttribute("comp_login").toString();
		if(email.equals(""))
		{
			response.sendRedirect("company_login.jsp");
		}
		
		CompanyDao.add_future_plans((String)request.getParameter("fplans"), email);
		
		request.setAttribute(Myvariables.comp_msg,"Future Plans detail added successfully");
		RequestDispatcher rd = request.getRequestDispatcher("add_future_plans.jsp");
		rd.forward(request, response);
		
	}

}
