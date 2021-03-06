<%@page import="com.dao.CustomerDao"%>
<%@page import="com.bean.Shares" %>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>
<%@page import="com.dao.SharesDao" %>
<%@page import="com.dao.CompanyDao" %>
<%@page import="com.myvariables.*" %>


<%

	String button = request.getParameter("button");
	
	HttpSession s = request.getSession();
	String email = s.getAttribute("cust_login").toString();
	String csymbol = request.getParameter("csymbol");
	String srate = request.getParameter("srate");
	String no = request.getParameter("noofshares");
	double tv = (Double.parseDouble(srate) * Double.parseDouble(no));
	String tvalue = String.valueOf(tv);
	String sleft = request.getParameter("sleft");
	Date tdate = new Date();
	SimpleDateFormat ft = new SimpleDateFormat("dd/MM/yyy");
	
	String lrate = request.getParameter("lrate");
	String rrate = request.getParameter("rrate");
	
	String comp_email = request.getParameter("comp_email");
	
	if((Integer.parseInt(no) > Integer.parseInt(sleft)) || Integer.parseInt(no) == 0  )
	{
		request.setAttribute(Myvariables.cust_msg,"No of shares cannot be greater than shares left");
		response.sendRedirect("buy_shares.jsp");
	}
	else if(button.equals("buynow"))
	{
		Shares sh = new Shares();
		
		sh.setCustemail(email);
		sh.setCsymbol(csymbol);
		sh.setSrate(srate);
		sh.setNoofshares(no);
		sh.setTvalue(tvalue);
		sh.setTdate(ft.format(tdate));
		sh.setStatus("buy");
	
		int newno = Integer.parseInt(sleft) - Integer.parseInt(no);
			
		String credit = CustomerDao.getcreditmoney(email);
		String debit = CustomerDao.getdebitmoney(email);
		String amt = "";
		
		if(credit == null)
			credit="0";	
		if(debit == null)
			debit="0";	
		
		double a = Double.parseDouble(credit);
		double b = Double.parseDouble(debit);
		double c = a - b;
		
		
		if(c>= Double.parseDouble(tvalue))
		{
		    CompanyDao.changeShareNo2(String.valueOf(newno), csymbol);
			
			int eff = SharesDao.insert(sh);
		
			CustomerDao.addmoney(email,tvalue,"debit");
			
			CompanyDao.addmoney(comp_email,tvalue,"credit");
			
			request.setAttribute(Myvariables.cust_msg,"Shares Bought Successfully !!");
			RequestDispatcher rd = request.getRequestDispatcher("buy_shares.jsp");
			rd.forward(request, response);
						
		}
		else
		{
			request.setAttribute(Myvariables.cust_msg,"Not Enough money in wallet.");
			RequestDispatcher rd = request.getRequestDispatcher("buy_shares.jsp");
			rd.forward(request, response);
		}
	}
	else if(button.equals("buylater"))
	{
		Shares sh = new Shares();
		
		sh.setCustemail(email);
		sh.setCsymbol(csymbol);
		sh.setSrate(srate);
		sh.setNoofshares(no);
		sh.setLrate(lrate);
		sh.setRrate(rrate);
		sh.setTvalue(tvalue);
		sh.setTdate(ft.format(tdate));
		sh.setStatus("buy");
	
		int newno = Integer.parseInt(sleft) - Integer.parseInt(no);
			
		String credit = CustomerDao.getcreditmoney(email);
		String debit = CustomerDao.getdebitmoney(email);
		String amt = "";
		
		if(credit == null)
			credit="0";	
		if(debit == null)
			debit="0";	
		
		double a = Double.parseDouble(credit);
		double b = Double.parseDouble(debit);
		double c = a - b;
		
		System.out.println(lrate+rrate);
		if(c>= Double.parseDouble(tvalue))
		{
		    //CompanyDao.changeShareNo2(String.valueOf(newno), csymbol);
			
			int eff = SharesDao.insertPending(sh);
		
			request.setAttribute(Myvariables.cust_msg,"Shares Saved for later purchase !!");
			RequestDispatcher rd = request.getRequestDispatcher("buy_shares.jsp");
			rd.forward(request, response);
						
		}
		else
		{
			request.setAttribute(Myvariables.cust_msg,"Not Enough money in wallet.");
			RequestDispatcher rd = request.getRequestDispatcher("buy_shares.jsp");
			rd.forward(request, response);
		}
		
		
	}
	

%>