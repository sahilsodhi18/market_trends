package com.service.customer;

import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bean.Customer;
import com.dao.CustomerDao;
import com.myvariables.Myvariables;

/**
 * Servlet implementation class customer_login_check
 */
public class customer_login_check extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public customer_login_check() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Customer cust = new Customer();
		
		String email = request.getParameter("email");
		String pwd = request.getParameter("pwd");
		
		MessageDigest m = null;
		try {
			m = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        m.update(pwd.getBytes(),0,pwd.length());
        pwd = new BigInteger(1,m.digest()).toString(16);
		
        cust.setPassword(pwd);
		cust.setEmail(email);
		
		ResultSet rs = CustomerDao.loginCheck(cust);
		
			try {
				if(rs.next())
				{
					
					ServletRequest session = null;
					session .setAttribute("cust_login",cust.getEmail());
					response.sendRedirect("customer_dashboard.jsp");
					
				}
				else
				{
					request.setAttribute(Myvariables.cust_error,"Invalid Email id or Password");
					RequestDispatcher rd = request.getRequestDispatcher("customer_login.jsp");
					rd.forward(request, response);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		

	}

}
