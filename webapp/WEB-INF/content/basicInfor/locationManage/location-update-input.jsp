<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--
/**
 * ------------------------------------------------------------------------
 * @source  : location-input.jsp
 * @desc    :车型管理修改和删除页面
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2012.02.16   HYJ                 初次建立
 * ------------------------------------------------------------------------ 
 */
--%>
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript"
	src="${ctx }/js/DatePicker/WdatePicker.js"></script>
<script type="text/javascript" language="javascript">
	$(function(){
		$("#id").focus();
		fncAppend("formDetail"); //传入主页面的查询参数值,及分页的信息
		Validator = $("#formDetail").validate({
			wrapper: "p", 		
			submitHandler:function(form){
			if (!confirm("请确认是否提交？")) return;
			form.submit();
		}	
	});
	});
	//取消当前编辑
  	function fncCancel() {
    	if(!confirm("是否要取消当前编辑并返回前页面？")) {
    		return;
    	}    	    	
    	fncExtraFormCancel('<c:url value="/basicInfor/locationManage/location.action"/>');
  	}
  	
  	//保存操作
  	function fncSave() { 
  		actSubmitValidate($('#formDetail'), '<c:url value="/basicInfor/locationManage/location!save.action"/>');
  	}
  	
 // 删除数据信息
 	function fncDelete(configid) { 		
 		actSubmit($('#formDetail'), "/car/basicInfor/locationManage/location!deleteDo.action");
 	}
  	
  	
  	//控制备注字符输入
  	var textarea_maxlen = {
		isMax : function (){
		   var textarea = document.getElementById("area");
		   var max_length = textarea.maxlength;
		if(textarea.value.length > max_length){ 
		   textarea.value = textarea.value.substring(0, max_length);
		   }
		},
		disabledRightMouse : function (){
		document.oncontextmenu = function (){ return false; }},
		enabledRightMouse : function (){
		document.oncontextmenu = null;}
	};
  
  
  
	
	
  	
  	
</script>
</head>

<body>
	<div id="messageBox" style="display: none;"></div>
	<div id="Lcontent">
		<SSTag:navigation />
		<form id="formDetail" method="post">
			<input type="hidden" name="operateModel" value="update" />
 			<input type="hidden" name="id" id="id" value="${location.id}"/>
		
		
		<table class="LDetailArea">
	
	 			<tr>
					<th>车辆存放地</th> 
					<td>
					<input type="text" name="location" id="location" maxlength="150" size="40" class="Lbordercolor" value="${location.location}"/>
					</td>
				</tr>
	 
				<tr>
					<th>备注</th>
					<td><input type="text" name="remark" id="remark" size="40" maxlength="150" class="Lbordercolor" value="${location.remark}"/></td>
				</tr>
			</table>
			
		</form>
		<fieldset>
			<legend>Button</legend>
			<ul class="LbtnArea">
				<li><input type="button" value="保存" onclick="fncSave()"
					id="btnSave" objType="bSave" />
					 <input type="button" value="删除"
					onclick="fncDelete('${location.id}')" id="btnDelete"
					objType="bDelete" />
					 <input type="button" value="取消"
					onclick="fncCancel()" id="btnCancel" objType="bCancel" />
				</li>
			</ul>
		</fieldset>
	</div>
</body>
</html>


