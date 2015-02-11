package ssdevframework.core.util;

/**
 * @(#) LDateUtils.java
 * 
 * Copyright 2008 by LG CNS, Inc.,
 * All rights reserved.
 *
 * Do Not Erase This Comment!!! (이 주석문을 지우지 말것)
 *
 * DevOn Core의 클래스를 실제 프로젝트에 사용하는 경우 DevOn Core 개발담당자에게
 * 프로젝트 정식명칭, 담당자 연락처(Email)등을 mail로 알려야 한다.
 *
 * 소스를 변경하여 사용하는 경우 DevOn Core 개발담당자에게
 * 변경된 소스 전체와 변경된 사항을 알려야 한다.
 * 저작자는 제공된 소스가 유용하다고 판단되는 경우 해당 사항을 반영할 수 있다.
 * 중요한 Idea를 제공하였다고 판단되는 경우 협의하에 저자 List에 반영할 수 있다.
 *
 * (주의!) 원저자의 허락없이 재배포 할 수 없으며
 * LG CNS 외부로의 유출을 하여서는 안 된다.
 */

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.Properties;

/**
 * <pre>
 * 시스템에서 활용될만한 날짜 관련 기능을 제공하는 기능을 정의한 class이다.
 * 외부에서 사용할수 있는 모든 메서드는 static으로 구성되어 있다.
 * 
 * sample :
 *     LDateUtils.getDate()
 *     LDateUtils.getDay(&quot;20031011&quot;)
 *     LDateUtils.getEngDay(&quot;20031011&quot;)
 *     LDateUtils.getHanDay(&quot;20031011&quot;)
 *     LDateUtils.toLunarDate(&quot;20031025&quot;)
 *     LDateUtils.toYYYYMMDDDate(&quot;20031025&quot;)
 *     LDateUtils.isAfter(&quot;20031025&quot;, &quot;2001/03/01&quot;)
 *     LDateUtils.getNextDateSkipLastHoliday(&quot;20031001&quot;,2)
 * 
 * result :
 *     2003/10/06
 *     7
 *     Saturday
 *     토
 *     2003/10/01
 *     20031025
 *     true
 *     2003/10/04
 * </pre>
 * 
 * @since DevOn Core 3.0
 * @version DevOn Core 3.0
 * @author Corporate Asset팀, devon@lgcns.com<br>
 *         LG CNS Technical Service Division<br>
 *         작성 : 2003/05/25
 */

public final class CDateUtils {

	/**
	 * holiday 파일의 Properties 변수.
	 */
	private static Properties holidayInfo = null;

	/**
	 * configuration파일 수정일자.
	 */
	private static long last_modified = 0;

	/**
	 * Default Date Format 변수.
	 */
	private static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd", Locale.CHINESE);

	/**
	 * 음력/양력 변환에 필요한 정보
	 */
	private static final int dt[] = new int[163];

