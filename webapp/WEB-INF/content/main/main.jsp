<%@ page
  language ="java"
  pageEncoding="UTF-8"
  contentType="text/html; charset=UTF-8"
%>
<%@ include file="/common/taglibs.jsp"%>
<%--
/**
 *------------------------------------------------------------------------------
 *------------------------------------------------------------------------------
 * PROJ : Package Based Framework
 * Copyright 2008 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 */
--%>

<html>
<head>
<%@ include file="/common/header.jsp"%>
<title>物料编码系统</title>

<script type="text/javascript">
  if (self != window.top) {
    window.top.location.href=self.location.href;
  }
   
</script>
</head>

<frameset id="indexFrame" rows="72,*,0" cols="*" frameborder="NO" border="0" framespacing="0">
  <frame src="${ctx}/login/menu.action" name="topFrame" scrolling="No" noresize>
  <frameset id="bodyFrame" cols="0,*,1" frameborder="NO" border="0" framespacing="0">
   <frame src="" id="leftFrame" name="leftFrame" scrolling="No" noresize >
      <frame src="about:blank" id="mainFrame" name="mainFrame">
     
 </frameset>
 

  
  
</frameset>

<noframes>
  <body></body>
</noframes>

</html>


