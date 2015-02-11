<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<html>
<head>
<title>班次</title>
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
	
	

	function selectRadioAndClose(id,name,wwww){
		if(window.opener)
        {
			
          window.opener.returnValue=id+";"+ name+";"+wwww;
        }
		window.returnValue =id+";"+ name+";"+wwww;
		window.close(); 
		
	}
	function fncRevert() 
	{ 
		var chked = getCheckedOnly(document.getElementsByName("chkRadio"));
		if(chked.length==1){
			var oTd = chked[0].parentNode.parentNode.getElementsByTagName("td");
			if(window.opener)
	        {
	          window.opener.returnValue=chked[0].value+";"+$.trim($(oTd[1]).text())+";"+$.trim($(oTd[2]).text());
	        }
			window.returnValue =chked[0].value+";"+$.trim($(oTd[1]).text())+";"+$.trim($(oTd[2]).text());
			
		}else
			window.returnValue =chked[0].value+";"+$.trim($(oTd[1]).text())+";"+$.trim($(oTd[2]).text());
		
		 window.close(); 
	} 
	function fncSubmit() {
		   	actSubmit($('#formSearch'), '<c:url value="/basicInfor/dataManage/data!classesdetail.action"/>');
  	}
</script>
</head>
<body class="body_sub">	
	<div id ="groupSupply" style="position:absolute; background-color:#ffffff;width:500px;display:block">
		<br/>
		<div id="LsearchArea" >		
			
		</div>
		<!-- END sbox --> <!--AREA [View]-->
		
		<form id="formPage" method="post" action="${ctx}/basicInfor/dataManage/data!classesdetail.action">								
					<table class="LlistArea" >
						<tr>
						<th></th>
							<th> 序号</th>
							<th> 班次</th>
						</tr>
						
						<c:forEach items="${page.result}" var="com_user_m" varStatus="inx">
							<c:set var="index" value="${inx.index}" />
							<tr onMouseOver="cfListOver(this)" onMouseOut="cfListOut(this)" 
								ondblclick="selectRadioAndClose('<c:out value="${com_user_m.id}" />','<c:out value="${com_user_m.id}" />');">
								
								<td>
									<input type="radio" id="chkRadio" name="chkRadio"  value="${com_user_m.id}"/>
									</td>
								<td>
									<c:out value="${com_user_m.id}" />
									
								</td>
								
								<td>
									
									<c:out value="${com_user_m.classesname}" />
								</td>
								
							</tr>
						</c:forEach>
						
						<tr>
							<td colspan="4" ><!-- LPAGE JavaScript Start --> 
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
