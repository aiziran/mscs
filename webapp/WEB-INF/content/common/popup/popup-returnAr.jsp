<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<html>
<head>
<title>档案借阅审批状态</title>
<base target="_self">
<%@ include file="/common/header.jsp"%>
 <script type="text/javascript" src="${ctx}/js/DatePicker/WdatePicker.js"></script>
 <script type="text/javascript" language="javascript">
	 
	

	function getreturnTime(){
		var str = document.getElementById("username").value;
		window.returnValue =str;
		window.close(); 
		
	}
	
	function showChildWindow5(obj,archivesnum,archivesname) 
	{ 
  		
		var url = "<c:url value='/common/popup/popup!userOne.action'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
		if(aa){
			$('#userid').val(aa.split(";")[0])
			$('#username').val(aa.split(";")[1])
			;
		} 
	}
	
</script>
</head>
<body class="body_sub">	
	<div id ="groupSupply" style="position:absolute; background-color:#ffffff;width:500px;display:block">
		<br/>
		<div id="LsearchArea" >		
			
		</div>
		<!-- END sbox --> <!--AREA [View]-->
		<form id="formPage" method="post" action="${ctx}/common/popup/popup!doLend.action">								
					<table class="LlistArea" >
					<tr >
					<th>归还人</th>
								<td>
								<input id="username" name="username" value="${ username}">
								<input type="hidden" id="usreid" >
								<img src="/archive/images/pbf/Content_icon_search.gif" class="btn_img"
											onClick="javascript:showChildWindow5(this,'archivesnum','archivesname');"
											style="cursor: hand; margin-right: 10px" />
								</td>
							
							</tr>
							 
							 
					</table>
			</form>		
				<fieldset>
							<legend>Button</legend>
							<ul class="LbtnArea">
								<li><input type="button" value="确定" onclick="getreturnTime()" id="btnSave" objType="bSave" />
								</li>
							</ul>
							</fieldset>		
	</div>
	<!-- END content -->
</div>			
</body>
</html>
