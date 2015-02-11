/**
 * @(#) DateUtil.java
 *
 * Copyright 2000-2005 by LG CNS, Inc.,
 * All rights reserved.
 */
package ssdevframework.core.util;

// Java API
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.commons.lang.time.DateUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springside.modules.utils.web.struts2.Struts2Utils;

import ssdevframework.core.collection.CData;

/**
 * <pre>
 *
 *  사용예제
 *
 *     private void testDateUtil()
 *     throws Exception
 *     {
 *
 *     System.out.println( DateUtil.getCurrentDateString() ) ;                                        // 20020719                출력
 *     System.out.println( DateUtil.getCurrentDateString(&quot;yyyy/MM/dd&quot;) ) ;                  // 2002/07/19              출력
 *     System.out.println( DateUtil.getCurrentTimeString() ) ;                                        // 094837                  출력
 *     System.out.println( DateUtil.getCurrentDateString(&quot;HH:mm:ss&quot;) ) ;                    // 09:48:37                출력
 *     System.out.println( DateUtil.getCurrentDateString(&quot;hh:mm:ss&quot;) ) ;                    // 09:48:37                출력
 *     System.out.println( DateUtil.convertFormat(&quot;20020716&quot;) ) ;                           // 2002/07/16              출력
 *     System.out.println( DateUtil.convertFormat(&quot;20020716&quot;,&quot;yyyy년MM월dd일&quot;) ) ; // 2002년07월16일           출력
 *     System.out.println( DateUtil.convertToTimestamp(&quot;20020717&quot;) ) ;                      // 2002-07-17 09:48:37.459 출력
 *     System.out.println( DateUtil.convertToTimestampHMS(&quot;20020717123456&quot;) ) ;             // 2002-07-17 12:34:56.459 출력
 *
 *     String fromDateDash = &quot;2002-07-18&quot; ;
 *     String fromDate = &quot;20020718&quot; ;
 *
 *     String toDateDash = &quot;2001-05-15&quot; ;
 *     String toDate = &quot;20010515&quot; ;
 *
 *     System.out.println( DateUtil.addDays( fromDate , 3 ) ) ;                                          // 20020721                출력
 *     System.out.println( DateUtil.addDays( fromDateDash , 3  , &quot;yyyy-MM-dd&quot; ) ) ;                      // 2002-07-21              출력
 *
 *     System.out.println( DateUtil.addMonths( fromDate , 3 ) ) ;                                        // 20021018                출력
 *     System.out.println( DateUtil.addMonths( fromDateDash , 3  , &quot;yyyy-MM-dd&quot; ) ) ;                    // 2002-10-18              출력
 *
 *     System.out.println( DateUtil.addYears( fromDate , 3 ) ) ;                                         // 20050717                출력
 *     System.out.println( DateUtil.addYears( fromDateDash , 3  , &quot;yyyy-MM-dd&quot; ) ) ;                     // 2005-07-17              출력
 *
 *     System.out.println( DateUtil.yearsBetween( fromDate , toDate ) ) ;                                // -1                      출력
 *     System.out.println( DateUtil.yearsBetween( fromDateDash , toDateDash  , &quot;yyyy-MM-dd&quot; ) ) ;        // -1                      출력
 *
 *     System.out.println( DateUtil.daysBetween( fromDate , toDate ) ) ;                                 // -429                    출력
 *     System.out.println( DateUtil.daysBetween( fromDateDash , toDateDash  , &quot;yyyy-MM-dd&quot; ) ) ;         // -429                    출력
 *
 *     System.out.println( DateUtil.monthsBetween( fromDate , toDate ) ) ;                               // -14                     출력
 *     System.out.println( DateUtil.monthsBetween( fromDateDash , toDateDash  , &quot;yyyy-MM-dd&quot; ) ) ;       // -14                     출력
 *
 *     System.out.println( DateUtil.whichDay( fromDate  ) ) ;                                            // 5                       출력
 *     System.out.println( DateUtil.whichDay( fromDateDash  , &quot;yyyy-MM-dd&quot; ) ) ;                         // 5                       출력
 *
 *     System.out.println( DateUtil.lastDayOfMonth( fromDate  ) ) ;                                      // 20020731                출력
 *     System.out.println( DateUtil.lastDayOfMonth( fromDateDash  , &quot;yyyy-MM-dd&quot; ) ) ;                   // 2002-07-31              출력
 *
 *     }
 *
 * </pre>
 *
 * @since 2011. 5. 10.
 * @version 1.0
 * @author shijl
 */
public class DateUtil {

	/**
	 *
	 * <pre>	
	 *    获取数据库系统的日期	 年月日
	 * </pre>
	 *
	 * @param None
	 * @return String yyyy-MM-dd 
	 * @exception Exception
	 */

	public static String getDBdate() throws Exception {
		WebApplicationContext wap = WebApplicationContextUtils.getWebApplicationContext(Struts2Utils.getRequest()
				.getSession().getServletContext());
		SqlSessionFactory sqlSessionFactory = (SqlSessionFactory) wap.getBean("sqlSessionFactory");
		SqlSession session = sqlSessionFactory.openSession();

		CData result = new CData();
		try {
			result = (CData) session.selectOne("utilManage.getDBdate");
		} finally {
			session.close();
		}
		return result.getString("dbDate");
	}

