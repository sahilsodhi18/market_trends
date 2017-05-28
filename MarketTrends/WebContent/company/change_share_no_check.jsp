<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.utility.MyConnection"%>
<%@ page import="com.dao.CompanyDao"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.myvariables.*" %>
<%@ page import="java.text.DecimalFormat" %>


<%
	HttpSession s = request.getSession();
	String email = s.getAttribute("comp_login").toString();
	
	String sno = CompanyDao.getShareNo(email);
	
	String newno = request.getParameter("newno");	
	DecimalFormat no = new DecimalFormat("0");
	
	newno = no.format(Double.parseDouble(sno) + Double.parseDouble(newno));
	
	
	int eff = CompanyDao.changeShareNo(newno, email);
	
	if(eff>0)
	{
		request.setAttribute(Myvariables.comp_msg,"Shares Quantity Changed Successfully.");
		RequestDispatcher rd = request.getRequestDispatcher("change_share_no.jsp");
		rd.forward(request, response);
	}


%>    