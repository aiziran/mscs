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
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<%@ include file="/common/header.jsp"%>
<script src="${ctx}/js/hmis.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
	$(function() {
		$("#userId").focus();
		fncAppend("formDetail");
		$("#formDetail").validate({
			submitHandler : function(form) {
				if (fncCheckUserRepeat() == false)
					return;
				if (!confirm("请确认是否提交？"))
					return;
				form.submit();
			}
		});
	});
	//取消当前编辑
	function fncCancel() {
		if (!confirm("是否要取消当前编辑并返回前页面？")) {
			return;
		}
		fncExtraFormCancel('<c:url value="/basicInfor/userManage/user!inspector.action"/>');
	}

	//保存操作
	function fncSave() {
	
// 		向论坛用户数据库中插入一条数据
// 		var xmlHttp = null;
// 	    xmlHttp = new XMLHttpRequest();
// 	    xmlHttp.open( "GET", "http://localhost:8000/bbs/mvnforum/createuser?MemberName="+$("#userId").val()+"&MemberPassword=empty&MemberMatkhau=empty&MemberMatkhauConfirm=empty&MemberFirstEmail="+$("#userId").val()+"@163.com&MemberEmail="+$("#userId").val()+"@163.com&MemberEmailVisible=0&MemberNameVisible=0&MemberFirstIP=0:0:0:0:0:0:0:1&MemberLastIP=0:0:0:0:0:0:0:1&MemberViewCount=0&MemberPostCount=0&MemberCreationDate=2013-03-11%2012:01:05&MemberModifiedDate=2013-03-11%2012:01:05&MemberExpireDate=2013-03-11%2012:01:05&MemberPasswordExpireDate=2013-03-11%2012:01:05&MemberLastLogon=2013-03-11%2012:01:05&MemberOption=0&MemberStatus=0&MemberMessageCount=0&MemberMessageOption=0&MemberPostsPerPage=10&MemberWarnCount=0&MemberVoteCount=0&MemberVoteTotalStars=0&MemberRewardPoints=0&MemberTitle=&MemberTimeZone=0&MemberSignature=&MemberAvatar=&MemberSkin=&MemberLanguage=&MemberFirstname=YourFristName&MemberLastname=YourLastName&MemberGender=1&MemberBirthday=1999-01-01&MemberAddress=&MemberCity=&MemberState=&MemberCountry=&MemberPhone=&MemberMobile=&MemberFax=&MemberCareer=&MemberHomepage=http://&MemberYahoo=&MemberAol=&MemberIcq=&MemberMsn=&MemberCoolLink1=http://&MemberCoolLink2=http://&MemberEmailConfirm="+$("#userId").val()+"@163.com&day=02&month=03&year=1999", false );
// 	    xmlHttp.send( null );
		actSubmitValidate($('#formDetail'),
				'<c:url value="/basicInfor/userManage/user!saveInspector.action"/>');
	}

	//验证是否userId是否重复
	function fncCheckUserRepeat() {
		var userId = $("#userId").val();
		if (userId == "")
			return;

		$
				.ajax({
					type : "POST",
					url : '<c:url value="/basicInfor/userManage/user!checkUserId.action"/>',
					data : "userId=" + userId,
					async : false,
					success : function(flag) {
						if (flag == "false") {
							alert("用户ID（" + userId + "）已注册 ,不能使用！");
							$("#userId").val("").focus();
							return false;
						} else
							return true;
					}
				});
	}

	//控制备注字符输入
	var textarea_maxlen = {
		isMax : function() {
			var textarea = document.getElementById("area");
			var max_length = textarea.maxlength;
			if (textarea.value.length > max_length) {
				textarea.value = textarea.value.substring(0, max_length);
			}
		},
		disabledRightMouse : function() {
			document.oncontextmenu = function() {
				return false;
			}
		},
		enabledRightMouse : function() {
			document.oncontextmenu = null;
		}
	};
	function cfIsNull(value) {
		if ($.trim(value) == "") {
			return true;
		}
		return false;
	}
	function onRoleChanged(role) {
		var value = document.getElementById('authId').value;
		if (value == '1000076') {
			$('#dept').css("display", "block");
		} else {
			$('#dept').css("display", "none");
		}
	}
