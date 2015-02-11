<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!--  
/**
 * ------------------------------------------------------------------------
 * @source  : listCode.jsp
 * @desc    : 业务数据处理
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.05.18  houyingchang       初次建立
 * ------------------------------------------------------------------------ 
 */
 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>业务数据处理</title>
</head>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript"
	src="${ctx }/js/DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
//固定表头
function fncFixupListHead()   
	{  
	  var tab = document.getElementById("listTab");
		if(tab) fixupFirstRow(tab);
		//if (tab.rows.length < 12) {
		//	if (document.getElementById("resultDiv"))
		//		document.getElementById("resultDiv").style.height = "";
	//	}
	}

</script>
<body onload="fncFixupListHead();">
<div id="Lcontent"><SSTag:navigation />
<div id="LsearchArea">
<form name="formSearch" id="formSearch" method="post"	class="enterhandler"
	action="<c:url value="/treasury/treasuryManage/treasury.action"/>"
	onEnter="this.submit()"><input type="hidden" name="drugName"
	id="txtDrugName">
</form>
</div>

<form name="formPage" id="formPage" method="post"
	action="<c:url value="/treasury/treasuryManage/treasury.action"/>" />
	<div id="resultDiv"
		style="width: 765px;height:280px;">
		<table>
			<tr>
				<td style="border:0">
					<font color="red">*</font>说明：为了提高系统性能，只保留36个月的业务数据， 之前的数据将被保存到历史业务数据表中。
				</td>
			</tr>
		</table>
		<table class="LDetailArea">
					<c:if test="${!empty data.importMst}">
					<tr><td><c:out value="${data.importMst}"/></td></tr>
					</c:if>
					<c:if test="${!empty data.importDtl}">
					<tr><td><c:out value="${data.importDtl}"/></td></tr>
					</c:if>
					<c:if test="${!empty data.exportMst}">
					<tr><td><c:out value="${data.exportMst}"/></td></tr>
					</c:if>
					<c:if test="${!empty data.exportDtl}">
					<tr><td><c:out value="${data.exportDtl}"/></td></tr>
					</c:if>
					<c:if test="${!empty data.purchasMst}">
					<tr><td><c:out value="${data.purchasMst}"/></td></tr>
					</c:if>
					<c:if test="${!empty data.purchasDtl}">
					<tr><td><c:out value="${data.purchasDtl}"/></td></tr>
					</c:if>
					<c:if test="${!empty data.startTime}">
					<tr><td><c:out value="${data.startTime}"/></td></tr>
					</c:if>
					<c:if test="${!empty data.endTime}">
					<tr><td><c:out value="${data.endTime}"/></td></tr>
					</c:if>
				</table>
			</div>
			</form>
			<br />
</div>
</body>
</html>