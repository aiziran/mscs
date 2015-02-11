<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>档案修改</title>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript" language="javascript">

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
	function fncInp(){
		if(document.getElementById("archivesnum").value==""){
			alert("档案室编号不能为空");
			return false;
		}
		if(!/^[0-9]*$/.test(document.getElementById("archivesnum").value)){
			alert("档案室编号只能是数字！！！");
			return false;
		}
		if(document.getElementById("archivesname").value==""){
			alert("档案室名称不能为空");
			return false;
		}
		actSubmit($('#formPage'),
		'<c:url value="test!update.action"/>');
	}
	function fncRet(){
		window.location.href="test.action";
	}
</script>
</head>

<body onload="fncFixupListHead();">
	<div id="Lcontent">
		<SSTag:navigation />
		<form id="formPage" method="post" >
			<!-- 滚动条设置 -->
			<c:if test="${!empty page.result}">
				<div id="resultDiv"
					style="width: 800px;
					<c:if test="${page.pageSize >10}">overflow-y:scroll;height:280px;</c:if>">
					<table class="LDetailArea" id="listTab" style="width: 800px;">
						</c:if>
						<c:if test="${empty page.result}">
							<table class="LlistArea" id="listTab">
								</c:if>
								
								<s:iterator value="page.result" status="st">
								<tr>
									<td colspan="2"><h1 align="center">档案室修改</h1></td>
								</tr>
									<tr>
										<th ><font color="red">*</font>档案室编号：</th>
										<td nowrap="nowrap"><input type="text" id="archivesnum" name="archivesnum" value=${archivesnum}></td>
									</tr>	
									<tr>
										<th><font color="red">*</font>档案室名称：</th>
										<td nowrap="nowrap">
										<input type="hidden" name="aid" id="aid" value=${id} />
										<input type="text" id="archivesname" name="archivesname" value=${archivesname}></td>
									</tr>
								</s:iterator>
								<!-- 滚动条设置 -->
								
							</table>
							
							
								
								</form>
								<fieldset>
				<legend>Button</legend>
				<ul class="LbtnArea" >
					<li>
						<input type="button" value="返回" onclick="fncRet()" id="btnAdd" />
					</li>
					<li>
						<input type="button" value="修改" onclick="fncInp()" id="fncUpd" />
					</li>
				</ul>
			</fieldset>
			</div>
							</div>
							</div>
							<!-- END content -->
</body>
</html>