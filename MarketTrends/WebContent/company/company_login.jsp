<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.myvariables.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html" />
	<meta name="author" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="shortcut icon" href="../images/logo.jpg" />

	<title>MarketTrends | Company Login</title>
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

<!-- menubar include starts -->
<jsp:include page="blank_menuBar.jsp"></jsp:include>

<!-- company login form starts -->

<div class="col-sm-12">
    <div class="col-sm-4"></div>
    
    <div class="col-sm-4 customerlogin center">
           <h2>Company Login</h2>
           <hr />
            <p style="float:left; color:red;">
            <%
        		String error = (String)request.getAttribute(Myvariables.comp_error);
        		if(error != null)
        		{
        			out.println("* "+error);
        		}
        	%>
        	</p>
        	<br/>
          <form class="form-horizontal" role="form" method="post" action="company_login_check.jsp">
            
            <div class="form-group">
              <div class="col-sm-12">
                <input type="email" class="form-control" name="email" id="email" placeholder="Enter Email" required >
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="password" class="form-control" name="pwd" id="pwd" placeholder="Enter Password" required  title="">
              </div>
            </div>
            <div class="form-group">        
              <div class="col-sm-offset-2 col-sm-8">
                <button type="submit" class="btn btn-primary">Login</button>
              </div>
            </div>
            <div class="form-group">        
              <div class="col-sm-12">
                <a href="company_forgot_pwd.jsp" style="float:left;"><u>Forgot Password ?</u></a>
              </div>
            </div>
          </form>
    </div>
</div>

<!-- company login form ends -->

<!-- footer include starts -->

<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>