	/**
	 *
	 * <pre>	
	 *    获取数据库系统的日期	 年月日 时分秒
	 * </pre>
	 *
	 * @param None
	 * @return String yyyymmddHH24MISS
	 * @exception Exception
	 */
	public static String getDBdateBySec() throws Exception {
		WebApplicationContext wap = WebApplicationContextUtils.getWebApplicationContext(Struts2Utils.getRequest()
				.getSession().getServletContext());
		SqlSessionFactory sqlSessionFactory = (SqlSessionFactory) wap.getBean("sqlSessionFactory");
		SqlSession session = sqlSessionFactory.openSession();

		CData result = new CData();
		try {
			result = (CData) session.selectOne("utilManage.getDBdateBySec");
		} finally {
			session.close();
		}
		return result.getString("dbDate");
	}

	/**
	 *
	 * <pre>	
	 *    获取数据库系统的日期年月	 
	 * </pre>
	 *
	 * @param None
	 * @return String yyyy-MM
	 * @exception Exception
	 */
	public static String getDBdateMonth() throws Exception {
		WebApplicationContext wap = WebApplicationContextUtils.getWebApplicationContext(Struts2Utils.getRequest()
				.getSession().getServletContext());
		SqlSessionFactory sqlSessionFactory = (SqlSessionFactory) wap.getBean("sqlSessionFactory");
		SqlSession session = sqlSessionFactory.openSession();

		CData result = new CData();
		try {
			result = (CData) session.selectOne("utilManage.getDBdateMonth");
		} finally {
			session.close();
		}
		return result.getString("dbDate");
	}

	/**
	 *
	 * <pre>	
	 *    获取数据库系统的日期+i(月) 返回yyyy-mm
	 * </pre>
	 *
	 * @param None
	 * @return String yyyy-MM
	 * @exception Exception
	 */
	public static String getDBdateMonthNext(int i) throws Exception {
		WebApplicationContext wap = WebApplicationContextUtils.getWebApplicationContext(Struts2Utils.getRequest()
				.getSession().getServletContext());
		SqlSessionFactory sqlSessionFactory = (SqlSessionFactory) wap.getBean("sqlSessionFactory");
		SqlSession session = sqlSessionFactory.openSession();

		CData input = new CData();
		input.setInt("num", i);
		CData result = new CData();

		try {
			result = (CData) session.selectOne("utilManage.getDBdateMonthNext", input);
		} finally {
			session.close();
		}
		return result.getString("dbDate");
	}

	/**
	* 系统日期+i(月)   返回yyyy-mm-dd
	* @return yyyy-mm-dd
	* @throws LException
	*/

	public static String getDBdateMonthNextByDay(int i) throws Exception {
		WebApplicationContext wap = WebApplicationContextUtils.getWebApplicationContext(Struts2Utils.getRequest()
				.getSession().getServletContext());
		SqlSessionFactory sqlSessionFactory = (SqlSessionFactory) wap.getBean("sqlSessionFactory");
		SqlSession session = sqlSessionFactory.openSession();
		CData input = new CData();
		input.setInt("num", i);
		CData result = new CData();

		try {
			result = (CData) session.selectOne("utilManage.getDBdateMonthNextByDay", input);
		} finally {
			session.close();
		}
		return result.getString("dbDate");
	}

	/**
	* 系统日期+i(天)   返回yyyy-mm-dd
	* @return yyyy-mm-dd
	* @throws LException
	*/

	public static String getDBdateAddedDay(int i) throws Exception {
		WebApplicationContext wap = WebApplicationContextUtils.getWebApplicationContext(Struts2Utils.getRequest()
				.getSession().getServletContext());
		SqlSessionFactory sqlSessionFactory = (SqlSessionFactory) wap.getBean("sqlSessionFactory");
		SqlSession session = sqlSessionFactory.openSession();
		CData input = new CData();
		input.setInt("num", i);
		CData result = new CData();

		try {
			result = (CData) session.selectOne("utilManage.getDBdateAddedDay", input);
		} finally {
			session.close();
		}
		return result.getString("dbDate");
	}

	public static String getCurrentDateString() throws Exception {
		return getCurrentDateString("yyyyMMdd");
	}

	/**
	 *
	 * <pre>
	 *
	 *    현재 시각을  HHmmss 형식으로 반환한다.
	 *
	 * </pre>
	 *
	 * @param None
	 * @return String HHmmss 형식의 현재 시각
	 * @exception Exception
	 */
	public static String getCurrentTimeString() throws Exception {
		return getCurrentDateString("HHmmss");
	}

