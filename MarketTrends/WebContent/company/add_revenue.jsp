<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.myvariables.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
/*	HttpSession s = request.getSession();
	String str = s.getAttribute("login").toString();
	System.out.println(str);*/	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html" />
	<meta name="author" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="shortcut icon" href="../images/logo.jpg" />

	<title>MarketTrends | Add Revenue</title>
    <!-- Bootstrap files -->    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <!-- Custom CSS files -->
    <link rel="stylesheet" href="../css/menubar.css" type="text/css"/>
    <link rel="stylesheet" href="../css/carousel.css" type="text/css"/>
    <link rel="stylesheet" href="../css/style.css" type="text/css"/>
</head>

<body class="blurbody">

<!-- Menubar starts -->
<jsp:include page="company_menuBar.jsp"></jsp:include>
<!-- Menubar ends -->

<!-- revenue form starts -->


<div class="col-sm-12">
    <div class="col-sm-4"></div>
    
    <div class="col-sm-4 customerlogin center">
           <h2>Add Revenue</h2>
           <hr />
    		<p style="float:left; color:green;">
            <%
        		String msg = (String)request.getAttribute(Myvariables.comp_msg);
        		if(msg != null)
        		{
        			out.println("* "+msg);
        		}
        	%>
        	</p>
        	<br/>
          <form class="form-horizontal" role="form" method="post" action="revenue_check.jsp">
            
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" class="form-control" name="revenue" pattern="[0-9]*" title="1000" placeholder="Enter Revenue" required >
              </div>
            </div>
           
            <div class="form-group">        
              <div class="col-sm-offset-2 col-sm-8">
                <button type="submit" class="btn btn-primary">Submit</button>
              </div>
            </div>
           
          </form>
    </div>
</div>

<!-- revenue form ends -->


<!-- footer include starts -->

<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>