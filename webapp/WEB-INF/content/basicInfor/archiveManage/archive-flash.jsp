<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--
/**
 * ------------------------------------------------------------------------
 * 档案列表界面
 * ------------------------------------------------------------------------
 * ------------------------------------------------------------------------ 
 */
--%>
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<body onload="fncFixupListHead();">
   
       
 <object width="420" height="363">
 <param name="movie" value="/archive/${swfFile }"></param>
 <param name="allowFullScreen" value="true"></param>
 <param name="allowscriptaccess" value="always"></param>
 <param name="wmode" value="opaque"></param>
 <embed src="/archive/${swfFile }" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" wmode="opaque" width="420" height="363"></embed></object>
</body>
 
</html>