<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--
/**
 * ------------------------------------------------------------------------
 * @source  : dept-input.jsp
 * @desc    : 数据权限管理创建页面
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2011.12.18   SSQ                 初次建立
 * ------------------------------------------------------------------------ 
 */
--%>
<%@ include file="/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/common/header.jsp" %>
<script type="text/javascript" language="javascript">
	$(function(){
		$("#name").focus();	
		fncAppend("formDetail"); //传入主页面的查询参数值
		$("#formDetail").validate({
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
    	fncExtraFormCancel('<c:url value="/basicInfor/dataManage/data!hander.action"/>');
  	}
	
  	
  	//保存操作
  	function fncSave() { 
  		alert("!!!!!!!!!");
  		actSubmitValidate($('#formDetail'), '<c:url value="/basicInfor/dataManage/data!insertHander.action"/>');
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
<div id="Lcontent">
<SSTag:navigation/>
	<!-- <pbf:navigation/> -->
  	<form id="formDetail" method="post">
  		<input type="hidden" name="operateModel" value="create"/>
  		<table class="LDetailArea" summary="Dept information.">
    		
				<tr>
      			<th><font color="red">*</font><span> 姓名</span></th>
      			<td>
					<input type="text" id="name" name="name" size="20" class="Lbordercolor" value="" validate="{required:true,maxlength:50}"/>
				</td>
	            </tr>
	            <tr>
      			<th><font color="red">*</font><span> 年龄</span></th>
      			<td>
					<input type="text" id="age" name="age" size="20" class="Lbordercolor" value="" />
				</td>
	            </tr>
	            <tr>
      			<th><font color="red">*</font><span> 性别</span></th>
      			<td>
					<input type="text" id="sex" name="sex" size="20" class="Lbordercolor" value="" />
				</td>
	            </tr>
	            <tr>
      			<th><font color="red">*</font><span> 备注</span></th>
      			<td>
					<input type="text" id="remark" name="remark" size="20" class="Lbordercolor" value=""/>
				</td>
	            </tr>
    		
    		
  		</table>
  	</form>
  	<fieldset>
  		<legend>Button</legend>
    	<ul class="LbtnArea">
      		<li>
      			<input type="button" value="保存" onclick="fncSave()" id="btnSave" objType="bSave"/>
        		<input type="button" value="取消" onclick="fncCancel()" id="btnCancel" objType="bCancel"/>
			</li>
    	</ul>
  	</fieldset>
</div>
</body>
</html>


