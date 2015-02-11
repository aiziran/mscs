<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--
/**
 * ------------------------------------------------------------------------
 * @source  : location.jsp
 * @desc    : 二手车管理页面
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2012.02.16   HYJ                 初次建立
 * ------------------------------------------------------------------------ 
 */
--%>
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>页面</title>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript" language="javascript">
	//进入修改页面
	function fncDetail(obj) {
		$('#id').val(obj);
		actSubmit($('#formPage'),
				'<c:url value="/basicInfor/locationManage/location!updateInput.action"/>');
	}

	//进入新增页面
	function fncAdd() {
		actSubmit($('#formPage'),
				'<c:url value="/basicInfor/locationManage/location!createInput.action"/>');
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
</script>
</head>

<body onload="fncFixupListHead();">
<div id="Lcontent">
		<SSTag:navigation />
	<!-- END sbox -->
	<!--AREA [View]-->
	<form id="formPage" method="post"
		action="<c:url value="/basicInfor/locationManage/location.action"/>">
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
							<tr>
								<th>编号</th>
								<th>存放位置</th>
								<th>备注</th>
								
							</tr>
							<s:iterator value="page.result" status="st">
								<tr onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
									onClick="fncDetail('${id}')">
									
									<td >${id}</td>
									<td >${location}</td>
									<td >${remark}</td>
									
									
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
								<td colspan="20" class="AreaLeft">
								<%@ include file="/common/page.jsp" %>
									<!-- LPAGE JavaScript Start --></td>
							</tr>
						</table>

						</form>
						<!-- 滚动条设置-end -->
						<fieldset>
							<legend>Button</legend>
							<ul class="LbtnArea" style="margin-right: 20px;">
								<li><input type="button" value="新增" onclick="fncAdd()"
									id="btnAdd" objType="bCreate" /></li>
							</ul>
						</fieldset>
						<br />
						</div>
						</div>

						<!-- END content -->
</body>
</html>