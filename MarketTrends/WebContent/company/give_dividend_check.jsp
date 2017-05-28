<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.myvariables.*" %>
<%@ page import="com.bean.*" %>
<%@ page import="com.dao.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>

<%
	HttpSession s = request.getSession();
	String str = s.getAttribute("comp_login").toString();
	if(str.equals(""))
	{
		response.sendRedirect("company_login.jsp");
	}
	
	String credit = "0",debit = "0";
	
	credit = CompanyDao.getcreditmoney(str);
	debit = CompanyDao.getdebitmoney(str);
	String amt = "";
		
	if(credit == null)
		credit = "0";
	if(debit == null)
		debit = "0";
	
	double a = Double.parseDouble(credit);
	double b = Double.parseDouble(debit);
	
	double c = a - b; //calculates difference 
	
	if(c> 0)
	{
		amt = String.valueOf(c);
	}
	else
	{
		amt = "0";
	}
	
	String dividend_amt = request.getParameter("amt"); //gets divident_amt 
	double d_amt = Double.parseDouble(dividend_amt);
	
	DecimalFormat ft = new DecimalFormat("0.00");
	d_amt = Double.parseDouble(ft.format(d_amt));

	if(d_amt > c)
	{
		request.setAttribute(Myvariables.comp_msg,"Wallet amount less than dividend amount !!");
		RequestDispatcher rd = request.getRequestDispatcher("company_wallet.jsp");
		rd.forward(request, response);
	}
	else
	{
		String csymbol = CompanyDao.getCsymbol(str); //finding csymbol
	
		int t_comp_shares = SharesDao.companyTotalShares(csymbol); //sum of all company shares
		
		ResultSet rs = SharesDao.custTotalShares(csymbol); //sum of shares owned by customers
		
		int t_cust_shares = 0;
		
		while(rs.next())
		{
			t_cust_shares = Integer.parseInt(rs.getString("no"));
			String custemail = rs.getString("custemail"); 
			
			double per = (double)t_cust_shares/t_comp_shares; //calculates %age of shares per person
			per = Double.parseDouble(ft.format(per));
			
			double cust_d_amt = per * d_amt;
			
			CustomerDao.addmoney(custemail, String.valueOf(cust_d_amt),"credit"); //credit to customerwallet
			
			CompanyDao.addmoney(str,String.valueOf(d_amt),"debit"); //debit from company wallet
			
		}
		
		request.setAttribute(Myvariables.comp_msg,"Successfully distributed dividend amount !!");
		RequestDispatcher rd = request.getRequestDispatcher("give_dividend.jsp");
		rd.forward(request, response);
		
	}
	
%>
