<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html>
<head>
   <%@ include file="/common/taglibs.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>质检</title>
<script type="text/javascript">
 function login(){
	 window.location.href="${ctx}/basicInfor/lishiManage/lishi!zhijian.action";
	
 }
 </script>
</head>
<body onload="login()">

</body>
</html>