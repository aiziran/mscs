<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="cewolf" uri="/WEB-INF/cewolf-1.1.tld"  %>
<%@page import="com.csValue.common.chart.VerticalProcessor"%>
<%@page import="de.laures.cewolf.ChartPostProcessor,org.jfree.chart.renderer.category.BarRenderer"%>
<%--
/**
 * ------------------------------------------------------------------------
 * @source  : vertical.jsp
 * @desc    : 柱状图示例
 * ------------------------------------------------------------------------
 * LG CNS Project Management System
 * Copyright(c) 2010 LG CNS,  All rights reserved.
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2011.05.15   csq        初次建立
 * ------------------------------------------------------------------------ 
 */
--%>
<html>
<jsp:useBean id="data" class="ssdevframework.core.collection.CData"	scope="request" />
<jsp:useBean id="categoryData"      class="com.csValue.common.chart.InitVerticalBar" scope="request"/> 
<head>
<TITLE><%=data.getString("queryTitle") %></TITLE>
</head>

<body >
	<% 
	 ChartPostProcessor fontRender = new VerticalProcessor();
    pageContext.setAttribute("fontRender", fontRender);
	%>	
	<cewolf:chart 
		id="verticalBar"
		title="<%=data.getString("title") %>" 
		type="verticalBar"  
        xaxislabel="<%=data.getString("typeName") %>" 
        yaxislabel="<%=data.getString("yScrollName") %>">  
      <cewolf:data>      
       <cewolf:producer id="categoryData" /> 
      </cewolf:data>
	<cewolf:chartpostprocessor id="fontRender"/>     
    </cewolf:chart>
       <p>
    <cewolf:img chartid="verticalBar" renderer="/cewolf"  width="760" height="350" removeAfterRender="true"/>  


</body>
</html>