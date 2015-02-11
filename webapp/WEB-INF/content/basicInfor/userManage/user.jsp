<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--
/**
 * ------------------------------------------------------------------------
 * @source  : user.jsp
 * @desc    : 用户管理页面
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
	<title>页面</title>
	<%@ include file="/common/header.jsp" %>
	<script type="text/javascript" language="javascript">
	//进入修改页面
	function fncDetail(obj) {
		$('#detailUserId').val(obj);		
		actSubmit($('#formPage'),'<c:url value="/basicInfor/userManage/user!updateInput.action"/>');
	}
	
	//进入新增页面
	function fncAdd() {
		actSubmit($('#formPage'),'<c:url value="/basicInfor/userManage/user!createInput.action"/>');
	}
	
	 
	// 固定表头
    function fncFixupListHead(){  
	    var tab = document.getElementById("listTab");
		if(tab) fixupFirstRow(tab);
		
		if (tab.rows.length < 12) {
			if (document.getElementById("resultDiv")) {
				document.getElementById("resultDiv").style.height = "";
			}
		}
  	}
	</script>
</head>

<body onload="fncFixupListHead();">
	<div id="Lcontent">
		<SSTag:navigation/>
		<div id="LsearchArea">
			<form id="formSearch" name="formSearch" method="post" class="enterhandler" style="width: 1000px;"
				  action="<c:url value="/basicInfor/userManage/user.action"/>" onEnter="this.submit()">					
					<div>
					<ul>
						<li>
							<label for="userId" style="width:42px">用户ID:</label> 
							<input type="text" name="queryUserId" class="Lbordercolor" 
								   value="${data.queryUserId}" size="13" style="margin-right: 10px;"/>
							<label for="userName" style="width:42px">用户名:</label> 
							<input type="text" name="queryUserName" class="Lbordercolor"
							value="${data.queryUserName}" size="13" style="margin-right: 10px;"/>
							<!--  
							<label for="deptId" style="width:28px">单位:</label>						
		        			<s:select name="queryDepartment" id="queryDepartment" list="codeGroupList" listKey="code" listValue="value" 
		        				value="data.queryDepartment"  style="width:96px;margin-right: 10px;" theme="simple" /> 
		        			-->
							<label for="roleName" style="width:55px">角色名称:</label> 
							<input type="text" id="queryRoleName" name="queryRoleName" class="Lbordercolor" size="13"
								value="${data.queryRoleName}"/>
						</li>
					</ul>
				</div>
				<p>
					<input id="LsearchIcon" type="image" src="${ctx}/images/btn_search_e_g.gif" alt="Search" />
				</p>
			</form>
		</div>
		<!-- END sbox --> <!--AREA [View]-->
		<form id="formPage" method="post" action="<c:url value="/basicInfor/userManage/user.action"/>">	
			<input type="hidden" name="detailUserId" id="detailUserId" />		
					<!-- 滚动条设置 -->
 					<c:if test="${!empty page.result}">
						<div id="resultDiv" style="width: 1000px;overflow-x:scroll;<c:if test="${page.pageSize >10}">overflow-y:scroll;height:280px;</c:if>">
						<table class="LlistArea" id="listTab" style="width: 1400px;">
					</c:if>
					<c:if test="${empty page.result}">
						<table class="LlistArea" id="listTab">
					</c:if>
					<!-- 滚动条设置-end -->
						<tr>
							<th>序号</th>
							<th><a href="javascript:sort('u.user_id','asc')">用户ID</a></th>
							<th><a href="javascript:sort('user_name','asc')">用户名</a></th>
							<th><a href="javascript:sort('dept_name','asc')">数据权限</a></th>
							<th><a href="javascript:sort('r.role_name','asc')">角色名</a></th>
							<th>电子邮件</th>
							<th>状态</th>
							<th>固定电话</th>
							<th>移动电话</th>
							<th>传真</th>
							<th>住址</th>
						</tr>
						<s:iterator value="page.result" status="st">						
							<tr onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
								onClick="fncDetail('${userId}')">
								<td width="5%"><c:out value="${st.index+1+(page.pageNo-1)*page.pageSize}" /></td>
								<td>${userId}</td>
								<td width="10%">${userName}</td>
								<td width="10%">${deptName}</td>

								<td>${roleName}</td>
								<td>${email}</td>
								<td>
									<c:if test="${useFlag == 'Y'}">可用</c:if>
									<c:if test="${useFlag == 'N'}">禁用</c:if>
								</td>
								<td>${phoneNo}</td>
								<td>${mobileNo}</td>
								<td>${faxNo}</td>
								<td  style="text-align: left">${address}</td>
							</tr>
						</s:iterator>
						<!-- 滚动条设置 -->	
						<c:if test="${!empty page.result}">
							</table>
							</div>
							<table >
						</c:if>
						<!-- 滚动条设置-end -->
						<tr>
							<td colspan="20" class="AreaLeft"><!-- LPAGE JavaScript Start --> 
								<%@ include file="/common/page.jsp" %>														
							</td>
						</tr>
					</table>
	
			</form>
			<!-- 滚动条设置-end -->
			<fieldset>
				<legend>Button</legend>
				<ul class="LbtnArea" style="margin-right: 20px;">
					<li>
						<input type="button" value="新增" onclick="fncAdd()" id="btnAdd" objType="bCreate"/>
					</li>
				</ul>
			</fieldset>
		<br/>
	</div>
	
<!-- END content -->
</body>
</html>