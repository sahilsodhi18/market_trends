package com.service.project;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.StringTokenizer;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.utility.MyConnection;

/**
 * Servlet implementation class ApplicationInitializer
 */
public class ApplicationInitializer extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ApplicationInitializer() {
        super();
        // TODO Auto-generated constructor stub
    }

    public void init(ServletConfig config) throws ServletException 
    {
		
    	System.out.println("in init..!!");
		
		ServletContext context=config.getServletContext();
		String filePath=context.getRealPath("jsp/tables.txt");
		
		System.out.println("fILEPATH  :"+filePath);
		
		try {
				FileInputStream fis=new FileInputStream(filePath);
				byte b[] =new byte[fis.available()];
				
				System.out.println("length  :"+b.length);
				
				fis.read(b);
				
				String allQuery=new String(b);
				//System.out.println("allQuery  ="+allQuery);
				
				StringTokenizer token=new StringTokenizer(allQuery,"/");
				while(token.hasMoreTokens())
				{	
					String sql=token.nextToken();
					if(sql.trim().equals("stop")){
						break;
					}
				Connection con= MyConnection.getConnection();
				PreparedStatement ps=con.prepareStatement(sql);
				ps.executeUpdate();
				
			}
			
			System.out.println("Table Created...!!");
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
