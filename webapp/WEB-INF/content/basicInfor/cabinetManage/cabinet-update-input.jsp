<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>柜子修改</title>
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
		} 
	}
	function fncInp(){
		if(document.getElementById("cabinetnum").value==""){
			alert("柜子编号不能为空");
			return false;
		}
		actSubmit($('#formPage'),
		'<c:url value="cabinet!update.action"/>');
	}
	//返回操作
	function fncDel(){
		window.location.href="cabinet.action";
	}
</script>
</head>

<body onload="fncFixupListHead();">
	<div id="Lcontent">
		<SSTag:navigation />
		<form id="formPage" method="post" action="http://localhost:8080/archive/basicInfor/cabinetManage/cabinet!update.action">
			<!-- 滚动条设置 -->
			<c:if test="${!empty page.result}">
				<div id="resultDiv"
					style="width: 700px;">
					<table class="LDetailArea" id="listTab" style="width: 700px;">
						</c:if>
						<c:if test="${empty page.result}">
							<table class="LDetailArea" id="listTab" >
								</c:if>
								<tr>
									<td colspan="2"><h1 align="center">修改柜子</h1></td>
								</tr>
								<s:iterator value="page.result" status="st">
									<tr>
										<th ><font color="red">*</font>档案室编号：</th>
										<td nowrap="nowrap" ><input type="text" id="archivesnum" name="archivesnum" value=${archivesnum}>
										<img src="/archive/images/pbf/Content_icon_search.gif" class="btn_img"
											onClick="javascript:showChildWindow5(this,'archivesnum','archivesname');"
											style="cursor: hand; margin-right: 10px" />
										</td>
									</tr>	
									<tr>
										<th><font color="red">*</font>档案室名称：</th>
										<td nowrap="nowrap">
										<input type="hidden" id="archivesid" name="archivesid" value=${archivesid}>
										<input type="text" id="archivesname" name="archivesname" value=${archivesname}>
										</td>
									</tr>
									<tr>
										<th><font color="red">*</font>柜子编号：</th>
										<td nowrap="nowrap">
										<input type="hidden" name="cabinetid" id="cabinetid" value=${cabinetid} }/>
										<input type="text" id="cabinetnum" name="cabinetnum" value=${cabinetnum}></td>
									</tr>
								</s:iterator>
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
						<input type="button" value="修改" onclick="fncInp()" id="btnAdd" />
					</li>
					
				</ul>
			</fieldset>
			</div>
							</div>
							</div>
							<!-- END content -->
</body>
</html>