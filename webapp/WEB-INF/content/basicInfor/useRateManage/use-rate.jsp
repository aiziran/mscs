<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>药品使用率查询</title>
</head>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript" src="${ctx }/js/DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
$(function(){
	$("#formSearch").validate({
		});
});
//固定表头
function fncFixupListHead()   
	{  
	  var tab = document.getElementById("listTab");
		if(tab) fixupFirstRow(tab);
		if (tab.rows.length < 12) {
			if (document.getElementById("resultDiv"))
				document.getElementById("resultDiv").style.height = "";
		}
	}
//查询药品供应关系列表
function fncSearch() {
	
	var queryStartDate =document.getElementById('queryStartDate');
	var queryEndDate =document.getElementById('queryEndDate');
	if (queryStartDate.value >queryEndDate.value) {
			alert("您输入的开始日期大于结束日期，请重新输入！");
			document.getElementById('queryStartDate').focus();
			return false;
		}
	actSubmit($('#formSearch'),'<c:url value="/basicInfor/useRateManage/use-rate.action"/>');
} 
</script>
<body onload="fncFixupListHead();">
<div id="Lcontent">
	<SSTag:navigation/>
	<div id="LsearchArea">
			<form name="formSearch" id="formSearch" method="post" class="enterhandler"
				action="<c:url value="/basicInfor/useRateManage/use-rate.action"/>"  onEnter="this.submit()">
				<input type="hidden" name="drugId" id="txtDrugId">
				<input type="hidden" name="drugName" id="txtDrugName">
				<div>
				<ul>
					<li>
						<label for="createDate" style="width:55px">统计期间:</label>
						<input name="queryStartDate" id="queryStartDate" value="${data.queryStartDate}" type="text" class="Wdate" onclick="WdatePicker()" readonly="readonly" validate="{required:true}"/>
						<input name="queryEndDate" id="queryEndDate" value="${data.queryEndDate}" type="text" class="Wdate" onclick="WdatePicker()" readonly="readonly" validate="{required:true}"/>
						
					</li>
					<li>	
	        			<label for="deptId" style="width:28px">部门:</label>						
		        			<s:select name="queryDepartment" id="queryDepartment" list="codeGroupList" listKey="code" listValue="value" value="data.queryDepartment"  style="width:96px;margin-right: 10px;" theme="simple" /> 
					</li>
				</ul>
				</div>
				<p>
					<a href="#" target="_self" onclick="fncSearch(); return false;">
						<input id="LsearchIcon" type="image" src="${ctx}/images/btn_search_e_g.gif" alt="Search" />
		            </a>		
				</p>
			</form>
		</div>
		
	<form name="formPage" method="post" />
		<!-- 滚动条设置 -->
 				<c:if test="${!empty page.result}">
						<div id="resultDiv" style="width: 765px;overflow-x:scroll;<c:if test="${page.pageSize >10}">overflow-y:scroll;height:280px;</c:if>">
						<table class="LlistArea" id="listTab" style="width: 1400px;">
					</c:if>
					<c:if test="${empty page.result}">
						<table class="LlistArea" id="listTab">
					</c:if>
			<!-- 滚动条设置-end -->
					<tr>
						<th>序号</th>
						<th>药品编码</th>
						<th>药品名</th>
						<th>规格</th>
						<th>生产厂家</th>
						<th>单位</th>
						<th>销售数量</th>
						<th>日均使用量</th>
						<th>使用率</th>
						<th>排序率</th>
					</tr>
					<s:iterator value="page.result" status="st">
					<tr >
						<td width="5%">${st.index+1}</td>
						<td>${hosDrugCode}</td>
						<td style="text-align: left">${drugName}</td>
						<td>${packageSpec}</td>						
						<td style="text-align: left">${manufactId}</td>
						<td>${packageUnits}</td>
						<td>${amountQuantity}</td>
						<td>${avgQuantity}</td>
						<td>${useRate}</td>
						<td>${rank}</td>
					</tr>
				</s:iterator>
				<!-- 滚动条设置 -->	
						<c:if test="${!empty page.result}">
							</table>
							</div>
							<table class="LlistArea">
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
			
		<br/>
	</div>
</body>
</html>