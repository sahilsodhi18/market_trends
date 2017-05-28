<%@page import="com.dao.CompanyDao"%>
<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
	ResultSet rs1 = CompanyDao.getAllDetails();
	String csymbol = "";
%>

<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html" />
	<meta name="author" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="shortcut icon" href="images/logo.jpg" />

	<title>Market Trends</title>
    <!-- Bootstrap files -->    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <!-- Custom CSS files -->
    <link rel="stylesheet" href="css/menubar.css" type="text/css"/>
    <link rel="stylesheet" href="css/carousel.css" type="text/css"/>
    <link rel="stylesheet" href="css/style.css" type="text/css"/>
</head>

<body>

<!-- menubar import starts -->

<jsp:include page="jsp/menuBar.jsp"></jsp:include>


<!-- Live stock market -->

<marquee width="auto">
<h4 style="padding-top:0px;"><b>
	<%
	while(rs1.next()) 
	{
		csymbol = rs1.getString("csymbol");
		
		String srate = CompanyDao.getShareRate2(csymbol);
		
	%>
		<span style="color: #d39c0c;"><%=csymbol %></span> - Rs.<%=srate %> &nbsp || &nbsp  
	<%	
		
	}
	%>
</b>
</h4>
 
</marquee>

<!-- Live stock market ends -->

<!-- Carousel starts-->

<div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">
      <div class="item active">
        <img src="images/sharemarket1.jpg" alt="" width="400" height="345px">
      </div>

      <div class="item">
        <img src="images/sharemarket2.jpg" alt="" width="400" height="345px">
      </div>
    
      <div class="item">
        <img src="images/sharemarket3.jpg" alt="" width="400" height="345px">
      </div>

    </div>

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
  <br /><br />
<!-- carousel ends -->

<!-- services starts -->
<div class="col-sm-12 center">

    <div class="col-sm-12">
        <h1><b><span class="glyphicon glyphicon-th" aria-hidden="true"></span> OUR SERVICES</b></h1>
        <br /><br />
    </div>
    
    <div class="col-sm-4">
        <h3><b><span class="glyphicon glyphicon-stats" aria-hidden="true"></span> Market Analysis</b></h3>
        <br />
        <h4>Analysis the share market with interactive graphs</h4>    
    </div><br />

    <div class="col-sm-4">
        <h3><b><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span> Buying &amp Selling Shares</b></h3>
        <br />
        <h4>Hassle free way of buying and selling shares online</h4>
        
    </div>
    
    <div class="col-sm-4">
        <h3><b><span class="glyphicon glyphicon-lock" aria-hidden="true"></span> Secure Transactions</b></h3>
        <br />
        <h4>Do all your transactions without any worry</h4>
    </div><br />
    
    <div class="col-sm-12"><br /><br /></div>
    <div class="col-sm-4">
        <h3><b><span class="glyphicon glyphicon-flash" aria-hidden="true"></span> Fast Transactions</b></h3>
        <br />
        <h4>Buy and sell shares at lightening fast speed</h4>
    </div><br />
    
    <div class="col-sm-4">
        <h3><b><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Expert Advice</b></h3>
        <br />
        <h4>Consider our expert opinion before trading</h4>
    </div><br />
    
    <div class="col-sm-4">
        <h3><b><span class="glyphicon glyphicon-remove-sign" aria-hidden="true"></span> No Brokage Charges</b></h3>
        <br />
        <h4>No hidden charges. Its free </h4>
    </div><br />
</div>    

<!-- services ends -->

<!-- steps image starts -->
<div class="col-sm-12 thumb center" id="howitworks">
    <br /><br />
    
    <div class="col-sm-2 thumbnail">
        <h1>Step 1</h1>
        <hr />
        <h3>Register</h3>
    </div>
    
    <div class="col-sm-2 thumbnail">
        <h1>Step 2</h1>
        <hr />
        <h3>Analyse Live Market</h3>
    </div>
    
    <div class="col-sm-2 thumbnail">
        <h1>Step 3</h1>
        <hr />
        <h3>Buy and Sell Shares</h3>
    </div>
    
    <div class="col-sm-2 thumbnail">
        <h1>Step 4</h1>
        <hr />
        <h3>Earn Profits</h3>
    </div>
    <br /><br />
</div>
<!-- steps image ends -->

<!-- about us starts -->

<div class="col-sm-12 center">
    <br /><br />
    <div class="col-sm-12">
        <h1><b><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> About US</b></h1>
        <br /><br />
    </div>
    <div class="col-sm-2"></div>
    <div class="col-sm-8"><h4>
    <p>Market Trends is a portal designed to facilitate companies and customers who deals in direct equity</p> 
    <p>market to come online and do transactions.</p>
    <p>Main motto of the clinic is to provide the buyers and sellers of equity a common platform where they</p>
    <p>can transact fast and securely using latest web technologies all that with <u><b><i>"any time any where"</i></b></u> feature.</p> 
    </h4></div>
</div>
<!-- about us ends -->

<!-- trading button starts -->
<div class="col-sm-12 center">
    <div class="col-sm-5"></div>
    <div class="col-sm-3"><h3 class="registerlink"><a href="customer/customer_signup.jsp"><b>Start Trading</b></a></h3></div>
    
</div>
<!-- trading button ends --> 

<!-- footer include starts -->

<jsp:include page="jsp/footer.jsp"></jsp:include>
   
</body>
</html>