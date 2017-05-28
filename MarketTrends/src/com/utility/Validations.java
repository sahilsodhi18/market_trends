package com.utility;
import java.util.regex.*;

public class Validations 
{
	public static boolean isNumber(String str)
	{
		boolean flag = false;
		flag = Pattern.matches("[0-9]*",str);
		return flag;
	}
	
	public static boolean isAlphabet(String str)
	{
		boolean flag = false;
		flag = Pattern.matches("[a-zA-Z ]*",str);
		return flag;
	}
	
	public static boolean isDecimal(String str)
	{
		boolean flag = false;
		flag = Pattern.matches("[0-9.]*",str);
		return flag;
	}
	
	public static boolean isEmail(String str)
	{
		boolean flag = false;
		flag = Pattern.matches("[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,3}$",str);
		return flag;
	}

	public static boolean isMobile(String str)
	{
		boolean flag = false;
		flag = Pattern.matches("[789][0-9]{9}",str);
		return flag;
	}
	
	public static boolean isPincode(String str)
	{
		boolean flag = false;
		flag = Pattern.matches("[0-9]{6}",str);
		return flag;
	}
	
	public static boolean isEmpty(String str)
	{
		boolean flag = false;
		if(!str.equals(""))
		{
			flag = true;
		}
		return flag;
	}
}
