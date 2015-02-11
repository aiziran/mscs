<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--
/**
 * ------------------------------------------------------------------------
 * @source  : user-input.jsp
 * @desc    : 用户管理创建用户页面
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
<script src="${ctx}/bootstrap/js/jquery.min.js"></script>
<script type="text/javascript" language="javascript">
	//回显操作模块权限
	$(function() {
		var arr = new Array();
		var urlArr = $("#urlid").val();
		if(urlArr!=null && urlArr.trim().length>0) {
			urlArr = urlArr.substring(0, urlArr.length-1);
		}
		arr = urlArr.split(",");
		for (var i = 0; i < arr.length; i++) {
			$("input[name='pagelist']").each(function(){
				if($(this).val() == arr[i]) {
					$(this).attr("checked", "checked");
				}
			});
		}
	});
	
	$(function(){
		$("#userName").focus();
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
    	fncExtraFormCancel('<c:url value="/basicInfor/userManage/user.action"/>');
  	}
  	
  	
  	//保存操作
  	function fncSave() { 
		var userIdVal = $("#userId").val();
		var userNameVal = $("#userName").val();
		if(userIdVal===null || userIdVal.trim().length<=0) {
			alert("请输入用户ID");
			return ;
		}
		if(userNameVal===null || userNameVal.trim().length<=0) {
			alert("请输入用户");
			return ;
		}
		if($("#authId option:selected").text() === "---请选择---") {
			alert("请选择角色");
			return ;
		}
		
  		var a=document.getElementById("phoneNo").value;
		var b=document.getElementById("mobileNo").value;
		if(a!=""){
			var partten=/^[\d]{3}-[\d]{8}$|^[\d]{4}-[\d]{7}$|^[\d]{11}$|^[\s]*$/;
			   var flag=partten.test(a);
			   if(!flag){
				   alert("电话号码格式不正确!,如***-********（座机格式）,****-*******（座机格式）"); 
		           document.getElementById("phoneNo").focus(); 
		           return false;
			 }
			   
			   var f = partten.test(b);
			   if(!f){
				   alert("电话号码格式不正确!,11位手机号码"); 
		           document.getElementById("mobileNo").focus(); 
		           return false;
			   }
			}
		
  		actSubmitValidate($('#formDetail'), 
  				'<c:url value="/basicInfor/userManage/user!save.action"/>');
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

 
  function showHosSupp()
  {
	  var v = formDetail.authId.options[formDetail.authId.selectedIndex].text;
	  if(v.indexOf("供应商")>-1)
	  {
		  formDetail.hosId.style.display="none";
		  formDetail.hosId.disabled = true;
		  formDetail.suppId.style.display="";
		  formDetail.suppId.disabled = false;
	  }
	  if(v.indexOf("医院")>-1)
	  {
		  formDetail.suppId.style.display="none";
		  formDetail.suppId.disabled = true;
		  formDetail.hosId.style.display="";
		  formDetail.hosId.disabled = false;
	  }
	  if(v.indexOf("系统")>-1)
	  {
		  formDetail.suppId.style.display="none";
		  formDetail.hosId.style.display="none";
		  formDetail.suppId.disabled = true;
		  formDetail.hosId.disabled = true;
	  }
  }
  
  function setSelect(hid,sid)
  {
	  if(hid!='')
	  {
		  var selObj = formDetail.hosId;
		  formDetail.hosId.style.display="";
		  formDetail.hosId.disabled = false;
		  for(i=0;i<selObj.options.length;i++)
		  {
			if(selObj.options[i].value==hid)
				selObj.options[i].selected = true;
		  }
	  }
	  if(sid!='')
	  {
		  var selObj = formDetail.suppId;
		  formDetail.suppId.style.display="";
		  formDetail.suppId.disabled = false;
		  for(i=0;i<selObj.options.length;i++)
		  {
			if(selObj.options[i].value==sid)
				selObj.options[i].selected = true;
		  }
	  }
  }
	function onRoleChanged(role){
  		var value=document.getElementById('authId').value;
  		if(value=='1000005'){
  			$('#shop').css("display", "none");
  		}else{
  			$('#shop').css("display", "block");
  		}
  	}
	//删除前验证是否有库存录入
  	function fncCheckUserName(){
  		var userName = $("#userName").val();
  		if(userName == "") return;
  		var flag2;
  		$.ajax({
  			type:"POST",
  			url: '<c:url value="/basicInfor/userManage/user!checkUserName.action"/>',
  			data: "userName="+userName,
  			async:false,
  			success: function(flag){
  				flag2=flag;
  				if(flag == "false" ){
  					alert("用户名（"+userName+"）已被引用 ,不能删除！");
  					return false;
  				}else
  					return true;
  			}
  		});
  		return flag2;
  	}
  	function fncDelete() {
  		/* if("false"==fncCheckUserName()){
  			return;
  		}  */
    	actSubmitValidate($('#formDetail'), 
    			'<c:url value="/basicInfor/userManage/user!deleteuser.action"/>');
  	}
	function fncCheckAll(num) {
		var mails = document.getElementsByName("pagelist");
		for(var x=0; x<mails.length; x++) {
			if(num>1)
				mails[x].checked = !mails[x].checked;
			else
				mails[x].checked = num;
		}
	}
  
</script>
</head>
   
