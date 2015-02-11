
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript" src="/archive/ckeditor/ckeditor.js"></script>
<html>
<head>
<title>房地产知识新增</title>
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
		actSubmit($('#formPage'), '<c:url value="/basicInfor/estatenManage/estaten!lorainput.action"/>');
	}
	
	
</script>
</head>

<body onload="fncFixupListHead();">
	<div id="Lcontent">
		<SSTag:navigation />
		<form id="formPage" method="post"  enctype="multipart/form-data" >
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
										<td colspan="2"><b>添加房地产知识</b></td>
									</tr>
									<tr>
										<td><font color="red">*</font>主题</td>
										<td nowrap="nowrap"><input type="text" id="subject" name="subject" ></td>
									</tr>
									<tr>
										<td><font color="red">*</font>详细内容</td>
										<td colspan = "2">
											  <textarea cols="300" id="message" name="message" rows="100">
												</textarea>
				 						</td>
				 					</tr>
				 					<!-- 
									<tr>
										<td><font color="red">*</font>介绍图片</td>
										<td colspan = "2">
											  <input type="file" id="upload" name="upload" />
				 						</td>
				 					</tr>
				    					 -->
							                       
										<script language="javascript">
											CKEDITOR.replace( 'message',
										{
										fullPage : true,
										extraPlugins : 'docprops',
										filebrowserUploadUrl : '${ctx}/basicInfor/newsinfoManage/newsinfo!savepic.action'
										});
											</script>
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