<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="cewolf" uri="/WEB-INF/cewolf-1.1.tld"  %>
<%@page import="org.jfree.chart.renderer.category.CategoryItemRenderer"%>
<%@page import="de.laures.cewolf.ChartPostProcessor"%>
<%@ page import="com.csValue.common.chart.PieProcessor" %>
<%--
/**
 * ------------------------------------------------------------------------
 * @source  : pieDemo.jsp
 * @desc    : 饼状图示例
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2011.05.15   csq        初次建立
 * ------------------------------------------------------------------------ 
 */
--%>
<html>
<jsp:useBean id="data" class="ssdevframework.core.collection.CData"	scope="request" />
<jsp:useBean id="categoryData"      class="com.csValue.common.chart.InitPieChart" scope="request"/> 
<head>
<TITLE><%=data.getString("queryTitle") %></TITLE>
</head>

<body >
	<% 
	 ChartPostProcessor fontRender = new PieProcessor() ;
    pageContext.setAttribute("fontRender", fontRender);
	%>	
	<cewolf:chart id="pieT"
	    title="饼状图"
	    antialias="false"    
		type="pie"  >
      <cewolf:data>      
       <cewolf:producer id="categoryData" /> 
      </cewolf:data>
	<cewolf:chartpostprocessor id="fontRender"/>     
    </cewolf:chart>
       <p>
    <cewolf:img chartid="pieT" renderer="/cewolf"  width="800" height="500" removeAfterRender="true"/>  


</body>
</html>