<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.myvariables.*" %>
<%@ page import="com.bean.*" %>
<%@ page import="com.dao.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
	HttpSession s = request.getSession();
	String email = s.getAttribute("cust_login").toString();
	if(email.equals(""))
	{
		response.sendRedirect("customer_login.jsp");
	}
		
	ResultSet rs = SharesDao.getAllCustPendingShares(email);
	int n=1;
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html" />
	<meta name="author" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="shortcut icon" href="../images/logo.jpg" />

	<title>MarketTrends | Pending Shares</title>
    <!-- Bootstrap files -->    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <!-- Custom CSS files -->
    <link rel="stylesheet" href="../css/style.css" type="text/css"/>
    <link rel="stylesheet" href="../css/menubar.css" type="text/css"/>
    <link rel="stylesheet" href="../css/carousel.css" type="text/css"/>
</head>

<body class="blurbody">

<!-- menubar include starts -->
<jsp:include page="customer_menuBar.jsp"></jsp:include>

<!-- content starts -->

<div class="col-sm-12">
    <div class="col-sm-2"></div>
    
    <div class="col-sm-8 customerlogin center">
           <h2><b>Pending Shares</b></h2>
           <hr />
        	<br/>
        	
       		<div class="col-sm-12">
       				<table class="table table-striped table-bordered" style="margin-top:10px;">
       								<tr>
       									<td><b>S.No</b></td>
       									<td><b>Company Symbol</b></td>
       									<td><b>Lower Rate</b></td>
       									<td><b>Upper Rate</b></td>
       									<td><b>No of shares</b></td>
       									<td><b>Total Value</b></td>
       									<td><b>Date</b></td>
       								</tr>
       						
				       				<%
				    					while(rs.next())
				    					{
				    				%>
				    				<tr>
				    					<td><%=n %></td>
				    					<td><%=rs.getString("csymbol") %></td>
				    					<td><%=rs.getString("lrate") %></td>
				    					<td><%=rs.getString("rrate") %></td>
				    					<td><%=rs.getString("noofshares") %></td>
				    					<td><%=rs.getString("tvalue") %></td>
				    					<td><%=rs.getString("tdate") %></td>
				    				</tr>		
				    				
				    				<% 		
				    				n++;
				    					}
				       				
				       				%>
       				</table>
       		</div> 	
        	
        	
        	
        	
      </div>
      
</div>




<!-- footer include starts -->

<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>