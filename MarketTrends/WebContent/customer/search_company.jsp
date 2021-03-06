<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.myvariables.*" %>
<%@ page import="com.bean.*" %>
<%@ page import="com.dao.*" %>
<%@ page import="java.sql.*" %>

<%
	String str="";
	HttpSession s = request.getSession();
	str = s.getAttribute("cust_login").toString();
	if(str.equals(""))
	{
		response.sendRedirect("customer_login.jsp");
	}
	ResultSet rs = CompanyDao.getAllDetails();

%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html" />
	<meta name="author" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="shortcut icon" href="../images/logo.jpg" />

	<title>MarketTrends | Search Company</title>
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

<!--  select company form starts -->

<div class="col-sm-12">
    <div class="col-sm-4"></div>
    
    <div class="col-sm-4 customerlogin center">
           <h2>Search Company</h2>
           <hr />
           <p style="float:left; color:red;">
            <%
        		String msg = (String)request.getAttribute(Myvariables.cust_msg);
        		if(msg != null)
        		{
        			out.println("* "+msg);
        		}
        	%>
        	</p>
        	<br/>
          <form class="form-horizontal" role="form" method="POST" action="search_company_dashboard.jsp" onsubmit="return check()">
            <div class="form-group">
              <div class="col-sm-12">
              	<label style="float:left;">Select Company:</label>
                <select name="csymbol" id="csymbol" class="form-control">
                	<option value="select">Choose Company</option>
                	<%
                		while(rs.next())
                		{
                			String cs = rs.getString("csymbol");
                			String cn = rs.getString("cname");
                	%>
                	<option value="<%=cs%>"><%=cs+" - "+cn%></option>
                	<% 		
                		}
                	
                	%>
                </select>
              </div>
            </div>
            <div class="form-group">        
              <div class="col-sm-12">
                
              </div>
            </div>
            <div class="form-group">        
              <div class="col-sm-offset-2 col-sm-8">
                <button type="submit" class="btn btn-primary">Search</button>
              </div>
            </div>
            
          </form>
    </div>
</div>

<!-- select company form ends -->


<!-- footer include starts -->

<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>

<script type="text/javascript">

function check()
{
	var v = document.getElementById("csymbol").value;
	
	if(v == 'select')
	{
		alert("Please Select a company");
		return false;
	}
}


</script>