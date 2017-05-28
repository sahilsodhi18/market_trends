<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.utility.MyConnection"%>
<%@ page import="com.dao.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.bean.*" %>
<%@ page import="com.myvariables.*" %>

<jsp:useBean id="fp" class="com.bean.CompanyFuturePlans"></jsp:useBean>
<jsp:setProperty property="*" name="fp"/>

<%
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
%>