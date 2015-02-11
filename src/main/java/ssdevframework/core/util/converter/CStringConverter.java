package ssdevframework.core.util.converter;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.StringTokenizer;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class CStringConverter {
	public CStringConverter() {
	}

	/**
	 * Y / N 을 예/아니오로 바꾸어 준다
	 * 
	 * @param ynStr - Y/N
	 * @return String - 예/아니오
	 */
	public static String convertYn(String ynStr) {
		if (ynStr == null)
			return "";
		if (ynStr.trim().toUpperCase().equals("Y"))
			return "예";
		if (ynStr.trim().toUpperCase().equals("N"))
			return "아니오";
		return "";
	}

	/**
	 * limit 자리수 만큼 글자를 잘라준다.
	 * 
	 * @param str - 대상문자열
	 * @param limit -자를 자릿수
	 * @return String - 잘라진 문자열
	 */
	public static String shortCutString(String str, final int limit) {

		if (str == null || limit < 4)
			return str;

		int len = str.length();
		int cnt = 0, index = 0;

		while (index < len && cnt < limit) {
			if (str.charAt(index++) < 256) // 1바이트 문자라면...
				cnt++; // 길이 1 증가
			else
				// 2바이트 문자라면...
				cnt += 2; // 길이 2 증가
		}

		if (index < len)
			str = str.substring(0, index);

		return str;
	}

	/**
	 * 대상문자열(strTarget)의 임의의 위치(loc)에 지정문자열(strInsert)를 추가한 문자열을 반환한다.
	 * 
	 * @param strTarget - 대상문자열
	 * @param loc - 지정문자열을 추가할 위치로서 대상문자열의 첫문자 위치를 0으로 시작한 상대 위치. loc가 0 보다 작은
	 *            값일 경우는 대상문자열의 끝자리를 0으로 시작한 상대적 위치. 맨앞과 맨뒤는 문자열 + 연산으로 수행가능함으로
	 *            제공하지 않는다.
	 * @param strInsert - 추가할 문자열
	 * @return String 추가완료된 문자열
	 */
	public static String insert(String strTarget, int loc, String strInsert) {
		String result = null;

		StringBuffer strBuf = new StringBuffer();
		int lengthSize = strTarget.length();
		if (loc >= 0) {
			if (lengthSize < loc) {
				loc = lengthSize;
			}
			strBuf.append(strTarget.substring(0, loc));
			strBuf.append(strInsert);
			strBuf.append(strTarget.substring(loc + strInsert.length()));
		} else {
			if (lengthSize < Math.abs(loc)) {
				loc = lengthSize * (-1);
			}
			strBuf.append(strTarget.substring(0, (lengthSize - 1) + loc));
			strBuf.append(strInsert);
			strBuf.append(strTarget.substring((lengthSize - 1) + loc + strInsert.length()));
		}
		result = strBuf.toString();

		return result;
	}

	/**
	 * 대상문자열(strTarget)에서 지정문자열(strDelete)을 삭제한 문자열을 반환한다.
	 * 
	 * @param strTarget - 대상문자열
	 * @param strDelete - 삭제할 문자열
	 * @return String - 삭제완료된 문자열
	 */
	public static String delete(String strTarget, String strDelete) {
		return replace(strTarget, strDelete, "");
	}

	/**
	 * 대상문자열(strTarget)에서 구분문자열(strDelim)을 기준으로 문자열을 분리하여 각 분리된 문자열을 배열에 할당하여
	 * 반환한다.
	 * 
	 * @param strTarget - 분리 대상 문자열
	 * @param strDelim - 구분시킬 문자열로서 결과 문자열에는 포함되지 않는다.
	 * @param bContainNull - 구분되어진 문자열중 공백문자열의 포함여부. true : 포함, false : 포함하지 않음.
	 * @return String[] - 분리된 문자열을 순서대로 배열에 격납하여 반환한다.
	 */
	public static String[] split(String strTarget, String strDelim, boolean bContainNull) {
		// StringTokenizer는 구분자가 연속으로 중첩되어 있을 경우 공백 문자열을 반환하지 않음.
		// 따라서 아래와 같이 작성함.
		int index = 0;
		String[] resultStrArray = null;
		resultStrArray = new String[search(strTarget, strDelim) + 1];
		String strCheck = new String(strTarget);
		while (strCheck.length() != 0) {
			int begin = strCheck.indexOf(strDelim);
			if (begin == -1) {
				resultStrArray[index] = strCheck;
				break;
			} else {
				int end = begin + strDelim.length();
				if (bContainNull) {
					resultStrArray[index++] = strCheck.substring(0, begin);
				}
				strCheck = strCheck.substring(end);
				if (strCheck.length() == 0 && bContainNull) {
					resultStrArray[index] = strCheck;
					break;
				}
			}
		}
		return resultStrArray;
	}

	/**
	 * 대상문자열(strTarget)에서 지정문자열(strSearch)이 검색된 횟수를, 지정문자열이 없으면 0 을 반환한다.
	 * 
	 * @param strTarget - 대상문자열
	 * @param strSearch - 검색할 문자열
	 * @return int - 지정문자열이 검색되었으면 검색된 횟수를, 검색되지 않았으면 0 을 반환한다.
	 */
	public static int search(String strTarget, String strSearch) {
		int result = 0;
		String strCheck = new String(strTarget);
		for (int i = 0; i < strTarget.length();) {
			int loc = strCheck.indexOf(strSearch);
			if (loc == -1) {
				break;
			} else {
				result++;
				i = loc + strSearch.length();
				strCheck = strCheck.substring(i);
			}
		}
		return result;
	}

	/**
	 * String에 포함된 '$'에 escape를 추가한다.
	 * 
	 * @param str - 대상문자열
	 * @return String - 변경된 문자열
	 */
	public static String escapeDollarMarker(String str) throws Exception {
		return CStringConverter.replace(str, "$", "\\$");
	}

	/**
	 * 입력값이 널인지 여부를 검사한다. 단 기본은 ""과 null을 모두 true로 리턴한다. 모든 DB Access메소드는
	 * null체크가 필요한 경우에 이것을 이용한다.
	 * 
	 * @param value - String
	 * @return boolean
	 */
	public static boolean isNull(String value) {
		return value == null;
	}

	/**
	 * index에 해당하는 token을 리턴한다.
	 * 
	 * @param value - 원본 String
	 * @param delim - String 구분자
	 * @param idx - index
	 * @return boolean
	 */
	public static String token(String value, String delim, int idx) {
		if (value == null)
			return null;
		StringTokenizer st = new StringTokenizer(value, delim);
		int i = 0;
		while (st.hasMoreTokens()) {
			if ((i++) == idx)
				return st.nextToken();
			else
				st.nextToken();
		}
		return null;
	}

	/**
	 * value(String type)가 널이거나 length()가 0이면 리턴 true 그렇지 않으면 false
	 * 
	 * @param value -String
	 * @return boolean
	 */
	public static boolean isNone(String value) {
		return (value == null || value.length() == 0);
	}

	/**
	 * 하나의 문자열을 기준 문자열을 준으로 두개로 분리한다.
	 * 
	 * @param target - String
	 * @param cut_str - 기준 문자열 String
	 * @return String[]
	 */
	public static String[] divide(String target, String cut_str) {
		if (target == null)
			return new String[] { "", "" };
		if (cut_str == null || cut_str.length() == 0)
			return new String[] { target, "" };
		int idx = target.indexOf(cut_str);
		if (idx < 0)
			return new String[] { target, "" };
		else
			return new String[] { target.substring(0, idx), target.substring(idx + cut_str.length()) };
	}

	/**
	 * 하나의 문자열을 기준 문자열로 여러개로 분리한다.
	 * 
	 * @param target - String
	 * @param cut_str - 기준 문자열 String
	 * @return String[]
	 */
	public static String[] cut(String target, String cut_str) {
		if (target == null)
			return new String[] {};
		if (cut_str == null || cut_str.length() == 0)
			return new String[] { target };
		int idx = target.indexOf(cut_str);
		if (idx < 0)
			return new String[] { target };
		ArrayList arr = new ArrayList();
		final int cut_str_len = cut_str.length();
		int next_idx = 0;
		while (idx >= 0) {
			arr.add(target.substring(next_idx, idx));
			next_idx = idx + cut_str_len;
			idx = target.indexOf(cut_str, next_idx);
			if (idx < 0) {
				arr.add(target.substring(next_idx));
				break;
			}
		}
		return (String[]) arr.toArray(new String[arr.size()]);
	}

	/**
	 * 문자열의 첫글자를 소문자로 변경하여 리턴한다.
	 * 
	 * @param s - String
	 * @return String - 첫글자가 소문자로 변경된 string
	 */
	public static String lowerFirst(String s) {
		if (s == null || s.length() < 1)
			return s;
		return (s.substring(0, 1).toLowerCase() + s.substring(1));
	}

	/**
	 * BASE64 Encoding을 수행한다.
	 * 
	 * @param vo - Object
	 * @return String
	 * @exception IOException
	 */
	public static String encode(Object vo) throws IOException {
		ByteArrayOutputStream bo = new ByteArrayOutputStream();
		ObjectOutputStream os = new ObjectOutputStream(bo);
		os.writeObject(vo);
		return new BASE64Encoder().encode(bo.toByteArray());
	}

	/**
	 * BASE64 Decoding을 수행한다.
	 * 
	 * @param text
	 * @return Object
	 * @exception IOException, ClassNotFoundException
	 */
	public static Object decode(String text) throws IOException, ClassNotFoundException {
		byte o[] = new BASE64Decoder().decodeBuffer(text);
		ByteArrayInputStream bi = new ByteArrayInputStream(o);
		ObjectInputStream os = new ObjectInputStream(bi);
		Object vo = os.readObject();
		return vo;
	}

	/**
	 * 입력된 스트링에서 특정 문자를 채운다.
	 * 
	 * @param s - 원본 String
	 * @param ch - byte
	 * @param len - int
	 * @return String
	 */
	public static String fillLeft(String s, byte ch, int len) {
		if (s == null)
			s = "";
		byte[] ss;
		try {
			ss = s.getBytes("ksc5601");
		} catch (Exception e) {
			return s;
		}
		if (len <= ss.length)
			return s;
		byte[] chs = new byte[len];
		int j = len - 1;
		for (int i = ss.length - 1; i >= 0; i--)
			chs[j--] = ss[i];
		for (; j >= 0; j--)
			chs[j] = ch;
		try {
			return new String(chs, "ksc5601");
		} catch (Exception e) {
			return s;
		}
	}

	/**
	 * 입력된 스트링에서 특정 문자를 추가한다.
	 * 
	 * @param s - 원본 String
	 * @param ch - byte
	 * @param len - int
	 * @return String
	 */
	public static String fillRight(String s, byte ch, int len) {
		if (s == null)
			s = "";
		byte[] ss;
		try {
			ss = s.getBytes("ksc5601");
		} catch (Exception e) {
			return s;
		}
		if (len <= ss.length)
			return s;
		byte[] chs = new byte[len];
		int j = 0;
		for (int i = 0; i < ss.length; i++)
			chs[j++] = ss[i];
		for (; j < len; j++)
			chs[j] = ch;
		try {
			return new String(chs, "ksc5601");
		} catch (Exception e) {
			return s;
		}
	}

	/**
	 * 입력된 스트링에서 특정 문자를 제거한다.
	 * 
	 * @param s - 원본 String
	 * @param delims - String 구분자
	 * @return String
	 */
	public static String strip(String s, String delims) {
		if (s == null || s.length() == 0 || delims == null)
			return s;
		StringBuffer sb = new StringBuffer();
		StringTokenizer st = new StringTokenizer(s, delims);
		while (st.hasMoreTokens()) {
			sb.append(st.nextToken());
		}
		return sb.toString();
	}

	/**
	 * 문자열의 첫글자를 대문자로 변경하여 리턴한다.
	 * 
	 * @param s - 원본 String
	 * @return String
	 */
	public static String upperFirst(String s) {
		if (s == null || s.length() < 1)
			return s;
		return (s.substring(0, 1).toUpperCase() + s.substring(1));
	}

	/**
	 * 구분자로 연결될 스트링을 스트링 배열로 리턴한다.
	 * 
	 * @param text - 원본 String
	 * @param delimiter - String 구분자
	 * @return String[]
	 */
	public static String[] stringToArray(String text, String delimiter) {
		ArrayList array = new ArrayList();
		String cur = text;
		while (cur != null && delimiter != null) {
			int i = cur.indexOf(delimiter);
			if (i < 0) {
				array.add(cur);
				cur = null;
			} else {
				array.add(cur.substring(0, i));
				cur = cur.substring(i + delimiter.length());
			}
		}
		return (String[]) array.toArray(new String[array.size()]);
	}

	/**
	 * 스트링 배열을 구분자로 연결한 스트링으로 리턴한다.
	 * 
	 * @param values - String[]
	 * @param delimiter - String 구분자
	 * @return String
	 */
	public static String arrayToString(String[] values, String delimiter) {
		StringBuffer sb = new StringBuffer();
		if (values == null || values.length < 1)
			return "";
		sb.append(values[0]);
		for (int i = 1; i < values.length; i++) {
			sb.append(delimiter).append(values[i]);
		}
		return sb.toString();
	}

	/**
	 * String을 mysql에 적합한 String으로 변환한다.
	 * 
	 * @param s - java String
	 * @return String - mySQL용 String
	 */
	public static String java2mysql(String s) {
		if (s == null)
			return null;
		StringBuffer buf = new StringBuffer();
		char[] c = s.toCharArray();
		int len = c.length;
		for (int i = 0; i < len; i++) {
			if (c[i] == '\n')
				buf.append("\\n");
			else if (c[i] == '\t')
				buf.append("\\t");
			else if (c[i] == '\r')
				buf.append("\\r");
			else if (c[i] == '\'')
				buf.append("\\'");
			else if (c[i] == '"')
				buf.append("\\\"");
			else if (c[i] == '%')
				buf.append("\\%");
			else
				buf.append(c[i]);
		}
		return buf.toString();
	}

	/**
	 * String을 alert(script)에 적합한 String으로 변환한다.
	 * 
	 * @param s - java String
	 * @return String - alert(script)용 String
	 */
	public static String str2alert(String s) {
		if (s == null)
			return null;
		StringBuffer buf = new StringBuffer();
		char[] c = s.toCharArray();
		int len = c.length;
		for (int i = 0; i < len; i++) {
			if (c[i] == '\n')
				buf.append("\\n");
			else if (c[i] == '\t')
				buf.append("\\t");
			else if (c[i] == '"')
				buf.append("'");
			else
				buf.append(c[i]);
		}
		return buf.toString();
	}

	/**
	 * String을 message(LMessage)에 적합한 String으로 변환한다.
	 * 
	 * @param s - java String
	 * @return String - message(LMessage)용 String
	 */
	public static String java2msg(String s) {
		if (s == null)
			return null;
		StringBuffer buf = new StringBuffer();
		char[] c = s.toCharArray();
		int len = c.length;
		for (int i = 0; i < len; i++) {
			if (c[i] == '\n')
				buf.append("\\n");
			else if (c[i] == '\t')
				buf.append("\\t");
			else
				buf.append(c[i]);
		}
		return buf.toString();
	}

	/**
	 * String을 html에 적합한 String으로 변환한다.
	 * 
	 * @param s - java String
	 * @return String - html용 String
	 */
	public static String java2html(String s) {
		if (s == null)
			return null;
		StringBuffer buf = new StringBuffer();
		char[] c = s.toCharArray();
		int len = c.length;
		for (int i = 0; i < len; i++) {
			if (c[i] == '&')
				buf.append("&amp;");
			else if (c[i] == '<')
				buf.append("&lt;");
			else if (c[i] == '>')
				buf.append("&gt;");
			else if (c[i] == '"')
				buf.append("&quot;");
			else if (c[i] == '\'')
				buf.append("&#039;");
			else
				buf.append(c[i]);
		}
		return buf.toString();
	}

	/**
	 * '\n'를 ' '으로 변환하여 리턴한다.
	 * 
	 * @param string - 원본 String
	 * @return String - 변경된 String
	 */
	public static String toOneLine(String string) {
		if (string == null)
			return null;
		else
			return string.replace('\n', ' ');
	}

	/**
	 * 매개변수로 들어온 문자열에서 '-'을 찾아 제거하고 //CH03
	 * 
	 * '-'이 없는 연결된 문자열을 Return한다.
	 * 
	 * @param org - '-'이 포함된 String
	 * @return String - '-'가 제거된 String
	 */
	public static String stripHyphen(String org) throws Exception {
		if (org != null)
			// exception handling
			for (;;) {
				int index = org.indexOf("-");
				if (index >= 0) {
					org = org.substring(0, index) + org.substring(index + 1);
				} else {
					break;
				}
			}
		return org;
	}

	/**
	 * 포멧을 지정하여 속성값을 String으로 변환한다. 널인경우에는 ""을 리턴한다.
	 * 
	 * @param value
	 * @param format
	 * @return String
	 */
	public static String print(String value, String format) {
		Object o = value;
		if (o == null)
			return "";
		if (format == null)
			return o.toString();
		try {
			// 데이타가 문자열인경우 ###-###형태를 사용합니다.
			if (o instanceof String) {
				String s = (String) o;
				int j = 0;
				StringBuffer sb = new StringBuffer();
				for (int i = 0; i < format.length(); i++) {
					if (format.charAt(i) == '#') {
						if (j >= s.length())
							return sb.toString();
						sb.append(s.charAt(j++));
					} else {
						sb.append(format.charAt(i));
					}
				}
				return sb.toString();
			}
			// 데이타가 날짜관련인경우에 javadoc의 SimpleDateFormat 참조
			// 데이타가 숫자인경우에 javadoc의 DecimalFormat을 참조
			// 포멧이 "#,##0"경우에는 3,100 형태로 출력되고
			// 포멧이 "00000"인경우에는 00009형태로 출력
			if (o instanceof Number || o instanceof BigDecimal) {
				DecimalFormat df = new DecimalFormat(format);
				return df.format(o);
			}
		} catch (Exception e) {
		}
		return o.toString();
	}

	public static String getCalcStr(String str, int sLoc, int eLoc) {
		byte[] bystStr = null;
		String rltStr = "";
		try {
			bystStr = str.getBytes();
			rltStr = new String(bystStr, sLoc, eLoc - sLoc);
		} catch (Exception e) {
			return str;
		}
		return rltStr;
	}

	/**
	 * 파라미터로 넘어온 String을 repeateCount만큼 반복하여 생성한 후 반환한다.
	 * 
	 * @param str String
	 * @param repeateCount int
	 * @return String
	 */
	public static String makeRepeatString(String str, int repeateCount) {
		StringBuffer resultStr = new StringBuffer();
		for (int inx = 0; inx < repeateCount; inx++) {
			resultStr.append(str);
		}
		return resultStr.toString();
	}

	/**
	 * 지정된 문자열에 '$', '\'가 포함되어 있으면 해당 문자앞에 '\'를 추가하여 리턴한다.
	 * 
	 * @param String s '$', '\'앞에 '\'가 없는 문자열
	 * @return \가 추가된 문자열
	 */
	public static String quoteReplacement(String s) {
		if ((s.indexOf('\\') == -1) && (s.indexOf('$') == -1))
			return s;
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			if (c == '\\') {
				sb.append('\\');
				sb.append('\\');
			} else if (c == '$') {
				sb.append('\\');
				sb.append('$');
			} else {
				sb.append(c);
			}
		}
		return sb.toString();
	}

	/**
	 * 지정된 문자열에 원하는 문자가 포함되어 있으면 해당 문자앞에 '\'를 추가하여 리턴한다.
	 * 
	 * @param String s '$', '\'앞에 '\'가 없는 문자열
	 * @return \가 추가된 문자열
	 */
	public static String quoteReplacement(String s, char ch) {
		if (s.indexOf(ch) == -1)
			return s;
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			if (c == ch) {
				sb.append('\\');
				sb.append(ch);
			} else {
				sb.append(c);
			}
		}
		return sb.toString();
	}

	/**
	 * 대상문자열(strTarget)에서 특정문자열(strSearch)을 찾아 지정문자열(strReplace)로 변경한 문자열을 반환한다.
	 * 
	 * @param strTarget 대상문자열
	 * @param strSearch 변경대상의 특정문자열
	 * @param strReplace 변경 시키는 지정문자열
	 * @exception Exception
	 * @return 변경완료된 문자열
	 */
	public static String replace(String strTarget, String strSearch, String strReplace) {
		String result = null;
		String strCheck = new String(strTarget);
		StringBuffer strBuf = new StringBuffer();
		while (strCheck.length() != 0) {
			int begin = strCheck.indexOf(strSearch);
			if (begin == -1) {
				strBuf.append(strCheck);
				break;
			} else {
				int end = begin + strSearch.length();
				strBuf.append(strCheck.substring(0, begin));
				strBuf.append(strReplace);
				strCheck = strCheck.substring(end);
			}
		}
		result = strBuf.toString();
		return result;
	}

	/**
	 * org내에 delim이 포함되어 있을 때 delim와 org내 delim을 구분하기 위해 처리하는 메소드.
	 * 
	 * @param org - String
	 * @param delim - char
	 * @return String
	 */
	public static String insertDelimToString(String org, char delim) {
		StringBuffer sb = new StringBuffer();

		char[] chars = org.toCharArray();
		for (int inx = 0; inx < chars.length; inx++) {
			if (inx == 0) {
				if (chars[inx] == delim) {
					sb.append(delim).append(chars[inx]);
				} else {
					sb.append(chars[inx]);
				}
			} else if (inx == chars.length - 1) {
				if (chars[inx - 1] == delim) {
					sb.append(delim).append(chars[inx]);
				} else {
					sb.append(chars[inx]);
				}
			} else {
				if (chars[inx] == delim && chars[inx - 1] != delim) {
					sb.append(delim).append(chars[inx]);
				} else {
					sb.append(chars[inx]);
				}
			}
		}

		return sb.toString();
	}
}