</script>
</head>

<body>
	<div id="Lcontent">
		<!-- <SSTag:navigation />-->
		<div id="LpageTitleArea">
			<h1>质检员管理</h1>
			<div>
				<a href="#">Home</a> &gt; <a href="#">基本信息管理</a> &gt; <a
					href="/CarPhone/basicInfor/newsinfoManage/newsinfo.action?selectMenuId=1110"
					id="Lhere">质检员信息</a>
			</div>
		</div>
		<form id="formDetail" method="post">
			<input type="hidden" name="operateModel" value="create" />
			<table class="LDetailArea" summary="User information.">
				<tr>
					<th><font color="red">*</font><span>用户ID</span></th>
					<td><input type="text" id="userId" name="userId" size="20"
						class="Lbordercolor" onblur="fncCheckUserRepeat();" value=""
						validate="{required:true,maxlength:20,userid:true}" /></td>
					<th><font color="red">*</font><span>用户名</span></th>
					<td><input type="text" id="userName" name="userName"
						class="Lbordercolor" value=""
						validate="{required:true,maxlength:20}" /></td>
				</tr>
				<tr>
					<th>固定电话</th>
					<td><input type="text" name="phoneNo" class="Lbordercolor"
						value="" validate="{phone:true,maxlength:20}" /></td>
					<th>移动电话</th>
					<td><input type="text" name="mobileNo" class="Lbordercolor"
						value="" maxlength="20" validate="{mobile:true,maxlength:20}" /></td>
				</tr>
				<tr>
					<th>传真</th>
					<td><input type="text" name="faxNo" class="Lbordercolor"
						value="" maxlength="20" validate="{phone:true,maxlength:20}" /></td>
					<th><font color="red">*</font>密码</th>
					<td><input type="password" id="password" name="password"
						class="Lbordercolor" value="" maxlength="20"
						validate="{required:true,pwd:true,maxlength:20}" /></td>
				</tr>
				<tr>
					<th>电子邮件</th>
					<td><input type="text" name="email" style="width: 250px"
						class="Lbordercolor" value="" maxlength="50"
						validate="{email:true,maxlength:50}" /></td>
					<th>状态</th>
					<td><select name="useFlag">
							<option value="Y" selected>可用</option>
							<option value="N">禁用</option>
					</select></td>
				</tr>
				<tr>
					<th>住址</th>
					<td colspan="3"><input type="text" name="address"
						style="width: 500px" class="Lbordercolor" value="" maxlength="200"
						validate="{maxlength:200}" /></td>
				</tr>
				<tr>
					<th>备注</th>
					<td colspan="3"><textarea id="area" rows="3"
							style="width: 500px" name="notes" maxlength="500"
							validate="{maxlength:500}" onkeyup="textarea_maxlen.isMax()"
							onfocus="textarea_maxlen.disabledRightMouse()"
							onblur="textarea_maxlen.enabledRightMouse()"></textarea></td>
				</tr>
			<tr>
      			<th><span>部门</span></th>
      			<td>
      				<s:select name="department" id="department" list="codeGroupList" listKey="code" listValue="value" value="userInfo.deptId" theme="simple" />        			       			
				</td>
    		</tr>
			</table>
			<br> <label>用户权限:</label>
			<table class="LDetailNoWidth">
				<colgroup>
					<col width="15%" />
					<col width="85%" />
				</colgroup>
				<tr>
					<th>角色</th>
					<td><s:select name="authId" id="authId" list="codeAuthList"
							listKey="code" listValue="value" value="" headerKey="-1"
							headerValue="---请选择---" theme="simple"  />
					</td>
				</tr>

			</table>
		</form>
		<fieldset>
			<legend>Button</legend>
			<ul class="LbtnArea">
				<li><input type="button" value="保存" onclick="fncSave()"
					id="btnSave" objType="bSave" /> <input type="button" value="取消"
					onclick="fncCancel()" id="btnCancel" objType="bCancel" /></li>
			</ul>
		</fieldset>
	</div>
</body>
</html>


