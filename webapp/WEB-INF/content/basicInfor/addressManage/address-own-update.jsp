<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>个人通讯录修改</title>
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
	//提交验证
	function fncInp(){
		if(document.getElementById("name").value==""){
			alert("姓名不能为空");
			return false;
		}
		if(document.getElementById("deptname").value==""){
			 alert("部门不能为空");
			 return false;
		}
			
		var a=document.getElementById("mobileone").value;
		var b=document.getElementById("mobiletwo").value;
		if(a=="" && b==""){
			   alert("电话不能为空");
			   return false;
			}
		var partten=/^[\d]{3}-[\d]{8}$|^[\d]{4}-[\d]{7}$|^[\d]{11}$|^[\s]*$/;
		   var flag=partten.test(a);
		   if(!flag){
			   alert("电话1号码格式不正确!,如***-********（座机格式）,****-*******（座机格式）,或11位手机号码"); 
	           document.getElementById("contract.tel").focus(); 
	           return false;
		 }  
		   var flag=partten.test(b);
		   if(!flag){
			   alert("电话2号码格式不正确!,如***-********（座机格式）,****-*******（座机格式）,或11位手机号码"); 
	           document.getElementById("contract.tel").focus(); 
	           return false;
		 } 
	  	if(!/^[0-9]*$/.test(document.getElementById("qq").value)){
			alert("QQ请输入数字！！！");
			return false;
		}
	  	if (document.getElementById("email").value.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) == -1)
  		{
  			alert("请输入格式正确的 e-mail 地址！"); 
  			return false;
  		}
	  	if (!confirm("是否要修改？")) {
			return;
		}
		actSubmit($('#formPage'), '<c:url value="/basicInfor/addressManage/address!ownupdate.action"/>');
	}
	
	//取消当前编辑
	function fncCancel() {
		if (!confirm("是否要取消当前编辑并返回前页面？")) {
			return;
		}
		fncExtraFormCancel('<c:url value="/basicInfor/addressManage/address!own.action"/>');
	}
	//部门的选择
	function showChildWindow1() 
	{ 
  		
		var url = "<c:url value='/common/popup/popup!myDept.action'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
		if(aa){
			$('#dept').val(aa.split(";")[0])
			$('#deptname').val(aa.split(";")[1])
		} 
	}
	function fncCheckRepeat() {
		   var name = document.getElementById("name").value;
			var mobileone =document.getElementById("mobileone").value;
				$
						.ajax({
							type : "POST",
							url : '<c:url value="/basicInfor/addressManage/address!fncCheckRepeat.action"/>',
							data : {"name":name,"mobileone":mobileone},
							async : false,
							success : function(flag) {
								if (flag == "false") {
									alert("姓名和电话号码不能同时相等");
									$("#name").val("").focus();
									$("#mobileone").val("").focus();
									return false;
								} else
									return true;
							}
						});
		}
</script>
</head>

<body onload="fncFixupListHead();">
	<div id="Lcontent">
		<SSTag:navigation />
		<form id="formPage" method="post" >
					<table  id="listTab" style="width: 1000px;">
									<tr>
										<th colspan="4"><b>个人通讯录修改</b></th>
									</tr>
									<tr>
										<th><font color="red">*</font>姓名</th>
										<td nowrap="nowrap"><input type="text" id="name" name="name" value="${test.name}"></td>
									     <th><font color="red">*</font>部门</th>
										<td nowrap="nowrap">
										    <input type="hidden" name="dept" id="dept" value="${test.dept}" /> 
											<input type="text" id="deptname" name="deptname" value="${test.deptname}" readonly>
											<img src="/archive/images/pbf/Content_icon_search.gif" class="btn_img"
												onClick="javascript:showChildWindow1();"
												style="cursor: hand; margin-right: 10px" />
										
										</td>
									</tr>
									<tr>
										<th><font color="red">*</font>手机号</th>
										<td nowrap="nowrap"><input type="text" id="mobileone" name="mobileone" value="${test.mobileone}" onclick="fncCheckRepeat()"/></td>
									    <th>职位</th>
										<td nowrap="nowrap"><input type="text" id="post" name="post" value="${test.post}"/></td>
									<tr>
									<tr>
										<th>座机</th>
										<td nowrap="nowrap"><input type="text" id="mobiletwo" name="mobiletwo" value="${test.mobiletwo}" /></td>
									    <th><font color="red">*</font>Email</th>
										<td nowrap="nowrap"><input type="text" id="email" name="email" value="${test.email}" /></td>
									<tr>
									<tr>
										<th>QQ</th>
										<td nowrap="nowrap"><input type="text" id="qq" name="qq" value="${test.qq}" /></td>
									    <th>备注</th>
										<td nowrap="nowrap"><input type="text" id="remark" name="remark" value="${test.remark}" /></td>
							            <input type="hidden" name="tid"  value="${test.id}"/>
									</tr>
							</table>	
						</form>
						<fieldset>
							<legend>Button</legend>
							<ul class="LbtnArea">
								<li><input type="button" value="提交" onclick="fncInp()" id="btnSave" objType="bSave" />
								 <input type="button" value="取消" onclick="fncCancel()" id="btnCancel" objType="bCancel" />
								</li>
							</ul>
							</fieldset>								
							</div>
							</div>
							<!-- END content -->
</body>
</html>
</body>
</html>