package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.bean.Shares;
import com.utility.MyConnection;

public class SharesDao 
{
	public static int insert(Shares sh)
	{
		int eff = 0;
		
		Connection con = MyConnection.getConnection();
		String sql = "insert into livemarket(transid,custemail,csymbol,srate,noofshares,tvalue,tdate,status) values(next_transid.nextval,?,?,?,?,?,?,?)";
		
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,sh.getCustemail());
			
			ps.setString(2,sh.getCsymbol());
			ps.setString(3,sh.getSrate());
			ps.setString(4,sh.getNoofshares());
			ps.setString(5,sh.getTvalue());
			ps.setString(6,sh.getTdate());
			ps.setString(7,sh.getStatus());
			
			eff = ps.executeUpdate();
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
		return eff;
	}
	
	public static int insertPending(Shares sh)
	{
		int eff = 0;
		
		Connection con = MyConnection.getConnection();
		String sql = "insert into pendingshares(sno,custemail,csymbol,lrate,rrate,noofshares,tvalue,tdate,status) values(next_pending_sno.nextval,?,?,?,?,?,?,?,?)";
		
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,sh.getCustemail());
			
			ps.setString(2,sh.getCsymbol());
			ps.setString(3,sh.getLrate());
			ps.setString(4,sh.getRrate());
			ps.setString(5,sh.getNoofshares());
			ps.setString(6,sh.getTvalue());
			ps.setString(7,sh.getTdate());
			ps.setString(8,sh.getStatus());
			
			eff = ps.executeUpdate();
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return eff;
	}
	
	public static ResultSet getAllDetails(String str)
	{
		ResultSet rs = null;
		
		Connection con = MyConnection.getConnection();
		String sql = "select DISTINCT(csymbol) from livemarket where custemail = ? and status = 'buy' ";
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
	
	public static ResultSet getAllDetails2(String str)
	{
		ResultSet rs = null;
		
		Connection con = MyConnection.getConnection();
		String sql = "select * from livemarket where transid = ? ";
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
	
	public static ResultSet getAllCompDetails()
	{
		ResultSet rs = null;
		
		Connection con = MyConnection.getConnection();
		String sql = "select DISTINCT(csymbol) from shareratedetails";
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
	
	public static String getBuyShareNo(String csymbol,String email)
	{
		String no = "0";
		
		Connection con = MyConnection.getConnection();
		String sql = "select SUM(noofshares) as buycnt from livemarket where custemail = ? and csymbol = ? and status = ? ";
		
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,email);
			ps.setString(2,csymbol);
			ps.setString(3,"buy");
			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				no = rs.getString("buycnt");
			}
			
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return no;
	}
	
	public static String getSellShareNo(String csymbol,String email)
	{
		String no = "0";
		
		Connection con = MyConnection.getConnection();
		String sql = "select SUM(noofshares) as sellcnt from livemarket where custemail = ? and csymbol = ? and status = ? ";
		
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,email);
			ps.setString(2,csymbol);
			ps.setString(3,"sell");
			ResultSet rs = ps.executeQuery();
			
			if(rs.next())
			{
				no = rs.getString("sellcnt");
			}	
			
			if(no == null)
			{
				no = "0";
			}
			
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return no;
	}
	
	public static ResultSet getAllSellingShares(String csymbol,String email)
	{
		ResultSet rs = null;
		
		Connection con = MyConnection.getConnection();
		String sql = "select * from livemarket where csymbol = ? and status = 'sell' ";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, csymbol);
			//ps.setString(2,email);
			rs = ps.executeQuery();
			
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			System.out.println("Error");
		}
		
		return rs;
	}
	
	public static int updateSellerSharesNo(String id,String sleft,String tvalue)
	{
		int eff=0;
		
		Connection con = MyConnection.getConnection();
		String sql = "update livemarket set noofshares = ? , tvalue = ?  where transid = ?";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,sleft);
			ps.setString(2,tvalue );
			ps.setInt(3,Integer.parseInt(id));
			eff = ps.executeUpdate();
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return eff;
	}
	
	public static ResultSet getAllPendingShares(String str)
	{
		ResultSet rs = null;
		
		Connection con = MyConnection.getConnection();
		String sql = "select * from pendingshares where csymbol = ?";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,str);
			
			rs = ps.executeQuery();
			
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	public static ResultSet getAllCustPendingShares(String email)
	{
		ResultSet rs = null;
		
		Connection con = MyConnection.getConnection();
		String sql = "select * from pendingshares where custemail = ?";
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
	
	
	public static int deletePendingShares(int str)
	{
		int eff = 0;
		
		Connection con = MyConnection.getConnection();
		String sql = "delete from pendingshares where sno = ?";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,String.valueOf(str));
			
			eff = ps.executeUpdate();
			
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return eff;
	}
	
	public static int companyTotalShares(String csymbol)
	{
		int no = 0;
		
		Connection con = MyConnection.getConnection();
		String sql = "select SUM(noofshares) as  no from livemarket where csymbol = ? and status = ?";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,csymbol);
			ps.setString(2,"buy");
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				no = Integer.parseInt(rs.getString("no"));
			}
			System.out.println(no);
			
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			System.out.println("No shares found");
		}
		return no;
	}
	
	public static ResultSet custTotalShares(String csymbol)
	{
		 ResultSet rs = null;
		
		Connection con = MyConnection.getConnection();
		String sql = "select SUM(noofshares) as no,custemail from livemarket where csymbol = ? and status = ? group by custemail";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,csymbol);
			ps.setString(2,"buy");
			
			rs = ps.executeQuery();
			
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}

	public static int shareratedetails(String csymbol,String srate,String perchange,String tdate)
	{
		 int eff = 0;
		
		Connection con = MyConnection.getConnection();
		String sql = "insert into shareratedetails(sno,csymbol,srate,perchange,tdate) values(next_sharerate.nextval,?,?,?,?)";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,csymbol);
			ps.setString(2,srate);
			ps.setString(3,perchange);
			ps.setString(4,tdate);
			
			eff = ps.executeUpdate();
			
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return eff;
	}
	
	public static ResultSet getshareratedetails(String csymbol)
	{
		 ResultSet rs = null;
		
		Connection con = MyConnection.getConnection();
		String sql = "select * from shareratedetails where csymbol = ? order by sno";		
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,csymbol);
			
			rs = ps.executeQuery();
			
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	
	public static ArrayList<String> topgainers()
	{
		ArrayList<String> al = new ArrayList<String>();
		
		 String p = "",c="";
		
		Connection con = MyConnection.getConnection();
		String sql = "select SUM(perchange) as per,csymbol from shareratedetails group by csymbol order by per DESC";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				p = rs.getString("per");
				c = rs.getString("csymbol");
				al.add(c);
				al.add(p);
				System.out.println(p+c);
			}
			
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return al;
	}
	
	public static ArrayList<String> toplosers()
	{
		ArrayList<String> al = new ArrayList<String>();
		
		 String p = "",c="";
		
		Connection con = MyConnection.getConnection();
		String sql = "select SUM(perchange) as per,csymbol from shareratedetails group by csymbol order by per ASC";
		try {
			
			PreparedStatement ps = con.prepareStatement(sql);
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				p = rs.getString("per");
				c = rs.getString("csymbol");
				al.add(c);
				al.add(p);
			}
			
		} 
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return al;
	}
	
	public static ResultSet buyingHistory(String email)
	{
		 ResultSet rs = null;
		
		Connection con = MyConnection.getConnection();
		String sql = "select * from livemarket where custemail = ? and status = 'buy'";		
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
	
	public static ResultSet sellingHistory(String email)
	{
		 ResultSet rs = null;
		
		Connection con = MyConnection.getConnection();
		String sql = "select * from livemarket where custemail = ? and status = 'sell'";		
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
