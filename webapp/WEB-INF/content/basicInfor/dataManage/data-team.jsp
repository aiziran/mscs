
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>班组</title>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript"
	src="${ctx }/js/DatePicker/WdatePicker.js"></script>
<script type="text/javascript" language="javascript">
	//进入修改页面
	function fncDetail(obj) {

		$('#id').val(obj);
		actSubmit($('#formPage'),
				'<c:url value="/basicInfor/dataManage/data!updateTeamPage.action"/>');
	}

	//进入新增页面
	function fncAdd() {
		actSubmit($('#formPage'),
				'<c:url value="/basicInfor/dataManage/data!insertTeamPage.action"/>');
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
		alert(n);
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
		actSubmit($('#formPage'),
				'<c:url value="/basicInfor/dataManage/data!deleteTeam.action"/>');
	}
	//复选框全选
	function CheckedAll(field) {
		var checkboxes = document.getElementsByName("checkBox");
		for ( var i = 0; i < checkboxes.length; i++) {
			checkboxes[i].checked = field.checked;
		}
	}
</script>
</head>
<body onload="fncFixupListHead();">
	<div id="Lcontent">
		<!-- <SSTag:navigation />-->
		<div id="LpageTitleArea">
			<h1>班组管理</h1>
			<div>
				<a href="#">Home</a> &gt; <a href="#">基本信息管理</a> &gt; <a
					href="/CarPhone/basicInfor/newsinfoManage/newsinfo.action?selectMenuId=1110"
					id="Lhere">班组信息</a>
			</div>
		</div>
		<!-- END sbox -->
		<!--AREA [View]-->
		<form id="formPage" method="post"
			action="<c:url value="/basicInfor/dataManage/data!team.action"/>">
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
									<th>序号</th>
									<th>班组</th>
								</tr>
								<s:iterator value="page.result" status="st">
									<tr>
										<td><input type="checkbox" id="checkBox" name="checkBox"
											value="${id}" onClick="CheckedSelf(this)" /></td>
										<td onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
											onClick="fncDetail('${id}')">${id}</td>
										<td onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
											onClick="fncDetail('${id}')">${teamname}</td>
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