	/**
	 *
	 * <pre>
	 *
	 *    현재날짜를 주어진 pattern 에 따라 반환한다.
	 *
	 * </pre>
	 *
	 * @param pattern
	 *            SimpleDateFormat 에 적용할 pattern
	 * @return String pattern 형식의 현재날짜
	 * @exception Exception
	 */
	public static String getCurrentDateString(String pattern) throws Exception {
		return convertToString(getCurrentTimeStamp(), pattern);
	}

	/**
	 * java.util.Date를 주어진 패턴의 스트링 타입으로 변환한다.
	 *
	 * @param date
	 * @param pattern
	 * @return
	 */
	public static String formatDate(java.util.Date date, String pattern) {
		return DateFormatUtils.format(date, pattern);
	}

	/**
	 * yyyyMMdd 형식의 스트링을 java.util.Date 타입으로 변환한다.
	 * 변환 실패시 null을 리턴.
	 *
	 * @param yyyyMMdd
	 * @return
	 */
	public static java.util.Date parseDate(String yyyyMMdd) {
		if (yyyyMMdd == null || yyyyMMdd.length() != 8)
			return null;

		java.util.Date date = null;

		try {
			date = DateUtils.parseDate(yyyyMMdd, new String[] { "yyyyMMdd" });
		} catch (Exception e) {
			return null;
		}

		return date;
	}

	/**
	 *
	 * <pre>
	 *
	 *    yyyyMMdd 형식의 날짜를 yyyy/MM/dd 형식으로 반환한다.
	 *
	 * </pre>
	 *
	 * @param dateData
	 *            yyyyMMdd 형식의 날짜
	 * @return String yyyy/MM/dd 형식의 해당 날짜
	 * @exception Exception
	 */
	public static String convertFormat(String dateData) throws Exception {
		return convertFormat(dateData, "yyyy/MM/dd");
	}

	/**
	 *
	 * <pre>
	 *
	 *    yyyyMMdd 형식의 날짜를 yyyy/MM/dd 형식으로 반환한다.
	 *
	 * </pre>
	 *
	 * @param dateData
	 *            yyyyMMdd 형식의 날짜
	 * @param format
	 *            SimpleDateFormat 에 적용할 pattern
	 * @return String pattern 형식의 해당 날짜
	 * @exception Exception
	 */

	public static String convertFormat(String dateData, String format) throws Exception {

		return convertToString(convertToTimestamp(dateData), format);

	}

	/**
	 *
	 * <pre>
	 *
	 *    yyyyMMdd 형식의 날짜를 yyyy/MM/dd 형식으로 반환한다.
	 *
	 * </pre>
	 *
	 * @param None
	 * @return Timestamp 현재 Timestamp 값
	 * @exception Exception
	 */

	public static Timestamp getCurrentTimeStamp() throws Exception {

		try {
			Calendar cal = new GregorianCalendar();
			Timestamp result = new Timestamp(cal.getTime().getTime());
			return result;
		} catch (Exception e) {
			throw new Exception("[DateUtil][getCurrentTimeStamp]" + e.getMessage(), e);
		}

	}

	/**
	 *
	 * <pre>
	 *
	 *    yyyyMMdd 형식의 Timestamp 날짜를 yyyy/MM/dd 형식으로 반환한다.
	 *
	 * </pre>
	 *
	 * @param dateData
	 *            Timestamp 형식의 날짜
	 * @return String yyyy/MM/dd 형식의 Timestamp 날짜
	 * @exception Exception
	 */
	public static String convertToString(Timestamp dateData) throws Exception {

		return convertToString(dateData, "yyyy/MM/dd");

	}

	/**
	 *
	 * <pre>
	 *
	 *    yyyyMMdd 형식의 Timestamp 날짜를 pattern 에 따른 형식으로 반환한다.
	 *
	 * </pre>
	 *
	 * @param dateData
	 *            Timestamp 형식의 날짜
	 * @param pattern
	 *            SimpleDateFormat 에 적용할 pattern
	 * @return String yyyy/MM/dd 형식의 Timestamp 날짜
	 * @exception None
	 */
	public static String convertToString(Timestamp dateData, String pattern) throws Exception {
		return convertToString(dateData, pattern, java.util.Locale.CHINA);
	}

	/**
	 *
	 * <pre>
	 *
	 *    yyyyMMdd 형식의 Timestamp 날짜를 pattern 과 locale  에 따른 형식으로 반환한다.
	 *
	 * </pre>
	 *
	 * @param dateData
	 *            Timestamp 형식의 날짜
	 * @param pattern
	 *            SimpleDateFormat 에 적용할 pattern
	 * @param locale
	 *            국가별 LOCALE
	 * @return String pattern 형식의 Timestamp 날짜
	 * @exception Exception
	 */
	public static String convertToString(Timestamp dateData, String pattern, java.util.Locale locale) throws Exception {
		try {

			if (dateData == null) {
				return null;
			}

			SimpleDateFormat formatter = new SimpleDateFormat(pattern, locale);
			//formatter.applyPattern( pattern );

			return formatter.format(dateData);
		} catch (Exception e) {
			throw new Exception("[DateUtil][convertToString]" + e.getMessage(), e);
		}

	}

