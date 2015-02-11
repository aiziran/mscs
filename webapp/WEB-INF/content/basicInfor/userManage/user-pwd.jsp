<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--
/**
 * ------------------------------------------------------------------------
 * @source  : user-pwd.jsp
 * @desc    : 用户管理修改密码
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
	 
 
  	
  	//保存操作
  	function fncSave() { 
  		
  		if($('#formDetail')[0].origPwd.value ==''){
  			alert("请输入原始密码");
  			$('#formDetail')[0].origPwd.focus();
  			return false;
  		} 
  		if($('#formDetail')[0].newPwd.value ==''){
  			alert("请输入新密码");
  			$('#formDetail')[0].newPwd.focus();
  			return false;
  		} 
  		if($('#formDetail')[0].confirmPwd.value ==''){
  			alert("请输入确认密码");
  			$('#formDetail')[0].confirmPwd.focus();
  			return false;
  		} 
  		
  		if($('#formDetail')[0].newPwd.value != $('#formDetail')[0].confirmPwd.value) {
  			
    		alert("两次输入的新密码不一致，请确认！");
    		$('#formDetail')[0].newPwd.value="";
    		$('#formDetail')[0].confirmPwd.value="";
    		$('#formDetail')[0].newPwd.focus();
    		return false;
    	}
  		
  		actSubmitValidate($('#formDetail'), '<c:url value="/basicInfor/userManage/user-pwd!updatePwd.action"/>');
  	}
  	
	//验证是否原密码是否正确
  	function fncCheckUserRepeat(){
  		var origpwd = $("#pwdOrigPwd").val();
  		if(origpwd == "") return;
  		$.ajax({
  			type:"POST",
  			url: "${ctx}/basicInfor/userManage/user-pwd!checkPwd.action",
  			data: "origpwd="+origpwd,
  			async:false,
  			success:function(flag){
  				if(flag == "false" ){
  					alert("原密码错误,请重新输入！");
  					$("#pwdOrigPwd").val("").focus();
  					return false;
  				}else if(flag == "sessionout"){
  					alert("请重新登录.");
  				}
  				else
  					return true;
  			}
  		});
  	}
   
</script>
<div id="actionAlert" style="display:none"><s:actionmessage/></div>



<script>
var oAlert = $('#actionAlert').html();
if(oAlert!=""&&oAlert!=null){
	alert($('div[id=actionAlert] ul li span').html());
}
</script>
</head>
   
<body>

<div id="Lcontent">
		<SSTag:navigation/>
  	<form id="formDetail" method="post">
  		<input type="hidden" name="operateModel" value="update"/>
  		<table class="LDetailArea" summary="User information.">
    		<tr>
      			<th><font color="red">*</font><span>原始密码</span></th>
      			<td>
				  <input type="password" id="origPwd" name="origPwd" size="20" class="Lbordercolor" 
				   validate="{required:true,maxlength:20}"  /><%-- onblur="fncCheckUserRepeat();" --%>
				</td>
      		</tr>
      		<tr>
      		    <th><font color="red">*</font><span>新密码</span></th>
      			<td><input type="password" id="newPwd" name="newPwd" class="Lbordercolor" 
      			value="${userInfo.userName}" validate="{required:true,maxlength:20}"/></td>
      		</tr>
      	
      		<tr>
      		    <th><font color="red">*</font><span>确认密码</span></th>
      			<td><input type="password" id="confirmPwd" name="confirmPwd" class="Lbordercolor" 
      			  validate="{required:true,maxlength:20}"/>
      			</td>
      		</tr>
  	 
		 
  		</table> 
  	</form>
  	<form id="mainForm" method="post">
  		
  	</form>
  	<fieldset>
  		<legend>Button</legend>
    	<ul class="LbtnArea">
      		<li>
      			<input type="button" value="保存" onclick="javascript:fncSave();" id="btnSave" objType="bSave" />
			</li>
    	</ul>
  	</fieldset>
</div>
</body>
</html>


