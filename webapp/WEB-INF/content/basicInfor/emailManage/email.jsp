<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>柜子列表</title>
<link rel="stylesheet" type="text/css" href="${ctx}/css/css.css">
<script src="${ctx}/js/dropdown.js" type="text/javascript"></script>
<%@ include file="/common/header.jsp"%>

<script type="text/javascript" language="javascript">
	//进入邮件内容信息
	function fncDetail(obj) {
		$('#eid').val(obj);
		actSubmit($('#formPage'),
				'<c:url value="../emailManage/email!detail.action "/>');
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
		actSubmit($('#formPage'),
				'<c:url value="../emailManage/email!deleteEmail.action"/>');
	}
	//复选框全选
	function fncCheckAll(field) {
		var checkboxes = document.getElementsByName("checkBox");
		for ( var i = 0; i < checkboxes.length; i++) {
			checkboxes[i].checked = field.checked;
		}
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
	function showChildWindow1(obj, archivesnum, archivesname) {
		var url = "<c:url value='/common/popup/popup!dept.action'/>";
		var strFeatures = "dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no";
		var aa = window.showModalDialog(url, "window", strFeatures); //取得子窗口传回的值.
		//alert(aa)
		if (aa) {
			$('#organizer').val(aa.split(";")[0])
			$('#organizername').val(aa.split(";")[1]);
		}
	}

	//标记已读
	function designRead() {
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
		actSubmit($('#formPage'),
				'<c:url value="../emailManage/email!designRead.action"/>');
	}
	//标记为未读
	function designNoRead() {
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
		actSubmit($('#formPage'),
				'<c:url value="../emailManage/email!designNoRead.action"/>');
	}
	//按时间排序
	function orderByTime() {
		actSubmit($('#formPage'),
				'<c:url value="../emailManage/email!orderByTime.action"/>');
	}
	//按发送人排序
	function orderBySendto() {
		actSubmit($('#formPage'),
				'<c:url value="../emailManage/email!orderBySendto.action"/>');
	}
</script>
</head>
<body onload="fncFixupListHead();">
	<div id="Lcontent">
		<SSTag:navigation />
		<div id="header"></div>
		<div id="topmenu">
			<div id="navMenu">
				<ul>
					<li><a href="../emailManage/email!createEmail.action">新建</a></li>
					<li><a href="#" onclick="fncDel()">删除</a></li>
					<li><a href='../emailManage/email.action' rel='dropmenu1'>标记为</a>
					</li>
					<li></li>
					<li><a href='../emailManage/email!orderByTime.action'
						rel='dropmenu3'>排序</a>
					</li>
				</ul>
			</div>
		</div>

		<ul id="dropmenu1" class="dropMenu">

			<li><a href="#" onclick="designRead()">已读</a>
			</li>
			<li><a href="#" onclick="designNoRead()">未读</a>
			</li>
		</ul>
		<ul id="dropmenu3" class="dropMenu">
			<li><a href="#" onclick="orderByTime()">按时间排序</a>
			</li>
			<li><a href="#" onclick="orderBySendto()">按发件人排序</a>
			</li>
		</ul>
		<script type="text/javascript">
			cssdropdown.startchrome("navMenu")
		</script>
		<br> <br>
		<div id="LsearchArea">
				<form id="formSearch" name="formSearch" method="post" class="enterhandler" style="width: 1000px;"
				  action="<c:url value="../emailManage/email!selectBySendto.action"/>" onEnter="this.submit()">
				<div>
					<table width="500">
						<tr>
							<th>按主题搜索电子邮件</th>
							<td><input name="sendto" id="sendto" style="width: 200px;"></td>
						</tr>
					</table>
				</div>
				<input id="LsearchIcon" type="image"
					src="${ctx}/images/btn_search_e_g.gif" alt="Search" />
				</p>
			</form>
		</div>
		<form id="formPage" method="post">
			<input type="hidden" name="eid" id="eid" />
			<!-- 滚动条设置 -->
			<c:if test="${!empty page.result}">
				<div id="resultDiv"
					style="width: 1000px;<c:if test="${page.pageSize >10}">overflow-y:scroll;height:280px;</c:if>">
					<table class="LlistArea" id="listTab" style="width: 1000px;">
						</c:if>
							<table class="LlistArea" id="listTab">
								<tr>
									<th><input type="checkbox" name="selectAll" id="selectAll"
										onclick="fncCheckAll(this);" /> <a
										href="../emailManage/email.action">所有</a> <a
										href="../emailManage/email!selectNoReadEmail.action">未读</a>
									</th>
									<th>发件人</th>
									<th>主题</th>
									<th>时间</th>
									<th>标志</th>
									<th>附件</th>
								</tr>
								<s:iterator value="page.result" status="st">
									<tr>
										<td><input type="checkbox" name="checkBox" id="checkBox"
											value="${eid}" />
										</td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)"
											onMouseOut="cfTrOut(this)" onClick="fncDetail('${eid}')">${sendto}</td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)"
											onMouseOut="cfTrOut(this)" onClick="fncDetail('${eid}')">${theme}</td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)"
											onMouseOut="cfTrOut(this)" onClick="fncDetail('${eid}')">${createtime}</td>
										<c:if test="${read eq 1}">
											<td nowrap="nowrap" onMouseOver="cfTrOver(this)"
												onMouseOut="cfTrOut(this)" onClick="fncDetail('${eid}')">未读</td>
										</c:if>
										<c:if test="${read eq 0}">
											<td nowrap="nowrap" onMouseOver="cfTrOver(this)"
												onMouseOut="cfTrOut(this)" onClick="fncDetail('${eid}')">已读</td>
										</c:if>
										<c:if test="${empty annex}">
											<td nowrap="nowrap" onMouseOver="cfTrOver(this)"
												onMouseOut="cfTrOut(this)" onClick="fncDetail('${eid}')">否</td>
										</c:if>
										<c:if test="${!empty annex}">
											<td nowrap="nowrap" onMouseOver="cfTrOver(this)"
												onMouseOut="cfTrOut(this)" onClick="fncDetail('${eid}')">有</td>
										</c:if>
									</tr>
								</s:iterator>
							</table>
							 
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

		<br> <br> <br> <br />
	</div>
	</div>
	<!-- END content -->
</body>
</html>