
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>排班表</title>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript"
	src="${ctx }/js/DatePicker/WdatePicker.js"></script>
<script type="text/javascript" language="javascript">
	//进入修改页面
	function fncDetail(obj) {
		$('#id').val(obj);
		actSubmit($('#formPage'),
				'<c:url value="/basicInfor/dataManage/data!updateWorkoingPage.action"/>');
	}
	
	//进入新增页面
	function fncAdd() {
		actSubmit($('#formPage'),
				'<c:url value="/basicInfor/dataManage/data!insertWorkoingPage.action"/>');
	}

	// 固定表头
	function fncFixupListHead() {
		var tab = document.getElementById("listTab");
		if (tab)
			fixupFirstRow(tab);

		if (tab.rows.length < 12) {
			if (document.getElementById("resultDiv")) {
				document.getElementById("resultDiv").style.height = "";
			}
		}
	}
	function fncDel() {

		var a = document.getElementsByName("checkBox");
		var n = a.length;
		var k = 0;
		for ( var i = 0; i < n; i++) {
			if (a[i].checked) {
				k = 1;
			}
		}
		if (k == 0) {
			alert("请选中所要删除的信息！!");
			return;
		}
		if (!confirm("请确认是否提交？"))
			return;
		actSubmit($('#formPage'), '<c:url value="/basicInfor/dataManage/data!deleteWorking.action"/>');
	}
	//复选框全选
	function CheckedAll(field) {
		var checkboxes = document.getElementsByName("checkBox");
		for ( var i = 0; i < checkboxes.length; i++) {
			checkboxes[i].checked = field.checked;
		}
	}
	function clearForm() {
		$('#username').val("");
		$('#classesname').val("");
		$('#date').val("");
		
	}
	 function showChildWindow1() 
		{ 
	  		
			var url = "<c:url value='/basicInfor/userManage/user!handerDetail.action'/>"; 
			var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
			var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
			if(!aa){
				 aa = window.returnValue;
			 } 
			if(aa){
				$('#userid').val(aa.split(";")[0])
				$('#username').val(aa.split(";")[1])
				} 
		}
	 
	 function showChildWindow2() 
		{ 
	  		
			var url = "<c:url value='/basicInfor/dataManage/data!classesdetail.action'/>"; 
			var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
			var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
			if(!aa){
				 aa = window.returnValue;
			 } 
			if(aa){
				$('#userid').val(aa.split(";")[0])
				$('#username').val(aa.split(";")[1])
			 
				} 
		}
	
</script>
</head>

<body onload="fncFixupListHead();">
	<div id="Lcontent">
	<!-- <SSTag:navigation />-->
			<div id="LpageTitleArea">
			<h1>排班管理</h1>
			<div>
				<a href="#">Home</a> &gt; <a href="#">基本信息管理</a> &gt; <a
					href="/CarPhone/basicInfor/newsinfoManage/newsinfo.action?selectMenuId=1110"
					id="Lhere">排班表</a>
			</div>
		</div>

		<div id="LsearchArea">
			<form id="formSearch" name="formSearch" method="post"
				style="width: 1000px;" class="enterhandler"
				action="<c:url value="/basicInfor/dataManage/data!handerWorking.action"/>">
				<div>
					<table>
						<tr>
						<th nowrap="nowrap">机手姓名:</th>
							<td>
							 
							 <input type="hidden" id="userid" name="userid"  />
							 <input type="text" id="username" name="username" value="${data.username}" readonly onClick="javascript:showChildWindow1();"
											style="cursor: hand; margin-right: 10px"  />	
							</td>
							<th nowrap="nowrap">班次:</th>
							<td>
							  <input type="hidden" id="classesid" name="classesid" />
							  <input type="text" id="classesname" name="classesname" value="${data.classesname}" readonly onClick="javascript:showChildWindow2();"
											style="cursor: hand; margin-right: 10px"  />
							</td>
							
							<th nowrap="nowrap">日期:</th>
							<td><input type="text" name="date" id="date" class="Wdate"
								onclick="WdatePicker({dateFmt:'yyyy-M-d'})" readonly="readonly" value="${data.date}" 
								style="margin-right: 0px;" > </td>

							<td><input type="image"
								src="${ctx}/images/btn_search_e_g.gif" alt="Search" /> <input
								type="button" value="清空条件" onclick="clearForm()">
							</td>
						</tr>
					</table>
				</div>

			</form>
		</div>
		<!-- END sbox -->
		<!--AREA [View]-->
		<form id="formPage" method="post"
			action="<c:url value="/basicInfor/dataManage/data!handerWorking.action"/>">
			<input type="hidden" name="id" id="id" value="${id}" />
			<!-- 滚动条设置 -->
			<c:if test="${!empty page.result}">
				<div id="resultDiv"
					style="width: 1000px;overflow-x:scroll;<c:if test="${page.pageSize >10}">overflow-y:scroll;height:280px;</c:if>">
					<table class="LlistArea" id="listTab" style="width: 1000px;">
						</c:if>
						<c:if test="${empty page.result}">
							<table class="LlistArea" id="listTab">
								</c:if>
								<!-- 滚动条设置-end -->
								<tr>
									<th><input type="checkbox" id="checkedALl"
										name="checkedALl" onclick="CheckedAll(this)" /></th>
									<th>机手id</th>
									<th>机手姓名</th>
									<th>班次</th>
									<th>日期</th>
								</tr>
								<s:iterator value="page.result" status="st">
									<tr>
										<td><input type="checkbox" id="checkBox" name="checkBox"
											value="${id}" onClick="CheckedSelf(this)" /></td>
										<td onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
											onClick="fncDetail('${id}')">${userid}</td>
											<td onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
											onClick="fncDetail('${id}')">${username}</td>
										<td onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
											onClick="fncDetail('${id}')">${classesname}</td>
										<td onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
											onClick="fncDetail('${id}')">${date}</td>

									</tr>
								</s:iterator>
								<!-- 滚动条设置 -->
								<c:if test="${!empty page.result}">
							</table>
							</div>
							<table class="LlistArea" style="width: 1000px;">
								</c:if>
								<!-- 滚动条设置-end -->
								<tr>
									<td colspan="20" class="AreaLeft"><%@ include
											file="/common/page.jsp"%> <!-- LPAGE JavaScript Start -->
									</td>
								</tr>
							</table>

							</form>
							<!-- 滚动条设置-end -->
							<fieldset>
								<legend>Button</legend>
								<ul class="LbtnArea">
									<li><input type="button" value="新增" onclick="fncAdd()"
										id="btnAdd" objType="bCreate" /></li>
									<li><input type="button" value="删除" onclick="fncDel()"
										id="checkself" objType="bCreate" /></li>
								</ul>
							</fieldset>
							<br />
							</div>
							</div>

							<!-- END content -->
</body>
</html>
