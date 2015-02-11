package com.csValue.common.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.TimeZone;

public class DateUtil {
	private static Object timeZoneLock = new Object();

	private static String timeZoneList[][] = null;

	private static Map dateFormatCache = new HashMap();

	/**
	 * @param date
	 * @param n
	 * @return
	 */
	public static Date add(Date date, int n) {
		if (date == null)
			return null;
		GregorianCalendar gc = new GregorianCalendar();
		gc.setTime(date);
		gc.add(Calendar.DATE, n);
		return gc.getTime();
	}
	public static int shicha(String date1, String date2) {
		long cha=0;
		try {
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			java.util.Date start = sdf.parse(date1);
			java.util.Date end = sdf.parse(date2);
			cha= end.getTime() - start.getTime();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return (int) (cha/(60*1000));
	}

	/**
	 * @param n
	 * @return
	 */
	public static Date add(int n) {
		return add(new Date(), n);
	}

	/**
	 * @param dateStr
	 * @param pattern
	 * @return
	 */
	public static Date parseDate(String dateStr, String pattern) {
		if (dateStr == null || dateStr.length() == 0 || pattern == null || pattern.length() == 0)
			return null;
		DateFormat fmt = new SimpleDateFormat(pattern);
		Date result = null;
		try {
			result = fmt.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * @param dateStr
	 * @return
	 */
	public static Date parseDate(String dateStr) {
		return parseDate(dateStr, "yyyy-MM-dd HH:mm:ss");
	}

	/**
	 * @param dateStr
	 * @return
	 */
	public static Date parseShortDate(String dateStr) {
		return parseDate(dateStr, "yyyy-MM-dd");
	}

	public static String asHtml(Date d) {
		return asHtml(d, TimeZone.getDefault());
	}

	public static String asHtml(Date date, TimeZone timeZone) {
		String key = timeZone.getID();
		DateFormat formatter = (DateFormat) dateFormatCache.get(key);
		if (formatter == null) {
			formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			formatter.setTimeZone(timeZone);
			dateFormatCache.put(key, formatter);
		}
		synchronized (formatter) {
			String s = formatter.format(date);
			return s;
		}
	}

	public static String asString(Date date) {
		String key = "asString";
		DateFormat formatter = (DateFormat) dateFormatCache.get(key);
		if (formatter == null) {
			formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			dateFormatCache.put(key, formatter);
		}
		return formatter.format(date);
	}

	public static String asShortString(Date date) {
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		return formatter.format(date);
	}

	public static String asShortString(Date date, TimeZone timeZone) {
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		formatter.setTimeZone(timeZone);
		return formatter.format(date);
	}

	public static String asNameSuffix(Date date, TimeZone timeZone) {
		DateFormat formatter = new SimpleDateFormat("yyyy_MM_dd");
		formatter.setTimeZone(timeZone);
		return formatter.format(date);
	}

	public static Date getDate(int time) {
		return new Date((long) time * 1000L);
	}

	public static int currentTimeSeconds() {
		return (int) (System.currentTimeMillis() / 1000L);
	}

	public static int secondsAfter(Date a, Date b) {
		return (int) ((a.getTime() - b.getTime()) / 1000L);
	}

	public static int secondsBefore(Date a, Date b) {
		return secondsAfter(b, a);
	}

	public static Date getDate(int yy, int mm, int dd) {
		return (new GregorianCalendar(yy, mm - 1, dd)).getTime();
	}

	public static int unixTimeStamp() {
		return (int) (System.currentTimeMillis() / 1000L);
	}

	public static int unixTimeStamp(Date date) {
		return (int) (date.getTime() / 1000L);
	}

	public static String[][] getTimeZoneList() {
		synchronized (timeZoneLock) {
			if (timeZoneList == null) {
				Date now = new Date();
				String timeZoneIDs[] = TimeZone.getAvailableIDs();
				timeZoneList = new String[timeZoneIDs.length][2];
				for (int i = 0; i < timeZoneList.length; i++) {
					String zoneID = timeZoneIDs[i];
					timeZoneList[i][0] = zoneID;
					timeZoneList[i][1] = getTimeZoneName(zoneID, now, Locale.getDefault());
				}

			}
		}
		return timeZoneList;
	}

	private static String getTimeZoneName(String zoneID, Date now, Locale locale) {
		TimeZone zone = TimeZone.getTimeZone(zoneID);
		StringBuffer buf = new StringBuffer();
		int offset = zone.getRawOffset();
		if (zone.inDaylightTime(now) && zone.useDaylightTime())
			offset = (int) ((long) offset + 0x36ee80L);
		if (offset < 0)
			buf.append("(GMT-");
		else
			buf.append("(GMT+");
		offset = Math.abs(offset);
		int hours = offset / 0x36ee80;
		int minutes = (offset % 0x36ee80) / 60000;
		if (hours < 10)
			buf.append("0").append(hours).append(":");
		else
			buf.append(hours).append(":");
		if (minutes < 10)
			buf.append("0").append(minutes);
		else
			buf.append(minutes);
		buf.append(") ").append(zoneID).append(" ");
		buf.append(zone.getDisplayName(true, 0, locale));
		return buf.toString();
	}
	public static String getNowTime(){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		 return sdf.format(new Date());
	}
	public static String getNowTime(String pattent){
		SimpleDateFormat sdf=new SimpleDateFormat(pattent);
		return sdf.format(new Date());
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Date date = new Date();
		System.out.println(getNowTime());
	
	}
}