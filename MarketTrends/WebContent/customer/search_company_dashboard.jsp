<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.myvariables.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@page import="com.bean.*" %>
<%@page import="com.dao.*" %>
<%@page import="java.sql.*" %>


<%
	String str = request.getParameter("csymbol"); //getting company cymbol
	
	ResultSet rs = null;
	String email = "";
	rs = CompanyDao.getAllDetails(str);
	while(rs.next())
	{
		email = rs.getString("email");
	}
	
	Company c = CompanyDao.getDetails(email);
	
	// for chart
		String csymbol = c.getCsymbol();
		ResultSet rs2 = SharesDao.getshareratedetails(csymbol);
		String tdate = "",srate = "";
		int n=0;
		System.out.println(csymbol);
	
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html" />
	<meta name="author" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="shortcut icon" href="../images/logo.jpg" />

	<title>MarketTrends | Company</title>
    <!-- Bootstrap files -->    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<!-- for javascript chart -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.3/Chart.min.js"></script> 
	

    <!-- Custom CSS files -->
    <link rel="stylesheet" href="../css/menubar.css" type="text/css"/>
    <link rel="stylesheet" href="../css/carousel.css" type="text/css"/>
    <link rel="stylesheet" href="../css/style.css" type="text/css"/>
</head>

<body onload="adddata()">

<!-- Menubar starts -->
<jsp:include page="customer_menuBar.jsp"></jsp:include>
<!-- Menubar ends -->

<!-- container starts -->

<div class="col-sm-12">
	<div class="col-sm-6 whiteback thumbnail">
        <h1 class="center" style="color: #0c2b4a;"><b><%=c.getCname() %></b></h1>
        <hr />
        
        <div class="col-sm-12">
	    	<table class="table table-striped ">
	    		<tbody>
		    		<tr>
		    			<td><b>Company Name :</b></td>
		    			<td><%=c.getCname() %></td>
		    		</tr>
		    		<tr>
		    			<td><b>Company Symbol :</b></td>
		    			<td><%= c.getCsymbol()%></td>
		    		</tr>
		    		<tr>
		    			<td><b>Date of Establishment :</b></td>
		    			<td><%=c.getDoe()%></td>
		    		</tr>
		    		<tr>
		    			<td><b>Company Type :</b></td>
		    			<td><%=c.getCtype() %></td>
		    		</tr>
		    		<tr>
		    			<td><b>Email :</b></td>
		    			<td><%=c.getEmail() %></td>
		    		</tr>
		    		<tr>
		    			<td><b>Mobile No :</b></td>
		    			<td><%=c.getMobile() %></td>
		    		</tr>
		    		<tr>
		    			<td><b>About Company :</b></td>
		    			<td><%=c.getCabout() %></td>
		    		</tr>
		    		
		    		<tr>
		    			<td><b>Adress :</b></td>
		    			<td><%=c.getAddress() %></td>
		    		</tr>
		    		<tr>
		    			<td><b>City :</b></td>
		    			<td><%=c.getCity() %></td>
		    		</tr>
		    		<tr>
		    			<td><b>State :</b></td>
		    			<td><%=c.getState() %></td>
		    		</tr>
		    		<tr>
		    			<td><b>Country :</b></td>
		    			<td><%=c.getCountry() %></td>
		    		</tr>
		    		<tr>
		    			<td><b>Pincode :</b></td>
		    			<td><%=c.getPincode() %></td>
		    		</tr>
	    		</tbody>
	    	</table>    
        </div>
    </div>
	
    <div class="col-sm-6">
		<div class="col-sm-12 whiteback thumbnail">
                <canvas id="myChart" height="170px"></canvas>
        </div>
        
		
<div class="col-sm-12 whiteback thumbnail">
            <h2 class="center" style="color: #0c2b4a;"><b>Expert Advice</b></h2>
            <hr />
            <%
            		
			String msg = CompanyDao.getRevenueDeatils(c.getEmail());
           	String plans = CompanyDao.getFuturePlansDetails(c.getEmail());
            %>
            
            <table>
            	<tbody>
            		<tr>
            			<td style="width:200px"><h4><b><span style="color:#ffb600;">Expert Opinion</span></b></h4></td>
            	
            			<td><h4><b><%=msg %></b></h4></td>		
            		</tr>
            		<tr>
            			<td style="width:200px"><h4><b><span style="color:#ffb600;">Future Plans</span></b></h4></td>
            			
            			<td><h4><b><%=plans %></b></h4></td>
            		</tr>
            	</tbody>
            </table>
</div>
		
		
	</div>
</div>


<!-- container ends -->

<!-- footer include starts -->

<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>

<script>
var canvas = document.getElementById('myChart');
var data = {
    labels: [],
    datasets: [
        {
            label: "<%=c.getCname()+" - "+c.getCsymbol()%>",
            fill: false,
            lineTension: 0.1,
            backgroundColor: "rgba(75,192,192,0.4)",
            borderColor: "rgba(75,192,192,1)",
            borderCapStyle: 'butt',
            borderDash: [],
            borderDashOffset: 0.0,
            borderJoinStyle: 'miter',
            pointBorderColor: "rgba(75,192,192,1)",
            pointBackgroundColor: "#fff",
            pointBorderWidth: 1,
            pointHoverRadius: 5,
            pointHoverBackgroundColor: "rgba(75,192,192,1)",
            pointHoverBorderColor: "rgba(220,220,220,1)",
            pointHoverBorderWidth: 2,
            pointRadius: 5,
            pointHitRadius: 10,
            data: [],
        }
    ]
};


function adddata(){
	
	 <% 
	 	while(rs2.next())
	 	{
	 		tdate = rs2.getString("tdate");
	 		srate = rs2.getString("srate");
	 		System.out.println(srate);
	 %>
	  myLineChart.data.datasets[0].data[<%= n%>] = <%=srate%>;
	  myLineChart.data.labels[<%= n%>] = "<%=tdate%>";
	
	  myLineChart.update();
	  
	 <%
	 n++;			
	 	}
	 %>
}

 var option = {
			showLines: true
		};
 
var myLineChart = Chart.Line(canvas,{
	data:data,
  options:option
});
</script>


