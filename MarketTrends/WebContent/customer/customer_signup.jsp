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

	<title>MarketTrends | Customer Sign Up</title>
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

<!-- customer signup form starts -->

<div class="col-sm-12 center" >
    
    <div class="col-sm-12">
        <div class="col-sm-2"></div>
        <div class="col-sm-8 whiteback">
            <h2>Customer Signup</h2><hr />
            <p style="float:left; color:red;">
            <%
        		String error = (String)request.getAttribute(Myvariables.cust_error);
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
        	
        
            <form class="form-horizontal" role="form" nonvalidate action="customer_signup_check.jsp" method="POST" onsubmit="return validate()">
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" class="form-control" name="fname" id="fname" placeholder="First Name" required pattern="^[a-zA-Z]+$" title="Example : Sahil">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" class="form-control"  name ="lname" id="lname" placeholder="Last Name" required pattern="[a-zA-Z]+" title="Example : Sodhi">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <select name="gender" id="gender" class="form-control">
                    <option value="select" selected="selected">Select Gender</option>
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                </select>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" required="required" name="dob" class="form-control" placeholder="DD-MM-YYYY" pattern="^[0-9]{2}-([0-9]{2})-([0-9]{4})+$" title="Example : 18-10-1994"/>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <select name="occupation" id="occupation" class="form-control">
                    <option value="select" selected="selected">Select Occupation</option>
                    <option value="student">Student</option>
                    <option value="business">Business</option>
                </select>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <select name="income" id="income" class="form-control">
                    <option value="select" selected="selected">Select Income Group</option>
                    <option value="0-10">0-10 lac</option>
                    <option value="11-20">11-20 lac</option>
                    <option value="21-30">21-30 lac</option>
                    <option value="31-40">31-40 lac</option>
                    <option value="41-50">41-50 lac</option>
                    <option value="51-above">51-above lac</option>
                </select>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="email" required="required" name="email" class="form-control" placeholder="Email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" title="Example : sahilsodhi18@yahoo.com"/>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" required="required" name="mobile" class="form-control" placeholder="Mobile No" pattern="[789][0-9]{9}" title="Example : 8968581700"/>
              </div>
            </div>
        </div>
        
        <div class="col-sm-4 form-horizontal whiteback">
             
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" name="city" class="form-control" id="city" placeholder="City" required pattern="^[a-zA-Z ]+$" title="Example : Jalandhar">
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
                <input type="text" class="form-control"  name="pincode" id="pincode" placeholder="Pincode" required pattern="[0-9]{6}" title="Example : 144003">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="password" class="form-control" name="password" id="pwd" placeholder="Password" required >
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="password" class="form-control" id="repwd" placeholder="Re-Enter Password" required >
              </div>
            </div>
            <div class="form-group sign-button">        
              <div class="col-sm-offset-2 col-sm-8">
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

function validate()
{
	var gender = document.getElementById('gender').value;
	var occupation = document.getElementById('occupation').value;
	var income = document.getElementById('income').value;
	var pwd = document.getElementById('password').value;
	var repwd = document.getElementById('repwd').value;
	
	if(gender == "select")
	{
		alert("Please select gender");
		return false;
	}
	if(occupation == "select")
	{
		alert("Please select occupation");
		return false;
	}
	if(income == "select")
	{
		alert("Please select income group");
		return false;
	}
	
	if(pwd != repwd)
	{
		alert("Password entered doesnot match");
		return false;
	}
	
}
</script>
