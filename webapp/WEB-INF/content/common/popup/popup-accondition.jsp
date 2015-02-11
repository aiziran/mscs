<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<html>
<head>
<title>档案室列表</title>
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
	
	

	function selectRadioAndClose(num,name,id){
		window.returnValue =num+";"+ name+";"+id;
		//window.close(); 
		
	}
	
	function fncSubmit() {
		   	actSubmit($('#formSearch'), '<c:url value="/common/popup/popup!accondition.action"/>');
  	}
</script>
</head>
<body class="body_sub">	
	<div id ="groupSupply" style="position:absolute; background-color:#ffffff;width:500px;display:block">
		<br/>
		<div id="LsearchArea" >		
			
		</div>
		<!-- END sbox --> <!--AREA [View]-->
		<form id="formPage" method="post" action="${ctx}/common/popup/popup!accondition.action">								
					<table class="LlistArea" >
						<tr>
							<th></th>
							<th>条件编号</th>
							<th>条件名称</th>
							<th>流程节点</th>
							
						</tr>
						<c:forEach items="${page.result}" var="accondition" varStatus="inx">
							<c:set var="index" value="${inx.index}" />
							<tr onMouseOver="cfListOver(this)" onMouseOut="cfListOut(this)" 
							ondblclick="selectRadioAndClose('<c:out value="${accondition.id}" />','<c:out value="${accondition.acname}" />','<c:out value="${accondition.actype}" />');">
								<td>
									<input type="radio" id="chkRadio" name="chkRadio"  value="${accondition.id}"/></td>
								<td><c:out value="${accondition.id}" /></td>
								<td>
									<c:out value="${accondition.acname}" />
								</td>
								<td>
									<c:out value="${accondition.actype}" />
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
<script type="text/javascript" language="javascript">
function fncRevert() 
{ 
	 window.close(); 
} 
</script>
</html>
