<%--
/**
 * ------------------------------------------------------------------------
 * @source  : exportExcel.jsp
 * @desc    : 报表导出
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2011.05.15  csq   	  初次建立
 * ------------------------------------------------------------------------ 
 */
--%>

<%@page import="com.csValue.common.util.ExportForExcel" %>
<%@page import="ssdevframework.core.collection.CMultiData" %>
<%@page import="ssdevframework.core.collection.CData" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Collection" %>
<%
    CMultiData result = (CMultiData)request.getAttribute("result");
    ArrayList columnName = (ArrayList)request.getAttribute("columnName");
    Map headerNameMap = (Map)request.getAttribute("headerNameMap");
    String target_file = (String)request.getAttribute("target_file");
    response.reset();
    response.setContentType("application/vnd.ms-excel");
    response.setHeader("Content-Disposition",
            "attachment;filename=" + target_file + ";");
    
    ExportForExcel.buildExcel(response.getOutputStream(),result,columnName,headerNameMap);
    out.clear();
    pageContext.pushBody();
%>