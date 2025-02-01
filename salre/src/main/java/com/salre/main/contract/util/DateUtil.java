package com.salre.main.contract.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
    
	//util.Date  -> sql.Date 
	public static java.sql.Date convertSqlDate(Date dt) {
		return new java.sql.Date(dt.getTime());
	}
	
	public static Date convertDate(String dt) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date d = null;
		try {
			d = sdf.parse(dt);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return d;
	}
	public static Date convertDate2(String dt) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date d = null;
		try {
			d = sdf.parse(dt);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return d;
	}
	public static String converString(Date dt) {
		String s = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		s = sdf.format(dt);
		return s;
	}
	
	
}
