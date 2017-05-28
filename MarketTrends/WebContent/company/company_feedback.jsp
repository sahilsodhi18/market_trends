<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.myvariables.*" %>
<%@ page import="com.dao.*" %>
<%@ page import="java.sql.*" %>
<%
HttpSession s = request.getSession();
String email = s.getAttribute("comp_login").toString();

int n=1;
ResultSet rs1 = null;
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html" />
	<meta name="author" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="shortcut icon" href="../images/logo.jpg" />

	<title>MarketTrends | Company Feedback</title>
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

<!-- company feedback form starts -->

<div class="col-sm-12">
    <div class="col-sm-3"></div>
    
    <div class="col-sm-6 customerlogin center">
           <h2>Give Your Feedback</h2>
           <hr />
            <p style="float:left; color:green;">
            <%
        		String error = (String)request.getAttribute(Myvariables.comp_msg);
        		if(error != null)
        		{
        			out.println("* "+error);
        		}
        	%>
        	</p>
        	<br/>
          <form class="form-horizontal" role="form" method="post" action="company_feedback_check">
            <div class="form-group">
              <div class="col-sm-12">
                <input type="email" class="form-control" name="remail" id="remail" placeholder="Enter Receiver's Email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" required >
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-12">
                <textarea class="form-control" rows="10" name="feedback" placeholder="Enter Message" required></textarea>
              </div>
            </div>
            <div class="form-group">        
              <div class="col-sm-offset-2 col-sm-8">
                <button type="submit" class="btn btn-primary">Submit</button>
              </div>
            </div>
          </form>
    </div>
</div>

<!-- company feedback form ends -->

<!-- feedback from users starts -->

<div class="col-sm-12 center" style="height: 50px;margin-top: 30px;">
	<h3><b>-- Feedback From Customers --</b></h3>
	<hr>
	
</div>

<div class="col-sm-12" style="margin-top: 30px;">
	<div class="col-sm-2"></div>
	<div class="col-sm-8">
	
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>S.No</th>
					<th>Sender's Email</th>
					<th>Message</th>
					
				</tr>
			</thead>

<%
			rs1 = CustomerDao.getFeedbackMsg(email);
			
			while(rs1.next())
			{
%>

			<tbody>
				<tr>
				<td><%=n %></td>
				<td><%=rs1.getString("semail") %></td>
				<td><%=rs1.getString("msg") %></td>
				</tr>
			</tbody>

	
<% 		
		n++;
		}
		n =1; //reset counter
%>
		</table>
	</div>
</div>	



<!-- feedback from companies -->
<div class="col-sm-12 center" style="height: 50px;margin-top: 30px;">
	<h3><b>-- Feedback From Companies --</b></h3>
	<hr>
	
</div>

<div class="col-sm-12" style="margin-top: 30px;">
	<div class="col-sm-2"></div>
	<div class="col-sm-8">
	
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>S.No</th>
					<th>Sender's Email</th>
					<th>Message</th>
					
				</tr>
			</thead>

<%
			rs1 = CompanyDao.getFeedbackMsg(email);
			
			while(rs1.next())
			{
%>

			<tbody>
				<tr>
				<td><%=n %></td>
				<td><%=rs1.getString("semail") %></td>
				<td><%=rs1.getString("msg") %></td>
				</tr>
			</tbody>

	
<% 		
		n++;
		}
	
%>
		</table>
	</div>
</div>	

<!-- footer include starts -->

<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>