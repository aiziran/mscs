<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%--
/**
 * ------------------------------------------------------------------------
 * @source  : role.jsp
 * @desc    : 角色信息管理
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2011.05.08        曹圣泉		                    初次建立
 * ------------------------------------------------------------------------ 
 */
--%>

<%@ include file="/common/taglibs.jsp" %>
<html>
<head>
<title>角色信息管理</title>
<%@ include file="/common/header.jsp" %>
<script type="text/javascript" language="javascript">	
  	var mode="create";
  	var selNo = "";  	
  	
  	//点击table时在下面的form中显示所选角色的详细信息
  	function fncDetail(roleId, roleName, roleDesc, roleNotes) {
    	$('#formDetail #roleId').val(roleId);
    	$('#formDetail #roleName').val(roleName);
    	$('#formDetail #roleDesc').val(roleDesc); 
    	$('#formDetail #roleNotes').val(roleNotes);
    	
    	mode = "update";
  	}
	
 	// 初始化角色信息
  	function fncAdd() {
    	$('#formDetail')[0].reset();
    	mode = "create";
    	$('#formDetail  #roleName').focus();
  	}
  	
  	// 检验所选角色是否是关联角色,点击删除按钮时执行的校验
  	function fncValidateRole() {
    	if($('#formDetail #roleId').val()=='') {
    		alert("请选择角色！");
    		return false;
    	}    	
    	if(!confirm("确定要删除吗？")) {
    		return false;
    	}

    	$.get("<c:url value="/basicInfor/roleManage/role!checkDel.action"/>",
				{roleId:$('#formDetail #roleId').val()},
				function(xml,status){
					if(xml=='ok')
						fncDelete($('#formDetail #roleId').val());
					else 
						alert(xml);
				},
				"text"
		);
 	}
 	
 	// 删除角色信息
 	function fncDelete(roleId) { 	
 		$('#formPage #delRoleId').val(roleId);
 		actSubmit($('#formPage'), "<c:url value="/basicInfor/roleManage/role!deleteDo.action"/>");
 	}
    
    // 检验角色名称是否已存在，点击保存按钮时执行的校验
  	function fncValidateRoleName() {
    	if($('#formDetail #roleName').val()==''){
    		alert("角色名称不能为空，请确认");
    		return false;
    	}
    	if(!confirm("确定要保存吗？")) {
    		return false;
    	}
  		$.get("<c:url value="/basicInfor/roleManage/role!checkRoleName.action"/>",
				{roleName:$('#formDetail #roleName').val(),
  				 roleDesc:$('#formDetail #roleDesc').val(),
  				 roleNotes:$('#formDetail #roleNotes').val(),
  				   roleId:$('#formDetail #roleId').val()==''?'--':$('#formDetail #roleId').val()},
				function(xml,status){
					if(xml=='ok')
						$('#formSearch').submit();
					else 
						alert(xml);
				},
				"text"
		);
 	}
 	//配置菜单权限
    function fncConfig(){
    	if($('#formDetail #roleId').val()=='') {
    		alert("请选择角色！");
    		return false;
    	}else
    	actSubmit($('#formDetail'), "<c:url value="/basicInfor/roleManage/role!config.action"/>");
    }	
  	  	
  	// 固定表头
    function fncFixupListHead(){  
	    var tab = $('#listTab');

			if(tab.length>0){ 
				fixupFirstRow(tab[0]);
			
			selNo = "<c:out value="${data.selShowpageNO}"/>";
			if($('#listTab tr').length> 1) {
				$('#listTab tr:eq(1)').click();
			}
			
			if ($('#listTab tr').length < 12) {
				if (document.getElementById("resultDiv"))
					document.getElementById("resultDiv").style.height = "";
			}
		}
  	}

</script>
</head>

