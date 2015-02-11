<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>页面</title>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript" language="javascript">
	//进入修改页面
	function fncDetail(obj) {
		$('#id').val(obj);
		actSubmit($('#formPage'),
				'<c:url value="/basicInfor/salcontractManage/salcontract!updateInput.action"/>');
	}

	//进入新增页面
	function fncAdd() {
		actSubmit($('#formPage'),
				'<c:url value="/basicInfor/salcontractManage/salcontract!createInput.action"/>');
	}

	// 固定表头
	function fncFixupListHead() {
		var tab = document.getElementById("listTab");
		if (tab)
			fixupFirstRow(tab);

		if (tab.rows.length < 12) {
			if (document.getElementById("resultDiv")) {
				document.getElementById("resultDiv").style.height = "";
			}
		}
	}
	function fncdel() {
		var a = document.getElementsByName("checkBox");
		var n = a.length;
		var k = 0;
		for ( var i = 0; i < n; i++) {
			if (a[i].checked) {
				k = 1;
			}
		}
		if (k == 0) {
			alert("请选中所要删除的信息！!");
			return;
		}
		if (!confirm("请确认是否提交？"))
			return;
		actSubmit($('#formPage'),
				'<c:url value="/basicInfor/salcontractManage/salcontract!delete.action"/>');
	}
	//复选框全选
	function fncCheckAll(field) {
		var checkboxes = document.getElementsByName("checkBox");
		for ( var i = 0; i < checkboxes.length; i++) {
			checkboxes[i].checked = field.checked;
		}
	}
	
</script>
</head>

<body onload="fncFixupListHead();">
	<div id="Lcontent">
		<SSTag:navigation />
<div id="LsearchArea">
	<form id="formSearch" name="formSearch" method="post" class="enterhandler" style="width: 1000px;"
				  action="<c:url value="/basicInfor/salcontractManage/salcontract.action"/>" onEnter="this.submit()">		
			<div>
				<ul>
					<li>
						<label for="gridId" style="width:60px" >联系人:</label> 
						<input type="text" name="hname" class="Lbordercolor" 
								   size="13" style="margin-right: 10px;" value="${data.hname }"/>
					</li>
					<li>
						<label for="archiveId" style="width:60px">合同名称:</label> 
						<input type="text" name="contractname" class="Lbordercolor" 
								    size="13" style="margin-right: 10px;"value="${data.contractname}"/>
					</li>
					 
				</ul>
				</div>
				<div>
				<ul>
					<li>
						<label for="gridId" style="width:60px">执行状态:</label> 
						<select name="executestatus" id="executestatus" style="width: 90px;margin-right: 10px;" >
							<option ></option>
							<option value="0">未执行</option>
							<option value="1">已执行</option>
					</select>
					</li>
					<li>
						<label for="cabinetId" style="width:60px">合同编号:</label> 
						<input type="text" name="contractnum" class="Lbordercolor" 
								    size="13" style="margin-right: 10px;" value="${data.contractnum}"/>
					</li>
					<li>
						<label for="archiveId" style="width:60px">合同单位:</label> 
						<input type="text" name="contractdept" class="Lbordercolor" 
								    size="13" style="margin-right: 10px;" value="${data.contractdept}"/>
					</li>
					 
				</ul>
			</div>
			<p>
					<input id="LsearchIcon" type="image" src="${ctx}/images/btn_search_e_g.gif" alt="Search" />
				</p>
	</form>
	</div>
		<form id="formPage" method="post">
			<input type="hidden" name="contractid" id="contractid" />
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
									<!-- 滚动条设置-end -->
									
									<th>
									<input type="checkbox"
													name="selectAll" id="selectAll"
													onclick="fncCheckAll(this);" />
													</th>
									<th>面积</th>
									<th>房款</th>
									<th>合同编号</th>
                                                                        <th>办理时间</th>
								 
									<th>合同名称</th>
									
									<th>合同单位</th>
									<th>合同金额</th>
                                                                        <th>签订日期</th>
									<th>续约时间</th>
									<th>联系人</th>
									<th>联系电话</th>	 
								</tr>
								<s:iterator value="page.result" status="st">
									<tr >
										<td><input type="checkbox" name="checkBox"
														id="checkBox" value="${id}" /></td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${id}')">${AREA}</td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${id}')">${money}</td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${id}')">${contractnum }</td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${id}')">${handletime}</td>
									 
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${id}')">${contractname}</td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${id}')">${contractdept}</td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${id}')">${contractamount}</td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${id}')">${signedtime}</td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${id}')">${renewaltime}</td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${id}')">${hname}</td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${id}')">${contactphone}</td>
										 
								</s:iterator>
								<!-- 滚动条设置 -->
								<c:if test="${!empty page.result}">
							</table>
							</div>
							<table class="LlistArea" style="width: 1000px;">
								</c:if>
								<!-- 滚动条设置-end -->
								<tr>
									<td colspan="20" class="AreaLeft"><%@ include
											file="/common/page.jsp"%> <!-- LPAGE JavaScript Start --></td>
								</tr>
							</table>

							</form>
							<!-- 滚动条设置-end -->
							<fieldset>
								<legend>Button</legend>
								<ul class="LbtnArea" style="margin-right: 20px;">
									
											<li><input type="button" value="删除" onclick="fncdel()"
										id="btnAdd" objType="bCreate" /></li>
										<li><input type="button" value="新增" onclick="fncAdd()"
										id="btnAdd" objType="bCreate" /></li>
								</ul>
							</fieldset>
							<br />
							</div>
							</div>
							<!-- END content -->
</body>
</html>