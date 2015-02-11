<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<html>
<head>
<title>借阅申请</title>
<base target="_self">
<script type="text/javascript"
	src="/archive/js/DatePicker/WdatePicker.js"></script>

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
		   	actSubmit($('#formSearch'), '<c:url value="/common/popup/popup!dept.action"/>');
  	}
</script>
<script type="text/javascript" language="javascript">
function fncRevert() 
{ 
	actSubmit($('#formPage'), '<c:url value="/basicInfor/archiveManage/archive!saveLoan.action"/>');
	// window.close(); 
} 
</script>
</head>
<body class="body_sub">	
	<div id ="groupSupply" style="position:absolute; background-color:#ffffff;width:500px;display:block">
		<br/>
		<div id="LsearchArea" >		
		</div>
		<!-- END sbox --> <!--AREA [View]-->
		<form id="formPage" method="post" action="${ctx}/common/popup/popup!myDept.action">	
			<c:forEach items="${page.result}" var="loan" varStatus="inx">
			<input type="hidden" name="checkedid" id="checkedid" value="${loan.ids}" />
				<table class="LDetailArea" summary="Secondhandcar information.">
				<tr>
					<th nowrap="nowrap"><span>档案名称</span>
					</th>
					<td><input type="text" id="archivenum" name="archivenum" size="70"
						class="Lbordercolor" value="${loan.names}"/>
					</td>
				</tr>
				<tr>
					<th nowrap="nowrap"><span>借阅人</span>
					</th>
					<td><input type="text" id="user" name="user" size="70"
						class="Lbordercolor" value="${userID }"/>
					</td>
				</tr>
				<tr>
					<th nowrap="nowrap"><span>归还日期</span>
					</th>
					<td><input type="text" name="returntime" id="returntime" maxlength="150" value="" 
						class="Wdate" onclick="WdatePicker()" readonly="readonly"
						style="margin-right: 30px;" /></td>

					</td>
				</tr>
				<tr>
					<th nowrap="nowrap"><span>借阅原因</span>
					</th>
					<td><input type="text" id="reason" name="reason" size="70"
						class="Lbordercolor"/>
					</td>
				</tr>
				</table>
						</c:forEach>
					</table>
			</form>			
			<fieldset>
				<legend>Button</legend>
				<ul class="LbtnArea">
					<li>
						<input type="button" value="保存" onclick="fncRevert()" id="btnAdd"/>
					</li>
				</ul>
			</fieldset>
	</div>
	<!-- END content -->
</div>			
</body>

</html>
