<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<html>
<head>
<title>产品</title>
<%@ include file="/common/taglibs.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Bootstrap -->
<link rel="stylesheet"
	href="http://cdn.bootcss.com/twitter-bootstrap/3.0.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="http://cdn.bootcss.com/twitter-bootstrap/3.0.2/css/bootstrap.css">
<link rel="stylesheet"
	href="http://cdn.bootcss.com/twitter-bootstrap/3.0.2/css/bootstrap-theme.css">
<link rel="stylesheet"
	href="http://cdn.bootcss.com/twitter-bootstrap/3.0.2/css/bootstrap-theme.min.css">
<script src="http://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
<script
	src="http://cdn.bootcss.com/twitter-bootstrap/3.0.2/js/bootstrap-dropdown.js"></script>
<script
	src="http://cdn.bootcss.com/twitter-bootstrap/3.0.2/js/bootstrap.min.js">
	
</script>
<script
	src="http://cdn.bootcss.com/twitter-bootstrap/3.0.2/js/bootstrap.js"></script>
<script src="${ctx}/bootstrap/js/jquery.dataTables.js"></script>
<style type="text/css" title="currentStyle">
@import "${ctx}/bootstrap/css/demo_page.css";

@import "${ctx}/bootstrap/css/demo_table_jui.css";

@import "${ctx}/bootstrap/css/jquery-ui-1.8.4.custom.css";

td {
	text-align: center;
}
</style>

<!-- datepicker -->
<script type="text/javascript"
	src="${ctx}/bootstrap/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript"
	src="${ctx}/bootstrap/js/bootstrap-dropdown.js" charset="UTF-8"></script>
<script type="text/javascript"
	src="${ctx}/bootstrap/js/locales/bootstrap-datetimepicker.zh-CN.js"
	charset="UTF-8"></script>
<link href="${ctx}/bootstrap/css/bootstrap.min.css" rel="stylesheet"
	media="screen">
<link href="${ctx}/bootstrap/css/bootstrap-datetimepicker.min.css"
	rel="stylesheet" media="screen">
<script src="${ctx}/js/DatePicker/WdatePicker.js"></script>


<script type="text/javascript">
	function getCheckedOnly(inputs) {
		var result = new Array();
		if (inputs && inputs.tagName == "INPUT" && inputs.checked)
			result[0] = inputs;
		else if (inputs && inputs.length && inputs.length > 0) {
			var until = inputs.length;
			for ( var idx = 0; idx < until; idx++) {
				if (inputs[idx].tagName == "INPUT" && inputs[idx].checked)
					result[result.length] = inputs[idx];
			}
		}
		return result;
	}

	function selectRadioAndClose(id, productor) {
		window.returnValue = id + ";" + productor;
		window.close();

	}
	function fncRevert() {
		var chked = getCheckedOnly(document.getElementsByName("chkRadio"));
		if (chked.length == 1) {
			var oTd = chked[0].parentNode.parentNode.getElementsByTagName("td");
			window.returnValue = chked[0].value + ";"
					+ $.trim($(oTd[1]).text()) + ";" + $.trim($(oTd[2]).text())
					+ ";" + $.trim($(oTd[3]).text()) + ";"
					+ $.trim($(oTd[4]).text()) + ";" + $.trim($(oTd[5]).text())
					+ ";" + $.trim($(oTd[6]).text());

		} else
			window.returnValue = "";

		window.close();
	}
	function fncSubmit() {
		actSubmit($('#formSearch'),
				'<c:url value="/common/popup/popup!brand.action"/>');
	}
	function savaOverpack() {
		$('#myModal').modal("show");
	}
</script>
</head>
<body onload="savaOverpack()">
	<!--对话框  -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>

				</div>
				<form id="savaCpform"
					action="${ctx}/common/popup/popup!brand.action" method="post">
					<div class="modal-body">

						<div class="panel panel-info">
							<div class="panel-heading">
								<h3 class="panel-title"> 品牌</h3>
							</div>

							<div class="panel-body">
								<table class="table table-striped">

									<tr>
										<th style="text-align: center"></th>
										<th style="text-align: center">品牌</th>

									</tr>
									<c:forEach items="${page.result}" var="com_user_m"
										varStatus="inx">
										<c:set var="index" value="${inx.index}" />
										<tr onMouseOver="cfListOver(this)"
											onMouseOut="cfListOut(this)"
											ondblclick="selectRadioAndClose('<c:out value="${com_user_m.id}" />','<c:out value="${com_user_m.brand}" />');">
											<td><input type="radio" id="chkRadio" name="chkRadio"
												value="${com_user_m.id}" /></td>

											<td><c:out value="${com_user_m.brand}" />
											</td>


										</tr>
									</c:forEach>


								</table>

							</div>

						</div>

						<div class="modal-footer">

							<button type="button" class="btn btn-primary" id="btnAdd"
								onclick="fncRevert()">确定</button>
						</div>
				</form>

			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	<!-- 对话框 -->
</body>
</html>