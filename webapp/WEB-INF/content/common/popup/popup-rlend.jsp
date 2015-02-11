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
		window.returnValue =document.getElementById("returntime").value;
		window.close(); 
		
	}
	
</script>
</head>
<body class="body_sub">	
	<div id ="groupSupply" style="position:absolute; background-color:#ffffff;width:500px;display:block">
		<br/>
		<div id="LsearchArea" >		
			
		</div>
		<!-- END sbox --> <!--AREA [View]-->
		<form id="formPage" method="post" action="${ctx}/common/popup/popup!lend.action">								
					<table class="LlistArea" >
					<tr >
								<td>
									续借档案名称
								</td>
								<td>
									 ${datanames.names}
								</td>
							</tr>
								<tr>
								<td>
									续借日期至
								</td>
								<td>
									<input type="text" name="returntime" id="returntime"
						class="Wdate" onclick="WdatePicker()" readonly="readonly"
						style="margin-right: 30px;" />
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
