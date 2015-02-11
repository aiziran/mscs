<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%--
/**
 * ------------------------------------------------------------------------
 * @source  : role.jsp
 * @desc    : 角色信息管理-配置菜单权限
 */
--%>

<%@ include file="/common/taglibs.jsp" %>
<html>
<head>
<title>角色信息管理</title>
<%@ include file="/common/header.jsp" %>
<script type="text/javascript" src="${ctx}/js/dtree.js"></script>
<script type="text/javascript" language="javascript">	

  // 初始化页面时显示所选菜单的详细
  function fncLoadMenu() {
  	if($('#formDetail :input[name=menuId]').val()!=''){
		fncDetail($('#formDetail :input[name=menuId]').val(),$('#formDetail :input[name=menuName]').val());
	} else {
		treeMenu.clearCookie();
	}
  }

  // 点击左边树时右边form显示所选菜单的详细内容
  function fncDetail(menuId, menuName) {
	$('#formDetail :input[name=menuName]').val(menuName);
	$('#formDetail :input[name=menuId]').val(menuId);
	$('[name=chkCodeId]:checkbox').attr('checked',false);
	
	$.get("<c:url value="/basicInfor/roleManage/role!retrieveMenuBtn.action"/>",
			{menuId:menuId,
			authCode:$('#formDetail :input[name=authCode]').val()},
			function(xml,status){
				var checkid="";
				$(xml).find("key").each(function(i){						
					if($(this).attr("id")=='useFlag'){
						$(':radio[name=useFlag][value='+$(this).text()+']').attr("checked",true);
					}if($(this).attr("id")=='codeId'){	
						$(':checkbox[name=chkCodeId][value='+$(this).text()+']').attr("checked",true);			
					}
				})
				
			},
			"xml"
	);	
   
  }
  
  // 保存菜单权限和按钮权限
  function fncSave() {
	if($('#formDetail :input[name=menuName]').val()=='') {
   		alert("请选择维护的菜单！");
   		return false;
   	}
	if($('#formDetail :input[name=authCode]').val()=='') {
   		alert("因系统原因遗失当前用户权限，请返回列表页重新点击配置按钮进行配置！");
   		return false;
   	}
	if($('#formDetail :input[name=menuId]').val()=='') {
   		alert("请重新选择要维护的菜单！");
   		return false;
   	}
   	
   	if(!confirm("确定要保存吗？")) {
   		return false;
   	}
   	
   	$.get("<c:url value="/basicInfor/roleManage/role!saveAuthMenuDo.action"/>",
   			$('#formDetail').serialize(),
			function(xml,status){
   				actSubmit($('#formDetail'), "<c:url value="/basicInfor/roleManage/role!config.action"/>");
			}
	);	
  }
  
  // 检验所给的值是否为空
  function fncValidate(varValue) {
	if (varValue.trim() == "" || varValue == null) {
		return false;
	} else {
		return true;
	}
  }
  
  // 点击取消按钮时所做的事件
  function fncCancel() {
  	if(!confirm("是否要取消当前编辑？")) {
   		return;
   	}
  	actSubmit($('#formHidden'), "<c:url value="/basicInfor/roleManage/role.action"/>");
  }

</script>
</head>

<body onload="fncLoadMenu()">
	<div id="Lcontent">
		<SSTag:navigation/>
		当前角色：<c:out value="${data.roleName}" /> <%-- Tree Content Area Start --%>
		<div class="table_layout"
			style="width: 35%; height: 479; float: left; border: 1px solid #B9B9B9; overflow: auto; background-color: #FFFFFF;">
			<div class="dtree">
				<script type="text/javascript" language="javascript">
		             treeMenu = new dTree('treeMenu','${ctx}');	             
		             <c:if test="${data.menuId == null }">
		             	treeMenu.clearCookie();
		             </c:if>
		             <c:forEach items="${menuList.menuId}" varStatus="inx">
		               	var treeName = "<span style='cursor:hand'><c:out value="${menuList.menuName[inx.index]}"/></span>";
		               	var treeUrl = "javascript:fncDetail('<c:out value="${menuList.menuId[inx.index]}"/>','<c:out value="${menuList.menuName[inx.index]}"/>');";                    
		               	var treeIcon = "";
		               	var treeIconOpen = ""; 
		               	<c:choose>
		                 <c:when test="${ inx.index > 0 }">
		               		treeMenu.add(<c:out value="${menuList.menuId[inx.index]}"/>, <c:out value="${menuList.prntMenuId[inx.index]}"/>, treeName, treeUrl, "", "", treeIcon, treeIconOpen);
		                 </c:when>
		                 <c:when test="${ inx.index == 0 }">
		               		treeMenu.add(<c:out value="${menuList.menuId[inx.index]}"/>, <c:out value="${menuList.prntMenuId[inx.index]}"/>, treeName);
		                 </c:when>
		                </c:choose>
		           	 </c:forEach>
		             document.write(treeMenu);
				</script>
			</div>
		</div>
		<%-- Tree Content Area End --%>
		<div style="width: 600px;float:left">
			<form name="formHidden" id="formHidden">
				<input type="hidden" name="queryRoleName" value="<c:out value="${data.queryRoleName}"/>" id="queryRoleName">
				<input type="hidden" name="selShowpageNO" value="<c:out value="${data.selShowpageNO}"/>">
			</form>
			<form id="formDetail" name="formDetail" method="post" action="">
				<input type="hidden" name="queryRoleName" value="<c:out value="${data.queryRoleName}"/>" id="queryRoleName">
				<input type="hidden" name="menuId" id="menuId" value="<c:out value="${data.menuId}"/>"> 
				<input type="hidden" name="roleName" value="<c:out value="${data.roleName}"/>" id="roleName"> 
				<input type="hidden" name="roleId" value="<c:out value="${data.roleId}"/>" id="roleId"> 
				<input type="hidden" name="authCode" value="<c:out value="${data.roleId}"/>" id="authCode">
				<input type="hidden" name="selShowpageNO" value="<c:out value="${data.selShowpageNO}"/>">
			<table class="LDetailArea" summary="message information table">
				<tr>
					<th><font color="red">*</font>菜单名</th>
					<td><input type="text" name="menuName" id="menuName" style="background-color:#EEFFB6"
						size="60%" class="Lbordercolor" value="<c:out value="${data.menuName}"/>" readonly required /></td>
				</tr>
				<tr>
					<th>菜单权限</th>
					<td>
						<input type="radio" name="useFlag" id="useFlag" value="Y" checked />使用 
						<input type="radio" name="useFlag" id="useFlag"	value="N" />不使用
					</td>
				</tr>
				<tr>
					<th>按钮权限</th>
					<td>
					<c:forEach items="${btnCodeList.codeId}" varStatus="inx">
						<c:set var="index" value="${inx.index}" />
						<input type="checkbox" name="chkCodeId" id="chkCodeId" value="<c:out value="${btnCodeList.codeId[inx.index]}"/>" />
						<c:out value="${btnCodeList.codeDesc[inx.index]}" />
					</c:forEach></td>
				</tr>
			</table>
			</form>
			<fieldset><legend>Button</legend>
			<ul class="LbtnArea">
				<li><input type="button" value="保存" onclick="fncSave()"	onkeypress="fncSave()" id="btnSave" objType="bSave" /> 
					<input type="button" value="返回" onclick="fncCancel()"	onkeypress="fncCancel()" id="btnCancel" objType="bCancel" />
				</li>
			</ul>
			</fieldset>
		</div>
	</div>
	<div id="poppy"></div>
</body>
</html>