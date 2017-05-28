<%@page import="com.myvariables.Myvariables"%>
<%@page import="sun.java2d.pipe.SpanShapeRenderer.Simple"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.dao.CompanyDao"%>
<%@page import="java.util.*" %>
<%

	String button = request.getParameter("button");

	if(button.equals("add"))
	{
		HttpSession s = request.getSession();
		String email = s.getAttribute("comp_login").toString();
		
		String amt = request.getParameter("amt");
		
	
		if(Double.parseDouble(amt) > 0)
		{
			CompanyDao.addmoney(email, amt,"credit");
			
			request.setAttribute(Myvariables.cust_msg,"Money Added Successfully !!");
			RequestDispatcher rd = request.getRequestDispatcher("company_wallet.jsp");
			rd.forward(request, response);
		}
		else
		{
			request.setAttribute(Myvariables.cust_msg,"Amount should be greater than ZERO");
			RequestDispatcher rd = request.getRequestDispatcher("company_wallet.jsp");
			rd.forward(request, response);	
		}
		
	}

%>