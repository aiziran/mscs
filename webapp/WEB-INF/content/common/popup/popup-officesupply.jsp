<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<html>
<head>
<title>员工列表</title>
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
	
	

	function selectRadioAndClose(id,name,returntype){
		window.returnValue =id+";"+ name+";"+returntype;
		window.close(); 
		
	}
	function fncRevert() 
	{ 
		var chked = getCheckedOnly(document.getElementsByName("chkRadio"));
		if(chked.length==1){
			var oTd = chked[0].parentNode.parentNode.getElementsByTagName("td");
			window.returnValue =chked[0].value+";"+$.trim($(oTd[2]).text())+";"+$.trim($(oTd[3]).text());
			
		}else
			window.returnValue = "";
		
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
			
		</div>
		<!-- END sbox --> <!--AREA [View]-->
		<form id="formPage" method="post" action="${ctx}/common/popup/popup!cartype.action">								
					<table class="LlistArea" >
						<tr>
							<th></th>
							<th>编号</th>
								<th>名称</th>
								<th>是否需要归还</th>
						</tr>
						<c:forEach items="${page.result}" var="office" varStatus="inx">
							<c:set var="index" value="${inx.index}" />
							<tr onMouseOver="cfListOver(this)" onMouseOut="cfListOut(this)" 
								ondblclick="selectRadioAndClose('<c:out value="${office.id}" />','<c:out value="${office.name}"/>','<c:out value="${office.returntype}" />');">
								
								<td>
									<input type="radio" id="chkRadio" name="chkRadio"  value="${office.id}"/>
									</td>
								<td>
									
									<c:out value="${office.id}" />
								</td>
								
								<td>
									<c:out value="${office.name}" />
								</td>
								<td>
								 
								<c:if test="${office.returntype eq 0 }">需要</c:if>
									<c:if test="${office.returntype eq 1 }">不需要</c:if>
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