<body onLoad="fncFixupListHead();">
<!-- ******************** PAGE BLOCK: CONTENT ******************** -->
	<div id="Lcontent"><!--AREA search-->
		<SSTag:navigation/>
		<div id="LsearchArea">
			<form id="formSearch" name="formSearch" method="post" style="width: 1000px;"
				class="enterhandler"  action="<c:url value="/basicInfor/roleManage/role.action"/>">
				<div>
					<ul>
						<li>
							<label for="LskillSearch">角色名称:</label> 
							<input type="text" id="queryRoleName" name="queryRoleName" class="Lbordercolor"
								value="<c:out value="${data.queryRoleName}"/>"/>
						</li>
					</ul>
				</div>
				<p>
					<input id="LsearchIcon" type="image" src="${ctx}/images/btn_search_e_g.gif" alt="Search" />
				</p>
			</form>
		</div>
		<!--END box--> <!--AREA [View]-->
		<form id="formPage" method="post" action="<c:url value="/basicInfor/roleManage/role.action"/>">
				<input type="hidden" id="delRoleId" name="delRoleId" value=""/>
 				<div id="resultDiv" style="width: 765px;<c:if test="${page.pageSize >10}">overflow-y:scroll;height:280px;</c:if>">
 				<script>
						document.getElementById("resultDiv").style.width=document.getElementById("formSearch").clientWidth;
					</script>
					<table class="LlistArea" id="listTab" >
				<tr>
					<th>序号</th>
					<th><a href="javascript:sort('role_id','asc')">角色编码</th>
					<th><a href="javascript:sort('role_name','asc')">角色名称</th>
					<th><a href="javascript:sort('create_date','asc')">创建时间</th>
				</tr>
				<s:iterator value="page.result" status="st">	
					<tr style="cursor: hand;"
						onClick="fncDetail('${roleId}', '${roleName}', '${roleDesc}', '${roleNotes}');">
						<td><c:out value="${st.index+1}" /></td>
						<td><c:out value="${roleId}" /></td>
						<td><c:out value="${roleName}" /></td>
						<td><c:out value="${createDate}" /></td>
					</tr>
				</s:iterator>
				<!-- 滚动条设置 -->	
				<c:if test="${!empty page.result}">
					</table>
					</div>
					<table  style="margin-left: -2px;">
				</c:if>
				<!-- 滚动条设置-end -->
				<tr>
					<td colspan="4" class="AreaLeft">
						<%@ include file="/common/page.jsp" %>
					</td>
				</tr>
			</table>
		</form>
		<br/>
		<form id="formDetail" method="post" style="width: 1000px;">
			<input type="hidden" name="queryRoleName" id="queryRoleName" value="${data.queryRoleName}">
			<input type="hidden" name="selShowpageNO" value="10">
			<table class="LDetailArea" summary="Menu and Auth.">
				<tr>
					<th>角色编码</th>
					<td>
						<input type="text" id="roleId" name="roleId" value="" readOnly
							class="Lbordercolor" style="background-color:#EEFFB6"  validate="{required:true}" />
					</td>
					<th><font color="red">*</font>角色名称</th>
					<td>
						<input type="text" id="roleName" name="roleName"
							class="Lbordercolor" maxlength="150" validate="{required:true,maxlength:150}" />
					</td>
				</tr>
				<tr>
					<th>描述</th>
					<td colspan="3">
						<input type="text" id="roleDesc"  maxlength="150"
							name="roleDesc" class="Lbordercolor" size="67%"  validate="{maxlength:150}" />
					</td>
				</tr>
				<tr>
					<th>备注</th>
					<td colspan="3">
						<input type="text" id="roleNotes" maxlength="150" 
							name="roleNotes" class="Lbordercolor" size="67%" validate="{maxlength:150}"/>
					</td>
				</tr>
			</table>
		</form>
		<fieldset><legend>Button</legend>
			<ul class="LbtnArea" style="margin-right: 20px;">
				<li><input type="button" value="配置" onclick="fncConfig()"	onkeypress="fncConfig()" id="btnConfig" objType="bUpdate" /> 
					<input type="button" value="新增" onclick="fncAdd()" onkeypress="fncAdd()" 	id="btnAdd" objType="bCreate" /> 
					<input type="button" value="删除" onclick="fncValidateRole()" onkeypress="fncValidateRole()" id="btnDelete" objType="bDelete" /> 
					<input type="button" value="保存" onclick="fncValidateRoleName()" onkeypress="fncValidateRoleName()" id="btnSave" objType="bSave" />
				</li>
			</ul>
		</fieldset>
	</div>
</body>
</html>