	/**
	 *
	 * <pre>
	 *
	 *    yyyyMMdd 형식의  날짜를 Timestamp 로  반환한다.
	 *
	 * </pre>
	 *
	 * @param dateData
	 *            yyyyMMdd 형식의 날짜
	 * @return Timestamp 형식의 해당 날짜
	 * @exception Exception
	 */
	public static Timestamp convertToTimestamp(String dateData) throws Exception {

		try {

			if (dateData == null)
				return null;
			if (dateData.trim().equals(""))
				return null;

			int dateObjLength = dateData.length();

			String yearString = "2002";
			String monthString = "01";
			String dayString = "01";

			if (dateObjLength >= 4) {
				yearString = dateData.substring(0, 4);
			}
			if (dateObjLength >= 6) {
				monthString = dateData.substring(4, 6);
			}
			if (dateObjLength >= 8) {
				dayString = dateData.substring(6, 8);
			}

			int year = Integer.parseInt(yearString);
			int month = Integer.parseInt(monthString) - 1;
			int day = Integer.parseInt(dayString);

			Calendar cal = new GregorianCalendar();
			cal.set(year, month, day);
			//cal.getTime();
			return new Timestamp(cal.getTime().getTime());

		} catch (Exception e) {
			throw new Exception("[DateUtil][convertToTimestamp]" + e.getMessage(), e);
		}

	}

	/**
	 *
	 * <pre>
	 *
	 *    yyyyMMddHHmmss 형식의  날짜시각을 Timestamp 로  반환한다.
	 *
	 * </pre>
	 *
	 * @param dateData
	 *            yyyyMMddHHmmss 형식의 날짜시각
	 * @return Timestamp 형식의 해당 날짜시각
	 * @exception Exception
	 */
	public static Timestamp convertToTimestampHMS(String dateData) throws Exception {
		try {

			if (dateData == null)
				return null;
			if (dateData.trim().equals(""))
				return null;

			String yearString = dateData.substring(0, 4);
			String monthString = dateData.substring(4, 6);
			String dayString = dateData.substring(6, 8);
			String hourString = dateData.substring(8, 10);
			String minString = dateData.substring(10, 12);
			String secString = dateData.substring(12, 14);

			int year = Integer.parseInt(yearString);
			int month = Integer.parseInt(monthString) - 1;
			int day = Integer.parseInt(dayString);
			int hour = Integer.parseInt(hourString);
			int min = Integer.parseInt(minString);
			int sec = Integer.parseInt(secString);

			Calendar cal = new GregorianCalendar();
			cal.set(year, month, day, hour, min, sec);

			return new Timestamp(cal.getTime().getTime());

		} catch (Exception e) {
			throw new Exception("[DateUtil][convertToTimestampHMS]" + e.getMessage(), e);
		}

	}

	/**
	 * check date string validation with an user defined format.
	 *
	 * @param s
	 *            date string you want to check.
	 * @param format
	 *            string representation of the date format. For example,
	 *            "yyyy-MM-dd".
	 * @return date java.util.Date
	 */
	private static java.util.Date check(String s, String format) throws java.text.ParseException {
		if (s == null)
			throw new java.text.ParseException("date string to check is null", 0);
		if (format == null)
			throw new java.text.ParseException("format string to check date is null", 0);

		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(format, java.util.Locale.CHINA);
		java.util.Date date = null;
		try {
			date = formatter.parse(s);
		} catch (java.text.ParseException e) {
			/*
			 * throw new java.text.ParseException( e.getMessage() + " with
			 * format \"" + format + "\"", e.getErrorOffset() );
			 */
			throw new java.text.ParseException(" wrong date:\"" + s + "\" with format \"" + format + "\"", 0);
		}

		if (!formatter.format(date).equals(s))
			throw new java.text.ParseException("Out of bound date:\"" + s + "\" with format \"" + format + "\"", 0);
		return date;
	}

	/**
	 * check date string validation with the default format "yyyyMMdd".
	 *
	 * @param s
	 *            date string you want to check with default format "yyyyMMdd"
	 * @return boolean true 날짜 형식이 맞고, 존재하는 날짜일 때 false 날짜 형식이 맞지 않거나, 존재하지 않는
	 *         날짜일 때
	 * @exception Exception
	 */
	public static boolean isValid(String s) throws Exception {
		return DateUtil.isValid(s, "yyyyMMdd");
	}

	/**
	 * check date string validation with an user defined format.
	 *
	 * @param s
	 *            date string you want to check.
	 * @param format
	 *            string representation of the date format. For example,
	 *            "yyyy-MM-dd".
	 * @return boolean true 날짜 형식이 맞고, 존재하는 날짜일 때 false 날짜 형식이 맞지 않거나, 존재하지 않는
	 *         날짜일 때
	 * @exception Exception
	 */
	public static boolean isValid(String s, String format) throws Exception {
		/*
		 * if ( s == null ) throw new NullPointerException("date string to check
		 * is null"); if ( format == null ) throw new
		 * NullPointerException("format string to check date is null");
		 */
		try {

			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(format, java.util.Locale.CHINA);
			java.util.Date date = null;
			try {
				date = formatter.parse(s);
			} catch (java.text.ParseException e) {
				return false;
			}

			if (!formatter.format(date).equals(s))
				return false;

			return true;

		} catch (Exception e) {
			throw new Exception("[DateUtil][isValid]" + e.getMessage(), e);
		}

	}

