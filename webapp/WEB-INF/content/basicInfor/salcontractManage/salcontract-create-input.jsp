<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript" src="${ctx}/js/DatePicker/WdatePicker.js"></script>

<script type="text/javascript" language="javascript">
	
	//取消当前编辑
	function fncCancel() {
		if (!confirm("是否要取消当前编辑并返回前页面？")) {
			return;
		}
		fncExtraFormCancel('<c:url value="/basicInfor/salcontractManage/salcontract.action"/>');
	}

	//保存操作
	function fncSave() {
		if(document.getElementById("area").value==""){
			   alert("面积不能为空");
			   return false;
		}
		if(document.getElementById("signedtime").value==""){
		   alert("签订时间不完整");
		   return false;
		}
		 
		var time = document.getElementById("signedtimeethours").value;
		if(time > 24 || !/^[0-9]*$/.test(time)||time==""){
			  alert("签订时间不完整");
			   return false;
		}
		
		var time1 = document.getElementById("signedtimeminutes").value;
		if(time1 > 59 || !/^[0-9]*$/.test(time1) || time1 ==""){
			  alert("签订时间不完整");
			   return false;
		}
		
		if(document.getElementById("money").value==""){
			   alert("房款不能为空");
			   return false;
		}
		if(document.getElementById("renewaltime").value==""){
			   alert("续签时间不完整");
			   return false;
			}
			 
			var time = document.getElementById("renewaltimeethours").value;
			if(time > 24 || !/^[0-9]*$/.test(time)||time==""){
				  alert("续签时间不完整");
				   return false;
			}
			
			var time1 = document.getElementById("renewaltimeetminutes").value;
			if(time1 > 59 || !/^[0-9]*$/.test(time1) || time1 ==""){
				  alert("续签时间不完整");
				   return false;
			}
		
		if(document.getElementById("contractnum").value==""){
			   alert("合同编号不能为空");
			   return false;
		}
		if(document.getElementById("hname").value==""){
			   alert("联系人不能为空");
			   return false;
		}
		
		if(document.getElementById("archivesname").value=="" || 
				document.getElementById("cabinetname").value==""||
				document.getElementById("gridname").value==""){
		    alert("位置不完整");
		   return false;
		}
		var a=document.getElementById("contactphone").value;
		if(a==""){
			   alert("联系电话不能为空");
			   return false;
			}
		
		var partten=/^[\d]{3}-[\d]{8}$|^[\d]{4}-[\d]{7}$|^[\d]{11}$|^[\s]*$/;
		   var flag=partten.test(a);
		   if(!flag){
			   alert("电话号码格式不正确!,如***-********（座机格式）,****-*******（座机格式）,或11位手机号码"); 
	           document.getElementById("contract.tel").focus(); 
	           return false;
		 }  
		   if(document.getElementById("handletime").value==""){
			   alert("办理时间不完整");
			   return false;
			}
			 
			var time = document.getElementById("handletimeethours").value;
			if(time > 24 || !/^[0-9]*$/.test(time)||time==""){
				  alert("办理时间不完整");
				   return false;
			}
			
			var time1 = document.getElementById("handletimeetminutes").value;
			if(time1 > 59 || !/^[0-9]*$/.test(time1) || time1 ==""){
				  alert("办理时间不完整");
				   return false;
			}
		
		 
		if(document.getElementById("contractname").value==""){
		   alert("合同名称不能为空");
		   return false;
		}if(document.getElementById("contractamount").value==""){
			   alert("合同金额不能为空");
			   return false;
		}
		if(document.getElementById("contractdept").value==""){
		   alert("合同单位不能为空");
		   return false;
		} 
		actSubmitValidate($('#formDetail'),
				'<c:url value="/basicInfor/salcontractManage/salcontract!create.action"/>');
	}

	//验证是否合同编号是否重复
	function fncCheckRepeat() {
		var contractnum = $("#contractnum").val();
		if (contractnum == "")
			return;

		$
				.ajax({
					type : "POST",
					url : '<c:url value="/basicInfor/salcontractManage/salcontract!checkContractnum.action"/>',
					data : "contractnum=" + contractnum,
					async : false,
					success : function(flag) {
						if (flag == "false") {
							alert("编号（" + contractnum + "）已是使用 !");
							$("#contractnum").val("").focus();
							return false;
						} else
							return true;
					}
				});
	}

	function showChildWindowOfCompany(obj, insurancecompanyid, insurancecompany) {
		var url = "<c:url value='/common/popup/popup!insurancecompany.action'/>";
		var strFeatures = "dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no";
		var aa = window.showModalDialog(url, "window", strFeatures); //取得子窗口传回的值.
		//alert(aa)
		if (aa) {

			$('#insurancecompany').val(aa.split(";")[1]);
		} else {

			$('#insurancecompany').attr("");
		}
	}
	
	function showChildWindow2() 
	{ 
  		
		var url = "<c:url value='/common/popup/popup!archives.action'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.

		if(aa){
			$('#archivesid').val(aa.split(";")[2])
			$('#archivesname').val(aa.split(";")[1])
		} 
	}
	function showChildWindow3() 
	{ 
  		var archivesid=document.getElementById('archivesid');
		var url = "<c:url value='/common/popup/popup!cabinet.action?archivesid="+archivesid.value+"'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.

		if(aa){
			$('#cabinetid').val(aa.split(";")[1])
			$('#cabinetname').val(aa.split(";")[0])
		} 
	}
	function showChildWindow4() 
	{ 
		var archivesid=document.getElementById('archivesid');
		var cabid=document.getElementById('cabinetid');
		var url = "<c:url value='/common/popup/popup!grid.action?archivesid="+archivesid.value+"&cabinetid="+cabid.value+"'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
		if(aa){
			$('#gridid').val(aa.split(";")[1])
			$('#gridname').val(aa.split(";")[0])
		} 
	}
