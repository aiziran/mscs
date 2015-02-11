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
function showChildWindow1(obj,email,email) 
{ 
	var url = "<c:url value='/common/popup/popup!sendto.action'/>"; 
	var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
	var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
	 //alert(aa);
	if(aa.split(";").length>2){
		
		var s1,s2,str="";
		for(var i=0; i<aa.length;i++){
			s1 = aa.split(";");
		}
		for(var i=0; i<s1.length-1;i++){
			s2 = s1[i].split(":");
			str+=s2[1]+"; ";
		}
	    $('#sendto').val(str);
		
	}else{
		//alert(aa.split(":")[1]);
		$('#sendto').val(aa.split(";")[1]+";");
	} 
}
// function showChildWindow2(obj,email,email) 
// { 
// 	var url = "<c:url value='/common/popup/popup!sendto.action'/>"; 
// 	var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
// 	var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
	
	
// 	if(aa.split(";").length>2){
		
// 		var s1,s2,str="";
// 		for(var i=0; i<aa.length;i++){
// 			s1 = aa.split(";");
// 		}
// 		for(var i=0; i<s1.length-1;i++){
// 			s2 = s1[i].split(":");
// 			str+=s2[1]+"; ";
// 		}
// 	    $('#copy').val(str);
// 	} else{
// 		$('#copy').val(aa.split(";")[1]+";");
// 	}
// }
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
					<td><input name="sendto" id="sendto" style="width: 800px;height:30px" readonly="readonly" ></td>
					</tr>
					 <tr>
					  <th> 主 题:  </th>
					<td><input name="theme" id="theme" style="width: 800px;height:30px" value="${data.theme }"></td>
					</tr>
					<tr>
					  <th> 插入:  </th>
					<td>附件： 
									 <input type="file" value="上传" name="upload" id="upload" value="${data.annex }"> <br>
				  <br></td>
					</tr>
				
				 
				
				  </table>
				   <textarea cols="300" id="message" name="message" rows="100">
				   ${data.message}
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