<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<%--
/**
 * ------------------------------------------------------------------------
 * @source  : code-input.jsp
 * @desc    : 公共代码修改与创建
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2011.12.18   SSQ                 初次建立
 * ------------------------------------------------------------------------ 
 */
--%>
<html>
<head>
<title>公共代码管理</title>
<%@ include file="/common/header.jsp" %>
<script language="javascript">
   
    //初始加载表单验证器
	$(function(){
		$("#codeId").focus()
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
	
    //检查code id是否合法
    function fncCheckCodeIdRepeat(form){
 		var codeGroup = $("#codeGroup").val();
 		var codeId = $("#codeId").val();
  		if(codeId=="") return;
  		$.ajax({
  			type:"POST",
  			url: "${ctx}/basicInfor/codeManage/code!checkCodeId.action",
  			data: "codeId="+codeId+"&codeGroup="+codeGroup,
  			async:true,
  			success:function(flag){
  				if(flag == "false" ){
  					alert("CODE ID（"+codeId+"）已存在 ,不能使用！");
  					$("#codeId").val("").focus();
  					return false;
  				}else{
  					if(!confirm("确认要保存吗？")) return;
  					form.submit();
  				}
  			}
  		});
    }
	// 保存公共代码
	function fncSave() {
		actSubmit($('#formDetail'), "<c:url value="/basicInfor/codeManage/code!save.action"/>");
	}

	// 点击取消按钮时返回上一页面
	function fncCancel() {
	  	if(!confirm("是否要取消当前编辑？")) {
   			return;
   	 	}	  
	  	fncExtraFormCancel("<c:url value='/basicInfor/codeManage/code.action'/>");
	}
    
</script>
</head>
<body>
	<div id="Lcontent">
		<SSTag:navigation/>
		<form name="formDetail" id="formDetail" method="post"
			class="enterhandler">
			<input type="hidden" name="mode" id="txtMode" value="<c:out value="${data.mode}"/>"> 
			<table class="LDetailArea">
				<tr>
					<th>组代码</th>
					<td><c:choose>
						<c:when test="${data.mode=='create'}">
								<s:select name="codeGroup" id="codeGroup" list="codeGroupList" listKey="code" listValue="value" value=""  style="width:96px;margin-right: 10px;" theme="simple"/> 
						</c:when>
						<c:when test="${data.mode=='update'}">
							<c:out value="${codeInfo.codeGroupName}" />
							<input type="hidden" name="codeGroup"
								value="<c:out value="${codeInfo.codeGroup}"/>">
						</c:when>
					</c:choose></td>
				</tr>
				<tr>
					<th>
						<c:choose>
							<c:when test="${data.mode=='create'}">
								<font color="red">*</font>代码 ID
							</c:when>
							<c:when test="${data.mode=='update'}">
								代码 ID
							</c:when>
						</c:choose>
					</th>
					<td>
						<c:choose>
							<c:when test="${data.mode=='create'}">
								<input type="text" name="codeId" id="codeId" value="" maxlength="40"
									class="Lbordercolor" validate="{required:true,maxlength:40}"/>
							</c:when>
							<c:when test="${data.mode=='update'}">
								<c:out value="${codeInfo.codeId}" />
								<input type="hidden" name="codeId" id="codeId" 
									value="<c:out value="${codeInfo.codeId}"/>" />
							</c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>代码描述</th>
					<td><input type="text" name="codeDesc" maxlength="150" class="Lbordercolor"
						value="<c:out value="${codeInfo.codeDesc}"/>" validate="{maxlength:150}"/></td>
				</tr>
				<tr>
					<th><span class="text">状态</span></th>
					<td><select name="useFlag">
						<option value="Y" <c:if test="${'Y' == codeInfo.useFlag}">selected</c:if>>可用</option>
						<option value="N" <c:if test="${'N' == codeInfo.useFlag}">selected</c:if>>禁用</option>
					</select></td>
				</tr>
				<tr>
					<th>显示排序</th>
					<td><input name="codeOrder" type="text" size="5" maxlength="13"
						value="<c:out value="${codeInfo.codeOrder}"/>" class="Lbordercolor"
						onkeyup="value=value.replace(/[^\d]/g,'')" /></td>
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
