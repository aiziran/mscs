<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/common/header.jsp" %>
<script type="text/javascript" language="javascript">
	$(function(){
		$("#classesname").focus();	
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
    	fncExtraFormCancel('<c:url value="/basicInfor/dataManage/data!classes.action"/>');
  	}
  	
  	//保存操作
  	function fncSave() { 
  		actSubmitValidate($('#formDetail'), '<c:url value="/basicInfor/dataManage/data!updateClasses.action"/>');
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
<!-- <SSTag:navigation />-->
<div id="LpageTitleArea">
			<h1>班次管理</h1>
			<div>
				<a href="#">Home</a> &gt; <a href="#">基本信息管理</a> &gt; <a
					href="/CarPhone/basicInfor/newsinfoManage/newsinfo.action?selectMenuId=1110"
					id="Lhere">班次信息</a>
			</div>
		</div>
<div id="message" style="color:red;font-size:12px;margin-top:35px;margin-left:300px;"><s:actionmessage/></div>
	<!-- <pbf:navigation/> -->
  	<form id="formDetail" method="post">
  		<input type="hidden" name="operateModel" value="update"/>
		<input type="hidden" name="id" value="${data.id}"/>
  		<table class="LDetailArea" summary="dataInfo information.">
    		<tr>
      			<th><span> 班次</span></th>
      			<td>
					<input type="text" id="classesname" name="classesname" size="20" class="Lbordercolor" value="${dataInfo.classesname}" validate="{required:true,maxlength:50}"/>
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