	/**
	 * return days between two date strings with default defined
	 * format.(yyyyMMdd)
	 *
	 * @param s
	 *            date string you want to check.
	 * @return int 날짜 형식이 맞고, 존재하는 날짜일 때 요일을 리턴 형식이 잘못 되었거나 존재하지 않는 날짜:
	 *         java.text.ParseException 발생 0: 일요일 (java.util.Calendar.SUNDAY 와
	 *         비교) 1: 월요일 (java.util.Calendar.MONDAY 와 비교) 2: 화요일
	 *         (java.util.Calendar.TUESDAY 와 비교) 3: 수요일
	 *         (java.util.Calendar.WENDESDAY 와 비교) 4: 목요일
	 *         (java.util.Calendar.THURSDAY 와 비교) 5: 금요일
	 *         (java.util.Calendar.FRIDAY 와 비교) 6: 토요일
	 *         (java.util.Calendar.SATURDAY 와 비교) 예) String s = "20000529"; int
	 *         dayOfWeek = whichDay(s, format); if (dayOfWeek ==
	 *         java.util.Calendar.MONDAY) System.out.println(" 월요일: " +
	 *         dayOfWeek); if (dayOfWeek == java.util.Calendar.TUESDAY)
	 *         System.out.println(" 화요일: " + dayOfWeek);
	 * @exception Exception
	 */
	public static int whichDay(String s) throws Exception {
		return whichDay(s, "yyyyMMdd");
	}

	/**
	 * return days between two date strings with user defined format.
	 *
	 * @param s
	 *            date string you want to check.
	 * @param format
	 *            string representation of the date format. For example,
	 *            "yyyy-MM-dd".
	 * @return int 날짜 형식이 맞고, 존재하는 날짜일 때 요일을 리턴 형식이 잘못 되었거나 존재하지 않는 날짜:
	 *         java.text.ParseException 발생 0: 일요일 (java.util.Calendar.SUNDAY 와
	 *         비교) 1: 월요일 (java.util.Calendar.MONDAY 와 비교) 2: 화요일
	 *         (java.util.Calendar.TUESDAY 와 비교) 3: 수요일
	 *         (java.util.Calendar.WENDESDAY 와 비교) 4: 목요일
	 *         (java.util.Calendar.THURSDAY 와 비교) 5: 금요일
	 *         (java.util.Calendar.FRIDAY 와 비교) 6: 토요일
	 *         (java.util.Calendar.SATURDAY 와 비교) 예) String s = "2000-05-29";
	 *         int dayOfWeek = whichDay(s, "yyyy-MM-dd"); if (dayOfWeek ==
	 *         java.util.Calendar.MONDAY) System.out.println(" 월요일: " +
	 *         dayOfWeek); if (dayOfWeek == java.util.Calendar.TUESDAY)
	 *         System.out.println(" 화요일: " + dayOfWeek);
	 * @exception Exception
	 */
	public static int whichDay(String s, String format) throws Exception {
		try {
			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(format, java.util.Locale.CHINA);
			java.util.Date date = check(s, format);

			java.util.Calendar calendar = formatter.getCalendar();
			calendar.setTime(date);
			return calendar.get(java.util.Calendar.DAY_OF_WEEK);
		} catch (Exception e) {
			throw new Exception("[DateUtil][whichDay]" + e.getMessage(), e);
		}
	}

	/**
	 * return days between two date strings with default defined
	 * format.("yyyyMMdd")
	 *
	 * @param String
	 *            from date string
	 * @param String
	 *            to date string
	 * @return int 날짜 형식이 맞고, 존재하는 날짜일 때 2개 일자 사이의 나이 리턴 형식이 잘못 되었거나 존재하지 않는 날짜:
	 *         java.text.ParseException 발생
	 * @exception Exception
	 */
	public static int daysBetween(String from, String to) throws Exception {
		return daysBetween(from, to, "yyyyMMdd");
	}

	/**
	 * return days between two date strings with user defined format.
	 *
	 * @param String
	 *            from date string
	 * @param String
	 *            to date string
	 * @return int 날짜 형식이 맞고, 존재하는 날짜일 때 2개 일자 사이의 일자 리턴 형식이 잘못 되었거나 존재하지 않는 날짜:
	 *         java.text.ParseException 발생
	 * @exception Exception
	 */
	public static int daysBetween(String from, String to, String format) throws Exception {
		// java.text.SimpleDateFormat formatter =
		// new java.text.SimpleDateFormat (format, java.util.Locale.CHINA);
		try {

			java.util.Date d1 = check(from, format);
			java.util.Date d2 = check(to, format);

			long duration = d2.getTime() - d1.getTime();

			return (int) (duration / (1000 * 60 * 60 * 24));
			// seconds in 1 day
		} catch (Exception e) {
			throw new Exception("[DateUtil][daysBetween]" + e.getMessage(), e);
		}
	}

