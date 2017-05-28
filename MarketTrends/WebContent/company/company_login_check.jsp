<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.bean.*" %>
<%@ page import="com.dao.CompanyDao" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.myvariables.*" %>
<%@page import="java.security.*" %>
<%@page import="java.math.*" %>

<%
	Company comp = new Company();
	
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
	
	comp.setEmail(email);
	comp.setPassword(pwd);
	
	
	
	ResultSet rs = CompanyDao.loginCheck(comp);
	
	if(rs.next())
	{
		session.setAttribute("comp_login",comp.getEmail());
		response.sendRedirect("company_dashboard.jsp");
	}
	else
	{
		request.setAttribute(Myvariables.cust_error,"Invalid Email id or Password");
		RequestDispatcher rd = request.getRequestDispatcher("company_login.jsp");
		rd.forward(request, response);
	}
	

%>
