<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.myvariables.*" %>
<%@ page import="com.bean.*" %>
<%@ page import="com.dao.*" %>
<%@ page import="java.sql.*" %>

<%
	String id = request.getParameter("transid");
	HttpSession s = request.getSession();
	String email = s.getAttribute("cust_login").toString();	

	if(email.equals(""))
	{
		response.sendRedirect("customer_login.jsp");
	}
	
	ResultSet rs = SharesDao.getAllDetails2(id);
	
	String cemail= "",csymbol="",srate="",sleft="",tvalue="";
	while(rs.next())
	{
		cemail = rs.getString("custemail");
		csymbol = rs.getString("csymbol");
		srate = rs.getString("srate");
		sleft = rs.getString("noofshares");
		tvalue = rs.getString("tvalue");
		
	}
	
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html" />
	<meta name="author" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="shortcut icon" href="../images/logo.jpg" />

	<title>MarketTrends | Buy Shares</title>
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
<div class="col-sm-12 center" >
    
    <div class="col-sm-12">
        <div class="col-sm-2"></div>
        <div class="col-sm-8 whiteback">
            <h2>Buy Shares</h2><hr />
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
        	
        
            <form class="form-horizontal" role="form" action="cust_buy_shares_form2_check" method="POST" >
            
            <input type="hidden" name="id" value="<%=id%>"/>
            
            <div class="form-group">
              <div class="col-sm-12">
              <label style="float: left;">Seller's Email :</label>
                <input type="text" class="form-control" name="cemail" value="<%=cemail %>" readonly="readonly">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
              <label style="float: left;">Company Symbol :</label>
                <input type="text" class="form-control"  name ="csymbol" value="<%=csymbol %>" readonly="readonly">
              </div>
            </div>
            <div class="form-group">
            
              <div class="col-sm-12">
              <label style="float: left;">Shares Available :</label>
                <input type="text" class="form-control"  name ="sleft" id="sleft" value="<%=sleft %>" readonly="readonly" style="color:red;font-weight: bold;">
              </div>
            </div>
            
            
        </div>
        
        <div class="col-sm-4 form-horizontal whiteback">
             
            <div class="form-group">
              <div class="col-sm-12">
              <label style="float: left;">Share Rate :</label>
                <input type="text" required="required" name="srate" id="srate" value="<%=srate %>" class="form-control" readonly="readonly"/>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
              <label style="float: left;">No of Shares :</label>
                <input type="text" name="noofshares" class="form-control" id="noofshares" placeholder="Enter no of shares" pattern="[0-9]*" required onchange="getValue()" autocomplete="off">
              </div>
            </div>
            <div class="form-group">
            
              <div class="col-sm-12">
              <label style="float: left;">Total Value :</label>
                <input type="text" class="form-control" name="tvalue" id="tvalue" style="color:red;font-weight: bold;" readonly="readonly" required >
              </div>
            </div>
            
            <div class="form-group sign-button">        
              <div class="col-sm-offset-2 col-sm-4">
                <button type="submit" name="button" value="buynow" class="btn btn-primary">Buy Now</button>
              </div>
            </div>
            
          </form>
        </div>
    </div>
</div>
<!-- select company form ends -->


<!-- footer include starts -->

<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>

<script type="text/javascript">

function getValue()
{
	var srate = document.getElementById("srate").value;
	var no = document.getElementById("noofshares").value;
	var sleft = document.getElementById("sleft").value;	
	
	if(parseInt(no) > parseInt(sleft))
	{
		document.getElementById("tvalue").value ="";
		document.getElementById("noofshares").value ="0";
		alert("Buying No cannot exceed available shares !!");
	}
	else if(no<=0)
	{
		document.getElementById("noofshares").value =""
		alert("Buying No should be greater than Zero !!");
	}
	else
	{
		var total = srate * no;
		document.getElementById("tvalue").value = total;	
	}
}


</script>
