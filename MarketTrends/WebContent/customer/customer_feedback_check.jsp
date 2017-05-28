<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="com.myvariables.*" %>
<%@ page import="com.dao.CustomerDao" %>

<%

	HttpSession s = request.getSession();
	String semail = s.getAttribute("comp_login").toString();
	
	String remail = request.getParameter("remail");
	String feedback = request.getParameter("feedback");
	
	int eff = CustomerDao.add_feedback(semail,remail,feedback);
	
	if(eff>0)
	{
		request.setAttribute(Myvariables.cust_msg,"Feedback sent successfully");
		RequestDispatcher rd = request.getRequestDispatcher("customer_feedback.jsp");
		rd.forward(request, response);	
	}
	else
	{
		request.setAttribute(Myvariables.cust_msg,"Error");
		RequestDispatcher rd = request.getRequestDispatcher("customer_feedback.jsp");
		rd.forward(request, response);
		
	}
	
%>