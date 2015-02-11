<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--
/**
 * ------------------------------------------------------------------------
 * @source  : code-group.jsp
 * @desc    : 组代码管理
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2011.12.18   SSQ                 初次建立
 * ------------------------------------------------------------------------ 
 */
-->
<%@ include file="/common/taglibs.jsp" %>
<html>
<head>
	<title>组代码管理</title>
	<%@ include file="/common/header.jsp" %>
<script language="javascript">
	// 查询组代码list
    function fncSearch() {
        actSubmit($("#formSearch"), "<c:url value='/basicInfor/codeGroupManage/code-group.action'/>");      
    } 
    
    // 新增组代码
	function fncCreate()  {
	  	$('#txtMode').val("create");
	  	actSubmit($('#formSearch'), "<c:url value="/basicInfor/codeGroupManage/code-group!createInput.action"/>");
	}
	
	// 更改组代码
	function fncDetail(codeGroup)  {
		$('#txtMode').val("update");
		$('#txtCodeGroup').val(codeGroup);
		actSubmit($('#formSearch'), "<c:url value="/basicInfor/codeGroupManage/code-group!updateInput.action"/>");
	}
	
	// 固定表头
    function fncFixupListHead(){  
	    var tab = document.getElementById("listTab");
		if(tab) fixupFirstRow(tab);
		
		if (tab.rows.length < 12) {
			if (document.getElementById("resultDiv"))
				document.getElementById("resultDiv").style.height = "";
		}
  	}
</script>
</head>

<body onLoad="fncFixupListHead();">
	<div id="Lcontent">		
		<SSTag:navigation/>
		<div id="LsearchArea">
			<form name="formSearch" id="formSearch" method="post" class="enterhandler" style="width: 1000px;" onEnter="fncSearch()" action="">
				 <input type="hidden" name="mode" value="create" id="txtMode">
				 <input	type="hidden" name="codeGroup" id="txtCodeGroup">
				 <input	type="hidden" name="codeGroupName" id="txtCodeGroupName">
				<div>
				<ul>
					<li><label for="LskillSearch">组名称:</label> 
						<input name="queryGroupName" id="txtQueryGroupName" type="text"
						class="Lbordercolor" value="<c:out value="${data.queryGroupName}"/>"/>
						
					</li>
				</ul>
				</div>
				<p>
					<a href="#" target="_self" onclick="fncSearch(); return false;">
						<img src="${ctx}/images/btn_search_e_g.gif" alt="查询" id="LsearchIcon" border="0">
					</a>
				</p>
			</form>
		</div>
		<form name="formPage" method="post" action="<c:url value='/basicInfor/codeGroupManage/code-group.action'/>">
			<input type="hidden" name="queryGroupName" value="${data.queryGroupName}"/>
			
				<c:if test="${!empty page.result}">
					<div id="resultDiv" style="width: 1000px; overflow-x: auto;overflow-y:scroll;height:280px;">
					<table class="LlistArea" id="listTab">
					<script>
						document.getElementById("resultDiv").style.width=document.getElementById("formSearch").clientWidth;
					</script>
				</c:if>
				<c:if test="${empty page.result}">
					<table class="LlistArea" id="listTab">
				</c:if>
				<tr>
					<th ><a href="javascript:sort('code_group','asc')">组代码</th>
					<th><a href="javascript:sort('code_group','asc')">组名称</th>
					<th><a href="javascript:sort('code_goup','asc')">组描述</th>
					<th><a href="javascript:sort('code_group','asc')">状态</th>
				</tr>
				<s:iterator value="page.result" status="st">
					<tr onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"	onClick="fncDetail('${codeGroup}')">
						<td width="10%">${codeGroup}</td>
						<td>${codeGroupName}</td>
						<td>${codeGroupDesc}</td>
						<td>
							<c:if test="${useFlag=='Y'}">可用</c:if>
							<c:if test="${useFlag=='N'}">禁用</c:if>
						</td>
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
						<td colspan="4" class="AreaLeft">
							<%@ include file="/common/page.jsp" %>
						</td>
					</tr>
				</table>
			</form>
				<fieldset>
					<ul class="LbtnArea" style="margin-right: 20px;">
						<li><input type="button" value="新增" onclick="fncCreate()"	onkeypress="fnCreate()" id="btnCreate" objType="bCreate" /></li>
					</ul>
				</fieldset>
				</div>
</body>
</html>