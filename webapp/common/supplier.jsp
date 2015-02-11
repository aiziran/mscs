<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--
/**
 * ------------------------------------------------------------------------
 * @source  : supplier-input.jsp
 * @desc    : 供应商管理页面
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
<title>页面</title>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript" language="javascript">
	//进入修改页面
	function fncDetail(obj) {
		$('#supplierId').val(obj);
		actSubmit($('#formPage'),
				'<c:url value="/basicInfor/supplierManage/supplier!updateInput.action"/>');
	}

	//进入新增页面
	function fncAdd() {
		actSubmit($('#formPage'),
				'<c:url value="/basicInfor/supplierManage/supplier!createInput.action"/>');
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
</script>
</head>

<body onload="fncFixupListHead();">
	<div id="Lcontent">
	<SSTag:navigation/>
		<div id="LsearchArea">
			<form id="formSearch" name="formSearch" method="post"
				class="enterhandler"
				action="<c:url value="/basicInfor/supplierManage/supplier.action"/>"
				onEnter="this.submit()">
				<input type="hidden" id="userId" name="userId" value="" />
				<div>
					<ul>
						<li><label for="LskillSearch" style="width: 55px">供应商ID:</label>
							<input name="querySupplierId" id="queryLegalPerso" type="text"
							class="Lbordercolor"
							value="${data.querySupplierId}" size="13"
							style="margin-right: 10px;" /> <label for="LskillSearch"
							style="width: 30px">名称:</label> <input name="querySupplierName"
							id="queryLegalPerso" type="text" class="Lbordercolor"
							value="${data.querySupplierName}"" size="13"
							style="margin-right: 10px;" /> <label for="LskillSearch"
							style="width: 55px">法人代表:</label> <input name="queryLegalPerson"
							id="queryLegalPerso" type="text" class="Lbordercolor"
							value="${data.queryLegalPerson}" size="13"
							style="margin-right: 10px;" /></li>
					</ul>
				</div>
				<input id="LsearchIcon" type="image"
					src="${ctx}/images/btn_search_e_g.gif" alt="Search" />
				</p>
			</form>
		</div>

		<!-- END sbox -->
		<!--AREA [View]-->
		<form id="formPage" method="post"
			action="<c:url value="/basicInfor/supplierManage/supplier.action"/>">
			
				<input type="hidden" id="supplierId" name="supplierId" value="" />
			<!-- 滚动条设置 -->
			<c:if test="${!empty page.result}">
				<div id="resultDiv"
					style="width: 765px;overflow-x:scroll;<c:if test="${page.pageSize >10}">overflow-y:scroll;height:280px;</c:if>">
					<table class="LlistArea" id="listTab" style="width: 1400px;">
					
					<script>
									document.getElementById("resultDiv").style.width = document
											.getElementById("formSearch").clientWidth;
								</script>
						</c:if>
						<c:if test="${empty page.result}">
							<table class="LlistArea" id="listTab">
								</c:if>
								<!-- 滚动条设置-end -->
								<tr>
									<th>序号</th>
									<th><a href="javascript:sort('supplier_id','asc')">供应商ID</a>
									</th>
									<th><a href="javascript:sort('supplier_name','asc')">名称</a>
									</th>
									<th><a href="javascript:sort('supplier_short','asc')">简称</a>
									</th>
									<th><a href="javascript:sort('legal_person','asc')">法人代表</a>
									</th>
									<th><a href="javascript:sort('phone','asc')">电话</a>
									</th>
									<th><a href="javascript:sort('mobile','asc')">手机</a>
									</th>
									<th><a href="javascript:sort('fax','asc')">传真</a>
									</th>
									<th><a href="javascript:sort('website','asc')">网址</a>
									</th>
									<th><a href="javascript:sort('address','asc')">地址</a>
									</th>

								</tr>
								<s:iterator value="page.result" status="st">
									<tr onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${supplierId}')">
										<td width="30px"><c:out value="${st.index+1}" />
										</td>
										<td align="center">${supplierId}</td>
										<td  style="text-align: left">${supplierName}</td>
										<td  style="text-align: left">${supplierShort}</td>
										<td  style="text-align: left">${legalPerson}</td>
										<td align="center">${phone}</td>
										<td align="center">${mobile}</td>
										<td align="center">${fax}</td>
										<td align="center">${website}</td>
										<td  style="text-align: left">${address}</td>
									</tr>
								</s:iterator>
								<!-- 滚动条设置 -->	
						<c:if test="${!empty page.result}">
					</table>
					</div>
					<table class="LlistArea">
				</c:if>
				<!-- 滚动条设置-end -->
				<c:if test="${page.totalCount>0}">
					<tr>
						<td colspan="5" class="AreaLeft">
							<%@ include file="/common/page.jsp" %>
						</td>
					</tr>
				</c:if>
				</table>
							</form>
							<!-- 滚动条设置-end -->
							<fieldset>
								<legend>Button</legend>
								<ul class="LbtnArea">
									<li><input type="button" value="新增" onclick="fncAdd()"
										id="btnAdd" objType="bCreate" /></li>
								</ul>
							</fieldset>
							<br />
							</div>

							<!-- END content -->
</body>
</html>