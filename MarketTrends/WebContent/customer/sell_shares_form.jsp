<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.myvariables.*" %>
<%@ page import="com.bean.*" %>
<%@ page import="com.dao.*" %>
<%@ page import="java.sql.*" %>

<%
	String str = request.getParameter("csymbol");
	HttpSession s = request.getSession();
	String email = s.getAttribute("cust_login").toString();
	
	if(str.equals(""))
	{
		response.sendRedirect("customer_login.jsp");
	}
	ResultSet rs = CompanyDao.getAllDetails(str);
	
	String cname= "",csymbol="",srate="",spresent="";
	int n = 0;
	while(rs.next())
	{
		cname = rs.getString("cname");
		csymbol = rs.getString("csymbol");
	}
	
	srate = CompanyDao.getShareRate2(csymbol);
	n = Integer.parseInt(SharesDao.getBuyShareNo(csymbol, email)) - Integer.parseInt(SharesDao.getSellShareNo(csymbol, email));
	
	if(n <0)
	{
		spresent = "0";
	}
	else
	{
		spresent = String.valueOf(n);
	}
	
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html" />
	<meta name="author" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="shortcut icon" href="../images/logo.jpg" />

	<title>MarketTrends | Sell Shares</title>
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
            <h2>Sell Shares</h2><hr />
            <p style="float:left; color:green;">
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
        	
        
            <form class="form-horizontal" role="form" action="cust_sell_share_form_check" method="POST" >
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
              <label style="float: left;">Share Rate :</label>
                <input type="text" required="required" name="srate" id="srate" value="<%=srate %>" class="form-control" readonly="readonly"/>
              </div>
            </div>
            
            
            
        </div>
        
        <div class="col-sm-4 form-horizontal whiteback">
			
			<div class="form-group">
              <div class="col-sm-12">
              <label style="float: left;">Shares Available :</label>
                <input type="text" name="spresent" class="form-control" value="<%=spresent %>" id="spresent" placeholder="Enter no of shares" readonly="readonly" >
              </div>
            </div>             
            <div class="form-group">
              <div class="col-sm-12">
              <label style="float: left;">Shares to Sell :</label>
                <input type="text" name="sellshares" class="form-control" id="sellshares" placeholder="Enter shares to sell" required onchange="getValue()" autocomplete="off">
              </div>
            </div>
            <div class="form-group">
            
              <div class="col-sm-12">
              <label style="float: left;">Total Value :</label>
                <input type="text" class="form-control" name="tvalue" id="tvalue" style="color:red;font-weight: bold;" readonly="readonly" >
              </div>
            </div>
            
            <div class="form-group sign-button">        
              <div class=" col-sm-4">
                <button type="submit" name="button" value="sellnow" class="btn btn-primary">Sell Now</button>
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
	var no = document.getElementById("sellshares").value;
	var spresent = document.getElementById("spresent").value;	
	
	if(parseInt(no) > parseInt(spresent))
	{
		document.getElementById("tvalue").value ="0";
		document.getElementById("sellshares").value ="0";
		alert("Selling No cannot exceed available shares !!");
	}
	else
	{
		var total = srate * no;
		document.getElementById("tvalue").value = total;	
	}
}


</script>
