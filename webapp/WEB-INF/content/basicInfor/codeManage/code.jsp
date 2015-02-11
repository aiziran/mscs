<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%--
/**
 * ------------------------------------------------------------------------
 * @source  : code.jsp
 * @desc    : 公共代码管理
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
	<title>组代码管理</title>
	<%@ include file="/common/header.jsp" %>
<script language="javascript">	

	// 查询代码list
	   function fncSearch() {
        actSubmit($("#formSearch"), "<c:url value='/basicInfor/codeManage/code.action'/>");      
    } 
	
	// 新增共同代码
	function fncAdd()  {
	  	$('#mode').val("create");
	  	actSubmit($('#formSearch'), "<c:url value="/basicInfor/codeManage/code!createInput.action"/>");
	}

	//($("#formSearch")
	
	// 转到更改组代码页面
	function fncSearchDetail(codeId,codeGroup)  {	
		$('#mode').val("update");
		$('#codeGroup').val(codeGroup);
		$('#codeId').val(codeId);
		actSubmit($('#formSearch'), "<c:url value="/basicInfor/codeManage/code!updateInput.action"/>");
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
			<form name="formSearch" id="formSearch" method="post" class="enterhandler" onEnter="fncSearch()" action="/basicInfor/codeManage/code.action	">
			<input type="hidden" name="mode" id="mode" value=""/>
			<input type="hidden" name="codeGroup" id="codeGroup" value=""/>
			<input type="hidden" name="codeId" id="codeId" value=""/>
			<div>
				<ul>
					<li>
					    <label for="LskillSearch">代码组:</label> 																																				
						<s:select name="queryCodeGroup" id="queryCodeGroup" list="codeGroupList" listKey="code" listValue="value" value="data.queryCodeGroup"  style="width:96px;margin-right: 10px;" theme="simple" headerKey="-1" headerValue="全部"/> 			
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
		<form name="formPage" method="post"
			action="<c:url value="/basicInfor/codeManage/code.action"/>">
				<!-- 滚动条设置 -->
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
				<!-- 滚动条设置-end -->
					<tr>
						<th>代码组</th>
						<th>代码</th>
						<th>代码描述</th>
						<th>代码排序</th>
						<th>状态</th>
					</tr>
					<c:forEach items="${page.result}" var="cdata" varStatus="inx">
						<c:set var="index" value="${inx.index}" />
						<tr onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
							style="cursor: hand;"
							onclick="fncSearchDetail('<c:out value="${cdata.codeId}"/>','<c:out value="${cdata.codeGroup}"/>')">
							<td  style="text-align: left"><c:out value="${cdata.codeGroupName}" /></td>
							<td  style="text-align: left"><c:out value="${cdata.codeId}" /></td>
							<td  style="text-align: left"><c:out value="${cdata.codeDesc}" /></td>
							<td align="center"><c:out value="${cdata.codeOrder}" /></td>
							<c:choose>
								<c:when test="${cdata.useFlag=='Y'}">
									<td align="center">可用</td>
								</c:when>
								<c:when test="${cdata.useFlag=='N'}">
									<td align="center">禁用</td>
								</c:when>
							</c:choose>
						</tr>
					</c:forEach>
				<!-- 滚动条设置 -->
				<c:if test="${!empty page.result}">
					</table>
					</div>
					<table class="LlistArea">
				</c:if>
				<!-- 滚动条设置-end -->
					<tr>
						<td colspan="5" class="AreaLeft">
							<%@ include file="/common/page.jsp" %>
						</td>
					</tr>
				</table>
		</form>
		<fieldset>
		<ul class="LbtnArea">
			<li><input type="button" value="新增" onclick="fncAdd()"
				onkeypress="fncAdd()" id="btnAdd" objType="bCreate" /></li>
		</ul>
		</fieldset>
	</div>
</body>
</html>