	/**
	 * return years between two date strings with default defined
	 * format.("yyyyMMdd")
	 *
	 * @param String
	 *            from date string
	 * @param String
	 *            to date string
	 * @return int 날짜 형식이 맞고, 존재하는 날짜일 때 2개 일자 사이의 나이 리턴 형식이 잘못 되었거나 존재하지 않는 날짜:
	 *         java.text.ParseException 발생
	 * @exception Exception
	 */
	public static int yearsBetween(String from, String to) throws Exception {
		return yearsBetween(from, to, "yyyyMMdd");
	}

	/**
	 * return years between two date strings with user defined format.
	 *
	 * @param String
	 *            from date string
	 * @param String
	 *            to date string
	 * @param format
	 *            string representation of the date format. For example,
	 *            "yyyy-MM-dd".
	 * @return int 날짜 형식이 맞고, 존재하는 날짜일 때 2개 일자 사이의 나이 리턴 형식이 잘못 되었거나 존재하지 않는 날짜:
	 *         java.text.ParseException 발생
	 * @exception Exception
	 */
	public static int yearsBetween(String from, String to, String format) throws Exception {
		return (int) (daysBetween(from, to, format) / 365);
	}

	/**
	 * return add day to date strings
	 *
	 * @param String
	 *            date string
	 * @param int
	 *            더할 일수
	 * @return String 날짜 형식이 맞고, 존재하는 날짜일 때 일수 더하기 형식이 잘못 되었거나 존재하지 않는 날짜:
	 *         java.text.ParseException 발생
	 * @exception Exception
	 */
	public static String addDays(String s, int day) throws Exception {
		return addDays(s, day, "yyyyMMdd");
	}

	/**
	 * return add day to date strings with user defined format.
	 *
	 * @param String
	 *            date string
	 * @param String
	 *            더할 일수
	 * @param format
	 *            string representation of the date format. For example,
	 *            "yyyy-MM-dd".
	 * @return int 날짜 형식이 맞고, 존재하는 날짜일 때 일수 더하기 형식이 잘못 되었거나 존재하지 않는 날짜:
	 *         java.text.ParseException 발생
	 * @exception Exception
	 */
	public static String addDays(String s, int day, String format) throws Exception {
		try {

			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(format, java.util.Locale.CHINA);
			java.util.Date date = check(s, format);

			date.setTime(date.getTime() + ((long) day * 1000 * 60 * 60 * 24));
			return formatter.format(date);
		} catch (Exception e) {
			throw new Exception("[DateUtil][addDays]" + e.getMessage(), e);
		}
	}

	/**
	 * return add month to date strings
	 *
	 * @param String
	 *            date string
	 * @param int
	 *            더할 월수
	 * @return String 날짜 형식이 맞고, 존재하는 날짜일 때 월수 더하기 형식이 잘못 되었거나 존재하지 않는 날짜:
	 *         java.text.ParseException 발생
	 * @exception Exception
	 */
	public static String addMonths(String s, int month) throws Exception {
		return addMonths(s, month, "yyyyMMdd");
	}

	/**
	 * return add month to date strings with user defined format.
	 *
	 * @param String
	 *            date string
	 * @param int
	 *            더할 월수
	 * @param format
	 *            string representation of the date format. For example,
	 *            "yyyy-MM-dd".
	 * @return String 날짜 형식이 맞고, 존재하는 날짜일 때 월수 더하기 형식이 잘못 되었거나 존재하지 않는 날짜:
	 *         java.text.ParseException 발생
	 * @exception Exception
	 */
	public static String addMonths(String s, int addMonth, String format) throws Exception {
		try {

			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(format, java.util.Locale.CHINA);
			java.util.Date date = check(s, format);

			java.text.SimpleDateFormat yearFormat = new java.text.SimpleDateFormat("yyyy", java.util.Locale.CHINA);
			java.text.SimpleDateFormat monthFormat = new java.text.SimpleDateFormat("MM", java.util.Locale.CHINA);
			java.text.SimpleDateFormat dayFormat = new java.text.SimpleDateFormat("dd", java.util.Locale.CHINA);
			int year = Integer.parseInt(yearFormat.format(date));
			int month = Integer.parseInt(monthFormat.format(date));
			int day = Integer.parseInt(dayFormat.format(date));

			month += addMonth;
			if (addMonth > 0) {
				while (month > 12) {
					month -= 12;
					year += 1;
				}
			} else {
				while (month <= 0) {
					month += 12;
					year -= 1;
				}
			}
			java.text.DecimalFormat fourDf = new java.text.DecimalFormat("0000");
			java.text.DecimalFormat twoDf = new java.text.DecimalFormat("00");
			String tempDate = String.valueOf(fourDf.format(year)) + String.valueOf(twoDf.format(month))
					+ String.valueOf(twoDf.format(day));
			java.util.Date targetDate = null;

			try {
				targetDate = check(tempDate, "yyyyMMdd");
			} catch (java.text.ParseException pe) {
				day = lastDay(year, month);
				tempDate = String.valueOf(fourDf.format(year)) + String.valueOf(twoDf.format(month))
						+ String.valueOf(twoDf.format(day));
				targetDate = check(tempDate, "yyyyMMdd");
			}

			return formatter.format(targetDate);
		} catch (Exception e) {
			throw new Exception("[DateUtil][addMonths]" + e.getMessage(), e);
		}
	}

