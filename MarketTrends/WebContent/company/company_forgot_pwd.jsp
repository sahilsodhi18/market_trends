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

	<title>MarketTrends | Forgot Password</title>
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
<jsp:include page="company_menuBar.jsp"></jsp:include>

<!-- customer login form starts -->

<div class="col-sm-12">
    <div class="col-sm-4"></div>
    
    <div class="col-sm-4 customerlogin center">
           <h2>Forgot Password</h2>
           <hr />
           <p style="float:left; color:red;">
            <%
        		String msg = (String)request.getAttribute(Myvariables.comp_msg);
        		if(msg != null)
        		{
        			out.println("* "+msg);
        		}
        	%>
        	</p>
        	
        	<br/>
          <form class="form-horizontal" role="form" method="POST" action="comp_forgot_pwd_check" onsubmit="return check()">
            <div class="form-group">
              <div class="col-sm-12">
              	<label style="float:left;">Email address:</label>
                <input type="email" class="form-control" name="email" placeholder="Enter Email"  required>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
              	<label style="float:left;">Mobile No:</label>
                <input type="text" class="form-control" name="mobile" placeholder="Enter Mobile No"  required>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
              <label style="float:left;">New Password:</label>
                <input type="password" class="form-control" name="pwd" id="pwd" placeholder="Enter Password" required>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
              <label style="float:left;">Re-enter New Password:</label>
                <input type="password" class="form-control" name="repwd" id="repwd" placeholder="Re-enter Password" required>
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

<!--  form ends -->

<!-- footer include starts -->

<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>

<script type="text/javascript">

function check()
{
	var pwd = document.getElementById("pwd").value;
	var repwd = document.getElementById("repwd").value;

	if(pwd != repwd)
	{
		alert("Password donot match !!");
		return false;
	}
	
}

</script>