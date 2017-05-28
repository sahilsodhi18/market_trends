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
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html" />
	<meta name="author" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="shortcut icon" href="../images/logo.jpg" />

	<title>MarketTrends | Top Gainers</title>
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
           <h2><b>Top Gainers</b></h2>
           <hr />
        	<br/>
        	
       		<div class="col-sm-12">
       			
       				<%
       					String csymbol = "",perchange= "";
       					ArrayList<String> al = null;
       				
       				    al = SharesDao.topgainers(); // getting sum of per changes
       					int j=0;
       				    for(int i=0 ; i<al.size()/2 ; i++)
       				    {
       				    	csymbol = al.get(j);
       				    	j++;
       				    	perchange = al.get(j);
       				    	j++;
       							%>
       							<table class="table table-striped table-bordered" style="margin-top:10px;">
       								<tr>
       									<td><b>Company Symbol</b></td>
       									<td><b>Total Change</b></td>
       									<td><b>Share Rate</b></td>
       								</tr>
       								
       								<tr>
       									<td><%= csymbol %></td>
       									<td><%= perchange %></td>
       									<td><%= CompanyDao.getShareRate2(csymbol) %></td>
       								</tr>
       							</table>
       								
       							<%
       						 }
       				
       				%>
       			
       		</div> 	
        	
        	
        	
        	
      </div>
      
</div>




<!-- footer include starts -->

<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>