	/**
	 * return add year to date strings
	 *
	 * @param String
	 *            s string
	 * @param int
	 *            더할 년수
	 * @return String 날짜 형식이 맞고, 존재하는 날짜일 때 년수 더하기 형식이 잘못 되었거나 존재하지 않는 날짜:
	 *         java.text.ParseException 발생
	 * @exception Exception
	 */

	public static String addYears(String s, int year) throws Exception {
		return addYears(s, year, "yyyyMMdd");
	}

	/**
	 * return add year to date strings with user defined format.
	 *
	 * @param String
	 *            date string
	 * @param int
	 *            더할 년수
	 * @param format
	 *            string representation of the date format. For example,
	 *            "yyyy-MM-dd".
	 * @return String 날짜 형식이 맞고, 존재하는 날짜일 때 년수 더하기 형식이 잘못 되었거나 존재하지 않는 날짜:
	 *         java.text.ParseException 발생
	 * @exception Exception
	 */
	public static String addYears(String s, int year, String format) throws Exception {
		try {

			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(format, java.util.Locale.CHINA);
			java.util.Date date = check(s, format);
			date.setTime(date.getTime() + ((long) year * 1000 * 60 * 60 * 24 * (365)));
			return formatter.format(date);
		} catch (Exception e) {
			throw new Exception("[DateUtil][addYears]" + e.getMessage(), e);
		}
	}

	/**
	 * return months between two date strings
	 *
	 * @param String
	 *            from date string
	 * @param String
	 *            to date string
	 * @return int 날짜 형식이 맞고, 존재하는 날짜일 때 2개 일자 사이의 개월수 리턴 형식이 잘못 되었거나 존재하지 않는
	 *         날짜: java.text.ParseException 발생
	 * @exception Exception
	 */
	public static int monthsBetween(String from, String to) throws Exception {
		return monthsBetween(from, to, "yyyyMMdd");
	}

	/**
	 * return months between two date strings with user defined format.
	 *
	 * @param String
	 *            from date string
	 * @param String
	 *            to date string
	 * @return int 날짜 형식이 맞고, 존재하는 날짜일 때 2개 일자 사이의개월수 리턴 형식이 잘못 되었거나 존재하지 않는 날짜:
	 *         java.text.ParseException 발생
	 * @exception Exception
	 */
	public static int monthsBetween(String from, String to, String format) throws Exception {
		//java.text.SimpleDateFormat formatter =
		//    new java.text.SimpleDateFormat (format, java.util.Locale.CHINA);

		try {

			java.util.Date fromDate = check(from, format);
			java.util.Date toDate = check(to, format);

			// if two date are same, return 0.
			if (fromDate.compareTo(toDate) == 0)
				return 0;

			java.text.SimpleDateFormat yearFormat = new java.text.SimpleDateFormat("yyyy", java.util.Locale.CHINA);
			java.text.SimpleDateFormat monthFormat = new java.text.SimpleDateFormat("MM", java.util.Locale.CHINA);
			java.text.SimpleDateFormat dayFormat = new java.text.SimpleDateFormat("dd", java.util.Locale.CHINA);

			int fromYear = Integer.parseInt(yearFormat.format(fromDate));
			int toYear = Integer.parseInt(yearFormat.format(toDate));
			int fromMonth = Integer.parseInt(monthFormat.format(fromDate));
			int toMonth = Integer.parseInt(monthFormat.format(toDate));
			int fromDay = Integer.parseInt(dayFormat.format(fromDate));
			int toDay = Integer.parseInt(dayFormat.format(toDate));

			int result = 0;
			result += ((toYear - fromYear) * 12);
			result += (toMonth - fromMonth);

			//        if (((toDay - fromDay) < 0) ) result +=
			// fromDate.compareTo(toDate);
			// ceil과 floor의 효과
			if (((toDay - fromDay) > 0))
				result += toDate.compareTo(fromDate);

			return result;
		} catch (Exception e) {
			throw new Exception("[DateUtil][monthsBetween]" + e.getMessage(), e);
		}
	}

	/**
	 * 그달의 마지말 날을 구함
	 *
	 * @param String
	 *            src string
	 * @return String 날짜 형식이 맞고, 존재하는 날짜일 때 그달의 마지말 날을 구함 형식이 잘못 되었거나 존재하지 않는
	 *         날짜: java.text.ParseException 발생
	 * @exception Exception
	 */

	public static String lastDayOfMonth(String src) throws Exception {
		return lastDayOfMonth(src, "yyyyMMdd");
	}

