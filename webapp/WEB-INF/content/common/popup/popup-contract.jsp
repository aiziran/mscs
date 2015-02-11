<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<html>
<head>
<title>合同列表</title>
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
	
	

	function selectRadioAndClose(num,id){
		window.returnValue =num+";"+ id;
		window.close(); 
		
	}
	
	function fncSubmit() {
		   	actSubmit($('#formSearch'), '<c:url value="/common/popup/popup!contract.action"/>');
  	}
</script>
</head>
<body class="body_sub">	
	<div id ="groupSupply" style="position:absolute; background-color:#ffffff;display:block">
		<br/>
		<div id="LsearchArea">
			<form id="formSearch" name="formSearch" method="post" class="enterhandler" 
				  action="<c:url value="/common/popup/popup!contractType.action"/>" onEnter="this.submit()">
					<div>
					<table class="LlistArea">
					     <tr>
					        <th>合同编号:</th><td ><input type="text" id="identifier" name="identifier"  /></td>
					        </tr>
					        <tr>
					        <th>合同名称:</th>
					        <td>
					        	<input type="text" name="contractname" id="contractname"  />
							</td>
					    </tr>
					</table>
				    </div>
				 <input id="LsearchIcon" type="image" src="${ctx}/images/btn_search_e_g.gif" alt="Search" />
				</p>
			</form>
		</div>
		<!-- END sbox --> <!--AREA [View]-->
		<form id="formPage" method="post" action="${ctx}/common/popup/popup!contractType.action">								
					<table class="LlistArea" >
						<tr>
							<th width="100"></th>
							<th width="200">合同编号</th>
							<th width="200">合同名称</th>
							
						</tr>
						<c:forEach items="${page.result}" var="contract" varStatus="inx">
								<c:set var="index" value="${inx.index}" />
							<tr onMouseOver="cfListOver(this)" onMouseOut="cfListOut(this)" 
							ondblclick="selectRadioAndClose('<c:out value="${contract.identifier}" />','<c:out value="${contract.contractname}" />');">
								
								<td width="100">
									<input type="radio" id="chkRadio" name="chkRadio"  value="${contract.identifier}"/></td>
								
								<td width="200">
									
									<c:out value="${contract.identifier}" />
								</td>
								<td width="200">
									<c:out value="${contract.contractname}" />
								</td>
							</tr>
						</c:forEach>
						
						<tr>
							<td colspan="4"  class="AreaCenter"><!-- LPAGE JavaScript Start --> 
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
	var chked = getCheckedOnly(document.getElementsByName("chkRadio"));
	if(chked.length==1){
		var oTd = chked[0].parentNode.parentNode.getElementsByTagName("td");
		var id=document.getElementById("chkRadio").value;
		window.returnValue =$.trim($(oTd[1]).text())+";"+ $.trim($(oTd[2]).text())+";"+chked[0].value;
	}else
		window.returnValue = "";
	
	 window.close(); 
} 
</script>
</html>
