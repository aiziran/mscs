<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--
/**
 * ------------------------------------------------------------------------
 * @source  : user.jsp
 * @desc    : 用户管理页面
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2011.12.18   SSQ                 初次建立
 * ------------------------------------------------------------------------ 
 */
--%>
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>机手页面</title>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript" language="javascript">
	//进入修改页面
	function fncDetail(obj) {
		$('#detailUserId').val(obj);
		actSubmit($('#formPage'),
				'<c:url value="/basicInfor/userManage/user!updateHander.action"/>');
	}

	//进入新增页面
	function fncAdd() {
		actSubmit($('#formPage'),
				'<c:url value="/basicInfor/userManage/user!createHander.action"/>');
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

	function showChildWindow1() {

		var url = "<c:url value='/basicInfor/userManage/user!handerDetail.action'/>";
		var strFeatures = "dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no";
		var aa = window.showModalDialog(url, "window", strFeatures); //取得子窗口传回的值.
		if (!aa) {
			aa = window.returnValue;
		}
		if (aa) {
			$('#queryUserId').val(aa.split(";")[0])

		}
	}

	function clearForm() {
		$('#queryUserId').val("");
		$('#queryUserName').val("");

	}
</script>
</head>

<body onload="fncFixupListHead();">
	<div id="Lcontent">
		<!-- <SSTag:navigation />-->
		<div id="LpageTitleArea">
			<h1>机手管理</h1>
			<div>
				<a href="#">Home</a> &gt; <a href="#">基本信息管理</a> &gt; <a
					href="/CarPhone/basicInfor/newsinfoManage/newsinfo.action?selectMenuId=1110"
					id="Lhere">机手信息</a>
			</div>
		</div>
		<div id="LsearchArea">
			<form id="formSearch" name="formSearch" method="post"
				class="enterhandler" style="width: 1000px;"
				action="<c:url value="/basicInfor/userManage/user!hander.action"/>"
				onEnter="this.submit()">


				<div>
					<table>
						<tr>
							<th nowrap="nowrap">用户:</th>
							<td><input type="text" id="queryUserId" name="queryUserId"
								value="${data.queryUserId }"
								onClick="
									javascript:showChildWindow1();"
								style="cursor: hand; margin-right: 10px" readonly /></td>

							<th nowrap="nowrap">用户名:</th>
							<td><input type="text" id="queryUserName"
								name="queryUserName" value="${data.queryUserName }" /></td>


							<td><input type="image"
								src="${ctx}/images/btn_search_e_g.gif" alt="Search" /> <input
								type="button" value="清空条件" onclick="clearForm()"></td>
						</tr>
					</table>
				</div>

			</form>
		</div>
		<!-- END sbox -->
		<!--AREA [View]-->
		<form id="formPage" method="post"
			action="<c:url value="/basicInfor/userManage/user!hander.action"/>">
			<input type="hidden" name="detailUserId" id="detailUserId" value="" />
			<!-- 滚动条设置 -->
			<c:if test="${!empty page.result}">
				<div id="resultDiv"
					style="width: 1000px;overflow-x:scroll;<c:if test="${page.pageSize >10}">overflow-y:scroll;height:280px;</c:if>">
					<table class="LlistArea" id="listTab" style="width: 100%;">
						</c:if>
						<c:if test="${empty page.result}">
							<table class="LlistArea" id="listTab">
								</c:if>
								<!-- 滚动条设置-end -->
								<tr>
									<th width="5%">序号</th>
									<th width="20%"><a href="javascript:sort('u.user_id','asc')">用户ID</a>
									</th>
									<th width="20%"><a href="javascript:sort('user_name','asc')">用户名</a>
									</th>

									<th width="20%">移动电话</th>

									<th width="35%">住址</th>
								</tr>
								<s:iterator value="page.result" status="st">
									<tr onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${userId}')">
										<td width="5%"><c:out
												value="${st.index+1+(page.pageNo-1)*page.pageSize}" />
										</td>
										<td>${userId}</td>
										<td width="10%">${userName}</td>
										<td>${mobileNo}</td>
										<td >${address}</td>
									</tr>
								</s:iterator>
								<!-- 滚动条设置 -->
								<c:if test="${!empty page.result}">
							</table>
							</div>
							<table>
								</c:if>
								<!-- 滚动条设置-end -->
								<tr>
									<td colspan="20" class="AreaLeft">
										<!-- LPAGE JavaScript Start --> <%@ include
											file="/common/page.jsp"%></td>
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

							<!-- END content -->
</body>
</html>