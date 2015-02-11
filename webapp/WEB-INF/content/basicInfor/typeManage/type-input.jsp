
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>档案新增</title>
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
	//验证表单
	function fncInp(){
        if(document.getElementById("archivename").value=="")
        {
        	alert("档案类型名称不能为空");
        	return false;
        }
		actSubmit($('#formPage'), '<c:url value="/basicInfor/typeManage/type!input.action"/>');
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
					style="width: 1000px;overflow-x:scroll;<c:if test="${page.pageSize >10}">overflow-y:scroll;height:280px;</c:if>">
					<table class="LlistArea" id="listTab" style="width: 1000px;">
						</c:if>
						<c:if test="${empty page.result}">
							<table class="LlistArea" id="listTab">
								</c:if>
								
									<tr>
										<td colspan="2"><b>添加档案类型</b></td>
									</tr>
									<tr>
										<td><font color="red">*</font>档案室类型名称</td>
										<td nowrap="nowrap"><input type="text" id="archivename" name="archivename" ></td>
									</tr>
									<tr><td nowrap="nowrap"><input type="hidden" name="tid"  value="${id}"/></td>
									<td nowrap="nowrap"><input class="button" type="button" value="保存" onclick="fncInp()"/>&nbsp;</td></tr>
							
								<!-- 滚动条设置 -->
								
							</table>
							</div>
							
								
								</form>
							</div>
							</div>
							<!-- END content -->
</body>
</html>
</body>
</html>