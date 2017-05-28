<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.utility.MyConnection"%>
<%@ page import="com.dao.CompanyDao"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.myvariables.*" %>
<%@ page import="java.math.*" %>
<%@ page import="java.security.*" %>
<%@ page import="com.utility.*" %>

<jsp:useBean id="comp" class="com.bean.Company"></jsp:useBean>
<jsp:setProperty property="*" name="comp"/>

<%
	String error = "";
	ResultSet rs1 = CompanyDao.csymbolValidate(comp.getCsymbol());
	ResultSet rs2 = CompanyDao.mobileValidate(comp.getMobile());
	ResultSet rs3 = CompanyDao.emailValidate(comp.getEmail());
	
	if(!Validations.isEmpty(comp.getCname()) || !Validations.isEmpty(comp.getCsymbol()) || !Validations.isEmpty(comp.getDoe()) ||
			!Validations.isEmpty(comp.getEmail()) || !Validations.isEmpty(comp.getMobile()) || !Validations.isEmpty(comp.getCabout()) ||	
			!Validations.isEmpty(comp.getAddress()) || !Validations.isEmpty(comp.getCity()) || !Validations.isEmpty(comp.getState()) ||
			!Validations.isEmpty(comp.getCountry()) || !Validations.isEmpty(comp.getPincode()))
	{
		error = "All Fields are mandatory !!";
	}
	else if(Validations.isAlphabet(comp.getCname()))
	{
		error = "Name should only have alphabets";
	}
	else if(Validations.isAlphabet(comp.getCsymbol()))
	{
		error = "Symbol should only have alphabets";
	}
	else if(Validations.isAlphabet(comp.getDoe()))
	{
		error = "Date of Establishment should be in correct format";
	}
	else if(Validations.isEmail(comp.getEmail()))
	{
		error = "Email should be in correct format";
	}
	else if(Validations.isMobile(comp.getMobile()))
	{
		error = "Mobile No should only have digits";
	}
	else if(Validations.isAlphabet(comp.getCity()))
	{
		error = "City should only have alphabets";
	}
	else if(Validations.isAlphabet(comp.getState()))
	{
		error = "State should only have alphabets";
	}
	else if(Validations.isAlphabet(comp.getCountry()))
	{
		error = "Country should only have alphabets";
	}
	else if(Validations.isPincode(comp.getPincode()))
	{
		error = "Pincode should be in correct format.";
	}
	
	if(rs1.next())
	{
		request.setAttribute(Myvariables.comp_error,"Company Symbol already registered.");
		RequestDispatcher rd = request.getRequestDispatcher("company_signup.jsp");
		rd.forward(request, response);
	}
	else if(rs2.next())
	{
		request.setAttribute(Myvariables.comp_error,"Mobile No already registered.");
		RequestDispatcher rd = request.getRequestDispatcher("company_signup.jsp");
		rd.forward(request, response);
	}
	else if(rs3.next())
	{
		request.setAttribute(Myvariables.comp_error,"Email already registered.");
		RequestDispatcher rd = request.getRequestDispatcher("company_signup.jsp");
		rd.forward(request, response);
	}
	else
	{
		String pwd = "";
		
		pwd = comp.getPassword(); //encrypt password 
		
		MessageDigest m=MessageDigest.getInstance("MD5");
        m.update(pwd.getBytes(),0,pwd.length());
        pwd = new BigInteger(1,m.digest()).toString(16);
		
        comp.setPassword(pwd);
	
		CompanyDao.insert(comp); //insert into companymaster
		
		request.setAttribute(Myvariables.comp_error,"Registered Successfully !!");
		RequestDispatcher rd = request.getRequestDispatcher("company_login.jsp");
		rd.forward(request, response);	
	}


%>    