	/**
	 * 그달의 마지말 날을 구함
	 *
	 * @param format
	 *            string representation of the date format. For example,
	 *            "yyyy-MM-dd".
	 * @return String 날짜 형식이 맞고, 존재하는 날짜일 때 그달의 마지말 날을 구함 형식이 잘못 되었거나 존재하지 않는
	 *         날짜: java.text.ParseException 발생
	 * @exception Exception
	 */

	public static String lastDayOfMonth(String src, String format) throws Exception {
		try {

			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(format, java.util.Locale.CHINA);
			java.util.Date date = check(src, format);

			java.text.SimpleDateFormat yearFormat = new java.text.SimpleDateFormat("yyyy", java.util.Locale.CHINA);
			java.text.SimpleDateFormat monthFormat = new java.text.SimpleDateFormat("MM", java.util.Locale.CHINA);

			int year = Integer.parseInt(yearFormat.format(date));
			int month = Integer.parseInt(monthFormat.format(date));
			int day = lastDay(year, month);

			java.text.DecimalFormat fourDf = new java.text.DecimalFormat("0000");
			java.text.DecimalFormat twoDf = new java.text.DecimalFormat("00");
			String tempDate = String.valueOf(fourDf.format(year)) + String.valueOf(twoDf.format(month))
					+ String.valueOf(twoDf.format(day));

			java.util.Date targetDate = check(tempDate, "yyyyMMdd");

			return formatter.format(targetDate);
		} catch (Exception e) {
			throw new Exception("[DateUtil][lastDayOfMonth]" + e.getMessage(), e);
		}
	}

	private static int lastDay(int year, int month) throws java.text.ParseException {
		int day = 0;
		switch (month) {
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
			day = 31;
			break;
		case 2:
			if ((year % 4) == 0) {
				if ((year % 100) == 0 && (year % 400) != 0) {
					day = 28;
				} else {
					day = 29;
				}
			} else {
				day = 28;
			}
			break;
		default:
			day = 30;
		}
		return day;
	}

	//---------------------------------------------------------------------------//

	public static void main(String[] args) throws Exception {

		System.out.println(DateUtil.getCurrentDateString()); // 20020719 출력
		System.out.println(DateUtil.getCurrentDateString("yyyy/MM/dd")); // 2002/07/19
		// 출력
		System.out.println(DateUtil.getCurrentTimeString()); // 094837 출력
		System.out.println(DateUtil.getCurrentDateString("HH:mm:ss")); // 09:48:37
		// 출력
		System.out.println(DateUtil.getCurrentDateString("hh:mm:ss")); // 09:48:37
		// 출력
		System.out.println(DateUtil.convertFormat("20020716")); // 2002/07/16 출력
		System.out.println(DateUtil.convertFormat("20020716", "yyyy년MM월dd일")); // 2002년07월16일
		// 출력
		System.out.println(DateUtil.convertToTimestamp("20020717")); // 2002-07-17
		// 09:48:37.459
		// 출력
		System.out.println(DateUtil.convertToTimestampHMS("20020717123456")); // 2002-07-17
		// 12:34:56.459
		// 출력

		String fromDateDash = "2002-07-18";
		String fromDate = "20020718";

		String toDateDash = "2001-05-15";
		String toDate = "20010515";

		System.out.println(DateUtil.addDays(fromDate, -18)); // 20020721 출력
		System.out.println(DateUtil.addDays(fromDateDash, -18, "yyyy-MM-dd")); // 2002-07-21
		// 출력

		System.out.println(DateUtil.addMonths(fromDate, 3)); // 20021018 출력
		System.out.println(DateUtil.addMonths(fromDateDash, 3, "yyyy-MM-dd")); // 2002-10-18
		// 출력

		System.out.println(DateUtil.addYears(fromDate, 3)); // 20050717 출력
		System.out.println(DateUtil.addYears(fromDateDash, 3, "yyyy-MM-dd")); // 2005-07-17
		// 출력

		System.out.println(DateUtil.yearsBetween(fromDate, toDate)); // -1 출력
		System.out.println(DateUtil.yearsBetween(fromDateDash, toDateDash, "yyyy-MM-dd")); // -1 출력

		System.out.println(DateUtil.daysBetween(fromDate, toDate)); // -429 출력
		System.out.println(DateUtil.daysBetween(fromDateDash, toDateDash, "yyyy-MM-dd")); // -429 출력

		System.out.println(DateUtil.monthsBetween(fromDate, toDate)); // -14 출력
		System.out.println(DateUtil.monthsBetween(fromDateDash, toDateDash, "yyyy-MM-dd")); // -14 출력

		System.out.println(DateUtil.whichDay(fromDate)); // 5 출력
		System.out.println(DateUtil.whichDay(fromDateDash, "yyyy-MM-dd")); // 5 출력

		System.out.println(DateUtil.lastDayOfMonth(fromDate)); // 20020731 출력
		System.out.println(DateUtil.lastDayOfMonth(fromDateDash, "yyyy-MM-dd")); // 2002-07-31
		// 출력

	}

}
