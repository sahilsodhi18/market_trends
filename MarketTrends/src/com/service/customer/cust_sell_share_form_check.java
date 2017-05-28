package com.service.customer;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bean.Shares;
import com.dao.SharesDao;
import com.myvariables.Myvariables;

/**
 * Servlet implementation class cust_sell_share_form_check
 */
public class cust_sell_share_form_check extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public cust_sell_share_form_check() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
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

		
	}

}
