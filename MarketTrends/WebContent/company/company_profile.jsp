<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.dao.CompanyDao" %>
<%@ page import="com.bean.*" %> 
<%@ page import="com.myvariables.*" %>   
<%
	
	HttpSession s = request.getSession();
	String str = s.getAttribute("comp_login").toString();
	if(str.equals(""))
	{
		response.sendRedirect("company_login.jsp");
	}
	Company c = CompanyDao.getDetails(str);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html" />
	<meta name="author" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="shortcut icon" href="../images/logo.jpg" />

	<title>MarketTrends | Company Profile</title>
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
<jsp:include page="company_menuBar.jsp"></jsp:include>

<!-- company profile form starts -->

<div class="col-sm-12 center">
    
    <div class="col-sm-12">
        <div class="col-sm-2"></div>
        <div class="col-sm-8 whiteback pad">
            <h2>Edit Profile</h2><hr />
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
            <form class="form-horizontal" role="form" action="update_company_profile.jsp" method="POST" onsubmit="return check()">
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" class="form-control" name="cname" id="cname" value ="<%= c.getCname() %>" readonly="readonly">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" class="form-control"  name="csymbol" id="csymbol" value ="<%= c.getCsymbol()%>" readonly="readonly"">
              </div>
            </div>
            
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" required="required" name="doe" class="form-control" value ="<%= c.getDoe() %>" readonly="readonly"/>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
               <input type="text" required="required" name="ctype" class="form-control" value ="<%= c.getCtype() %>" readonly="readonly"/>
              </div>
            </div>
            
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" required="required" name="email" class="form-control" value ="<%= c.getEmail() %>" readonly="readonly"/>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" required="required" name="mobile" class="form-control" value ="<%= c.getMobile()%>" readonly="readonly"/>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <textarea name="cabout" placeholder="Write about company." class="form-control" readonly="readonly"><%= c.getCabout() %></textarea>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" required="required" name="address" value ="<%= c.getAddress() %>" class="form-control" placeholder="Address" />
              </div>
            </div>
        </div>
        
        <div class="col-sm-4 form-horizontal whiteback">
             
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" class="form-control" name="city" value ="<%= c.getCity() %>" required>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" class="form-control" name="state" value ="<%= c.getState() %>" required>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" class="form-control" name="country" value ="<%= c.getCountry() %>" required>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="text" class="form-control" name="pincode" value ="<%= c.getPincode() %>" required>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="password" class="form-control" name="oldpwd" id="oldpwd" placeholder="Old password" required>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="password" name="pwd" class="form-control" id="pwd" placeholder="New Password" required>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <input type="password" class="form-control" id="repwd" placeholder="Re-Enter Password" required>
              </div>
            </div>
          	<div class="form-group">        
              <div class="col-sm-offset-2 col-sm-8" style="margin-top:20px;">
                <button type="submit" class="btn btn-primary" name="button" value="update">Update Profile</button>
              </div>
            </div>
            
          </form>
        </div>
          
    </div>
</div>


<!-- customer profile form ends -->

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
		alert("Password donot match");
		return false;
	}

}
	
	
	
</script>

