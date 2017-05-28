package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.bean.Customer;
import com.bean.Customer;
import com.utility.MyConnection;

public class CustomerDao 
{
	public static ResultSet loginCheck(Customer c)
	{
		ResultSet rs = null;
		Connection con = MyConnection.getConnection();
		String sql ="select * from customermaster where email = ? and pwd = ?";
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
	
	public static ResultSet mobileValidate(String mobile)
	{
		ResultSet rs = null;
		
		Connection con = MyConnection.getConnection();
		String sql = "select * from customermaster where mobile = '"+mobile+"'";
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
		String sql = "select * from customermaster where email = '"+email+"'";
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
	
	
	public static void insert(Customer c)
	{
		Connection con = MyConnection.getConnection();
		String sql = "insert into customermaster(memid,name,gender,dob,occupation,income,email,mobile,city,state,country," +
						"pincode,pwd) values(next_cust_memid.nextVal,?,?,?,?,?,?,?,?,?,?,?,?)";
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,c.getFname()+" "+c.getLname());
			ps.setString(2,c.getGender());
			ps.setString(3,c.getDob());
			ps.setString(4,c.getOccupation());
			ps.setString(5,c.getIncome());
			ps.setString(6,c.getEmail());
			ps.setString(7,c.getMobile());
			ps.setString(8,c.getCity());
			ps.setString(9,c.getState());
			ps.setString(10,c.getCountry());
			ps.setString(11,c.getPincode());
			ps.setString(12,c.getPassword());
			
			ps.executeUpdate();
			
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

	
	public static ResultSet passwordValidate(String email, String pwd)
	{
		ResultSet rs = null;
		
		Connection con = MyConnection.getConnection();
		String sql = "select * from customermaster where email = ? and pwd = ?";
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
	
	public static int updateProfile(Customer c,String oldpwd)
	{
		int eff = 0;
		Connection con = MyConnection.getConnection();
		String sql = "update customermaster set city = ? , state =? , country = ? , pincode =? , pwd = ? where email = ?";
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			System.out.println("city---"+c.getCity());
			ps.setString(1,c.getCity());
			ps.setString(2,c.getState());
			ps.setString(3,c.getCountry());
			ps.setString(4,c.getPincode());
			ps.setString(5,c.getPassword());
			ps.setString(6,c.getEmail());
			
			ResultSet rs = CustomerDao.passwordValidate(c.getEmail(),oldpwd);
			
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
		String sql = "update customermaster set pwd = ? where email = ?";
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,pwd);
			ps.setString(2,email);
			
			ResultSet rs = CustomerDao.emailValidate(email);
			
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
	
	
	public static Customer getDeatils(String str)
	{
		Customer c = new Customer();
		
		Connection con = MyConnection.getConnection();
		String sql = "select * from customermaster where email = ?";
		
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,str);
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				String name = rs.getString("name");
				String ch[] = name.split(" ");
				c.setFname(ch[0]);
				c.setLname(ch[1]);
				c.setGender(rs.getString("gender"));
				c.setDob(rs.getString("dob"));
				c.setOccupation(rs.getString("occupation"));
				c.setIncome(rs.getString("income")+" lakhs");
				c.setEmail(rs.getString("email"));
				c.setMobile(rs.getString("mobile"));
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
		
		return c;
	}
	
	public static int add_feedback(String semail,String remail,String msg)
	{
		int eff = 0;
		Connection con = MyConnection.getConnection();
		String sql = "insert into customerfeedback values(next_custfeed_sno.nextval,?,?,?)";
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

	public static void addmoney(String email, String amt,String msg)
	{
		
		Connection con = MyConnection.getConnection();
		String sql = "insert into customerwallet(transid,email,amt,transtype,tdate) values(next_custwallet_transid.nextval,?,?,?,?) ";
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
		String sql = "select SUM(amt) as amount from customerwallet where email = ? and transtype = 'credit'";
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
		String sql = "select SUM(amt) as amount from customerwallet where email = ? and transtype = 'debit'";
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
	
	public static ResultSet getWalletDetails(String email)
	{
		ResultSet rs = null;
		Connection con = MyConnection.getConnection();
		String sql = "select * from customerwallet where email = ? ";
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
		String sql = "select * from customerfeedback where remail = ? ";
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
	
}