	/**
	 * 음력/양력 변환에 필요한 정보
	 */
	private static final int dateCount[] = { 31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

	/**
	 * 음력/양력 변환에 필요한 정보
	 */
	private static final int kk[] = {
	/* 1881 */1, 2, 1, 2, 1, 2, 2, 3, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 0, 1, 1, 2, 1, 1, 2, 1, 2, 2,
			2, 1, 2, 0, 2, 1, 1, 2, 1, 3, 2, 1, 2, 2, 1, 2, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 0, 2, 1, 2, 1, 2, 1,
			1, 2, 1, 2, 1, 2, 0, 2, 2, 1, 2, 3, 2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 0, 2, 1, 2,
			2, 1, 2, 1, 2, 1, 2, 1, 2, 0, 1, 2, 3, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2,

			/* 1891 */1, 2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 0, 1, 1, 2, 1, 1, 2, 3, 2, 2, 1, 2, 2, 2, 1, 1, 2, 1, 1, 2,
			1, 2, 1, 2, 2, 2, 0, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 0, 2, 1, 2, 1, 2, 3, 1, 2, 1, 2, 1, 2, 1, 2, 2, 2,
			1, 2, 1, 1, 2, 1, 2, 1, 2, 0, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 0, 2, 1, 2, 3, 2, 2, 1, 2, 1, 2, 1, 2, 1,
			2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 0, 1, 2, 1, 1, 2, 1, 2, 2, 3, 2, 2, 1, 2,

			/* 1901 */1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 0, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 0, 1, 2, 1, 2, 1, 3,
			2, 1, 1, 2, 2, 1, 2, 2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 0, 2, 2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 2, 0, 1, 2, 2,
			1, 4, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 0, 2, 1, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2, 0,
			1, 2, 3, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 0,

			/* 1911 */2, 1, 2, 1, 1, 2, 3, 1, 2, 2, 1, 2, 2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 0, 2, 2, 1, 2, 1, 1,
			2, 1, 1, 2, 1, 2, 0, 2, 2, 1, 2, 2, 3, 1, 2, 1, 2, 1, 1, 2, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 0, 1, 2, 1,
			2, 1, 2, 2, 1, 2, 1, 2, 1, 0, 2, 1, 3, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2, 0,
			1, 2, 1, 1, 2, 1, 2, 3, 2, 2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2, 0,

			/* 1921 */2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 0, 2, 1, 2, 2, 1, 3, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1,
			2, 1, 2, 1, 1, 2, 0, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1, 0, 2, 1, 2, 2, 3, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1, 2,
			1, 2, 1, 2, 2, 1, 2, 2, 1, 0, 2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 0, 1, 2, 3, 1, 2, 1, 1, 2, 2, 1, 2, 2, 2,
			1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 0, 1, 2, 2, 1, 1, 2, 3, 1, 2, 1, 2, 2, 1,

			/* 1931 */2, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1, 0, 2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 0, 1, 2, 2, 1, 2, 4,
			1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 2, 0, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 0, 2, 1, 1,
			4, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 0, 2, 2, 1, 1, 2, 1, 1, 4, 1, 2, 2, 1, 2,
			2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1, 2, 0, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 0,

			/* 1941 */2, 2, 1, 2, 2, 1, 4, 1, 1, 2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 1, 2, 0, 1, 2, 1, 2, 1, 2,
			2, 1, 2, 2, 1, 2, 0, 1, 1, 2, 1, 4, 1, 2, 1, 2, 2, 1, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2, 0, 2, 1, 1,
			2, 1, 1, 2, 1, 2, 2, 1, 2, 0, 2, 2, 3, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 0,
			2, 2, 1, 2, 1, 2, 1, 3, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 0,

			/* 1951 */2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 0, 1, 2, 1, 2, 1, 4, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2, 2,
			1, 2, 2, 1, 2, 2, 0, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 0, 2, 1, 1, 4, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2, 1,
			2, 1, 1, 2, 1, 2, 1, 2, 2, 0, 2, 1, 2, 1, 2, 1, 1, 2, 3, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 0,
			1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 0, 2, 1, 2, 1, 2, 2, 3, 2, 1, 2, 1, 2, 1,

			/* 1961 */2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 0, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 0, 2, 1, 2, 1, 3, 2,
			1, 2, 1, 2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 0, 1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 0, 2, 2, 2,
			3, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 2, 0, 1, 2, 2, 1, 2, 1, 2, 3, 2, 1, 2, 1, 2,
			1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 0, 2, 1, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2, 0,

			/* 1971 */1, 2, 1, 1, 2, 3, 2, 1, 2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 0, 2, 1, 2, 1, 1, 2,
			1, 1, 2, 2, 2, 1, 0, 2, 2, 1, 2, 3, 1, 2, 1, 1, 2, 2, 1, 2, 2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 0, 2, 2, 1,
			2, 1, 2, 1, 2, 3, 2, 1, 1, 2, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 0, 2, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 0,
			2, 1, 1, 2, 1, 2, 4, 1, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 0,

			/* 1981 */1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2, 0, 2, 1, 2, 1, 3, 2, 1, 1, 2, 2, 1, 2, 2, 2, 1, 2, 1, 1, 2,
			1, 1, 2, 1, 2, 2, 0, 2, 1, 2, 2, 1, 1, 2, 1, 1, 2, 3, 2, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 0, 1, 2, 2,
			1, 2, 2, 1, 2, 1, 2, 1, 1, 0, 2, 1, 2, 2, 1, 2, 3, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 0,
			2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 0, 1, 2, 1, 1, 2, 3, 1, 2, 1, 2, 2, 2, 2,

			/* 1991 */1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 0, 1, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 0, 1, 2, 2, 3, 2, 1,
			2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 0, 1, 2, 2, 1, 2, 2, 1, 2, 3, 2, 1, 1, 2, 1, 2, 1,
			2, 2, 1, 2, 1, 2, 2, 1, 2, 0, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 0, 2, 1, 1, 2, 1, 3, 2, 2, 1, 2, 2, 2, 1,
			2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 0, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 0,

			/* 2001 */2, 2, 2, 1, 3, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 0, 2, 2, 1, 2, 2, 1,
			2, 1, 1, 2, 1, 2, 0, 1, 2, 3, 2, 2, 1, 2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 0, 1, 1, 2,
			1, 2, 1, 2, 3, 2, 2, 1, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2, 0, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 0,
			2, 2, 1, 1, 2, 3, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 0,

			/* 2011 */2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 0, 2, 1, 2, 4, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 1, 2, 2, 1, 2,
			1, 2, 1, 2, 1, 2, 0, 1, 2, 1, 2, 1, 2, 1, 2, 2, 3, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2, 2, 0, 1, 1, 2,
			1, 1, 2, 1, 2, 2, 1, 2, 2, 0, 2, 1, 1, 2, 1, 3, 2, 1, 2, 1, 2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 0,
			2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 0, 2, 1, 2, 2, 3, 2, 1, 1, 2, 1, 2, 1, 2,

			/* 2021 */1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 0, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 0, 1, 2, 3, 2, 1, 2,
			1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 0, 2, 1, 2, 1, 1, 2, 3, 2, 1, 2, 2, 2, 1, 2, 1, 2,
			1, 1, 2, 1, 2, 1, 2, 2, 2, 0, 1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 2, 0, 1, 2, 2, 1, 2, 3, 1, 2, 1, 1, 2, 2, 1,
			2, 2, 1, 2, 2, 1, 1, 2, 1, 1, 2, 2, 0, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 0,

			/* 2031 */2, 1, 2, 3, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 0, 1, 2, 1, 1, 2, 1,
			2, 3, 2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 0, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 0, 2, 2, 1,
			2, 1, 1, 4, 1, 1, 2, 1, 2, 2, 2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 0, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2, 1, 0,
			2, 2, 1, 2, 2, 3, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 2, 1, 0,

			/* 2041 */2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 0, 1, 2, 3, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1,
			1, 2, 2, 1, 2, 2, 0 };

	/**
	 * LDateUtils default constructor
	 */
	public CDateUtils() {
	}

	/**
	 * pBasisDate이 pComparativeDate보다 이전일인지를 반환한다.
	 * 
	 * @param pBasisDate - 기준이 되는 일자
	 * @param pComparativeDate - 비교 대상 일자
	 * @return boolean - 기준일이 입력일 보다 이전인지 여부를 반환
	 */
	public static boolean isBefore(String pBasisDate, String pComparativeDate) {

		if (!CDateUtils.isValid(CDateUtils.toYYYYMMDDDate(pBasisDate))) {

			throw new IllegalArgumentException("'" + pBasisDate + "'는 적절한 date 값이 아닙니다.");
		}

		if (!CDateUtils.isValid(CDateUtils.toYYYYMMDDDate(pComparativeDate))) {
			throw new IllegalArgumentException("'" + "'" + pBasisDate + "'는 적절한 date 값이 아닙니다.");
		}
		Calendar cal1 = toCalendar(pBasisDate);
		Calendar cal2 = toCalendar(pComparativeDate);

		return cal1.before(cal2);
	}

	/**
	 * pBasisDate이 pComparativeDate보다 이후일인지를 반환한다.
	 * 
	 * @param pBasisDate - 기준이 되는 일자
	 * @param pComparativeDate - 비교 대상 일자
	 * @return boolean - 기준일이 입력일 보다 이후인지 여부를 반환
	 */
	public static boolean isAfter(String pBasisDate, String pComparativeDate) {

		if (!CDateUtils.isValid(CDateUtils.toYYYYMMDDDate(pBasisDate))) {

			throw new IllegalArgumentException("'" + pBasisDate + "'는 적절한 date 값이 아닙니다.");
		}

		if (!CDateUtils.isValid(CDateUtils.toYYYYMMDDDate(pComparativeDate))) {
			throw new IllegalArgumentException("'" + "'" + pBasisDate + "'는 적절한 date 값이 아닙니다.");
		}
		Calendar cal1 = toCalendar(pBasisDate);
		Calendar cal2 = toCalendar(pComparativeDate);

		return cal1.after(cal2);
	}

	/**
	 * pFromDate와 pToDate 사이에 몇일이 있는지를 검사한다.
	 * 
	 * <pre>
	 *      example :
	 *         LDateUtils.getDaysBetween(&quot;2002.10.15&quot;, &quot;2002.10.10&quot;)
	 *         LDateUtils.getDaysBetween(&quot;2002.10.10&quot;, &quot;2002.10.15&quot;)
	 *         LDateUtils.getDaysBetween(&quot;20021030&quot;, &quot;20021120&quot;)
	 *      result :
	 *             5
	 *             5
	 *            21
	 * </pre>
	 * 
	 * @param pFromDate - 시작일
	 * @param pToDate - 종료일
	 * @return int - 두 날짜사이의 일자
	 */
	public static int getDaysBetween(String pFromDate, String pToDate) {

		Calendar cal1 = toCalendar(pFromDate);
		Calendar cal2 = toCalendar(pToDate);

		if (cal1.getTime().compareTo(cal2.getTime()) == -1)
			return (int) ((cal2.getTime().getTime() - cal1.getTime().getTime()) / (1000 * 60 * 60 * 24));

		return (int) ((cal1.getTime().getTime() - cal2.getTime().getTime()) / (1000 * 60 * 60 * 24));
	}

	/**
	 * 현재 날짜가 포함된 달의 마지막 일자를 구한다.
	 * 
	 * <pre>
	 *      example :
	 *            LDateUtils.getLastDate()
	 *      result :
	 *            30
	 * </pre>
	 * 
	 * @return 마지막일자
	 */
	public static int getLastDate() {
		GregorianCalendar calendar = new GregorianCalendar();

		calendar.add(Calendar.MONTH, 1);
		calendar.set(Calendar.DATE, 1);
		calendar.add(Calendar.DATE, -1);

		return calendar.get(Calendar.DATE);
	}

	/**
	 * <pre>
	 * pDate가 포함된 달의 마지막 일자를 구한다.
	 *      example :
	 *            LDateUtils.getLastDate(&quot;20021030&quot;)
	 *            LDateUtils.getLastDate(&quot;2002.02.10&quot;)
	 *            LDateUtils.getLastDate(&quot;020410&quot;)
	 *      result :
	 *            31
	 *            28
	 *            30
	 * </pre>
	 * @param pDate - 기준일
	 * @return int - 마지막일자
	 */
	public static int getLastDate(String pDate) {

		if (!CDateUtils.isValid(CDateUtils.toYYYYMMDDDate(pDate))) {
			throw new IllegalArgumentException("'" + "'" + pDate + "'는 적절한 date 값이 아닙니다.");
		}

		java.util.Calendar cal = toCalendar(pDate);

		cal.add(Calendar.MONTH, 1);
		cal.set(Calendar.DATE, 1);
		cal.add(Calendar.DATE, -1);

		return cal.get(Calendar.DATE);
	}

	/**
	 * pDate 부터 pDays 만큼의 날짜를 구한다. pDays에 음수(-) 값은 지원하지 않는다.
	 * 
	 * <pre>
	 *      example :
	 *            LDateUtils.getNextDate(&quot;20021030&quot; , 10) 
	 *            LDateUtils.getNextDate(&quot;2002.02.10&quot;, 20) 
	 *            LDateUtils.getNextDate(&quot;020410&quot;, 30) 
	 *            LDateUtils.getNextDate(&quot;20021030&quot; , -10) 
	 *        result :
	 *            20021109
	 *            20020302
	 *            20020510
	 *            [LDateUtils.getNextDayNum] : Int value under 0 is not allowed and raw data will be returned
	 *            20021030
	 * </pre>
	 * 
	 * @param pDate - 기준 날짜
	 * @param pDays - 더해질 일자
	 * @return String - 변환된 날짜
	 */
	public static String getNextDate(String pDate, int pDays) {

		if (pDays < 0) {
			return pDate;
		}

		if (!CDateUtils.isValid(CDateUtils.toYYYYMMDDDate(pDate))) {
			throw new IllegalArgumentException("'" + pDate + "'는 적절한 date 값이 아닙니다.");
		}

		Calendar cal = toCalendar(pDate);

		cal.add(Calendar.DATE, pDays);

		return dateFormat.format(cal.getTime());
	}

	/**
	 * pDate(YYYYMMDD)에서 pDays일자 만큼 전의 날짜를 구해준다.
	 * 
	 * <pre>
	 *     example:
	 *             LDateUtils.getPrevDayNum(&quot;20020306&quot;, 7)
	 *             LDateUtils.getPrevDayNum(&quot;2002.05.15&quot;, 30)
	 *         result :
	 *             20020227
	 *             20020415
	 * </pre>
	 * 
	 * @param pDate 기준일
	 * @param pHowMany 몇일전
	 * @return 수정된 일자
	 */
	public static String getPrevDate(String pDate, int pDays) {
		if (pDays < 0) {
			return pDate;
		}

		if (!CDateUtils.isValid(CDateUtils.toYYYYMMDDDate(pDate))) {
			throw new IllegalArgumentException("'" + pDate + "'는 적절한 date 값이 아닙니다.");
		}

		Calendar cal = toCalendar(pDate);

		cal.add(Calendar.DATE, -(pDays));

		return dateFormat.format(cal.getTime());
	}

	/**
	 * pDate가 포함된 달로 부터 pWeeks 주 뒤의 일자 구한다. pWeeks 음수값을 지원하지 않는다.
	 * <pre>
	 *      example :
	 *             LDateUtils.getNextWeekDate(&quot;20020630&quot;, 4)
	 *             //4주뒤
	 *             LDateUtils.getNextWeekDate(&quot;2002.05.15&quot;, 2)
	 *             //2주뒤
	 *      result :
	 *             20020728
	 *             20020529
	 * </pre>
	 * 
	 * @param pDate - 기준일
	 * @param pWeeks - 몇주후
	 * @return String - 기준일에서 몇주후의 날짜
	 */
	public static String getNextWeekDate(String pDate, int pWeeks) {
		if (pWeeks < 0) {
			return pDate;
		}

		Calendar cal = toCalendar(pDate);

		cal.add(Calendar.DATE, pWeeks * 7);

		return dateFormat.format(cal.getTime());
	}

	/**
	 * pDate가 포함된 달로 부터 pWeeks 주 전의 일자 구한다. <br>
	 * pWeeks는 음수 값을 가질 수 없다.
	 * 
	 * <pre>
	 *         example :
	 *                 LDateUtils.getPrevWeekDate(&quot;20020321&quot;, 3)
	 *                 LDateUtils.getPrevWeekDate(&quot;2002.05.30&quot;, 2)
	 *         result :
	 *                 20020228
	 *                 20020516
	 * </pre>
	 * 
	 * @param pDate - 기준일
	 * @param pWeeks - 몇주전
	 * @return String - 기준일에서 몇주전의 날짜
	 */
	public static String getPrevWeekDate(String pDate, int pWeeks) {

		if (!CDateUtils.isValid(CDateUtils.toYYYYMMDDDate(pDate))) {
			throw new IllegalArgumentException("'" + pDate + "'는 적절한 date 값이 아닙니다.");
		}

		if (pWeeks < 0) {
			return pDate;
		}

		Calendar cal = toCalendar(pDate);

		cal.add(Calendar.DATE, pWeeks * (-7));

		return dateFormat.format(cal.getTime());
	}

	/**
	 * pDate에서 pMonths만큼 다음달의 날짜를 구한다.
	 * 
	 * <pre>
	 *        example :
	 *                LDateUtils.getNextMonthDate(&quot;20020603&quot;,3)
	 *                LDateUtils.getNextMonthDate(&quot;20020906&quot;,4)
	 *                LDateUtils.getNextMonthDate(&quot;20020130&quot;,1)
	 *                // 다음달에 해당일이 없을 경우 마지막 날짜 표시
	 *        result :
	 *                20020903
	 *                20030106
	 *                20020228
	 * </pre>
	 * 
	 * @param pDate - 기준일
	 * @param pMonths - 개월수
	 * @return String - 입력된 날짜에서 pMonth 이후 달의 날짜
	 */
	public static String getNextMonthDate(String pDate, int pMonths) {
		if (!CDateUtils.isValid(CDateUtils.toYYYYMMDDDate(pDate))) {
			throw new IllegalArgumentException("'" + pDate + "'는 적절한 date 값이 아닙니다.");
		}

		if (pMonths < 0) {
			return pDate;
		}

		Calendar cal = toCalendar(pDate);

		cal.add(Calendar.MONTH, pMonths);

		return dateFormat.format(cal.getTime());
	}

	/**
	 * pDate날짜에서 pMonth만큼 이전 달의 날짜를 구한다.
	 * <pre>
	 *        example :
	 *                LDateUtils.getPrevMonthDate(&quot;20020603&quot;,3)
	 *                LDateUtils.getPrevMonthDate(&quot;20020206&quot;,4)
	 *                LDateUtils.getPrevMonthDate(&quot;20020330&quot;,1)
	 *                // 다음달에 해당일이 없을 경우 마지막 날짜 표시
	 *            result :
	 *                20020303
	 *                20011006
	 *                20020228
	 * </pre>
	 * 
	 * @param pDate - 기준일
	 * @param pMonth - 개월수
	 * @return String - 입력된 날짜에서 pMonth 이전 달의 날짜
	 */
	public static String getPrevMonthDate(String pDate, int pMonth) {
		if (!CDateUtils.isValid(CDateUtils.toYYYYMMDDDate(pDate))) {
			throw new IllegalArgumentException("'" + pDate + "'는 적절한 date 값이 아닙니다.");
		}

		if (pMonth < 0) {
			return pDate;
		}

		Calendar cal = toCalendar(pDate);

		cal.add(Calendar.MONTH, -(pMonth));

		return dateFormat.format(cal.getTime());
	}

	/**
	 * pDate날짜가 포함된 년도의 윤달 여부를 반환한다.
	 * 
	 * @param pDate - 입력된 일자 (yyyy, yyyyMM, yyyyMMdd 형식) 
	 * @return boolean - 윤달 여부
	 */
	public static boolean isLeapYear(String pDate) {

		java.util.GregorianCalendar gCal = new GregorianCalendar();
		if (pDate.length() == 4) {
			gCal.setTime(new Date(toCalendar(pDate + "0101").getTime().getTime()));
		} else {
			if (!CDateUtils.isValid(CDateUtils.toYYYYMMDDDate(pDate))) {
				throw new IllegalArgumentException("'" + pDate + "'는 적절한 date 값이 아닙니다.");
			}
			gCal.setTime(new Date(toCalendar(pDate).getTime().getTime()));
		}

		return gCal.isLeapYear(gCal.get(Calendar.YEAR));
	}

	/**
	 * 오늘의 요일을 한글로 반환한다.
	 * 
	 * @return String - 한글로 된 요일정보
	 */
	public static String getHanDay() {
		return getHanDay(getDate());
	}

	/**
	 * 해당일자의 요일을 한글로 반환한다.
	 * 
	 * @param pDate - 입력된 일자
	 * @return String - 한글로 된 요일정보
	 */
	public static String getHanDay(String pDate) {

		if (!CDateUtils.isValid(CDateUtils.toYYYYMMDDDate(pDate))) {
			throw new IllegalArgumentException("'" + pDate + "'는 적절한 date 값이 아닙니다.");
		}

		Calendar cal = toCalendar(pDate);
		SimpleDateFormat dateForm = new SimpleDateFormat("EEE", Locale.KOREA);

		return dateForm.format(cal.getTime());
	}

	/**
	 * 오늘의 요일을 영어로 반환한다.
	 * 
	 * @return String - 영어로된 요일정보
	 */
	public static String getEngDay() {
		return getEngDay(getDate());
	}

	/**
	 * 해당일자의 요일을 영어로 반환한다.
	 * 
	 * @param pDate - 입력된 일자
	 * @return String - 영어로 된 요일정보
	 */
	public static String getEngDay(String pDate) {

		if (!CDateUtils.isValid(CDateUtils.toYYYYMMDDDate(pDate))) {
			throw new IllegalArgumentException("'" + pDate + "'는 적절한 date 값이 아닙니다.");
		}

		Calendar cal = toCalendar(pDate);

		SimpleDateFormat dateForm = new SimpleDateFormat("EEEEEEEE", Locale.ENGLISH);

		return dateForm.format(cal.getTime());
	}

	/**
	 * 오늘의 요일을 반환한다.
	 * 
	 * @return int - 요일정보 int 값
	 */
	public static int getDay() {
		GregorianCalendar calendar = new GregorianCalendar();
		return calendar.get(Calendar.DAY_OF_WEEK);
	}

	/**
	 * 해당일자의 요일을 반환한다.
	 * 
	 * @param pDate - 입력된 일자
	 * @return int - 요일정보 int 값
	 */
	public static int getDay(String pDate) {

		java.util.Calendar cal = toCalendar(pDate);

		return cal.get(Calendar.DAY_OF_WEEK);
	}

	/**
	 * 서버를 기준으로 현재 날짜를 사용자가 지정한 구분자를 이용하여 반환한다.
	 * 
	 * <pre>
	 * example :
	 *      LDateUtils.getDBDate(&quot;/&quot;)
	 * result :
	 *      2002/10/09
	 * </pre>
	 * 
	 * @param seperator 날짜/월/일 사이에 구분자
	 * @return String 서버일자반환
	 */
	public static String getDate(String seperator) {
		String sDate = getDate();
		return sDate.substring(0, 4) + seperator + sDate.substring(4, 6) + seperator + sDate.substring(6, 8);
	}

	/**
	 * 이번달을 알려준다. 실제 자바에서의 1월은 0을 리턴하나, getMonth() 메소드에서는 실제 월과 일치하는 인트값을 리턴한다.
	 * 
	 * <pre>
	 * example :
	 *      LDateUtils.getMonth()
	 * result :
	 *      11
	 * </pre>
	 * 
	 * @return int - 이번달 
	 */
	public static int getMonth() {
		GregorianCalendar calendar = new GregorianCalendar();
		return calendar.get(Calendar.MONTH) + 1;
	}

	/**
	 * 이번달을 알려준다. 실제 자바에서의 1월은 0을 리턴하나, getMonth() 메소드에서는 실제 월과 일치하는 인트값을 리턴한다.
	 * 
	 * <pre>
	 * example :
	 *      LDateUtils.getMonth()
	 * result :
	 *      11
	 * </pre>
	 * 
	 * @return String 서버일자반환
	 */
	public static String getEngMonth() {
		GregorianCalendar calendar = new GregorianCalendar();

		SimpleDateFormat monthForm = new SimpleDateFormat("MMMMM", Locale.ENGLISH);

		return monthForm.format(calendar.getTime());
	}

	/**
	 * 영문 이번달을 알려준다.
	 * 
	 * @return String
	 */
	public static String getShortEngMonth() {
		GregorianCalendar calendar = new GregorianCalendar();

		SimpleDateFormat monthForm = new SimpleDateFormat("MMM", Locale.ENGLISH);

		return monthForm.format(calendar.getTime());
	}

	/**
	 * 서버를 기준으로 현재 날짜를 devon-framework.xml에서 등록한 Default 형태로 반환한다.
	 * 
	 * <pre>
	 * example :
	 *      LDateUtils.getDBDate()
	 * result :
	 *      20021009
	 * </pre>
	 * 
	 * @return String 서버일자반환
	 */
	public static String getDate() {
		return dateFormat.format(new java.util.Date());
	}

	/**
	 * 연도를 받아서 완전한 네자리 연도로 변환한다.
	 * 
	 * <pre>
	 * ex&gt; 85 &gt;&gt; 1985, 1985 &gt;&gt; 1985, 985 &gt;&gt; 1985, 01 &gt;&gt; 2001, 01 &gt;&gt; 2001, 1 &gt;&gt; 2001
	 * </pre>
	 * 
	 * @param argYear - 변환할 년도
	 * @return String - 정상적인 경우 네자리 년도
	 */
	public static String getYear(String argYear) {
		String year = "";

		if (argYear != null)
			year = argYear.trim();

		if (year.length() > 4 || year.length() == 0) {
			throw new IllegalArgumentException("'" + year + "'는 적절한 년도 값이 아닙니다.");
		}

		for (int inx = 0; inx < year.length(); inx++) {
			if (!java.lang.Character.isDigit(year.charAt(inx))) {
				throw new IllegalArgumentException("'" + year + "'는 적절한 년도 값이 아닙니다.");
			}
		}

		if (year.length() == 4)
			return year;

		switch (year.length()) // 년도가 한자리 혹은 세자리로 입력되는 특수 경우 처리
		{
		case 1:
			year = "0" + year;
			break;
		case 3:
			year = year.substring(1, 3);
			break;
		default:
			break;
		}

		if (Integer.parseInt(year) > 50)
			year = "19" + year;
		else
			year = "20" + year;

		return year;
	}

	/**
	 * 입력한 일자 유형을 표준형식 'YYYY.MM.DD'으로 변환해서 반환한다.
	 * 
	 * @param argDate - 대상 일자( 1998.01.02, 98.01.02, 19980102, 980102 등 )
	 * @return String - 변환된 문자열
	 */
	public static String toBaseDate(String argDate) {

		if (!CDateUtils.isValid(CDateUtils.toYYYYMMDDDate(argDate))) {
			throw new IllegalArgumentException("'" + argDate + "'는 올바르지 않은 년월일 형식입니다.");
		}

		String formattedDate = toYYYYMMDDDate(argDate);

		try {
			Integer.parseInt(formattedDate);
		} catch (NumberFormatException ne) {
			throw new IllegalArgumentException("'" + argDate + "'는 올바르지 않은 년월일 형식입니다.");
		}

		if (formattedDate != "") {
			return formattedDate.substring(0, 4) + "." + formattedDate.substring(4, 6) + "."
					+ formattedDate.substring(6, 8);
		}

		return argDate;
	}

	/**
	 * 어떤 날짜가( 1998.01.02, 98.01.02, 19980102, 980102 ) 들어오건 간에 YYYYMMDD로 변환한다.
	 * 
	 * @param argDate - 변환할 일자( 1998.01.02, 98.01.02, 19980102, 980102 등 )
	 * @return String - 변환된 일자
	 */
	public static String toYYYYMMDDDate(String argDate) {
		boolean isMunja = false;
		boolean isCorrectArg = true;
		String subArg = "";
		String date = "";
		String result = "";

		if (argDate != null)
			subArg = argDate.trim();

		for (int inx = 0; inx < subArg.length(); inx++) {
			if (java.lang.Character.isLetter(subArg.charAt(inx)) || subArg.charAt(inx) == ' ') {
				isCorrectArg = false;
				break;
			}
		}

		if (!isCorrectArg) {
			throw new IllegalArgumentException("'" + argDate + "'는 올바르지 않은 년월일 형식입니다.");
		}

		if (subArg.length() != 8) {
			if (subArg.length() != 6 && subArg.length() != 10) {
				throw new IllegalArgumentException("'" + argDate + "'는 올바르지 않은 년월일 형식입니다.");
			}

			if (subArg.length() == 6) {
				if (Integer.parseInt(subArg.substring(0, 2)) > 50)
					date = "19";
				else
					date = "20";

				result = date + subArg;
			}

			if (subArg.length() == 10)
				result = subArg.substring(0, 4) + subArg.substring(5, 7) + subArg.substring(8, 10);
		} else {// 8자린 경우 ( 98.01.02, 19980102 )

			try {
				Integer.parseInt(subArg);
			} catch (NumberFormatException ne) {
				isMunja = true;
			}

			if (isMunja) // 98.01.02 혹은 98/01/02 형식의 포맷일 경우
			{
				date = subArg.substring(0, 2) + subArg.substring(3, 5) + subArg.substring(6, 8);
				if (Integer.parseInt(subArg.substring(0, 2)) > 50)
					result = "19" + date;
				else
					result = "20" + date;
			} else
				// 19980102 형식의 포맷인 경우
				return subArg;
		}
		return result;
	}

	/**
	 * 입력된 일자에 해당하는 음력일자를 반환한다.
	 * 
	 * @param argDate - 변환할 일자( 1998.01.02, 98.01.02, 19980102, 980102 등 )
	 * @return String - 음력일자
	 */
	public static String toLunarDate(String argDate) {

		if (!CDateUtils.isValid(CDateUtils.toYYYYMMDDDate(argDate))) {
			throw new IllegalArgumentException("'" + argDate + "'는 적절한 date 값이 아닙니다.");
		}

		int lyear, lmonth, lday = 0;
		int i, j, m1, m2, jcount = 0;
		boolean ll = false;
		long td, td0, td1 = 0;

		for (i = 0; i < 163; i++) {
			dt[i] = 0;
			for (j = 0; j < 12; j++) {
				switch (kk[i * 13 + j]) {
				case 1:
				case 3:
					dt[i] = dt[i] + 29;
					break;
				case 2:
				case 4:
					dt[i] = dt[i] + 30;
				}
			}

			switch (kk[i * 13 + 12]) {
			case 0:
				break;
			case 1:
			case 3:
				dt[i] = dt[i] + 29;
				break;
			case 2:
			case 4:
				dt[i] = dt[i] + 30;
				break;
			}
		}
		td1 = 1880 * 365L + 1880 / 4 - 1880 / 100 + 1880 / 400 + 30;

		String standardDate = toYYYYMMDDDate(argDate);
		int syear = Integer.parseInt(standardDate.substring(0, 4));
		int smonth = Integer.parseInt(standardDate.substring(4, 6));
		int sday = Integer.parseInt(standardDate.substring(6, 8));

		long k11 = (long) (syear - 1);
		long td2 = k11 * 365L + k11 / 4L - k11 / 100L + k11 / 400L;
		ll = syear % 400 == 0 || syear % 100 != 0 && syear % 4 == 0;
		if (ll)
			dateCount[1] = 29;
		else
			dateCount[1] = 28;

		for (i = 0; i < smonth - 1; i++)
			td2 = td2 + (long) dateCount[i];

		td2 = td2 + (long) sday;

		/* ## 1881. 1. 30. - syear. smonth. sday. ## */
		td = td2 - td1 + 1;

		/* ## Lunar Year Caculation ## */
		td0 = (long) dt[0];
		for (i = 0; i < 163; i++) {
			if (td <= td0)
				break;
			td0 = td0 + (long) dt[i + 1];
		}
		lyear = i + 1881; /* Calculated Lunar Year */

		/* ## Lunar Month Calculation ## */
		td0 = td0 - (long) dt[i];
		td = td - td0;

		if (kk[i * 13 + 12] != 0)
			jcount = 13;
		else
			jcount = 12;
		m2 = 0;

		for (j = 0; j < jcount; j++) {
			if (kk[i * 13 + j] <= 2)
				m2++;
			if (kk[i * 13 + j] <= 2)
				m1 = kk[i * 13 + j] + 28;
			else
				m1 = kk[i * 13 + j] + 26;
			if (td <= (long) m1)
				break;
			td = td - (long) m1;
		}

		lmonth = m2; /* Calculated Lunar Month */

		lday = (int) td; /* Calculated Lunar Day */

		i = (int) ((td2 + 4L) % 10L);
		j = (int) ((td2 + 2L) % 12L);

		Date lunarDate = createDate(lyear, lmonth, lday);

		return dateFormat.format(lunarDate);
	}

	/**
	 * 입력된 음력일자에 해당하는 양력일자를 반환한다.
	 * 
	 * @param argDate - 변환할 일자( 1998.01.02, 98.01.02, 19980102, 980102 등 )
	 * @return String - 양력일자
	 */
	public static String toSolarDate(String argDate) {
		return toSolarDate(argDate, false);
	}

	/**
	 * 입력된 음력일자에 해당하는 양력일자를 반환한다.
	 * 
	 * @param argDate - 변환할 일자( 1998.01.02, 98.01.02, 19980102, 980102 등 )
	 * @param isLeap - 윤달 여부
	 * @return String - 양력일자
	 */
	public static String toSolarDate(String argDate, boolean isLeap) {
		int syear, smonth, sday = 0;
		int i, j, m1, m2 = 0;
		boolean leap = false;
		long td = 0;

		for (i = 0; i < 163; i++) {
			dt[i] = 0;
			for (j = 0; j < 12; j++) {
				switch (kk[i * 13 + j]) {
				case 1:
				case 3:
					dt[i] = dt[i] + 29;
					break;
				case 2:
				case 4:
					dt[i] = dt[i] + 30;
				}
			}

			switch (kk[i * 13 + 12]) {
			case 0:
				break;
			case 1:
			case 3:
				dt[i] = dt[i] + 29;
				break;
			case 2:
			case 4:
				dt[i] = dt[i] + 30;
				break;
			}
		}

		String standardDate = toYYYYMMDDDate(argDate);
		int lyear = Integer.parseInt(standardDate.substring(0, 4));
		int lmonth = Integer.parseInt(standardDate.substring(4, 6));
		int lday = Integer.parseInt(standardDate.substring(6, 8));

		boolean isLeapYear = isLeap;

		if (!isLeapYear && !verifyDate(lyear, lmonth, lday, "To Solar-")) {
			throw new IllegalArgumentException("Date Range Error");
		}

		if (isLeapYear && !verifyDate(lyear, lmonth, lday, "To Solar+")) {
			throw new IllegalArgumentException("Date Range or Leap Check Error");
		}

		m1 = -1;
		td = 0L;

		if (lyear != 1881) {
			m1 = lyear - 1882;
			for (i = 0; i <= m1; i++) {
				for (j = 0; j < 13; j++)
					td = td + (long) kk[i * 13 + j];
				if (kk[i * 13 + 12] == 0)
					td = td + 336L;
				else
					td = td + 362L;
			}
		}

		m1++;
		int n2 = lmonth - 1;
		m2 = -1;

		while (true) {
			m2++;
			if (kk[m1 * 13 + m2] > 2) {
				td = td + 26L + (long) kk[m1 * 13 + m2];
				n2++;
			} else if (m2 == n2)
				break;
			else
				td = td + 28L + (long) kk[m1 * 13 + m2];
		}
		;

		if (isLeapYear)
			td = td + 28L + (long) kk[m1 * 13 + m2];

		td = td + (long) lday + 29L;
		m1 = 1880;

		while (true) {
			m1++;
			leap = m1 % 400 == 0 || m1 % 100 != 0 && m1 % 4 == 0;
			if (leap)
				m2 = 366;
			else
				m2 = 365;
			if (td < (long) m2)
				break;
			td = td - (long) m2;
		}
		;

		syear = m1;
		dateCount[1] = m2 - 337;
		m1 = 0;
		while (true) {
			m1++;
			if (td <= (long) dateCount[m1 - 1])
				break;
			td = td - (long) dateCount[m1 - 1];
		}
		;

		smonth = m1;
		sday = (int) td;

		long y = syear - 1L;

		td = (long) (y * 365) + (long) (y / 4) - (long) (y / 100) + (long) (y / 400);

		leap = syear % 400 == 0 || syear % 100 != 0 && syear % 4 == 0;

		if (leap)
			dateCount[1] = 29;
		else
			dateCount[1] = 28;

		for (i = 0; i < smonth - 1; i++)
			td = td + (long) dateCount[i];
		td = td + (long) sday;

		i = (int) (td % 10L);
		i = (i + 4) % 10;
		j = (int) (td % 12L);
		j = (j + 2) % 12;

		Date solarDate = createDate(syear, smonth, sday);

		return dateFormat.format(solarDate);
	}

	/**
	 * 입력된 일자를 Calendar 객체로 반환한다.
	 * 
	 * @param argDate - 변환할 일자( 1998.01.02, 98.01.02, 19980102, 980102 등 )
	 * @return Calendar - 해당일자에 해당하는 Calendar
	 */
	public static Calendar toCalendar(String pDate) {
		String date = toYYYYMMDDDate(pDate);

		return createCalendar(Integer.parseInt(date.substring(0, 4)), Integer.parseInt(date.substring(4, 6)),
				Integer.parseInt(date.substring(6, 8)));
	}

	/**
	 * 입력된 일자를 Date 객체로 반환한다.
	 * 
	 * @param argDate - 변환할 일자( 1998.01.02, 98.01.02, 19980102, 980102 등 )
	 * @return Calendar - 해당일자에 해당하는 Calendar
	 */
	public static Date toDate(String pDate) {
		String date = toYYYYMMDDDate(pDate);

		return createDate(Integer.parseInt(date.substring(0, 4)), Integer.parseInt(date.substring(4, 6)),
				Integer.parseInt(date.substring(6, 8)));
	}

	/**
	 * 입력된 일자를 Date 객체로 반환한다.
	 * 
	 * @param year - 년
	 * @param month - 월
	 * @param date - 일
	 * @return Date - 해당일자에 해당하는 Date
	 */
	public static Date createDate(int year, int month, int date) {
		return createCalendar(year, month, date).getTime();
	}

	/**
	 * 입력된 정보를 Date 객체로 반환한다.
	 * 
	 * @param year - 년
	 * @param month - 월
	 * @param date - 일
	 * @param hour - 시
	 * @param minute - 분
	 * @return Date - 해당일자에 해당하는 Date
	 */
	public static Date createDate(int year, int month, int date, int hour, int minute) {
		return createCalendar(year, month, date, hour, minute).getTime();
	}

	/**
	 * 입력된 정보를 Date 객체로 반환한다.
	 * 
	 * @param year - 년
	 * @param month - 월
	 * @param date - 일
	 * @param hour - 시
	 * @param minute - 분
	 * @param second - 초
	   * @return Date - 해당일자에 해당하는 Date
	 */
	public static Date createDate(int year, int month, int date, int hour, int minute, int second) {
		return createCalendar(year, month, date, hour, minute, second).getTime();
	}

	/**
	 * 입력된 일자를 Calendar 객체로 반환한다.
	 * 
	 * @param year - 년
	 * @param month - 월
	 * @param date - 일
	 * @return Calendar - 해당일자에 해당하는 Calendar
	 */
	public static Calendar createCalendar(int year, int month, int date) {
		GregorianCalendar calendar = new GregorianCalendar();
		calendar.set(year, month - 1, date);
		return calendar;
	}

	/**
	 * 입력된 정보를 Calendar 객체로 반환한다.
	 * 
	 * @param year - 년
	 * @param month - 월
	 * @param date - 일
	 * @param hour - 시
	 * @param minute - 분
	 * @return Calendar - 해당일자에 해당하는 Calendar
	 */
	public static Calendar createCalendar(int year, int month, int date, int hour, int minute) {
		GregorianCalendar calendar = new GregorianCalendar();
		calendar.set(year, month - 1, date, hour, minute);
		return calendar;
	}

	/**
	 * 입력된 정보를 Calendar 객체로 반환한다.
	 * 
	 * @param year - 년
	 * @param month - 월
	 * @param date - 일
	 * @param hour - 시
	 * @param minute - 분
	 * @param second - 초
	 * @return Calendar - 해당일자에 해당하는 Calendar
	 */
	public static Calendar createCalendar(int year, int month, int date, int hour, int minute, int second) {
		GregorianCalendar calendar = new GregorianCalendar();
		calendar.set(year, month - 1, date, hour, minute, second);
		return calendar;
	}

	/**
	 * 입력된 일자가 양력이나 음력으로 변환 가능한지 여부를 반환한다.
	 * 
	 * @param year - 년
	 * @param month - 월
	 * @param date - 일
	 * @param whatToDo - 음력 또는 양력으로 변환여부
	 * @return boolean - 변환 가능한지에 대한 boolean 값
	 */
	private static boolean verifyDate(int year, int month, int day, String whatToDo) {
		if (year < 1881 || year > 2043 || month < 1 || month > 12) {
			return false;
		}

		if (whatToDo.equals("To Lunar")) {
			if (day > dateCount[month - 1])
				return false;
		}

		if (whatToDo.equals("To Solar+")) {
			if (kk[(year - 1881) * 13 + 12] < 1)
				return false;
			if (kk[(year - 1881) * 13 + month] < 3)
				return false;
			if ((kk[(year - 1881) * 13 + month] + 26) < day)
				return false;
		}

		if (whatToDo.equals("To Solar-")) {
			int j = month - 1;
			for (int i = 1; i <= 12; i++)
				if (kk[(year - 1881) * 13 + i - 1] > 2)
					j++;
			if (day > (kk[(year - 1881) * 13 + j] + 28))
				return false;
		}
		return true;
	}

	/**
	 * check date string validation with the default format "yyyyMMdd".
	 * 
	 * @param s - date string you want to check with default format "yyyyMMdd"
	 * @return boolean - true 날짜 형식이 맞고, 존재하는 날짜일 때 false 날짜 형식이 맞지 않거나, 존재하지 않는
	 *         날짜일 때
	 */
	public static boolean isValid(String s) {
		return isValid(s, "yyyyMMdd");
	}

	/**
	 * check date string validation with an user defined format.
	 * 
	 * @param s - date string you want to check.
	 * @param format - string representation of the date format. For example,
	 *            "yyyy-MM-dd".
	 * @return boolean - true 날짜 형식이 맞고, 존재하는 날짜일 때 false 날짜 형식이 맞지 않거나, 존재하지 않는
	 *         날짜일 때
	 * @see java.text.SimpleDateFormat
	 */
	public static boolean isValid(String s, String format) {

		SimpleDateFormat formatter = new SimpleDateFormat(format, Locale.KOREA);
		Date date = null;
		try {
			date = formatter.parse(s);
		} catch (java.text.ParseException e) {
			return false;
		}

		if (!formatter.format(date).equals(s)) {
			return false;
		}
		return true;
	}

	/**
	 * return months between two date strings
	 * 
	 * @param String - from date string, yyyyMMdd 형식
	 * @param String - to date string, yyyyMMdd 형식
	 * @return int - 날짜 형식이 맞고, 존재하는 날짜일 때 2개 일자 사이의 개월수 리턴 형식이 잘못 되었거나 존재하지 않는
	 *         날짜: java.text.ParseException 발생
	 * @exception LException
	 */
	public static int getMonthsBetween(String from, String to) throws Exception {
		return getMonthsBetween(from, to, "yyyyMMdd");
	}

	/**
	 * return months between two date strings with user defined format.
	 * 
	 * @param String - from date string
	 * @param String - to date string
	 * @return int - 날짜 형식이 맞고, 존재하는 날짜일 때 2개 일자 사이의개월수 리턴 형식이 잘못 되었거나 존재하지 않는
	 *         날짜: java.text.ParseException 발생
	 * @exception LException
	 */
	public static int getMonthsBetween(String from, String to, String format) {

		Date fromDate = new Date();
		Date toDate = new Date();
		try {
			fromDate = check(from, format);
			toDate = check(to, format);
		} catch (ParseException e) {
			throw new IllegalArgumentException(e.getMessage());
		}

		// if two date are same, return 0.
		if (fromDate.compareTo(toDate) == 0)
			return 0;

		SimpleDateFormat yearFormat = new SimpleDateFormat("yyyy", Locale.KOREA);
		SimpleDateFormat monthFormat = new SimpleDateFormat("MM", Locale.KOREA);
		SimpleDateFormat dayFormat = new SimpleDateFormat("dd", Locale.KOREA);

		int fromYear = Integer.parseInt(yearFormat.format(fromDate));
		int toYear = Integer.parseInt(yearFormat.format(toDate));
		int fromMonth = Integer.parseInt(monthFormat.format(fromDate));
		int toMonth = Integer.parseInt(monthFormat.format(toDate));
		int fromDay = Integer.parseInt(dayFormat.format(fromDate));
		int toDay = Integer.parseInt(dayFormat.format(toDate));

		int result = 0;
		result += ((toYear - fromYear) * 12);
		result += (toMonth - fromMonth);

		// ceil과 floor의 효과
		if (((toDay - fromDay) > 0)) {
			result += toDate.compareTo(fromDate);
		}

		return result;
	}

	/**
	 * check date string validation with an user defined format.
	 * 
	 * @param s - date string you want to check.
	 * @param format - string representation of the date format. For example,
	 *            "yyyy-MM-dd".
	 * @return java.util.Date
	 */
	private static Date check(String s, String format) throws ParseException {
		if (s == null) {
			throw new ParseException("date string to check is null", 0);
		}
		if (format == null) {
			throw new ParseException("format string to check date is null", 0);
		}

		SimpleDateFormat formatter = new SimpleDateFormat(format, Locale.KOREA);
		Date date = null;
		try {
			date = formatter.parse(s);
		} catch (ParseException e) {
			throw new ParseException(" wrong date:\"" + s + "\" with format \"" + format + "\"", 0);
		}

		if (!formatter.format(date).equals(s)) {
			throw new ParseException("Out of bound date:\"" + s + "\" with format \"" + format + "\"", 0);
		}
		return date;
	}

	/**
	 * <pre>
	 * yyyyMMdd 형식의 Timestamp 날짜를 yyyy/MM/dd 형식으로 반환한다.
	 * </pre>
	 * 
	 * @param dateData - Timestamp 형식의 날짜
	 * @return String - yyyy/MM/dd 형식의 Timestamp 날짜
	 */
	public static String convertToString(Timestamp dateData) {
		return convertToString(dateData, "yyyy/MM/dd");
	}

	/**
	 * <pre>
	 * yyyyMMdd 형식의 Timestamp 날짜를 pattern 에 따른 형식으로 반환한다.
	 * </pre>
	 * 
	 * @param dateData - Timestamp 형식의 날짜
	 * @param pattern - SimpleDateFormat 에 적용할 pattern
	 * @return String - yyyy/MM/dd 형식의 Timestamp 날짜
	 */
	public static String convertToString(Timestamp dateData, String pattern) {
		return convertToString(dateData, pattern, Locale.KOREA);
	}

	/**
	 * <pre>
	 * yyyyMMdd 형식의 Timestamp 날짜를 pattern 과 locale  에 따른 형식으로 반환한다.
	 * </pre>
	 * 
	 * @param dateData - Timestamp 형식의 날짜
	 * @param pattern - SimpleDateFormat 에 적용할 pattern
	 * @param locale - 국가별 LOCALE
	 * @return String - pattern 형식의 Timestamp 날짜
	 */
	public static String convertToString(Timestamp dateData, String pattern, Locale locale) {

		if (dateData == null) {
			return null;
		}

		SimpleDateFormat formatter = new SimpleDateFormat(pattern, locale);

		return formatter.format(dateData);
	}

	/**
	 * <pre>
	 * yyyyMMdd 형식의 날짜를 Timestamp 로  반환한다.
	 * </pre>
	 * 
	 * @param dateData - yyyyMMdd 형식의 날짜
	 * @return Timestamp - 형식의 해당 날짜
	 */
	public static Timestamp convertToTimestamp(String dateData) {

		if (!CDateUtils.isValid(CDateUtils.toYYYYMMDDDate(dateData))) {

			throw new IllegalArgumentException("'" + dateData + "'는 적절한 date 값이 아닙니다.");
		}

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
		return new Timestamp(cal.getTime().getTime());
	}

	/**
	 * <pre>
	 * yyyyMMddHHmmss 형식의  날짜시각을 Timestamp 로  반환한다.
	 * </pre>
	 * 
	 * @param dateData - yyyyMMddHHmmss 형식의 날짜시각
	 * @return Timestamp - 형식의 해당 날짜시각
	 */
	public static Timestamp convertToTimestampHMS(String dateData) {

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
	}
}
