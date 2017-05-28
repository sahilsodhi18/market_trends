package com.service.company;

import java.io.IOException;
import java.text.DecimalFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.CompanyDao;
import com.myvariables.Myvariables;

/**
 * Servlet implementation class change_share_no_check
 */
public class change_share_no_check extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public change_share_no_check() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession s = request.getSession();
		String email = s.getAttribute("comp_login").toString();
		
		String sno = CompanyDao.getShareNo(email);
		
		String newno = request.getParameter("newno");	
		DecimalFormat no = new DecimalFormat("0");
		
		newno = no.format(Double.parseDouble(sno) + Double.parseDouble(newno));
		
		
		int eff = CompanyDao.changeShareNo(newno, email);
		System.out.println(newno+email);
		if(eff>0)
		{
			request.setAttribute(Myvariables.comp_msg,"Shares Quantity Changed Successfully.");
			RequestDispatcher rd = request.getRequestDispatcher("change_share_no.jsp");
			rd.forward(request, response);
		}

		
	}

}
