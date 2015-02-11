<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>

<html>
<head>
<title>车型管理</title>
<%@ include file="/common/header.jsp" %>
<script type="text/javascript"
	src="${ctx }/js/DatePicker/WdatePicker.js"></script>
<script language="javascript">
   
    //初始加载表单验证器
	$(function(){
		$("#configid").focus()
		fncAppend("formDetail");	
		$("#formDetail").validate({
			submitHandler:function(form){
				var mode = $("#txtMode").val();
				if(mode=="create"){
					fncCheckCodeIdRepeat(form);												
				}else{
					if(!confirm("确认要保存吗？")) return;
					form.submit();
				}
				
			}	
		});
	});
	
  	//保存操作
  	function fncSave() { 
  		actSubmitValidate($('#formDetail'), '<c:url value="/basicInfor/locationManage/location!save.action"/>');
  	}
	// 点击取消按钮时返回上一页面
	function fncCancel() {
	  	if(!confirm("是否要取消当前编辑？")) {
   			return;
   	 	}	  
	  	fncExtraFormCancel("<c:url value='/basicInfor/locationManage/location.action'/>");
	}
	
	
	
  
    
</script>
</head>
<body>
	<div id="Lcontent">
		<SSTag:navigation/>
		<form name="formDetail" id="formDetail" method="post"
			class="enterhandler">
			<input type="hidden" name="operateModel" id="operateModel" value="create"/> 
			<table class="LDetailArea">
	
	 			<tr>
					<th>车辆存放地</th> 
					<td>
					<input type="text" name="location" id="location" maxlength="150" size="40" class="Lbordercolor"/>
					</td>
				</tr>
	 
				<tr>
					<th>备注</th>
					<td><input type="text" name="remark" id="remark" size="40" maxlength="150" class="Lbordercolor"/></td>
				</tr>
				
				
              
			</table>
		</form>
		<fieldset><legend>Button</legend>
		<ul class="LbtnArea">
			<li><label for="Lcancel">Cancel</label>
				<input value="取消" onclick="fncCancel()" onkeypress="fncCancel()" id="btnCancel"
				type="button" objType="bCancel">
			</li>
			<li><label for="Lsave">Save</label>
				<input value="保存" onclick="fncSave()" onkeypress="fncSave()" id="btnSave" type="button"
				objType="bSave">
			</li>
		</ul>
		</fieldset>
	</div>
</body>
</html>
