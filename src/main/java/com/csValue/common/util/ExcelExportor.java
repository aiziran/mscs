package com.csValue.common.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ssdevframework.core.collection.CMultiData;

/**
 * 对ExportForExcel的包装类，稍易于使用
 * @author guanxihua
 */
public class ExcelExportor {

	private String m_fileName;
	private CMultiData m_result;
	private ArrayList m_columnName;
	private Map m_headerNameMap;

	private ExcelExportor() {
	}

	public ExcelExportor(HttpServletRequest req, HttpServletResponse res, String fileName, CMultiData result) {
		this.m_fileName = fileName;
		this.m_result = result;
		this.m_columnName = new ArrayList();
		this.m_headerNameMap = new HashMap();
		ExportForExcel.exportToXlsTemp(req, res, m_fileName, m_result, m_columnName, m_headerNameMap);
	}

	public void addColumn(String columnName, String headerName) {
		this.m_columnName.add(columnName);
		this.m_headerNameMap.put(columnName, headerName);
	}
}