<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript" src="/archive/ckeditor/ckeditor.js"></script>
<html>
<head>
<title>房地产新闻详情</title>
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
		actSubmit($('#formPage'), '<c:url value="/basicInfor/estatenManage/estaten!selectOne.action"/>');
	}
	function fncDel() {
	 if (!confirm("请确认是否提交？")) return;       
		actSubmit($('#formPage'),
				'<c:url value="estaten!deleteAll.action"/>');
	}
</script>
</head>

<body onload="fncFixupListHead();">
	<div id="Lcontent">
		<SSTag:navigation />
		<form id="formPage" method="post" enctype="multipart/form-data" >
			<!-- 滚动条设置 -->
			<c:if test="${!empty page.result}">
				<div id="resultDiv"
					style="width: 1000px;overflow-x:scroll;<c:if test="${page.pageSize >10}">overflow-y:scroll;height:280px;</c:if>">
					<table class="LlistArea" id="listTab" style="width: 1000px;">
						</c:if>
						<c:if test="${empty page.result}">
							<table class="LlistArea" id="listTab" style="border: 0;" >
								</c:if>
								
									<tr>
										<td onclick="fncInp()">
											<font style="font-size: 22px;" >
												${estaten.subject}
											</font></br>
											<font style="font-size: 12px;"  >
												${estaten.createtime} &nbsp;&nbsp;发布人:&nbsp;${estaten.createusername}
											</font>
										</td>
									</tr>
									<tr>
										<td >
												<img src="${estaten.imageRealPath}"/>
											        ${estaten.detail }
				 						</td>
				 					</tr>
				 						<input type="hidden" name="id" id="id"  value="${estaten.id}"/>
									
								<!--<td nowrap="nowrap"><input type="button" value="修改" onclick="fncInp()" />&nbsp;</td> 滚动条设置 -->
								
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