</script>
</head>
<body>
	<div id="Lcontent">
		<SSTag:navigation />
		<form id="formDetail" method="post" enctype="multipart/form-data">
		<input type="hidden" name="archivesid" id="archivesid" />
			<input type="hidden" name="cabinetid" id="cabinetid" />
			<input type="hidden" name="gridid" id="gridid" />
			<table class="LDetailArea" summary="Secondhandcar in
			<input type="hidden" name="operateModel" value="create" />
			
			<table class="LDetailArea" summary="Inventory information.">
				<tr>
					<th><font color="red">*</font>面积:</th>
					<td><input type="text" name="area" id="area"
						maxlength="150"></td>
						
					
					<th><font color="red">*</font>签订日期:</th>
						<td>
										<input type="text" name="signedtime" id="signedtime" class="Wdate"
								onclick="WdatePicker()" readonly="readonly" value="${data.timebegin}" 
								style="margin-right: 0px;" >&nbsp;&nbsp;日
										<input type="text" id="signedtimeethours" name="signedtimeethours" style="width:30px">&nbsp;&nbsp;时
										<input type="text" id="signedtimeminutes" name="ssignedtimeminutes" style="width:30px">&nbsp;&nbsp;分
										</td>
				</tr>
				<tr>
					<th><font color="red">*</font>房款:</th>
					<td><input type="text" name="money" id="money" maxlength="150"
						class="Lbordercolor"></td>
						<th><font color="red">*</font>办理时间:</th>
						<td>
										<input type="text" name="handletime" id="handletime" class="Wdate"
								onclick="WdatePicker()" readonly="readonly" value="${data.timebegin}" 
								style="margin-right: 0px;" >&nbsp;&nbsp;日
										<input type="text" id="handletimeethours" name="handletimeethours" style="width:30px">&nbsp;&nbsp;时
										<input type="text" id="handletimeetminutes" name="handletimeetminutes" style="width:30px">&nbsp;&nbsp;分
										</td>
						
					
				</tr>
				<tr>
					<th><font color="red">*</font>合同编号</th>
					<td><input type="text" name="contractnum" id="contractnum"
						maxlength="150" class="Lbordercolor" onblur="fncCheckRepeat();" 
						validate="{required:true,maxlength:20,contractnum:true}"></td>
					<th><font color="red">*</font>联系人</th>
					<td><select name="hname" id="hname">
					        <s:iterator value="contactpeople" var="list">
								<option value='<s:property value="#list.id" />'>
									<s:property value="#list.hname" />
								</option>
								
							</s:iterator></select></td>
				</tr>
				<tr>
					
					
					<th><font color="red">*</font>联系电话:</th>
					<td><input type="text" name="contactphone" id="contactphone"
						maxlength="150" class="Lbordercolor"></td>
					<th>执行状态:</th>
					<td><select name="executestatus" id="executestatus">
							<option value="0">未执行</option>
							<option value="1">已执行</option>
					</select></td>
				</tr>
				<tr>
					
				
						 <th><font color="red">*</font>房屋地址:</th>
					<td><input type="text" name="address" id="address"
						maxlength="150" class="Lbordercolor"></td>
						<th><font color="red">*</font>存档位置:</th>
					<td>
						<input type="text" size="5" id="archivesname" name="archivesname" onclick="javascript:showChildWindow2();" readonly>
						<input type="text" size="5" id="cabinetname" name="cabinetname" onclick="javascript:showChildWindow3();" readonly>
						<input type="text" size="5" id="gridname" name="gridname" onclick="javascript:showChildWindow4();" readonly>
					</td>
				</tr>
				

				<tr>
					<th><font color="red">*</font>合同名称:</th>
					<td><input type="text" name="contractname" id="contractname"
						maxlength="150" class="Lbordercolor"></td>
					<th><font color="red">*</font>合同金额:</th>
					<td><input type="text" name="contractamount" id="contractamount" maxlength="150"
						class="Lbordercolor" /></td>
				</tr>
				
				

				<tr>
					 
					<th ><font color="red">*</font>合同单位:</th>
					<td  align="left"><input type="text" name="contractdept" id="contractdept" maxlength="150"
						class="Lbordercolor" /></td>
						<th><font color="red">*</font>续约时间:</th>
						<td>
										<input type="text" name="renewaltime" id="renewaltime" class="Wdate"
								onclick="WdatePicker()" readonly="readonly" value="${data.timebegin}" 
								style="margin-right: 0px;" >&nbsp;&nbsp;日
										<input type="text" id="renewaltimeethours" name="renewaltimeethours" style="width:30px">&nbsp;&nbsp;时
										<input type="text" id="renewaltimeetminutes" name="renewaltimeetminutes" style="width:30px">&nbsp;&nbsp;分
										</td>
				</tr>
				 <tr>
					<th><font color="red">*</font>合同期限:</th>
					<td colspan="3"><input type="text" name="totalTime" id="totalTime"
						maxlength="150" class="Lbordercolor"></td>
					 
				</tr>
				 <tr>
					<th>合同扫描件:</th>
					<td ><input type="file" name="scan" id="scan"
						size="40"></td>
						<th>合同附件:</th>
					<td ><input type="file" name="upload" id="upload"
						size="40"></td>
				</tr>
			
			</table>
		</form>
		<fieldset>
			<legend>Button</legend>
			<ul class="LbtnArea">
				<li><input type="button" value="保存" onclick="fncSave()"
					id="btnSave" objType="bSave" /> <input type="button" value="取消"
					onclick="fncCancel()" id="btnCancel" objType="bCancel" /></li>
			</ul>
		</fieldset>
	</div>
</body>
</html>


