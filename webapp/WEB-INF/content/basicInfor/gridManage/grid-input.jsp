<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>添加格子</title>
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
	function showChildWindow5(obj,salesid,salesname,color) 
	{ 
  		
		var url = "<c:url value='/common/popup/popup!archives.action'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
		if(aa){
			$('#archivesnum').val(aa.split(";")[0])
			$('#archivesname').val(aa.split(";")[1])
			$('#archivesid').val(aa.split(";")[2]);
			$('#cabinetnum').val("");
		} 
	}
	function showChildWindow1(obj,cabinetid) 
	{ 
		if(document.getElementById("archivesnum").value==""){
			alert("请先选择档案室");
			return false;
		}
  		var archivesid=document.getElementById("archivesid").value;
  		var url = "<c:url value='/common/popup/popup!cabinet.action?archivesid="+archivesid+"'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
		if(aa){
			$('#cabinetnum').val(aa.split(";")[0])
			$('#cabinetid').val(aa.split(";")[1])
		} 
	}
	
	function fncIns(){
		if(document.getElementById("cabinetnum").value==""){
			alert("柜子不能为空！");
			return false;
		}
		if(document.getElementById("cabinetnum").value==""){
			alert("柜子编号不能为空");
			return false;
		}
		actSubmitValidate($('#formPage'), 'grid!input.action');
	}
	function fncSave(){
		window.location.href="grid.action";
	}
</script>
</head>

<body onload="fncFixupListHead();">
  <div id="Lcontent">
	<SSTag:navigation/>
		<form id="formPage" method="post" >
				<div id="resultDiv"	style="width: 800px;"">
					<table class="LDetailArea" id="listTab" style="width:800px">
								<tr><td colspan="2"><h1 align="center">新增格子</h1></td></tr>
										<tr>
										<th ><font color="red">*</font>档案室名称：</th>
										<td >
										<input type="text" id="archivesname" name="archivesname"  readonly>
										<img src="/archive/images/pbf/Content_icon_search.gif" class="btn_img"
											onClick="javascript:showChildWindow5(this,'archivesnum','archivesname');"
											style="cursor: hand; margin-right: 10px" />
										</td>
									</tr>	
									<tr>
										<th><font color="red">*</font>档案室编号：</th>
										<td nowrap="nowrap">
										<input type="hidden" id="archivesid" name="archivesid" >
										<input type="text" id="archivesnum" name="archivesnum"  readonly>
										</td>
									</tr>
									<tr>
										<th><font color="red">*</font>柜子编号:</th>
										<td nowrap="nowrap">
										<input type="text" id="cabinetnum" name="cabinetnum"  readonly>
										<input type="hidden" id="cabinetid" name="cabinetid" >
										<img src="/archive/images/pbf/Content_icon_search.gif" class="btn_img"
											onClick="javascript:showChildWindow1(this,'cabinetid');"
											style="cursor: hand; margin-right: 10px" />
										</td>
									</tr>
									<tr>
										<th>格子编号:</th>
										<td nowrap="nowrap"><input type="text" id="gridnum" name="gridnum" ></td>
									</tr>
									<tr>
										<th>备注:</th>
										<td nowrap="nowrap">
										<input type="hidden" name="gridid" id="gridid"/>
										<textarea id="remark" name="remark" rows="3" style="font-size:15px" style="width:500px" ></textarea>
										</td>
									</tr>
								
								</div>
							</table>
								</form>
								<fieldset>
				<legend>Button</legend>
				<ul class="LbtnArea" >
					<li>
						<input type="button" value="返回" onclick="fncSave()" id="btnAdd" />
					</li>
					<li>
						<input type="button" value="增加" onclick="fncIns()" id="fncUpd" />
					</li>
				</ul>
			</fieldset>
							</div>
							</div>
							<!-- END content -->
</body>
</html>