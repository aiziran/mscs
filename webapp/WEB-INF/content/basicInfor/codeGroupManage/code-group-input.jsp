<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--
/**
 * ------------------------------------------------------------------------
 * @source  : code-group.jsp
 * @desc    : 组代码管理修改
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2011.12.18   SSQ                 初次建立
 * ------------------------------------------------------------------------ 
 */
-->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%@ include file="/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/common/header.jsp" %>
<script type="text/javascript" language="javascript">
	$(function(){
		$("#codeGroupName").focus();	
		fncAppend("formDetail");
		$("#formDetail").validate({
			submitHandler:function(form){
			    var mode =  $("#mode").val();
				if(fncCheckCodeGroup(mode)== false)return;			
				if (!confirm("请确认是否提交？")) return;
				form.submit();
			}	
		});
	});

	//验证code groupid是否重复
	function fncCheckCodeGroup(type){
		var codeGroup =  "";
		var codeGroupName = "";
		var newCodeGroupName = $("#txtCodeGroupName").val();
		var oldCodeGroupName = $("#txtOldCodeGroupName").val();

		if(type=="create"){
			codeGroup =  $("#txtCodeGroup").val();
			codeGroupName =  $("#txtCodeGroupName").val();
		}else{
			if(oldCodeGroupName != newCodeGroupName){
				codeGroupName =  $("#txtCodeGroupName").val();
			}		
		}

		$.ajax({
  			type:"POST",
  			url: "${ctx}/basicInfor/codeGroupManage/code-group!checkCodeGroup.action",
  			data: "codeGroup="+codeGroup+"&codeGroupName="+codeGroupName+"&mode="+type,
  			async:false,
  			success:function(status){
  				if(status == "1" ){
  					alert("[组代码]（"+codeGroup+"）已存在 ,不能使用！");
  					$("#txtCodeGroup").val("").focus();
  					return false;
  				}else if(status == "2" ){
  					alert("[组名称]（"+codeGroupName+"）已存在 ,不能使用！");
  					$("#txtCodeGroupName").val("").focus();
  					return false;
  	  	  		}
  				return true;
  			}
  		});
		
	}
	//取消当前编辑
  	function fncCancel() {
    	if(!confirm("是否要取消当前编辑并返回前页面？")) {
    		return;
    	}
    	fncExtraFormCancel('<c:url value="/basicInfor/codeGroupManage/code-group.action"/>');
  	}
  	
  	//保存操作
  	function fncSave() { 
  		actSubmitValidate($('#formDetail'), '<c:url value="/basicInfor/codeGroupManage/code-group!save.action"/>');
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
  	<form id="formDetail" method="post">
  		<input type="hidden" name="mode" id="mode" value="${data.mode}"/>	
  		<table class="LDetailArea" summary="User information.">
    		<tr>
      			<th><font color="red">*</font><span>代码组</span></th>
      			<td>	
      				<c:if test="${data.mode!='update'}">
      				<input name="codeGroup" id="txtCodeGroup" type="text" size="30%" onblur="fncCheckCodeGroup('${data.mode}')"
							maxlength="40" class="Lbordercolor" validate="{required:true,maxlength:40}" />
      				</c:if>
      				
      				<c:if test="${data.mode=='update'}">
						<input type="text" name="codeGroup" id="txtCodeGroup" size="30%"
							readonly style="background-color: #EEFFB6" class="Lbordercolor"
							value="<c:out value="${codeGroupInfo.codeGroup}"/>"  validate="{required:true}"/>
					</c:if>
				</td>
    		</tr>
    		<tr>
      			<th><span>代码组名</span></th>
      			<td>
					
					<input name="codeGroupName" id="txtCodeGroupName" type="text" onblur="fncCheckCodeGroup('${data.mode}')"
						maxlength="50" value="<c:out value="${codeGroupInfo.codeGroupName}"/>" 
						size="30%" class="Lbordercolor" validate="{required:true,maxlength:50}" />
					<input type="hidden" name="oldCodeGroupName"  id="txtOldCodeGroupName"  value="${codeGroupInfo.codeGroupName}"/>
				</td>
    		</tr>
    		<tr>
      			<th>代码组描述</th>
      			<td>
      				
      				<input name="codeGroupDesc" id="txtCodeGroupDesc" type="text"
						maxlength="100" value="<c:out value="${codeGroupInfo.codeGroupDesc}"/>"
						size="80%" class="Lbordercolor" validate="{maxlength:100}"/>
      				</td>
			</tr>
			<tr>
				 <th>状态</th>
	      		 <td>
	        		<select name="useFlag" id="selUseFlag">
						<c:if test="${codeGroupInfo.useFlag!='N'}">
							<option value="Y" selected>可用</option>
							<option value="N">禁用</option>
						</c:if>
						<c:if test="${codeGroupInfo.useFlag=='N'}">
							<option value="Y">可用</option>
							<option value="N" selected>禁用</option>
						</c:if>
					</select>
	      		 </td>
    		</tr>
    		<c:if test="${data.mode=='update'}">
					<tr>
						<th>创建人</th>
						<td><c:out value="${codeGroupInfo.createUser}" /></td>
					</tr>
					<tr>
						<th>创建时间</th>
						<td><c:out value="${codeGroupInfo.createDate}" /></td>
					</tr>
					<tr>
						<th>修改人</th>
						<td><c:out value="${codeGroupInfo.updateUser}" /></td>
					</tr>
					<tr>
						<th>修改时间</th>
						<td><c:out value="${codeGroupInfo.updateDate}" /></td>
					</tr>
				</c:if>
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