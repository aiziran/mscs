<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>查询公告</title>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript"
	src="${ctx }/js/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="/archive/ckeditor/ckeditor.js"></script>
</head>
<script type="text/javascript" language="javascript">
 function fncSave(){
	 window.location.href="notice.action";
 }
 function fncUpdate(){
	 actSubmit($('#formDetail'),
		'<c:url value="notice!selectTwo.action"/>');
 }
 function downFile(){
	 actSubmit($('#formDetail'),
		'<c:url value="notice!downFile.action "/>');
 }
</script>
<body onload="fncFixupListHead();">
  <div id="Lcontent">
	<SSTag:navigation/>
		<form id="formDetail" method="post" >
		<div id="resultDiv"	style="width: 1000px;">
		<s:iterator value="page.result" status="st">
					<table class="LDetailArea" id="listTab" style="width:1000px">
					
									<tr>
										<td colspan="4"><b>查询公告</b></td>
									</tr>
									<tr>
										<th>创建时间</th>
										<td>${createtime }</td>
									</tr>
									<tr>
										<th >标题：</th>
										<td>
										<input type="hidden" id="id" name="id" value="${id }">
										${title }
										</td>
									</tr>
									<tr>
									<th>附件： </th>
									<td ><c:if test="${empty file}">没有附件</c:if>
										<c:if test="${not empty file }"><a href="#" onclick="downFile()"> ${file }</a></c:if>
										<input type="hidden" id="annex" name="annex" value=${annex }>
									</td>
									</tr>
									<tr>
										<th>有效期：</th>
										<td>
											${validity }
										</td>
									</tr>
									
									<tr>
										<th>显示位置：</th>
										<td >
											${dname }
										</td>
									</tr>
									<tr>
									<th>其他：</th>
									<td>
										<c:if test="${ishomepage==1 }">置顶&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${sethomepagetime }</c:if>
										<c:if test="${ishomepage==0 }">没有置顶</c:if>
									</td>
									</tr>
									<tr>
									 <td colspan="2" align="center"><font color="red">*</font>内容：</td>
									</tr>
								
							</table>
																<textarea id="content" name="content" rows="15" >${ content}</textarea>
									<script language="javascript">
				CKEDITOR.replace( 'content',
			{
			fullPage : true,
			extraPlugins : 'docprops',
			filebrowserUploadUrl : '${ctx}/basicInfor/newsinfoManage/newsinfo!savepic.action'
			});
				</script>
					</s:iterator>
								</form>
								<fieldset>
				<legend>Button</legend>
				<ul class="LbtnArea" >
					
					<li>
						<input type="button" value="返回" onclick="fncSave()" id="fncUpd" />
					</li>
					<li>
						<input type="button" value="修改" onclick="fncUpdate()" id="fncUpd" />
					</li>
				</ul>
			</fieldset>
							</div>
							</div>
							<!-- END content -->
</body>
</html>