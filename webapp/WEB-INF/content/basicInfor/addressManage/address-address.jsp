<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<html>
<head>
<title>部门列表</title>
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
							<th>部门名称名称</th>
							
						</tr>
						<c:forEach items="${page.result}" var="archives" varStatus="inx">
							<c:set var="index" value="${inx.index}" />
							<tr onMouseOver="cfListOver(this)" onMouseOut="cfListOut(this)" 
							ondblclick="selectRadioAndClose('<c:out value="${archives.archivesnum}" />','<c:out value="${archives.archivesname}" />','<c:out value="${archives.id}" />');">
								
								<td>
									<input type="radio" id="chkRadio" name="chkRadio"  value="${archives.id}"/></td>
								
								<td>
									
									<c:out value="${archives.archivesnum}" />
								</td>
								<td>
									<c:out value="${archives.archivesname}" />
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
