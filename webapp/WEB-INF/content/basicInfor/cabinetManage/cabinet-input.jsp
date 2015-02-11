<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>档案修改</title>
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
	function showChildWindow5(obj,archivesnum,archivesname) 
	{ 
  		
		var url = "<c:url value='/common/popup/popup!archives.action'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
		if(aa){
			$('#archivesnum').val(aa.split(";")[0])
			$('#archivesname').val(aa.split(";")[1])
			$('#archivesid').val(aa.split(";")[2])
			;
		} 
	}
	//验证表单
	function fncInp(){
		if(document.getElementById("archivesnum").value==""){
			alert("档案室不能为空");
			return false;
		}
		if(document.getElementById("cabinetnum").value==""){
			alert("柜子编号不能为空");
			return false;
		}
		actSubmit($('#formPage'),
		'<c:url value="cabinet!input.action"/>');
	}
	function fncDel(){
		window.location.href="cabinet.action";
	}
</script>
</head>

<body onload="fncFixupListHead();">
	<div id="Lcontent">
		<SSTag:navigation />
		<form id="formPage" method="post" >
			<!-- 滚动条设置 -->
				<div id="resultDiv"	style="width: 700px;">
					<table class="LDetailArea"  id="listTab" style="width: 700px;">
								
									<tr>
										<td colspan="2"><h1 align="center">添加柜子</h1></td>
									</tr>
									<tr>
										<th ><font color="red">*</font>档案室编号：</th>
										<td nowrap="nowrap" >
										<input type="text" id="archivesnum" name="archivesnum" readonly>
										<img src="/archive/images/pbf/Content_icon_search.gif" class="btn_img"
											onClick="javascript:showChildWindow5(this,'archivesnum','archivesname');"
											style="cursor: hand; margin-right: 10px" />
										</td>
									</tr>	
									<tr>
										<th><font color="red">*</font>档案室名称：</th>
										<td nowrap="nowrap">
										<input type="hidden" id="archivesid" name="archivesid" >
										<input type="text" id="archivesname" name="archivesname" readonly></td>
									</tr>
									<tr>
										<th><font color="red">*</font>柜子编号：</th>
										<td nowrap="nowrap"><input type="text" id="cabinetnum" name="cabinetnum" ></td>
									</tr>
								
								<!-- 滚动条设置 -->
								
							</table>
							
							
								
								</form>
								<fieldset>
				<legend>Button</legend>
				<ul class="LbtnArea" >
					<li>
						<input type="button" value="返回" onclick="fncDel()" id="btnDel" />
					</li>
					<li>
						<input type="button" value="增加" onclick="fncInp()" id="btnAdd" />
					</li>
					
				</ul>
			</fieldset>
			</div>
							</div>
							</div>
							<!-- END content -->
</body>
</html>