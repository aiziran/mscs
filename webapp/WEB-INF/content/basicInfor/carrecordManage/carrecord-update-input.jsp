<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>档案修改</title>
<script type="text/javascript"
	src="${ctx }/js/DatePicker/WdatePicker.js"></script>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript" language="javascript">

	// 固定表头
	function fncFixupListHead() {
		var tab = document.getElementById("listTab");
		if (tab)
			fixupFirstRow(tab);

		if (tab.rows.length < 12) {
			if (document.getElementById("resultDiv")) {
				document.getElementById("resultDiv").style.height = "";
			}
		}
	}
	function fncInp(){
		if($('#carid').val().length==0){
			alert("车辆id为必填项!");
			return false;
		}
		if($('#carname').val().length==0){
			alert("车辆名称为必填项!");
			return false;
		}
		if($('#lendername').val().length==0){
			alert("借出申请人为必填项!");
			return false;
		}
		
		
		actSubmit($('#formPage'),
		'<c:url value="carrecord!update.action"/>');
	}
	function fncDel(){
		actSubmit($('#formPage'),
		'<c:url value="carrecord!deleteDo.action"/>');
	}
	function fncRet(){
		window.location.href="carrecord.action";
	}
	function showChildWindow() 
	{ 
		var url = "<c:url value='/common/popup/popup!userOne.action'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
		if(aa){
			$('#lender').val(aa.split(";")[0])
			$('#lendername').val(aa.split(";")[1])
			;
		} 
	}
	function showChildWindow2() 
	{ 
		var url = "<c:url value='/common/popup/popup!userOne.action'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
		if(aa){
			$('#return_man').val(aa.split(";")[0])
			$('#return_manname').val(aa.split(";")[1])
			;
		} 
	}
	function showChildWindow3() 
	{ 
			
		var url = "<c:url value='/common/popup/popup!cartype.action'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
		if(aa){
			$('#carid').val(aa.split(";")[1])
			$('#carname').val(aa.split(";")[0])
			;
		} 
	}
</script>
</head>

<body onload="fncFixupListHead();">
	<div id="Lcontent">
		<SSTag:navigation />
		<form id="formPage" method="post" >
		<input type="hidden" id="id" name="id" value=${carrecord.id }>
		<input type="hidden" id="lender" name="lender" value=${carrecord.lender }>
		<input type="hidden" id="return_man" name="return_man" value=${carrecord.return_man }>
			<!-- 滚动条设置 -->
			<c:if test="${!empty page.result}">
				<div id="resultDiv"
					style="width: 800px;
					<c:if test="${page.pageSize >10}">overflow-y:scroll;height:280px;</c:if>">
					<table class="LDetailArea" id="listTab" style="width: 800px;">
						</c:if>
						<c:if test="${empty page.result}">
							<table class="LlistArea" id="listTab">
								</c:if>
								<tr><td colspan="4"><h1 align="center">修改车辆使用记录</h1></td></tr>
										<tr>
										<th ><font color="red">*</font>车辆id：</th>
										<td  >
										<input type="text" id="carid" name="carid" value="${carrecord.carid }" readonly="readonly" >
										<img src="/archive/images/pbf/Content_icon_search.gif" class="btn_img"
											onClick="javascript:showChildWindow3();"
											style="cursor: hand; margin-right: 10px" />
										</td>
										<th><font color="red">*</font>车辆名称：</th>
										<td nowrap="nowrap">
										<input type="text" id="carname" name="carname"  value="${carrecord.carname }" readonly="readonly" >
										</td>
									</tr>	
									<tr>
										<th><font color="red">*</font>借出申请人：</th>
										<td nowrap="nowrap">
										<input type="text" id="lendername" name="lendername" value="${carrecord.lendername}" readonly="readonly" >
										<img src="/archive/images/pbf/Content_icon_search.gif" class="btn_img"
											onClick="javascript:showChildWindow();"
											style="cursor: hand; margin-right: 10px" />
										</td>
										<th>借用时间：</th>
										<td nowrap="nowrap">
										<input type="text" name="lendtime" id="lendtime" class="Wdate"
											onclick="WdatePicker()" readonly="readonly" 
											style="margin-right: 0px;"  value="${carrecord.lendtime }"/>
										</td>
									</tr>
									<tr>
										<th>预计归还时间：</th>
										<td nowrap="nowrap">
									<input type="text" name="estimate_return_time" id="estimate_return_time" class="Wdate"
											onclick="WdatePicker()" readonly="readonly" 
											style="margin-right: 0px;" value="${carrecord.estimate_return_time }"/>
										</td>
										<th>实际归还时间：</th>
										<td nowrap="nowrap">
										<input type="text" name="actual_return_time" id="actual_return_time" class="Wdate"
											onclick="WdatePicker()" readonly="readonly" 
											style="margin-right: 0px;" value="${carrecord.actual_return_time}"/>
										</td>
									</tr>
									<tr>
										<th>审批人：</th>
										<td nowrap="nowrap">
											<input type="text" id="approver" name="approver"  value="${carrecord.approver }" readonly="readonly" >
										</td>
										<th>审批时间：</th>
										<td nowrap="nowrap">
											<input type="text" id="approvetime" name="approvetime"  value="${carrecord.approvetime }" readonly="readonly" >
										</td>
									</tr>
									<tr>
										<th>审批状态：</th>
										<td nowrap="nowrap">
											<select id="status" name="status">
											
											  <option value ="已审批" <c:if test="${carrecord.status=='已审批'}">selected</c:if>>已审批</option>
											  <option value ="未审批" <c:if test="${carrecord.status=='未审批'}">selected</c:if>>未审批</option>
											</select>
										</td>
										<th>归还人：</th>
										<td nowrap="nowrap">
											<input type="text" id="return_manname" name="return_manname" value="${carrecord.return_man}" readonly="readonly" >
											<img src="/archive/images/pbf/Content_icon_search.gif" class="btn_img"
											onClick="javascript:showChildWindow2();"
											style="cursor: hand; margin-right: 10px"/>
										</td>
									</tr>
							</table>
							
							
								
								</form>
								<fieldset>
				<legend>Button</legend>
				<ul class="LbtnArea" >
					<li>
						<input type="button" value="返回" onclick="fncRet()" id="btnAdd" />
					</li>
					<li>
						<input type="button" value="保存" onclick="fncInp()" id="fncUpd" />
					</li>
					<li>
						<input type="button" value="删除" onclick="fncDel()" id="fncDelete" />
					</li>
				</ul>
			</fieldset>
			</div>
							</div>
							</div>
							<!-- END content -->
</body>
</html>