<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
  	alert("当前会话已超时，请重新登录！");
  	document.location.href ='<c:url value="/login/login.action"/>';
</script>

