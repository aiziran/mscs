<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>柜子列表</title>
<script type="text/javascript" src="/archive/ckeditor/ckeditor.js"></script>
 <%@ include file="/common/header.jsp"%>
<script type="text/javascript" language="javascript">
function fncInp(){
	if(document.getElementById("sendto").value==""){
		alert("请在'收件人'文本框内输入地址");
		return false;
	}
	document.getElementById("formPage").submit();
}
 
</script>
</head>
<body onload="fncFixupListHead();">
	<div id="Lcontent">
		 <br> <br> 
		<form id="formPage" method="post" action="../emailManage/email!createEmailResult.action" enctype="multipart/form-data">
             	<table class="LlistArea"  id="listTab">
					 <tr  >
					  <th align="left" colspan="2"> <input class="button" type="button" value="发送" onClick="fncInp()"/> </th>
					 </tr>
					 <tr>
					  <th><input type="button" value="收件人:" style="width: 100px" onclick="showChildWindow1(this,'email','email')"></th>
					<td><input name="sendto" id="sendto" style="width: 800px;height:30px" readonly="readonly"  value="${data.sendto };"></td>
					</tr>
					 <tr>
					  <th> 主 题:  </th>
					<td><input name="theme" id="theme" style="width: 800px;height:30px" ></td>
					</tr>
					<tr>
					  <th> 插入:  </th>
					<td>附件： 
									 <input type="file" value="上传" name="upload" id="upload"><br>
				  <br></td>
					</tr>
			
				  
				
				  </table>
				  <textarea cols="300" id="message" name="message" rows="100">
				
			</textarea>
		    
			<script language="javascript">
				CKEDITOR.replace( 'message',
			{
			fullPage : true,
			extraPlugins : 'docprops',
			filebrowserUploadUrl : '${ctx}/basicInfor/newsinfoManage/newsinfo!savepic.action'
			});
				</script>
				</form>
				
		</div>
							<!-- END content -->
</body>
</html>