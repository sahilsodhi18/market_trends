<%@page import="com.myvariables.Myvariables"%>
<%@page import="com.dao.CompanyDao"%>
<%@ page import="com.bean.*" %>
<%@ page import="java.security.*" %>
<%@ page import="java.math.*" %>

<%
	
	
		String email = request.getParameter("email");
		String address = request.getParameter("address");
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
       
		
		
		Company c = new Company();
		
		c.setAddress(address);
		c.setCity(city);
		c.setState(state);
		c.setCountry(country);
		c.setPincode(pincode);
		c.setPassword(pwd);
		c.setEmail(email);
		
		int eff = CompanyDao.updateProfile(c,oldpwd);
		
		if(eff>0)
		{
			request.setAttribute(Myvariables.comp_error,"Password Changed Successfuly");
			RequestDispatcher rd = request.getRequestDispatcher("company_login.jsp");
			rd.forward(request, response);
		}
		else
		{
			request.setAttribute(Myvariables.comp_error,"Old Password donot match");
			RequestDispatcher rd = request.getRequestDispatcher("company_profile.jsp");
			rd.forward(request, response);
		}
		
	
	

%>