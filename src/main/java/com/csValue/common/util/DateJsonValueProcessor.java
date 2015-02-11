package com.csValue.common.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;

public class DateJsonValueProcessor implements JsonValueProcessor {

	public static final String DEFAULT_DATE_PATTERN = "yyyy-MM-dd";

	private DateFormat dateFormat;

	/** 
	* 
	*/

	public DateJsonValueProcessor(String datePattern) {

		if (null == datePattern)

			dateFormat = new SimpleDateFormat(DEFAULT_DATE_PATTERN);

		else

			dateFormat = new SimpleDateFormat(datePattern);
		//System.out.println(dateFormat);

	}

	/*

	* @see net.sf.json.processors.JsonValueProcessor#processArrayValue(java.lang.Object, net.sf.json.JsonConfig) 

	*/

	/* 
	* @see net.sf.json.processors.JsonValueProcessor#processObjectValue(java.lang.String, java.lang.Object, net.sf.json.JsonConfig) 

	*/

	public Object process(Object value) {
		if (value == null) {
			return "";
		}
		return dateFormat.format((Date) value);

	}

	@Override
	public Object processArrayValue(Object arg0, JsonConfig arg1) {
		// TODO Auto-generated method stub
		return process(arg0);
	}

	@Override
	public Object processObjectValue(String arg0, Object arg1, JsonConfig arg2) {
		// TODO Auto-generated method stub
		return process(arg1);
	}

}
