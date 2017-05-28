package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

import javax.xml.ws.Response;

import com.bean.*;
import com.utility.MyConnection;
import com.myvariables.*;

public class CompanyDao 
{
	public static ResultSet loginCheck(Company c)
	{
		ResultSet rs = null;
		Connection con = MyConnection.getConnection();
		String sql ="select * from companymaster where email = ? and pwd = ?";
		try 
		{
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setString(1,c.getEmail());
			pst.setString(2, c.getPassword());
			
			rs = pst.executeQuery();
			
		}
		catch (SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;	
	}
	
	public static ResultSet csymbolValidate(String csymbol)
	{
		ResultSet rs = null;
		
		Connection con = MyConnection.getConnection();
		String sql = "select * from companymaster where csymbol = '"+csymbol+"'";
		PreparedStatement ps;
		try {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	public static ResultSet mobileValidate(String mobile)
	{
		ResultSet rs = null;
		
		Connection con = MyConnection.getConnection();
		String sql = "select * from companymaster where mobile = '"+mobile+"'";
		PreparedStatement ps;
		try {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	public static ResultSet emailValidate(String email)
	{
		ResultSet rs = null;
		
		Connection con = MyConnection.getConnection();
		String sql = "select * from companymaster where email = '"+email+"'";
		PreparedStatement ps;
		try {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return rs;
	}

	public static ResultSet passwordValidate(String email, String pwd)
	{
		ResultSet rs = null;
		
		Connection con = MyConnection.getConnection();
		String sql = "select * from companymaster where email = ? and pwd = ?";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,email);
			ps.setString(2, pwd);
			
			rs = ps.executeQuery();
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	
	public static void insert(Company c)
	{
		Connection con = MyConnection.getConnection();
		String sql = "insert into companymaster(memid,cname,csymbol,doe,ctype,email,mobile,cabout,address,city,state,country," +
						"pincode,pwd) values(next_comp_memid.nextVal,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		String sql2 = "insert into companysharemaster(sno,csymbol,email,share_rate,no_of_shares) values(next_sharerate_sno.nextVal,?,?,?,?)";
		
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,c.getCname());
			ps.setString(2,c.getCsymbol());
			ps.setString(3,c.getDoe());
			ps.setString(4,c.getCtype());
			ps.setString(5,c.getEmail());
			ps.setString(6,c.getMobile());
			ps.setString(7,c.getCabout());
			ps.setString(8,c.getAddress());
			ps.setString(9,c.getCity());
			ps.setString(10,c.getState());
			ps.setString(11,c.getCountry());
			ps.setString(12,c.getPincode());
			ps.setString(13,c.getPassword());
			
			ps.executeUpdate();
			
			PreparedStatement ps2 = con.prepareStatement(sql2);
			ps2.setString(1,c.getCsymbol());
			ps2.setString(2,c.getEmail());
			ps2.setString(3,"0.00");
			ps2.setString(4,"0");
			
			ps2.executeUpdate();
			
		}
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally
		{
			try
			{
				con.close();
			} 
			catch (SQLException e) 
			{
				
				e.printStackTrace();
			}
		}

	}

	public static int updateProfile(Company c,String oldpwd)
	{
		int eff = 0;
		Connection con = MyConnection.getConnection();
		String sql = "update companymaster set address =? , city = ? , state =? , country = ? , pincode =? , pwd = ? where email = ?";
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,c.getAddress());
			ps.setString(2,c.getCity());
			ps.setString(3,c.getState());
			ps.setString(4,c.getCountry());
			ps.setString(5,c.getPincode());
			ps.setString(6,c.getPassword());
			ps.setString(7,c.getEmail());
		
			ResultSet rs = CompanyDao.passwordValidate(c.getEmail(),oldpwd);
			
			if(rs.next())
			{
				eff = ps.executeUpdate();
			}
		}
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return eff;
	}
	
	public static int updatePassword(String email,String mobile,String pwd)
	{
		int eff = 0;
		Connection con = MyConnection.getConnection();
		String sql = "update companymaster set pwd = ? where email = ?";
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,pwd);
			ps.setString(2,email);
			
			ResultSet rs = CompanyDao.emailValidate(email);
			
			if(rs.next())
			{
				eff = ps.executeUpdate();
				
			}
		}
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return eff;
	}	
	
	
	public static Company getDetails(String str)
	{
		Company c = new Company();
		
		Connection con = MyConnection.getConnection();
		String sql = "select * from companymaster where email = ?";
		
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,str);
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				
				c.setCname(rs.getString("cname"));
				c.setCsymbol(rs.getString("csymbol"));
				c.setDoe(rs.getString("doe"));
				c.setCtype(rs.getString("ctype"));
				c.setEmail(rs.getString("email"));
				c.setMobile(rs.getString("mobile"));
				c.setCabout(rs.getString("cabout"));
				c.setAddress(rs.getString("address"));
				c.setCity(rs.getString("city"));
				c.setState(rs.getString("state"));
				c.setCountry(rs.getString("country"));
				c.setPincode(rs.getString("pincode"));
				c.setPassword(rs.getString("pwd"));
			
			}
		}
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return c;
	}
	
	public static int add_revenue(CompanyRevenue r,String email)
	{
		int eff = 0;
		Connection con = MyConnection.getConnection();
		String sql = "insert into addrevenue values(next_revenue_sno.nextval,?,?)";
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,email);
			ps.setString(2,r.getRevenue());
			
			eff = ps.executeUpdate();
			
		}
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return eff;
		
	}
	
	public static int add_future_plans(String fp,String email)
	{
		int eff = 0;
		Connection con = MyConnection.getConnection();
		String sql = "insert into addfutureplans values(next_fplans_sno.nextval,?,?)";
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,email);
			ps.setString(2,fp);
			
			eff = ps.executeUpdate();
			
		}
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return eff;	
	}
	
	public static int add_feedback(String semail,String remail,String msg)
	{
		int eff = 0;
		Connection con = MyConnection.getConnection();
		String sql = "insert into companyfeedback values(next_compfeed_sno.nextval,?,?,?)";
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,semail);
			ps.setString(2,remail);
			ps.setString(3,msg);
			
			eff = ps.executeUpdate();
			
		}
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return eff;
	}

	public static ResultSet getAllDetails()
	{
		ResultSet rs = null;
		
		Connection con = MyConnection.getConnection();
		String sql = "select * from companymaster ORDER BY csymbol ASC";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			
			rs = ps.executeQuery();
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	public static ResultSet getAllDetails(String str)
	{
		ResultSet rs = null;
		
		Connection con = MyConnection.getConnection();
		String sql = "select * from companymaster where csymbol = ?";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, str);
			rs = ps.executeQuery();
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	public static String getShareRate(String email)
	{
		String price ="0.00";
		Connection con = MyConnection.getConnection();
		String sql = "select * from companysharemaster where email = ?";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,email);
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				price = rs.getString("share_rate");
			}
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return price;
	}
	
	public static String getShareRate2(String str) //using csymbol
	{
		String price ="0.00";
		Connection con = MyConnection.getConnection();
		String sql = "select * from companysharemaster where csymbol = ?";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,str);
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				price = rs.getString("share_rate");
			}
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return price;
	}
	
	public static int changeShareRate(String newrate,String email)
	{
	
		int eff=0;
		Connection con = MyConnection.getConnection();
		String sql = "update companysharemaster set share_rate = ? where email = ?";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,newrate);
			ps.setString(2,email);
			
			eff = ps.executeUpdate();
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return eff;
	}
	
	public static String getShareNo(String email)
	{
		String no ="0";
		Connection con = MyConnection.getConnection();
		String sql = "select * from companysharemaster where email = ?";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,email);
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				no = rs.getString("no_of_shares");
			}
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return no;
	}
	
	public static String getShareNo2(String csymbol)
	{
		String no ="0";
		Connection con = MyConnection.getConnection();
		String sql = "select * from companysharemaster where csymbol = ?";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,csymbol);
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				no = rs.getString("no_of_shares");
			}
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return no;
	}
	
	public static int changeShareNo(String newno,String email)
	{
		int eff=0;
		Connection con = MyConnection.getConnection();
		String sql = "update companysharemaster set no_of_shares = ? where email = ?";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,newno);
			ps.setString(2,email);
			
			eff = ps.executeUpdate();
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return eff;
	}
	
	public static void changeShareNo2(String newno,String csymbol)
	{
		
		Connection con = MyConnection.getConnection();
		String sql = "update companysharemaster set no_of_shares = ? where csymbol = ?";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,newno);
			ps.setString(2,csymbol);
			
			ps.executeUpdate();
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void addmoney(String email, String amt,String msg)
	{
		
		Connection con = MyConnection.getConnection();
		String sql = "insert into companywallet(transid,email,amt,transtype,tdate) values(next_compwallet_transid.nextval,?,?,?,?) ";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,email);
			ps.setString(2, amt);
			ps.setString(3, msg);
			Date d = new Date();
			SimpleDateFormat ft = new SimpleDateFormat("dd/MM/yyyy");
			ps.setString(4,ft.format(d));
			
			ps.executeUpdate();
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

	public static String getcreditmoney(String email)
	{
		String amt = "0";
		Connection con = MyConnection.getConnection();
		String sql = "select SUM(amt) as amount from companywallet where email = ? and transtype = 'credit'";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,email);

			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				amt = rs.getString("amount");
			}
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return amt;
	}
	
	public static String getdebitmoney(String email)
	{
		String amt = "0";
		Connection con = MyConnection.getConnection();
		String sql = "select SUM(amt) as amount from companywallet where email = ? and transtype = 'debit'";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,email);

			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				amt = rs.getString("amount");
			}
			
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return amt;
	}
	
	public static String getCsymbol(String email)
	{
		String csymbol = "0";
		Connection con = MyConnection.getConnection();
		String sql = "select * from companymaster where email = ?";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,email);

			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				csymbol = rs.getString("csymbol");
			}
			
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return csymbol;
	}

	public static ArrayList<String> getShareHolders(String csymbol)
	{
		ArrayList<String> al = new ArrayList<String>();
		Connection con = MyConnection.getConnection();
		String sql = "select custemail,srate,SUM(noofshares) as no, SUM(tvalue) as val from livemarket where csymbol = ? and status='buy' group by custemail,srate";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,csymbol);

			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				al.add(rs.getString("custemail"));
				al.add(rs.getString("srate"));
				al.add(rs.getString("no"));
				al.add(rs.getString("val"));
			}
			
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return al;
	}
	
	public static ResultSet getWalletDetails(String email)
	{
		ResultSet rs = null;
		Connection con = MyConnection.getConnection();
		String sql = "select * from companywallet where email = ?";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,email);

			rs = ps.executeQuery();
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	public static ResultSet getFeedbackMsg(String email)
	{
		ResultSet rs = null;
		Connection con = MyConnection.getConnection();
		String sql = "select * from companyfeedback where remail = ? ";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,email);

			rs = ps.executeQuery();
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	public static String getRevenueDeatils(String email)
	{
		ResultSet rs = null;
		String msg="No Deatils Available !!";
		double r1 =0,r2=0,r3=0;
		int no = 0;
		Connection con = MyConnection.getConnection();
		String sql = "select * from addrevenue where email =? and  ROWNUM <=3 order by sno DESC ";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,email);

			rs = ps.executeQuery();
			
			if(rs.next())
			{
				r1 = Double.parseDouble(rs.getString("revenuedetails"));
				
				while(rs.next())
				{
					r2 = Double.parseDouble(rs.getString("revenuedetails"));
					
					if(r2>r1)
					{
						++no;
					}
					else
					{
						--no;
					}
				}
			}
			
			if(no>=2)
			{
				msg = "Highly Recommended !! - Revenue increased ";
			}
			else if(no>=0 && no <2)
			{
				msg = "Moderately Recommended !! - Revenue fluctuated";
			}
			else
			{
				msg = "Not Recommended !! - Revenue Decreased";
			}
			
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return msg;
	}
	
	public static String getFuturePlansDetails(String str)
	{
		String plans = "No Future Plans Available !!";
		
		Connection con = MyConnection.getConnection();
		String sql = "select * from addfutureplans where email = ?";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, str);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				plans = rs.getString("futureplansdetails");
			}
			
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return plans;
	}
	
}
