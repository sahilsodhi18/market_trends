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

	<title>MarketTrends | Company Sign Up</title>
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

<!-- company signup form starts -->

<div class="col-sm-12 center">
    
    <div class="col-sm-12">
        <div class="col-sm-2"></div>
        <div class="col-sm-8 whiteback pad">
            <h2>Company Signup</h2><hr />
            <p  style="float:left; color:red;">
            <%
        		String error = (String)request.getAttribute(Myvariables.comp_error);
        		if(error != null)
        		{
        			out.println("* "+error);
        		}
        	%>
        	</p>
        	<br/>
        	<br/>
        	</div>
        </div>
    
    <div class="col-sm-12">
        <div class="col-sm-2"></div>
        
        <div class="col-sm-4 whiteback">
            <form class="form-horizontal" role="form" action="company_signup_check.jsp" method="POST" onsubmit="return check()">
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" class="form-control" name="cname" id="cname" placeholder="Company Name" required pattern="^[a-zA-Z ]+$" title="Example : Mahindra">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" class="form-control" name="csymbol" id="csymbol" placeholder="Company Symbol" required pattern="^[a-z]{3}+$" title="Example : mhd">
              </div>
            </div>
            
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" required="required" name="doe" name="doe" class="form-control" pattern="[0-9]{4}" placeholder="Date of Establishment : YYYY" required title="Example : 1994"/>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <select name="ctype" id="ctype" class="form-control">
                    <option value="select" selected="selected">Select Company type</option>
                    <option value="Health Care">Health Care</option>
                    <option value="Automobile">Automobiles</option>
                    <option value="IT">I.T</option>
                    <option value="Other">Other</option>
                </select>
              </div>
            </div>
            
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" required="required" name="email" class="form-control" required placeholder="Email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" title="Example : info@mahindra.com"/>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" required="required" name="mobile" class="form-control" required placeholder="Mobile No" pattern="[789][0-9]{9}" title="Example : 8968581700"/>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <textarea name="cabout" placeholder="Write about company." maxlength="200" class="form-control" required></textarea>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" required="required" name="address" class="form-control" placeholder="Address" />
              </div>
            </div>
        </div>
        
        <div class="col-sm-4 form-horizontal whiteback">
             
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" class="form-control" name="city" id="city" placeholder="City" required pattern="^[a-zA-Z ]+$" title="Example : Jalandhar">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" class="form-control" name="state" id="state" placeholder="State" required pattern="^[a-zA-Z ]+$" title="Example : Punjab">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" class="form-control" name="country" id="country" placeholder="Country" required pattern="^[a-zA-Z]+$" title="Example : India">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" class="form-control" name="pincode" id="Pincode" placeholder="Pincode" required pattern="^[0-9]{6}+$" title="Example : 144003">
              </div>
            </div>
            
            <div class="form-group">
              <div class="col-sm-12">
                <input type="password" class="form-control"  name="password" id="pwd" placeholder="Password" required >
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="password" class="form-control" id="repwd" placeholder="Re-Enter Password" required >
              </div>
            </div>
            <div class="form-group">        
              <div class="col-sm-offset-2 col-sm-8" style="margin-top:20px;">
                <button type="submit" class="btn btn-primary">Signup</button>
              </div>
            </div>
            
          </form>
        </div>
    </div>
</div>


<!-- customer signup form ends -->

<!-- footer include starts -->

<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>

<script type="text/javascript">

function check()
{
	var ctype = document.getElementById('ctype').value;
	var pwd = document.getElementById('password').value;
	var repwd = document.getElementById('repwd').value;
	
	if(ctype=="select")
	{
		alert("Please select company type.");
		return false;
	}
	
	if(pwd != repwd)
	{
		alert("Password donot match");
		return false;
	}
	
	
	
	
	
}

</script>
