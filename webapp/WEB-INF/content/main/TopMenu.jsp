<%@page import="java.util.*"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.springside.modules.security.springsecurity.SpringSecurityUtils" %>
<%@ page import="java.util.Date"
   import="java.util.Locale"
   import="java.text.SimpleDateFormat"
   import="com.csValue.common.login.entity.LoginUserData"
%>

<%
	Date date = new Date();
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd", Locale.US);
	String enToday=format.format(date);   
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>页面</title>
	<%@ include file="/common/taglibs.jsp" %>
	<%@ include file="/common/header.jsp" %>
	<script language="JavaScript" src="${ctx}/js/nikia/progress.js"></script>
	<script>	
	  function fncInitMainMenu(mainMenuName) {
	    var mainMenuUL = document.getElementById("LmainMenu").getElementsByTagName("UL")[0];
     	    for (var i=0; i<mainMenuUL.childNodes.length; i++) {
	         if (mainMenuUL.childNodes[i].nodeType == 1) {
	        if (mainMenuUL.childNodes[i].firstChild.firstChild.innerHTML == mainMenuName)
	          mainMenuUL.childNodes[i].className = "Ldepth1Current";
	        else 
	          mainMenuUL.childNodes[i].className = "Ldepth1";
	      }
	    }
	  }
	  
	   function fncLogout() {
	   	if(confirm("确认退出系统?")){
	   		parent.window.location="${ctx}/login/login!loginOut.action"
	    	
	   	}
	  }
	  
	  function fncGoSubMenu(topMenuId, topMenuName) {
		var topMenuID='<%=session.getAttribute("topMenuId")%>';
		var topMenuN='<%=session.getAttribute("topMenuName")%>';
		
	    parent.leftFrame.location.href = "${ctx}/login/menu!leftMenuList.action?topMenuId=" + topMenuID; 
	    fncInitMainMenu(topMenuN);
	  }
	  
	  function fncSetInitMenu() {
	    var topMenuName = '${topMenuList.menuName[0]}';
	    //fncInitMainMenu(topMenuName);
	  }
	  function searchOutofwarranty() {
		  actSubmit($('#langform'),'<c:url value=""/>');
	  }
	  function searchExpirationdate() {
		  actSubmit($('#langform'),'<c:url value=""/>');
	  }
	  
	  function showRightMenu()
	  {
		  if(parent.bodyFrame.cols=="210,*,1")
		  {
			 parent.bodyFrame.cols="0,*,1";
		  }
		  else
		  {
			  parent.bodyFrame.cols="210,*,1";
		  }
	  }
	  function tiaozhuan(){
		  var username='<%if (session.getAttribute("username") != null)out.print(session.getAttribute("username"));%>'; 
		  var password='<%if (session.getAttribute("password") != null)out.print(session.getAttribute("password"));%>';
		  parent.location.href="${ctx}/login/login!login.action?j_username="+username+"&j_password="+password;
		  
	  }
	</script>


</script>
</head>
<body class="Ltop1" onLoad="fncGoSubMenu('','');">

<div id="Lheader" style="background-color:#1765A9; width: auto;height: 80px;">
  <div id="Lmasthead" >   
  
   <div style="float:left;padding-top:30px; margin-top: -30px;">  
       <a title="HomePage" href="${ctx}/login/login!home.action" target="_top"><%-- <img src="${ctx}/images/devonlogo.jpg" alt="HomePage" width="195"/> --%></a>
    </div> 
	<form id="langform" name="langform" method="post">
	
	    <ul id="Lsitemenu-h" style="width:450px;">
	       <!--    <li style="float:left;padding-top:0px;" ><font style="color: white;">车检提醒:</font><a href="${ctx}/basicInfor/carinfoManage/carinfo.action?overtimeflag=true" target="mainFrame"><font style="color: white;">${carinfoCount}</font></a></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    	 <li style="float:left;padding-top:0px;" ><font style="color: white;">过期档案:</font><a href="${ctx}/basicInfor/archiveManage/archive.action?overtimeflag=true" target="mainFrame"><font style="color: white;">${archiveCount}</font></a></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 -->
	    <li style="float:left;padding-top:0px;color: white;>
	    <c:if test="${!empty message }">
	    <a href="${ctx}/basicInfor/emailManage/email!selectNoReadEmail.action" target="mainFrame"></li>
		<img src="${ctx}/images/email.gif" style="width:20px;height:20px"></a> </c:if></li>
	      <li style="float:left;padding-top:0px;color: white;" >日期：<%=enToday %> &nbsp;&nbsp;&nbsp;<B> <%=LoginUserData.getCurrentUserData().getUserNm()%> </B>&nbsp;&nbsp;&nbsp;<B> ${loginCompany} </B>&nbsp;&nbsp;&nbsp;</li>
	      <li style="float:left;padding-top:0px;"><a href="${ctx}/login/login!home.action" target="_top"><font style="color: white;">首页</font></a></li>
	      <!-- <li class="Lpipe" style="float:left;padding-top:0px"  >&nbsp;|&nbsp;<a onclick = "fncLogout()" style="cursor: pointer;color: white;"  target="_top">退出</a></li> -->
		 <li style="float:left;padding-top:0px"  >&nbsp;|&nbsp;&nbsp;<a onclick = "fncLogout()" style="cursor: pointer;color: white;"  target="_top">退出</a></li>
		 <li style="float:left;padding-top:0px"  >&nbsp;|&nbsp;&nbsp;<a onclick = "showRightMenu()" style="cursor: pointer;color: white;"  target="_top">显/隐菜单</a></li>
		 <li style="float:left;padding-top:0px"  >&nbsp;|&nbsp;&nbsp;<a onclick = "tiaozhuan()" style="cursor: pointer;color: white;"  target="_top">返回跳转页面</li>
		</li>
	</ul>

							
	</form>
  </div>

  <div id="LmainMenu"  style="padding-top:-10px;margin-left: 40px;margin-top: 1px; width: auto;">     
    <ul>
        <%--  <c:if test="${menu.MENUID==1187}">
          <li class="Ldepth1"><span><a href="javascript:fncGoSubMenu('<c:out value="${menu.MENUID}"/>', '<c:out value="${menu.MENUNAME}"/>')"><c:out value="${menu.MENUDESC}"/></a></span></li>
         </c:if> --%>
         <c:forEach items="${map}" var="menu">
        <%-- 
          <c:if test="${menu.MENUID=='1881'}">
          <li class="Ldepth1"><span><a href="javascript:fncGoSubMenu('<c:out value="${menu.MENUID}"/>', '<c:out value="${menu.MENUNAME}"/>')"><c:out value="${menu.MENUDESC}"/></a></span></li>
         </c:if>  --%>
             <%--  <li class="Ldepth1"><span><a href="javascript:fncGoSubMenu('<c:out value="${menu.MENUID}"/>', '<c:out value="${menu.MENUNAME}"/>')"><c:out value="${menu.MENUDESC}"/></a></span></li> --%>
         </c:forEach>    
	</ul>
  </div>
</div>

</body>
</html>


