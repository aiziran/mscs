<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<%--
<script language="JavaScript" type="text/javascript">
	function Close() {
		//关闭当前窗口
		window.open('', '_parent', '');
		window.close();
	}
	function OpenWin(url) {
		//全屏打开窗口，网址 url
		window.open(url, '_blank', 'fullscreen=yes,toolbar=no,location=no,directories=no ,status=yes,menubar=no,scrollbars=no,resizable=yes');
		Close();
	}
</script>

</head>
<body
	onload="OpenWin('${ctx}/login/login.action')">
</body>
</html>

--%>
<% response.sendRedirect("login/login.action"); %>
 
