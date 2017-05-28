<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
       
<%@ page import="com.dao.CustomerDao" %>
<%@ page import="com.bean.*" %> 
<%@ page import="com.myvariables.*" %>   
<%
	
	HttpSession s = request.getSession();
	String str = s.getAttribute("cust_login").toString();
	
	if(str.equals(""))
	{
		response.sendRedirect("customer_login.jsp");
	}
	Customer c = CustomerDao.getDeatils(str);
		
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html" />
	<meta name="author" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="shortcut icon" href="../images/logo.jpg" />

	<title>MarketTrends | Customer Profile</title>
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
<jsp:include page="customer_menuBar.jsp"></jsp:include>

<!-- customer signup form starts -->

<div class="col-sm-12 center" >
    
    <div class="col-sm-12">
        <div class="col-sm-2"></div>
        <div class="col-sm-8 whiteback">
            <h2>Edit Profile</h2><hr />
            <p  style="float:left; color:red;">
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
            <form class="form-horizontal" role="form" action="update_customer_profile.jsp" method="POST" onsubmit="return check()">
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" class="form-control" id="fname" value="<%= c.getFname() %>" readonly="readonly">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" class="form-control" id="lname" value="<%= c.getLname() %>" readonly="readonly">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
              	<input type="text" class="form-control" id="gender" value="<%= c.getGender() %>" readonly="readonly">  
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" required="required" name="dob" class="form-control" value="<%= c.getDob() %>"  readonly="readonly"/>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
               <input type="text" class="form-control" value="<%= c.getOccupation()%>" name="occupation" readonly="readonly">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" class="form-control" value="<%= c.getIncome()%>" name="income" readonly="readonly">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" required="required" name="email" value="<%= c.getEmail()%>" class="form-control" readonly="readonly"/>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" required="required" name="mobile" value="<%= c.getMobile()%>" class="form-control" readonly="readonly"/>
              </div>
            </div>
        </div>
        
        <div class="col-sm-4 form-horizontal whiteback">
             
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" class="form-control" value="<%= c.getCity()%>" name="city" placeholder="City" required pattern="^[a-zA-Z ]+$" title="Example : Jalandhar">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" class="form-control" value="<%= c.getState()%>" name="state" placeholder="State" required pattern="^[a-zA-Z ]+$" title="Example : Punjab">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" class="form-control" value="<%= c.getCountry()%>" name="country" placeholder="Country" required pattern="^[a-zA-Z ]+$" title="Example : India">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" class="form-control" value="<%= c.getPincode()%>" name="pincode" placeholder="Pincode" required pattern="[0-9]{6}$" title="Example : 144003">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="password" class="form-control" name="oldpwd" id="oldpwd" placeholder="Old Password" required>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="password" class="form-control" name="pwd" id="pwd" placeholder="New Password" required >
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="password" class="form-control" id="repwd" name="repwd" placeholder="Re-Enter Password" required >
              </div>
            </div>
            <div class="form-group">        
              <div class="col-sm-offset-2 col-sm-8">
                <button type="submit" name="update" class="btn btn-primary">Update Profile</button>
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
		var pwd = document.getElementById("pwd").value;
		var repwd = document.getElementById("repwd").value;
		
		if(pwd != repwd)
		{
			alert("Passwords donot match.");
			return false;
		}
	}
</script>
