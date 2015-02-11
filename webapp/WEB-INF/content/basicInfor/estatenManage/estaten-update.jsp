<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript" src="/archive/ckeditor/ckeditor.js"></script>
<html>
<head>
<title>房地产新闻修改</title>
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
		actSubmit($('#formPage'), '<c:url value="/basicInfor/estatenManage/estaten!update.action"/>');
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
		<form id="formPage" method="post" enctype="multipart/form-data">
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
										<td colspan="2"><b>修改房地产新闻</b></td>
									</tr>
									<tr>
										<td><font color="red">*</font>主题</td>
										<td nowrap="nowrap"><input type="text" id="subject" name="subject" value="${estaten.subject}" ></td>
									</tr>
									<tr>
										<td><font color="red">*</font>详细内容</td>
										<td colspan = "2">
											  
				 						</td>
				 					</tr>
									<tr>
										<td><font color="red">*</font>介绍图片</td>
										<td colspan = "2">
											  <input type="file" id="upload" name="upload" />
				 						</td>
				 					</tr>
				 						<tr><td nowrap="nowrap"><input type="hidden" name="id" id="id"  value="${estaten.id}"/></td>
										
									<td nowrap="nowrap"><input type="button" value="提交" onclick="fncInp()" />&nbsp;
									<input type="button" value="删除" onclick="fncDel()" id="checkBox" objType="bCreate"/></td></tr>
										
								<!-- 滚动条设置 -->
								
							</table>
							<textarea cols="300" id="message" name="message" rows="100">
											        ${estaten.detail }
												</textarea>
										<script language="javascript">
											CKEDITOR.replace( 'message',
										{
										fullPage : true,
										extraPlugins : 'docprops',
										filebrowserUploadUrl : '${ctx}/basicInfor/newsinfoManage/newsinfo!savepic.action'
										});
											</script>
							</div>
							
								
								</form>
							</div>
							</div>
							<!-- END content -->
</body>
</html>
</body>
</html>