<body>
<div id="messageBox" style="display: none;"></div>
<div id="Lcontent">
	<SSTag:navigation/>
  	<form id="formDetail" method="post" >
  		<input type="hidden" name="operateModel" value="update"/>	
  		<input type="hidden" id="rolename" name="rolename" value="${userInfo.rolename}"/>	
  		<table class="LDetailArea" summary="User information.">
    		<tr>
      			<th><font color="red">*</font><span>用户ID</span></th>
      			<td>
					<input type="text" id="userId" name="userId" size="20" class="Lbordercolor" value="${userInfo.userId}" validate="{required:true}" readonly/>
				</td>
      			<th><font color="red">*</font><span>用户名</span></th>
      			<td><input type="text" id="userName" name="userName" class="Lbordercolor" value="${userInfo.userName}" validate="{required:true,maxlength:20}"/></td>
    		</tr>
 			<!-- 
    		<tr>
      			<th><span>数据权限</span></th>
      			<td>
      				<s:select name="department" id="department" list="codeGroupList" listKey="code" listValue="value" value="userInfo.deptId" theme="simple"/>        			
				</td>
      			<th></th>
      			<td> 
        		</td>
    		</tr>
    		 -->
    		<tr>
      			<th>固定电话</th>
      			<td><input type="text" name="phoneNo" id="phoneNo" class="Lbordercolor" value="${userInfo.phoneNo}" validate="{phone:true,maxlength:20}"/></td>
    			<th>移动电话</th>
      			<td><input type="text" name="mobileNo" id="mobileNo" class="Lbordercolor" value="${userInfo.mobileNo}" maxlength="20" validate="{mobile:true,maxlength:20}"/></td>
			</tr>
    		<tr>
      			<th>传真</th>
      			<td><input type="text" name="faxNo" class="Lbordercolor" value="${userInfo.faxNo}" maxlength="20" validate="{phone:true,maxlength:20}"/></td>
      			<th>密码</th>
      			<td>
      				<input type="password" name="newPwd" id="newPwd" size="20" class="Lbordercolor" value="" maxlength="20"  validate="{pwd:true,maxlength:20}"/>				
					<input type="hidden" id="password" name="password" value="${userInfo.password}"/></td>
    		</tr>
			<tr>
      			<th>电子邮件</th>
      			<td>
        			<input type="text" name="email" style="width: 250px"  class="Lbordercolor" value="${userInfo.email}" maxlength="50" validate="{email:true,maxlength:50}"/>
      			</td>
      			<th>状态</th>
	      		<td>
	        		<select name="useFlag">
						<option value="Y" <c:if test="${userInfo.useFlag == 'Y'}"> selected</c:if>>可用</option>
						<option value="N" <c:if test="${userInfo.useFlag == 'N'}"> selected</c:if>>禁用</option>
					</select>
	      		</td>
    		</tr>
    		<tr>
      			<th>住址</th>
      			<td colspan="3"><input type="text" name="address" style="width: 500px" class="Lbordercolor" value="${userInfo.address}" maxlength="200" validate="{maxlength:200}"/></td>
    		</tr>
			<tr>
      			<th>备注</th>
      			<td colspan="3">
					<textarea id="area" rows="3" style="width: 500px" name="notes"  maxlength="500" validate="{maxlength:500}" onkeyup="textarea_maxlen.isMax()" onfocus="textarea_maxlen.disabledRightMouse()" onblur="textarea_maxlen.enabledRightMouse()">${userInfo.notes}</textarea>
				</td>
    		</tr>
    		<tr>
      			<th><span>部门</span></th>
      			<td>
      				<s:select name="department" id="department" list="codeGroupList" listKey="code" listValue="value" value="userInfo.deptId" theme="simple" />        			       			
				</td>
    		</tr>
  		</table><br>
		<label>用户权限:</label>
		<table class="LDetailNoWidth">
			<colgroup>
      			<col width="15%"/>
		      	<col width="85%"/>
		    </colgroup>
			<tr>
				<th><font color="red">*</font>角色</th>
				<td>
		        	<s:select name="authId" id="authId" list="codeAuthList" listKey="code" listValue="value"  theme="simple" headerKey="-1" headerValue="---请选择---"  />
		        </td>
    		</tr>
  		</table>
		<br />
		<!-- 操作模块权限: -->
		<br /><br />
		<div class="checkbox">
			<input id="urlid" type="hidden" value="${userInfo.urllist }" />
			<c:forEach items="${allURL }" var="allurl" varStatus="idx">
				<label><input type="checkbox" name="pagelist" value="${allurl.id }" />${allurl.urlname }</label>
				<c:if test="${idx.index eq 11 }">
					<br /><br />
				</c:if>
			</c:forEach>
		</div>
  	</form>
  	<fieldset>
  		<legend>Button</legend>
    	<ul class="LbtnArea">
      		<li>
      		<!-- <input type="button" value="全选" onclick="fncCheckAll(1)" id="btnCheckAll" objType="bCheckAll" />
      		<input type="button" value="取消全选" onclick="fncCheckAll(0)" id="btnCheckNull" objType="bCheckNull" /> -->
      		<input type="button" value="删除" onclick="fncDelete()" id="btnDelete" objType="bDelete" />
      		<input type="button" value="保存" onclick="fncSave()" id="btnSave" objType="bSave" />
        	<input type="button" value="取消" onclick="fncCancel()" id="btnCancel" objType="bCancel"/>
			</li>
    	</ul>
  	</fieldset>
</div>
</body>
<script>
	setSelect('${userInfo.hospitalId}','${userInfo.supplierId}');
</script>
</html>


