package com.service.company;

import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.CompanyDao;
import com.dao.CustomerDao;
import com.myvariables.Myvariables;

/**
 * Servlet implementation class comp_forgot_pwd_check
 */
public class comp_forgot_pwd_check extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public comp_forgot_pwd_check() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String mobile = request.getParameter("mobile");
		String pwd = request.getParameter("pwd");
		
		MessageDigest m = null;
		try {
			m = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        m.update(pwd.getBytes(),0,pwd.length());
        pwd = new BigInteger(1,m.digest()).toString(16);
        
        int eff = CompanyDao.updatePassword(email, mobile, pwd);
        
        if(eff>0)
        {
            
        	request.setAttribute(Myvariables.comp_error,"Password changed successfully !!");
			RequestDispatcher rd = request.getRequestDispatcher("company_login.jsp");
			rd.forward(request, response);
        }
        else
        {
        	request.setAttribute(Myvariables.comp_msg,"Wrong Email or Mobile No !!");
			RequestDispatcher rd = request.getRequestDispatcher("company_forgot_pwd.jsp");
			rd.forward(request, response);
        }

	}

}
