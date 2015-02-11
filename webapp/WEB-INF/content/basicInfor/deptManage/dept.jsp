<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--
/**
 * ------------------------------------------------------------------------
 * @source  : dept.jsp
 * @desc    : 部门管理页面
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
		$('#deptId').val(obj);		
		actSubmit($('#formPage'),'<c:url value="/basicInfor/deptManage/dept!updateInput.action"/>');
	}
	
	//进入新增页面
	function fncAdd() {
		actSubmit($('#formPage'),'<c:url value="/basicInfor/deptManage/dept!createInput.action"/>');
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
				  action="<c:url value="/basicInfor/deptManage/dept.action"/>" onEnter="this.submit()">
					<input type="hidden" id="userId" name="userId" value=""/>
					<div>
					<ul>
						<li>
							<label for="userName" style="width:42px">负责人:</label> 
							<input type="text" name="queryDeptManager" class="Lbordercolor"
							value="${data.queryDeptManager}" size="13" style="margin-right: 10px;"/>
							<label for="deptId" style="width:76px">数据权限类型:</label>						
		        			<s:select name="queryDeptType" id="queryDeptType" list="deptTypeList" listKey="code" listValue="value" value="data.queryDeptType" style="width:96px;margin-right: 10px;" theme="simple" /> 
							
						</li>
					</ul>
				</div>
					<input id="LsearchIcon" type="image" src="${ctx}/images/btn_search_e_g.gif" alt="Search" />
				</p>
			</form>
		</div>

		<!-- END sbox --> <!--AREA [View]-->
		<form id="formPage" method="post" action="<c:url value="/basicInfor/deptManage/dept.action"/>">
		           <input type="hidden" name="deptId" id="deptId" value=""/>	
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
							<th><a href="javascript:sort('d.dept_id','asc')">编号</th>
							<th nowrap><a href="javascript:sort('d.dept_name','asc')">数据权限名称</th>
							<th nowrap><a href="javascript:sort('c.code_value1','asc')">数据权限类型</th>
							<th><a href="javascript:sort('d.dept_manager','asc')">负责人</th>
							<th><a href="javascript:sort('d.dept_tel','asc')">负责人电话</th>
							<th><a href="javascript:sort('d.dept_address','asc')">负责人地址</th>
							
						</tr>
						<s:iterator value="page.result" status="st">						
							<tr onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
								onClick="fncDetail('${deptId}')">
								<td width="30px"><c:out value="${st.index+1}" /></td>
								<td width="100px">${deptId}</td>
								<td width="70px">${deptName}</td>
								<td width="70px">${deptTypeName}</td>
								<td width="70px">${user_name}</td>
								<td width="70px">${deptTel}</td>
								<td  style="text-align: left">${deptAddress}</td>
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
			<!-- 滚动条设置-start -->
			<c:if test="${!empty page.result}">
			<script>
				document.getElementById("resultDiv").style.width=document.getElementById("formSearch").clientWidth;
			</script>
			</c:if>
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