<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.myvariables.*" %>
<%@ page import="com.bean.*" %>
<%@ page import="com.dao.*" %>
<%@ page import="java.sql.*" %>

<%
	
	HttpSession s = request.getSession();
	String email = s.getAttribute("cust_login").toString();	
	String str = request.getParameter("csymbol");

	if(str.equals(""))
	{
		response.sendRedirect("customer_login.jsp");
	}
	ResultSet rs = CompanyDao.getAllDetails(str);
	
	String comp_email = "";
	
	String cname= "",csymbol="",srate="",sleft="";
	while(rs.next())
	{
		cname = rs.getString("cname");
		csymbol = rs.getString("csymbol");
		comp_email = rs.getString("email");
	}
	
	srate = CompanyDao.getShareRate2(csymbol);
	sleft = CompanyDao.getShareNo2(csymbol);
	
	
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
        	
        
            <form class="form-horizontal" role="form" action="cust_buy_shares_form_check"  method="POST" >
            
            <input type="hidden" name="comp_email" value="<%=comp_email%>"/>
            
            <div class="form-group">
              <div class="col-sm-12">
              <label style="float: left;">Company Name :</label>
                <input type="text" class="form-control" name="cname" value="<%=cname %>" readonly="readonly">
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
              <label style="float: left;">Shares Left :</label>
                <input type="text" class="form-control"  name ="sleft" id="sleft" value="<%=sleft %>" readonly="readonly" style="color:green;font-weight: bold;">
              </div>
            </div>
            <div class="form-group">
            
              <div class="col-sm-12">
              <label style="float: left;">Share Rate :</label>
                <input type="text" required="required" name="srate" id="srate" value="<%=srate %>" class="form-control" readonly="readonly"/>
              </div>
            </div>
            
        </div>
        
        <div class="col-sm-4 form-horizontal whiteback">
             
            <div class="form-group">
            
              <div class="col-sm-12">
              <label style="float: left;">No of Shares :</label>
                <input type="text" name="noofshares" class="form-control" id="noofshares" placeholder="Enter no of shares" pattern="[0-9]*" required onchange="getValue()" autocomplete="off">
              </div>
            </div>
            <div class="form-group">
            
              <div class="col-sm-12">
              <label style="float: left;">Total Value :</label>
                <input type="text" class="form-control" name="tvalue" id="tvalue" style="color:red;font-weight: bold;" readonly="readonly" >
              </div>
            </div>
            <div class="form-group">
            
              <div class="col-sm-6">
              <label style="float: left;">Select Lower Limit :</label>
                <input type="text" class="form-control" name="lrate" value="<%=srate %>" id="lrate" onchange="check_rate()" required>
              </div>
              
              <div class="col-sm-6">
              <label style="float: left;">Select Upper Limit :</label>
                <input type="text" class="form-control" name="rrate" value="<%=srate %>" id="rrate" onchange="check_rate()" required>
              </div>
            </div>
            
            <div class="form-group sign-button">        
              <div class="col-sm-offset-2 col-sm-4">
                <button type="submit" name="button" value="buynow" class="btn btn-primary">Buy Now</button>
              </div>
              <div class=" col-sm-2">
                <button type="submit" name="button" value="buylater" class="btn btn-primary">Buy Later</button>
              </div>
            </div>
            
          </form>
        </div>
    </div>
</div>
<!-- select company form ends -->

<div class="col-sm-12 center" style="height: 50px;margin-top: 30px;">
	<h3><b>-- Shares Available --</b></h3>
	<hr>
	
</div>

<div class="col-sm-12" style="margin-top: 30px;">
	<div class="col-sm-2"></div>
	<div class="col-sm-8">
	
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>TransID</th>
					<th>Email</th>
					<th>Share Rate</th>
					<th>No of Shares</th>
					<th>Total Value</th>
					<th></th>
				</tr>
			</thead>

<%
	ResultSet rs1 = SharesDao.getAllSellingShares(csymbol,email);

	while(rs1.next())
	{
		if(Integer.parseInt(rs1.getString("noofshares")) > 0 && !rs1.getString("custemail").equals(email) )
		{
%>

			<tbody>
				<tr>
				<td><%=rs1.getInt("transid") %></td>
					<td><%=rs1.getString("custemail") %></td>
					<td><%=rs1.getString("srate") %></td>
					<td><%=rs1.getString("noofshares") %></td>
					<td><%=rs1.getString("tvalue") %></td>
					
					<form action="buy_shares_form2.jsp" method="post">
					<input type="hidden" name="transid" value="<%=rs1.getInt("transid") %>"/>	
						<td><input type="submit" class="btn-primary" name="submit" value="Buy"/></td>
					</form>	
				</tr>
			</tbody>

	
<% 		
		}
	}


%>
		</table>
	</div>
</div>	



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
		document.getElementById("tvalue").value ="0";
		document.getElementById("noofshares").value ="";
		alert("Buying No cannot exceed available shares !!");
	}
	
	else
	{
		var total = srate * no;
		document.getElementById("tvalue").value = total;	
	}
}

function check_rate()
{
	var srate = document.getElementById("srate").value;
	var lrate = document.getElementById("lrate").value;
	var rrate = document.getElementById("rrate").value;
	
	if((parseInt(lrate) > parseInt(rrate))|| parseInt(lrate)==0||parseInt(lrate)==null || parseInt(rrate)==null || parseInt(rrate)==0)
	{
		document.getElementById("lrate").value =srate;
		document.getElementById("rrate").value =srate;
		alert("Please select correct range !!");
	}
	
	
}

</script>
