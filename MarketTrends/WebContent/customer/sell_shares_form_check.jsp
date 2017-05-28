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
	String spresent = request.getParameter("spresent");
	String no = request.getParameter("sellshares");
	double tv = (Double.parseDouble(srate) * Double.parseDouble(no));
	String tvalue = String.valueOf(tv);
	
	Date tdate = new Date();
	SimpleDateFormat ft = new SimpleDateFormat("dd/MM/yyy");
	
	if(Integer.parseInt(no) > Integer.parseInt(spresent) || Integer.parseInt(spresent) == 0)
	{
		request.setAttribute(Myvariables.cust_msg,"No of shares cannot be greater than shares available");
		RequestDispatcher rd = request.getRequestDispatcher("sell_shares.jsp");
		rd.forward(request, response);
	}
	else
	{
		Shares sh = new Shares();
	
		sh.setCustemail(email);
		sh.setCsymbol(csymbol);
		sh.setSrate(srate);
		sh.setNoofshares(no);
		sh.setTvalue(tvalue);
		sh.setTdate(ft.format(tdate));
		sh.setStatus("sell");
		
		int eff = SharesDao.insert(sh);
		request.setAttribute(Myvariables.cust_msg,"Shares Successfully Sold !!");
		RequestDispatcher rd = request.getRequestDispatcher("sell_shares.jsp");
		rd.forward(request, response);
		
	}
	

%>