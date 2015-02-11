<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<%@ include file="/common/header.jsp"%>
<script>
//保存操作
  	function fncSave() { 
  		actSubmitValidate($('#formDetail'), '<c:url value="/basicInfor/acconditionManage/accondition!update.action"/>');
  	}
  //取消当前编辑
	function fncCancel() {
		if (!confirm("是否要取消当前编辑并返回前页面？")) {
			return;
		}
		fncExtraFormCancel('<c:url value="/basicInfor/acconditionManage/accondition.action"/>');
	}
  
	function showArchiveTypeWindow()
	{   
		
		var url = "<c:url value='/common/popup/popup!listArchiveType.action'/>"; 
	var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
	var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.

	if(aa){
		//$('#archivesnum').val(aa.split(";")[0])
		$('#actype').val(aa.split(";")[0])
		$('#typename').val(aa.split(";")[1]);
	} 
}
 </script>
</head>
<body>
<div id="Lcontent">
		<SSTag:navigation />

  <form id="formDetail" method="post">
			<input type="hidden" name="operateModel" value="update" />
			<input type="hidden" name="id" id="id" value="${accondition.id}"/>
			<table class="LDetailArea" summary="Accondition information.">
			<tr>
										<td><font color="red">*</font>流程节点</td>
										<td nowrap="nowrap" align="left" class=''><input type="hidden" id="actype" name="actype"  value="${accondition.actype}">
										<input type="text" id="typename" name="typename"  value="${accondition.typename}" size="60"/>
										<image src="/archive/images/pbf/Content_icon_search.gif" onclick="showArchiveTypeWindow()"/></td>
									</tr>
									<tr>
										<td><font color="red">*</font>条件名称</td>
										<td nowrap="nowrap"  align="left">
										<input type="text" id="acname" name="acname"  size="60" value="${accondition.acname}"></td>
									</tr>
									<tr>
										<td><font color="red">*</font>条件描述</td>
										<td nowrap="nowrap"  align="left">
										<textarea id="acdesc" name="acdesc" rows="6" cols="60">${accondition.acdesc}</textarea>
										</td>
									</tr>
									<tr>
										<td><font color="red">*</font>条件重要性</td>
										<td nowrap="nowrap">
										<select  id="acimpt" name="acimpt">
										  	<option value="0">必需</option>
										  	<option value="1">非必需</option>
										  </select>
										</td>
									</tr>
			</table>
		</form>
		<fieldset>
			<legend>Button</legend>
			<ul class="LbtnArea">
				<li><input type="button" value="保存" onclick="fncSave()"
					id="btnSave" objType="bSave" />
					
					 <input type="button" value="取消"
					onclick="fncCancel()" id="btnCancel" objType="bCancel" />
				</li>
			</ul>
		</fieldset>
</div>
</body>
</html>