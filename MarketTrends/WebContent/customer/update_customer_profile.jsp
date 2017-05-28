<%@page import="com.myvariables.Myvariables"%>
<%@page import="com.dao.CustomerDao"%>
<%@ page import="com.bean.*" %>
<%@ page import="java.security.*" %>
<%@ page import="java.math.*" %>
<%@ page import="com.utility.*" %>

<%
		String error=null;
		String email = request.getParameter("email");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String country = request.getParameter("country");
		String pincode = request.getParameter("pincode");
		String pwd = request.getParameter("pwd");
		String oldpwd = request.getParameter("oldpwd");
		 
		MessageDigest m=MessageDigest.getInstance("MD5");
        m.update(pwd.getBytes(),0,pwd.length());
        pwd = new BigInteger(1,m.digest()).toString(16);
		
        m.update(oldpwd.getBytes(),0,oldpwd.length());
        oldpwd = new BigInteger(1,m.digest()).toString(16);
             
		Customer c = new Customer();
	
		c.setCity(city);
		c.setState(state);
		c.setCountry(country);
		c.setPincode(pincode);
		c.setPassword(pwd);
		c.setEmail(email);
		/*
		if(!Validations.isAlphabet(city))
		{
			error = "City should only have alphabet.";
		}
		else if(!Validations.isAlphabet(state))
		{
			error = error+"\n"+"State should only have alphabet.";
		}
		else if(!Validations.isAlphabet(country))
		{
			error = error+"\n"+"Country should only have alphabet.";
		}
		*/
		int eff = CustomerDao.updateProfile(c, oldpwd); //update profile
		
	
		if(eff>0)
		{
			request.setAttribute(Myvariables.comp_error,"Password changed successfully !!");
			RequestDispatcher rd = request.getRequestDispatcher("customer_login.jsp");
			rd.forward(request, response);
		}
		else
		{
			request.setAttribute(Myvariables.comp_error,"Old Password donot match");
			RequestDispatcher rd = request.getRequestDispatcher("customer_profile.jsp");
			rd.forward(request, response);
		}
%>