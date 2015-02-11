<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<html>
<head>
<title>跳转</title>
<%@ include file="/common/taglibs.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Bootstrap -->
<link rel="stylesheet" href="${ctx}/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${ctx}/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="${ctx}/bootstrap/css/bootstrap-theme.css">
<link rel="stylesheet" href="${ctx}/bootstrap/css/bootstrap-theme.min.css">
<script src="${ctx}/bootstrap/js/jquery.min.js"></script>
<script src="${ctx}/bootstrap/js/bootstrap-dropdown.js"></script>
<script src="${ctx}/bootstrap/js/bootstrap.min.js"></script>
<script src="${ctx}/bootstrap/js/bootstrap.js"></script>
<script src="${ctx}/bootstrap/js/jquery.dataTables.js"></script>

<script src="${ctx}/bootstrap/js/jquery.dataTables.js"></script>
<style type="text/css" title="currentStyle">
@import "${ctx}/bootstrap/css/demo_page.css";

@import "${ctx}/bootstrap/css/demo_table_jui.css";

@import "${ctx}/bootstrap/css/jquery-ui-1.8.4.custom.css";
</style>

<!-- datepicker -->
<script type="text/javascript"
	src="${ctx}/bootstrap/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript"
	src="${ctx}/bootstrap/js/bootstrap-dropdown.js" charset="UTF-8"></script>
<script type="text/javascript"
	src="${ctx}/bootstrap/js/locales/bootstrap-datetimepicker.zh-CN.js"
	charset="UTF-8"></script>
<link href="${ctx}/bootstrap/css/bootstrap.min.css" rel="stylesheet"
	media="screen">
<link href="${ctx}/bootstrap/css/bootstrap-datetimepicker.min.css"
	rel="stylesheet" media="screen">
<script type="text/javascript" charset="utf-8">
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
  

function fncGoSubMenu(topMenuId, topMenuName) {
   window.location.href = "${ctx}/login/login!tiaozhuan.action?topMenuId=" + topMenuId+"&topMenuName="+topMenuName; 
    fncInitMainMenu(topMenuName);
  }
function fncGoSubMenuTest(){
	 window.location.href ="${ctx}/basicInfor/materialcodingManage/materialcoding!search.action";
}


</script>
</head>
<body>
<form id="jiShouform" action="${ctx}/basicInfor/lishiManage/lishi!savaJiShouDafen.action" method="post">
 
<div class='container-fluid'>
		<div class='row-fluid'>
			<div class='span12'>
			<input type="hidden" id="tab_index" value="1"/>
				
				<div class="panel panel-primary">
			
						<div class="panel-heading">
							<h3 class="panel-title">跳转</h3>
						</div>
<div class="panel-body">
   <div id="my2" style="display: block; width: 100%; height: 450px; background-image: url(${ctx}/images/baojie1.jpg); margin: 0px auto; background-position: 50% 50%; background-repeat: no-repeat no-repeat;">

    </div>
</div>
</div>
<div class="panel panel-primary">
		<div class="panel-body">
				<div class="col-sm-12">
								<div class="input-group-btn" style="left: 360px"><!-- style="left: 280px" -->
								<button type="button" class="btn btn-primary" onclick="fncGoSubMenuTest()">操作模块</button>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<!-- <button type="button" class="btn btn-primary" onclick="fncGoSubMenu('1188', '数据导出')">数据导出</button>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
								<button type="button" class="btn btn-primary" onclick="fncGoSubMenu('10', '系统管理')">系统管理</button>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<button type="button" class="btn btn-primary" onclick="tuichu()">&nbsp;&nbsp;退&nbsp;&nbsp;出&nbsp;&nbsp;</button>
								</div>
							
						</div>
					
					<!-- 	<div class="col-sm-3" >
								<div class="input-group-btn" >
									<button type="button" class="btn btn-primary" onclick="fncGoSubMenu('1188', '数据导出')">数据导出</button>
								</div>
							
						</div>
						
						<div class="col-sm-3">
								<div class="input-group-btn" style="left: 80px">
									<button type="button" class="btn btn-info" onclick="fncGoSubMenu('10', '系统管理')">系统管理</button>
								</div>
							
						</div>
						<div class="col-sm-3">
								<div class="input-group-btn" style="right: 30px">
									<button type="button" class="btn btn-info" onclick="tuichu()">退出</button>
								</div>
							
						</div> -->
					</div>
			
		</div>
	</div>
	</div>
</form>	
   
	<script type="text/javascript">
	
		function loginOut(){
			
			window.location.href = "${ctx}/login/login!loginOut.action";
		}
		function tiaozhuan(obj){
			if(obj==1){
				alert(obj);
				window.location.href = "";
			}
			if(obj==2){
				alert(obj);
				window.location.href = "";
			}
			if(obj==3){
				alert(obj);
				window.location.href = "";
			}
		}
		function tuichu(){
			window.location.href = "${ctx}/login/login.action";
		}
		
	</script>
</body>
</html>