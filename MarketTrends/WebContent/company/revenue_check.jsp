<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.utility.MyConnection"%>
<%@ page import="com.dao.CompanyDao"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.myvariables.*" %>

<jsp:useBean id="r" class="com.bean.CompanyRevenue"></jsp:useBean>
<jsp:setProperty property="*" name="r"/>

<%
	HttpSession s = request.getSession();
	String email = s.getAttribute("comp_login").toString();
	if(email.equals(""))
	{
		response.sendRedirect("company_login.jsp");
	}

	CompanyDao.add_revenue(r, email);
	
	request.setAttribute(Myvariables.comp_msg,"Revenue details added successfully");
	RequestDispatcher rd = request.getRequestDispatcher("add_revenue.jsp");
	rd.forward(request, response);	
%>