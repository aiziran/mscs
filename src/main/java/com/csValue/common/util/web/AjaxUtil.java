package com.csValue.common.util.web;

import java.util.Iterator;

import ssdevframework.core.collection.CData;
import ssdevframework.core.collection.CMultiData;

/**
 * 
 * @ClassName: AjaxUtil 
 * @Description: 
 *		ajax转换工具类
 * @author caoshengquan csq39@126.com 
 * @date 2011-5-2 上午01:02:37 
 *
 */
public class AjaxUtil {

	private static String XML_HEADER = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";

	/**
	 * 
	 * @Description: 
	 *		cdata 转换为xml格式的form数据
	 *      格式如下：
	 *      	<form>
	 *      	  	<key id="key1">value1</key1>
	 *      		<key id="key2">value2</key2>
	 *      	</form>
	 * @param data
	 * @return     
	 * @throws
	 */
	public static String convert2FormXml(CData data) {
		StringBuilder sb = new StringBuilder();
		sb.append(XML_HEADER);
		sb.append("<form>");

		for (Iterator iterator = data.keySet().iterator(); iterator.hasNext();) {
			String type = (String) iterator.next();
			sb.append("<key id=\"" + type + "\">");
			sb.append(data.get(type));
			sb.append("</key>");
		}

		sb.append("</form>");

		return sb.toString();
	}

	/**
	 * @Description: 
	 *	CMultiData转换为xml格式的数据
	 *		格式如下
	 *	      	<multi>
	 *      	  	<key id="key1">value1</key1>
	 *      		<key id="key1">value2</key1>
	 *      		<key id="key1">value3</key1>
	 *      		<key id="key2">value1</key2>
	 *      		<key id="key2">value2</key2>
	 *      	</form>
	 * @param data
	 * @return     
	 * @throws
	 */
	public static String convert2MultidataXml(CMultiData data) {
		StringBuilder sb = new StringBuilder();
		sb.append(XML_HEADER);
		sb.append("<multi>");

		for (Iterator iterator = data.keySet().iterator(); iterator.hasNext();) {
			String type = (String) iterator.next();
			for (int i = 0; i < data.getDataCount(type); i++) {
				sb.append("<key id=\"" + type + "\">");
				sb.append(data.get(type, i));
				sb.append("</key>");
			}
		}

		sb.append("</multi>");

		return sb.toString();
	}

	/**
	 * @Description: 
	 *	CMultiData转换为xml格式的数据
	 *		格式如下
	 *	      	<data>
	 *      	  	<key id="key1">value1</key1>
	 *      		<key id="key2">value2</key2>
	 *      	</data>
	 * @param data
	 * @return     
	 * @throws
	 */
	public static String convert2dataXml(CData data) {
		StringBuilder sb = new StringBuilder();
		sb.append("<data>");

		for (Iterator iterator = data.keySet().iterator(); iterator.hasNext();) {
			String type = (String) iterator.next();
			sb.append("<key id=\"" + type + "\">");
			sb.append(data.get(type));
			sb.append("</key>");
		}

		sb.append("</data>");

		return sb.toString();
	}

	/**
	 * @Description: 
	 *	CMultiData转换为xml格式的数据
	 *		格式如下
	 *	      	<multi>
	 *				<data>
	 *      	  	<key id="key1">value1</key1>
	 *      		<key id="key2">value2</key1>
	 *      		</data>
	 *      		<data>
	 *      	  	<key id="key1">value1</key1>
	 *      		<key id="key2">value2</key1>
	 *      		</data>
	 *      		<data>
	 *      	  	<key id="key1">value1</key1>
	 *      		<key id="key2">value2</key1>
	 *      		</data>
	 *      	</multi>
	 * @param data
	 * @return     
	 * @throws
	 */
	public static String convert2MultidataXml2(CMultiData data) {
		StringBuilder sb = new StringBuilder();
		sb.append(XML_HEADER);
		sb.append("<multi>");

		for (int i = 0; i < data.getDataCount(); i++) {
			sb.append(convert2dataXml(data.getCData(i)));
		}

		sb.append("</multi>");

		return sb.toString();
	}
}
