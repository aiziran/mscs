package com.csValue.common.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.math.BigDecimal;
import java.net.URL;
import java.net.URLClassLoader;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class EtcUtil {

	public static boolean isNull(String value) {
		//return value==null  ;
		return value == null;
	}

	public static boolean isNull(Object value) {
		return value == null;
	}

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

	public static boolean isNone(Object vl) {
		return (vl == null);
	}

	public static boolean isNone(String value) {
		return (value == null || value.length() == 0);
	}

	public static boolean isNone(Number value) {
		return (value == null);
	}

	public static boolean isNone(List value) {
		return (value == null || value.size() == 0);
	}

	public static boolean isNone(Object[] value) {
		return (value == null || value.length == 0);
	}

	public static boolean isNone(Map value) {
		return (value == null || value.size() == 0);
	}

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

	public static String replace(String target, String oldStr, String newStr) {
		String[] targets = cut(target, oldStr);
		if (targets.length <= 1)
			return target;
		StringBuffer sb = new StringBuffer(targets[0]);
		for (int i = 1; i < targets.length; i++) {
			sb.append(newStr);
			sb.append(targets[i]);
		}
		return sb.toString();
	}

	public static void main(String[] args) {
		String ss = replace("b fd fdas fdsa fdsa fdsa", "", "<B>");
		System.out.println(ss);
	}

	public static String convSQL(String sql) {
		boolean flag = false;
		StringBuffer sb = new StringBuffer();
		StringTokenizer st = new StringTokenizer(sql);
		while (st.hasMoreTokens()) {
			String tmp = st.nextToken();
			if ("from".equalsIgnoreCase(tmp))
				break;
		}
		while (st.hasMoreTokens()) {
			String tok = st.nextToken();
			if ("order".equalsIgnoreCase(tok)) {
				if (st.hasMoreTokens() == false) {
					sb.append(' ').append(tok);
					break;
				}
				String tok2 = st.nextToken();
				if ("by".equalsIgnoreCase(tok2)) {
					break;
				} else {
					sb.append(' ').append(tok);
					sb.append(' ').append(tok2);
				}
			} else {
				sb.append(' ').append(tok);
			}
			if ("group".equalsIgnoreCase(tok)) {
				flag = true;
			} else if ("where".equalsIgnoreCase(tok)) {
				flag = false;
			}
		}
		if (flag)
			return "select count(count(*)) from " + sb.toString();
		else
			return "select count(*) from " + sb.toString();
	}

	public static Float roundup(Float value, int scale) {
		if (value == null)
			return null;
		BigDecimal b = new BigDecimal(toString(value));
		return new Float(b.setScale(scale, BigDecimal.ROUND_UP).toString());
	}

	public static Float rounddown(Float value, int scale) {
		if (value == null)
			return null;
		BigDecimal b = new BigDecimal(toString(value));
		return new Float(b.setScale(scale, BigDecimal.ROUND_DOWN).toString());
	}

	public static Float roundhalfup(Float value, int scale) {
		if (value == null)
			return null;
		BigDecimal b = new BigDecimal(toString(value));
		return new Float(b.setScale(scale, BigDecimal.ROUND_HALF_UP).toString());
	}

	public static Double roundup(Double value, int scale) {
		if (value == null)
			return null;
		BigDecimal b = new BigDecimal(toString(value));
		return new Double(b.setScale(scale, BigDecimal.ROUND_UP).toString());
	}

	public static Double rounddown(Double value, int scale) {
		if (value == null)
			return null;
		BigDecimal b = new BigDecimal(toString(value));
		return new Double(b.setScale(scale, BigDecimal.ROUND_DOWN).toString());
	}

	public static Double roundhalfup(Double value, int scale) {
		if (value == null)
			return null;
		BigDecimal b = new BigDecimal(toString(value));
		return new Double(b.setScale(scale, BigDecimal.ROUND_HALF_UP).toString());
	}

	protected static String toString(Float f) {
		DecimalFormat df = new DecimalFormat("#0.0#################");
		return df.format(f.floatValue());
	}

	protected static String toString(Double d) {
		DecimalFormat df = new DecimalFormat("#0.0#################");
		return df.format(d.doubleValue());
	}

	public static String encode(Object vo) throws IOException {
		ByteArrayOutputStream bo = new ByteArrayOutputStream();
		ObjectOutputStream os = new ObjectOutputStream(bo);
		os.writeObject(vo);
		return new BASE64Encoder().encode(bo.toByteArray());
	}

	public static Object decode(String text) throws IOException, ClassNotFoundException {
		byte o[] = new BASE64Decoder().decodeBuffer(text);
		ByteArrayInputStream bi = new ByteArrayInputStream(o);
		ObjectInputStream os = new ObjectInputStream(bi);
		Object vo = os.readObject();
		return vo;
	}

	public static int pageToStart(int page, int size) {
		return (page - 1) * size;
	}

	public static String bindParamToSql(String sql, Object[] values) {
		if (sql == null || values == null) {
			return sql;
		} else {
			StringBuffer sb = new StringBuffer();
			StringTokenizer st = new StringTokenizer(sql, "?");
			if (st.hasMoreTokens())
				sb.append(st.nextToken());
			int i = 0;
			while (st.hasMoreTokens()) {
				if (i < values.length) {
					if (values[i] instanceof String || values[i] instanceof java.util.Date)
						sb.append("'" + values[i] + "'");
					else
						sb.append(values[i]);
					i++;
				} else {
					sb.append('?');
				}
				sb.append(st.nextToken());
			}
			while (i < values.length) {
				if (values[i] instanceof String || values[i] instanceof java.util.Date)
					sb.append("'" + values[i] + "'");
				else
					sb.append(values[i]);
				i++;
			}
			return sb.toString();
		}
	}

	public static String bindParamToSql(String sql, Object value) {
		if (sql == null)
			return null;
		char[] ch = sql.toCharArray();
		ArrayList pValue = new ArrayList();
		for (int i = 0; i < ch.length; i++) {
			if ('?' == ch[i])
				pValue.add(value);
		}
		return bindParamToSql(sql, pValue.toArray());
	}

	public static int bindParamCountOnSql(String sql) {
		if (sql == null)
			return 0;
		char[] ch = sql.toCharArray();
		int cnt = 0;
		for (int i = 0; i < ch.length; i++) {
			if ('?' == ch[i])
				cnt++;
		}
		return cnt;
	}

	public static String lowerFirst(String s) {
		if (s == null || s.length() < 1)
			return s;
		return (s.substring(0, 1).toLowerCase() + s.substring(1));
	}

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

	public static String upperFirst(String s) {
		if (s == null || s.length() < 1)
			return s;
		return (s.substring(0, 1).toUpperCase() + s.substring(1));
	}

	public static String arrayToString(String[] values, String gubun) {
		StringBuffer sb = new StringBuffer();
		if (values == null || values.length < 1)
			return "";
		sb.append(values[0]);
		for (int i = 1; i < values.length; i++) {
			sb.append(gubun).append(values[i]);
		}
		return sb.toString();
	}

	public static String[] stringToArray(String text, String gubun) {
		ArrayList array = new ArrayList();
		String cur = text;
		while (cur != null && gubun != null) {
			int i = cur.indexOf(gubun);
			if (i < 0) {
				array.add(cur);
				cur = null;
			} else {
				array.add(cur.substring(0, i));
				cur = cur.substring(i + gubun.length());
			}
		}
		return (String[]) array.toArray(new String[array.size()]);
	}

	public static String eng2kor(String s) {
		if (s == null)
			return s;
		try {
			return new String(s.getBytes("8859_1"), "ksc5601");
		} catch (Exception e) {
		}
		return s;
	}

	public static String kor2eng(String s) {
		if (s == null)
			return s;
		try {
			return new String(s.getBytes("ksc5601"), "8859_1");
		} catch (Exception e) {
		}
		return s;
	}

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

	public static String toOneLine(String string) {
		if (string == null)
			return null;
		else
			return string.replace('\n', ' ');
	}

	public static ClassLoader getClassLoader(String path) {
		try {
			URL url = new URL("file://" + path.replace('\\', '/'));
			return new URLClassLoader(new URL[] { url }, Thread.currentThread().getContextClassLoader());
		} catch (Exception e) {
			return Thread.currentThread().getContextClassLoader();
		}
	}

	public static Object deepClone(Object source) {
		try {
			ByteArrayOutputStream b = new ByteArrayOutputStream();
			ObjectOutputStream out = new ObjectOutputStream(b);
			out.writeObject(source);
			ByteArrayInputStream bIn = new ByteArrayInputStream(b.toByteArray());
			ObjectInputStream oi = new ObjectInputStream(bIn);
			return ((Object) oi.readObject());
		} catch (Exception e) {
			return null;
		}
	}

	public static String decodeUrl(String str) {
		String encodedString = null;
		try {
			if (str != null) {
				encodedString = new String(str.getBytes("ISO-8859-1"), "UTF-8");
			}
		} catch (Exception ex) {
			return null;
		}
		return encodedString;
	}
}
