<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!--  
/**
 * ------------------------------------------------------------------------
 * @source  : listCode.jsp
 * @desc    : 业务数据处理
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.05.18  houyingchang       初次建立
 * ------------------------------------------------------------------------ 
 */
 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>业务数据处理</title>
</head>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript"
	src="${ctx }/js/DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
//固定表头
function fncFixupListHead()   
	{  
	  var tab = document.getElementById("listTab");
		if(tab) fixupFirstRow(tab);
		if (tab.rows.length < 12) {
			if (document.getElementById("resultDiv"))
				document.getElementById("resultDiv").style.height = "";
		}
	}
//数据库备份
function fncDataProcess() {    	
		if(confirm("确定开始业务数据处理吗?")){
			actSubmit($('#formSearch'), '<c:url value="/management/processInit/process-init!processImportSto.action"/>');
	}
}
</script>
<body onload="fncFixupListHead();">
<div id="Lcontent"><SSTag:navigation />

<form name="formSearch" id="formSearch" method="post"
	action="<c:url value="/management/processInit/process-init!processImportSto.action"/>" />
	<div id="resultDiv"
		style="width: 765px;height:280px;">
		<table>
			<tr>
				<td style="border:0">
					<font color="red">*</font>说明：为了提高系统性能，只保留36个月的业务数据， 之前的数据将被保存到历史业务数据表中。
				</td>
			</tr>
		</table>
		<table class="LlistArea" id="listTab" style="width: 765px;">
			
				<tr>
							<th style="text-align:center;" >序号</th>
							<th style="text-align:center;" >上次处理时间</th>
							<th style="text-align:center;" >业务数据开始时间</th>
							<th style="text-align:center;" >业务数据结束时间</th>
							<th style="text-align:center;" >处理条数</th>
							<th style="text-align:center;" >业务表名</th>
				</tr>
				<s:iterator value="historyLog" status="st">
					<tr>
								<td>${st.index+1}</td>
								<td>
									${createDate}
								</td>
								<td>
									${minProcessDate}
								</td>
								<td>
									${maxProcessDate}
								</td>
								<td>
									${deleteRowCount}
								</td>
								<td >
									${tableName}
								</td>
							</tr>
				</s:iterator>
			</table>
			</div>
			</form>
			<br />
		<fieldset><legend>Button</legend>
			<ul class="LbtnArea">
				<li><input type="button" value="开始" onclick="fncDataProcess()"
					onkeypress="fncDataProcess()" id="btnStart" objType="btnStart" /></li>
			</ul>
		</fieldset>
</div>
</body>
</html>