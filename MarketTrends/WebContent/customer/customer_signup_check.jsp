<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.dao.CustomerDao"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.myvariables.*" %>
<%@page import="java.security.*" %>
<%@page import="java.math.*" %>
<%@page import="com.utility.*" %>

<jsp:useBean id="cust" class="com.bean.Customer"></jsp:useBean>
<jsp:setProperty property="*" name="cust"/>

<%
	String error = null;

	String email = cust.getEmail();
	String mobile = cust.getMobile();
	
	ResultSet rs1 = CustomerDao.mobileValidate(mobile);
	ResultSet rs2 = CustomerDao.mobileValidate(email);
	
	if(!Validations.isEmpty(cust.getFname()) || !Validations.isEmpty(cust.getLname()) || !Validations.isEmpty(cust.getGender()) ||
			!Validations.isEmpty(cust.getDob()) || !Validations.isEmpty(cust.getOccupation()) || !Validations.isEmpty(cust.getIncome()) ||
			!Validations.isEmpty(cust.getEmail()) || !Validations.isEmpty(cust.getMobile()) || !Validations.isEmpty(cust.getCity()) || 
			!Validations.isEmpty(cust.getState()) || !Validations.isEmpty(cust.getCountry()) || !Validations.isEmpty(cust.getPincode()))
	{
		error = "All Fields are mandatory !!";
		
	}
	else if(!Validations.isAlphabet(cust.getFname()))
	{
		error = "First Name should only have alphabets.";		
	}
	else if(!Validations.isAlphabet(cust.getLname()))
	{
		error = error+"\n"+"Last Name should only alphabets.";
	}
	else if(!Validations.isMobile(cust.getMobile()))
	{
		error = error+"\n"+"Mobile No should have 10 digits.";
	}
	else if(!Validations.isEmail(cust.getEmail()))
	{
		error = error+"\n"+"Email should be in correct format.";
	}
	else if(!Validations.isAlphabet(cust.getCity()))
	{
		error = error+"\n"+"City should only have alphabets.";
	}
	else if(!Validations.isAlphabet(cust.getState()))
	{
		error = error+"\n"+"State should only have alphabets.";
	}
	else if(!Validations.isAlphabet(cust.getCountry()))
	{
		error = error+"\n"+"Country should only have alphabets.";
	}
	else if(!Validations.isPincode(cust.getPincode()))
	{
		error = "Pincode should have 6 digits.";
	}
	
	if(rs1.next())
	{
		request.setAttribute(Myvariables.cust_error,"Mobile No already registered.");
		RequestDispatcher rd = request.getRequestDispatcher("customer_signup.jsp");
		rd.forward(request, response);
	}
	else if(rs2.next())
	{
		request.setAttribute(Myvariables.cust_error,"Email id already registered.");
		RequestDispatcher rd = request.getRequestDispatcher("customer_signup.jsp");
		rd.forward(request, response);
	}
	else
	{
		String pwd = "";
		
		pwd = cust.getPassword(); //encrypt password 
		
		MessageDigest m=MessageDigest.getInstance("MD5");
        m.update(pwd.getBytes(),0,pwd.length());
        pwd = new BigInteger(1,m.digest()).toString(16);
		
        cust.setPassword(pwd);
		
		CustomerDao.insert(cust); //insert into database
		request.setAttribute(Myvariables.cust_error,"Successfully Registered !!");
		RequestDispatcher rd = request.getRequestDispatcher("customer_login.jsp");
		rd.forward(request, response);
		
	}
	
%>