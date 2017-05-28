package com.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MyConnection
{
	private final static String userName = "markettrends" ;
	private final static String password = "markettrends";
	private final static String driver = "oracle.jdbc.driver.OracleDriver";
	private final static String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
	private Connection con = null;
	
	public static Connection getConnection()
	{
		Connection con =null;
		
		try {
			Class.forName(driver);
			
			try {
				con = DriverManager.getConnection(dbURL,userName,password);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return con;
	}
	
	
}
