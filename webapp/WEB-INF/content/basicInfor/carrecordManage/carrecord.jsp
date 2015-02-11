<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp" %>
<html>
<head>
	<title>车辆基本信息</title>
	<%@ include file="/common/header.jsp" %>
	<script type="text/javascript" language="javascript">
	//进入修改页面
	function fncDetail(obj) {
		$('#id').val(obj);		
		actSubmit($('#formPage'),'<c:url value="carrecord!SelectOne.action"/>');
	}
	
	//进入新增页面
	function fncAdd() {
		actSubmit($('#formPage'),'<c:url value="carrecord!create.action"/>');
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
		<form id="formPage" method="post">	
			<input type="hidden" name="id" id="id" />		
			<!-- 滚动条设置 -->
		<c:if test="${!empty page.result}">
			<div id="resultDiv"
				style="width: 1000px;overflow-x:scroll;<c:if test="${page.pageSize >10}">overflow-y:scroll;height:280px;</c:if>">
				<table class="LlistArea" id="listTab" style="width: 1000px;">
					</c:if>
					<c:if test="${empty page.result}">
						<table class="LlistArea" id="listTab">
							</c:if>
							<tr>
							<th>车辆名称</th>
							<th>车牌号码</th>
							<th>借出申请人</th>
							<th>借用时间</th>
							<th>审批人</th>
							<th>审批状态</th>
						</tr>
							<s:iterator value="page.result" status="st">
								<tr >
								<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
									onClick="fncDetail('${id}')">${carname}</td>
								<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
									onClick="fncDetail('${id}')">${carframeid}</td>
								<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
									onClick="fncDetail('${id}')">${lender}</td>
								<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
									onClick="fncDetail('${id}')">${lendtime}</td>
								<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
									onClick="fncDetail('${id}')">${approver}</td>
								<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
									onClick="fncDetail('${id}')">${status}</td>
							</tr>
							</s:iterator>
							
			
							
							<!-- 滚动条设置 -->
							<c:if test="${!empty page.result}">
						</table>
						</div>
						<table class="LlistArea" style="width: 1000px;">
							</c:if>
							<!-- 滚动条设置-end -->
							<tr>
								<td colspan="20" class="AreaLeft">
								<%@ include file="/common/page.jsp" %>
									<!-- LPAGE JavaScript Start --></td>
							</tr>
						</table>

			</form>
			<!-- 滚动条设置-end -->
				 
			<fieldset>
				<legend>Button</legend>
				<ul class="LbtnArea" >
					<li>
						<input type="button" value="新增" onclick="fncAdd()" id="btnAdd" />
					</li>
					
				</ul>
			</fieldset>
			<br />
							</div>
							</div>
		<br/>
	</div>
	
<!-- END content -->
</body>
</html>