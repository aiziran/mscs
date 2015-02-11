<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%--
/**
 * ------------------------------------------------------------------------
 * @source  : popup-supplier.jsp
 * @desc    : 供应商列表弹出选择页面
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2011.05.11   shijinglong          初次建立
 * ------------------------------------------------------------------------ 
 */
--%>
<html>
<head>
<title></title>
<base target="_self">
<%@ include file="/common/header.jsp"%>
<script type="text/javascript" language="javascript">
	function getCheckedOnly(inputs) {
		var result = new Array();
		if (inputs && inputs.tagName == "INPUT" && inputs.checked) result[0] = inputs;
		else if (inputs && inputs.length && inputs.length > 0 ) {
			var until = inputs.length;
			for (var idx=0; idx<until; idx++) {
				if (inputs[idx].tagName == "INPUT" && inputs[idx].checked) result[result.length] = inputs[idx];
			}
		}
		return result;
	}
	
	function fncRevert() 
	{ 
		var chked = getCheckedOnly(document.getElementsByName("chkRadio"));
		if(chked.length==1){
			var oTd = chked[0].parentNode.parentNode.getElementsByTagName("td");
			
			window.returnValue = $.trim($(oTd[1]).text())+";"+ $.trim($(oTd[2]).text())+";"+ $.trim($(oTd[3]).text());
		}else
			window.returnValue = "";
		
		 window.close(); 
	} 

	function selectRadioAndClose(code,value){
		window.returnValue =value+";"+ code;
		window.close(); 
	}
	
	function fncSubmit() {
		   	actSubmit($('#formSearch'), '<c:url value="/common/popup/popup!cartype.action"/>');
  	}
</script>
</head>
<body class="body_sub">	
	<div id ="groupSupply" style="position:absolute; background-color:#ffffff;width:500px;display:block">
		<br/>
		<div id="LsearchArea" >		
			<form id="formSearch" name="formSearch" method="post" class="enterhandler" 
				  action="${ctx}/common/popup/popup!cartype.action" onEnter="fncSubmit();">
					<input type="hidden" id="id" name="id" value=""/>
				<p>
					<input id="LsearchIcon" type="image" src="${ctx}/images/pbf/sbox_btn.gif" alt="Search" style="margin-bottom:10px" />
				</p>
			</form>
		</div>
		<!-- END sbox --> <!--AREA [View]-->
		<form id="formPage" method="post" action="${ctx}/common/popup/popup!cartype.action">								
					<table class="LlistArea" >
						<tr>
							<th></th>
							<th>车型名称</th>
							<th>车牌号码</th>
						</tr>
						<c:forEach items="${page.result}" var="cartype" varStatus="inx">
							<c:set var="index" value="${inx.index}" />
							<tr onMouseOver="cfListOver(this)" onMouseOut="cfListOut(this)" ondblclick="selectRadioAndClose('<c:out value="${cartype.carid}" />','<c:out value="${cartype.carname}" />');">
								<td><input type="radio" id="chkRadio" name="chkRadio"/>
									<input type="hidden" id="id" name="id" value="${cartype.carid}"/>
								</td>
								
								<td>
									<c:out value="${cartype.carname}" />
								</td>
								<td>
									<c:out value="${cartype.carframeid}" />
								</td>
							</tr>
						</c:forEach>
						
						<tr>
							<td colspan="4" class="AreaLeft"><!-- LPAGE JavaScript Start --> 
								<%@ include file="/common/page.jsp" %>														
							</td>
						</tr>
					</table>
			</form>			
			<fieldset>
				<legend>Button</legend>
				<ul class="LbtnArea">
					<li>
						<input type="button" value="确定" onclick="fncRevert()" id="btnAdd"/>
					</li>
				</ul>
			</fieldset>
	</div>
	<!-- END content -->
</div>			
</body>
</html>
