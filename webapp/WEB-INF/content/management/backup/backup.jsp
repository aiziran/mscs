<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!--  
/**
 * ------------------------------------------------------------------------
 * @source  : listCode.jsp
 * @desc    : 系统备份
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.05.29  houyingchang       初次建立
 * ------------------------------------------------------------------------ 
 */
 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系统备份</title>
</head>
<%@ include file="/common/header.jsp"%>
<script src="${ctx}/js/common.js" type="text/javascript"></script>
<script type="text/javascript"
	src="${ctx }/js/DatePicker/WdatePicker.js"></script>
<script type="text/javascript" language="javascript">
	function fncDbBackup() {    	
		var file=document.getElementById("bakFile").value;
		if(file==""){
			alert("【备份文件】为必输项，请输入合适的数据");
            return ;
			}
		document.getElementById("proDiv").style.display="block";
   		document.getElementById("btnDbBackup").disabled = true;
   		actSubmit($('#formDetail'), '<c:url value="/management/backup/backup!backUp.action"/>');
   	}
   	function message(){
   		var message=document.getElementById("message").value;
   		if(message==1){
   	   		alert("保存失败！");
   	   		}
   		if(message==2){
   	   		alert("保存成功！");
   	   		}
   	   	}
</script>
<body onload="message()" >
	<div id="Lcontent"><SSTag:navigation />
		<form name="formDetail" id="formDetail" method="post" class="enterhandler" >
		<input type="hidden" id="message"  name="message"  value="<c:out value='${data.queryMessage}'/>" >
    	<table class="LDetailArea">	
			<tr>
				<th>备份文件</th>
		   		<td>  
		   		<input name="bakFile" id="bakFile"  value="<c:out value='${data.newFile}'/>" class="Lbordercolor" style="width:300;text-align:right" onkeyup='value=value.replace(/[ |\\/<>"?,\^~`!@#$%&{}=+*:().]/g,"")' alt="备份文件:yes:maxByteLength=300"    />.dmp
		    	</td>
		   	</tr>
    	</table>
	</form>  	
	<fieldset>
		<legend>Button</legend>
		<ul class="LbtnArea">
			<li><input value="备份" onclick="fncDbBackup()" onkeypress="fncDbBackup()" id="btnDbBackup" type="button"></li>
		</ul>
	</fieldset> 
	</div>
	<div id ="proDiv" style="position:absolute; z-index:10;top:100;left:280;display:none">
	<object   classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"   codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=5,0,0,0"   width="200"   height="150">   
	      <param   name="movie"   value="${ctx}/images/issm/body/progress_bar.swf">   
	      <param   name="quality"   value="high">   
	      <embed   src="${ctx}/images/issm/body/progress_bar.swf"   quality="high"  pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash"   type="application/x-shockwave-flash"   width="130"   height="50">   
	      </embed>     
	</object>
</div>
</body>
</html>