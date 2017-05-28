<%@page import="com.dao.*" %>
<%@page import="java.sql.*" %>

<%
	String csymbol = "REL";
	ResultSet rs = SharesDao.getshareratedetails(csymbol);
	String tdate = "",srate = "";
	int n=0;
%>

<html>
<head>

</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.3/Chart.min.js"></script>

<body onload="adddata()">
<div class="col-sm-2">
<canvas id="myChart" height="100px"></canvas>

</div>
<script>
var canvas = document.getElementById('myChart');
var data = {
    labels: [],
    datasets: [
        {
            label: "My First dataset",
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
	 	while(rs.next())
	 	{
	 		tdate = rs.getString("tdate");
	 		srate = rs.getString("srate");
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
</script></body>


</html>