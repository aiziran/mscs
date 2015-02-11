<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<html>
<head>
<title>机器号</title>
<base target="_self">
<%@ include file="/common/header.jsp"%>
<script type="text/javascript" language="javascript">
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

	function fncRevert() {

		var idArray = new Array();
		var j = 0;
		var chked = document.getElementsByName("checkbox");

		if (chked.length >= 1) {
			for ( var i = 0; i < chked.length; i++) {
				if (chked[i].checked) {
					var oTd1 = chked[i].parentNode.parentNode
							.getElementsByTagName("td");
					idArray[j] = oTd1;
					j = j + 1;
				}
			}

			if (window.opener) {
				for ( var m = 0; m < idArray.length; m++) {
					if (window.returnValue == null) {
						window.returnValue = $.trim($(idArray[m][1]).text())
								+ ";" + $.trim($(idArray[m][2]).text());
						
					} else {
						window.returnValue += ","
								+ $.trim($(idArray[m][1]).text()) + ";"
								+ $.trim($(idArray[m][2]).text());
						
					}

				}
			} else {

				for ( var m = 0; m < idArray.length; m++) {
					if (window.returnValue == null) {
						window.returnValue = $.trim($(idArray[m][1]).text())
								+ ";" + $.trim($(idArray[m][2]).text());

					} else {
						window.returnValue += ","
								+ $.trim($(idArray[m][1]).text()) + ";"
								+ $.trim($(idArray[m][2]).text());

					}

				}

			}

		} else
			for ( var m = 0; m < idArray.length; m++) {
				if (window.returnValue == null) {
					window.returnValue = $.trim($(idArray[m][1]).text()) + ";"
							+ $.trim($(idArray[m][2]).text());

				} else {
					window.returnValue += "," + $.trim($(idArray[m][1]).text())
							+ ";" + $.trim($(idArray[m][2]).text());
				}

			}
		window.close();
	}

	function selectRadioAndClose(id, lineNo) {
		if (window.opener) {
			window.opener.returnValue = id + ";" + lineNo;
		}

		window.returnValue = id + ";" + lineNo;

		window.close();
	}

	function fncSubmit() {
		actSubmit($('#formSearch'),
				'<c:url value="/common/popup/popup!lineNo.action"/>');
	}
</script>
</head>
<body class="body_sub">
	<div id="groupSupply"
		style="position: absolute; background-color: #ffffff; width: 500px; display: block">
		<br />

		<!-- END sbox -->
		<!--AREA [View]-->
		<form id="formPage" method="post"
			action="${ctx}/common/popup/popup!lineNo.action">
	
					<table class="LlistArea" width=100%>
						<tr>
							<th width=20%></th>
							<th width=20%>id</th>
							<th width=20%>机器号</th>

						</tr>
						<c:forEach items="${page.result}" var="cartypedic" varStatus="inx">
							<c:set var="index" value="${inx.index}" />
							<tr onMouseOver="cfListOver(this)" onMouseOut="cfListOut(this)"
								ondblclick="selectRadioAndClose('<c:out value="${cartypedic.id}" />','<c:out value="${cartypedic.lineNo}" />');">
								<td width="100"><input type="checkbox" id="checkbox"
									name="checkbox" />
								</td>
								<td width=20%><c:out value="${cartypedic.id}" /></td>
								<td width=20%><c:out value="${cartypedic.LineNo}" /></td>
							</tr>
						</c:forEach>

						<tr>
							<td colspan="5">
								<!-- LPAGE JavaScript Start --> <%@ include
									file="/common/page.jsp"%></td>
						</tr>
					</table>
			
		</form>
		<fieldset>
			<legend>Button</legend>
			<ul class="LbtnArea">
				<li><input type="button" value="确定" onclick="fncRevert()"
					id="btnAdd" /></li>
			</ul>
		</fieldset>
	</div>
	<!-- END content -->
	</div>
</body>
</html>
