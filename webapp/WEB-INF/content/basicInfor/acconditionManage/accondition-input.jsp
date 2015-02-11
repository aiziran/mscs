<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<%@ include file="/common/header.jsp"%>
<html>
<head>

<title>Insert title here</title>
<script type="text/javascript" language="javascript">

//固定表头
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

function showArchiveTypeWindow()
	{   
		
		var url = "<c:url value='/common/popup/popup!listArchiveType.action'/>"; 
	var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
	var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.

	if(aa){
		//$('#archivesnum').val(aa.split(";")[0])
		$('#actype').val(aa.split(";")[0])
		$('#typename').val(aa.split(";")[1]);
	} 
}

function fncInp() { 
	
	if(document.getElementById("actype").value==""){
		   alert("actype不能为空");
		   return false;
	}
	if(document.getElementById("acname").value==""){
	   alert("acname不能为空");
	   return false;
	}
	if(document.getElementById("acdesc").value==""){
		   alert("acdesc不能为空");
		   return false;
		}
	if(document.getElementById("acimpt").value==""){
		   alert("acimpt不能为空");
		   return false;
		}
	   
	    alert("ddddd");
	   actSubmit($('#formPage'),'<c:url value="/basicInfor/acconditionManage/accondition!save.action"/>');
		
		}


//取消当前编辑
function fncCancel() {
	if (!confirm("是否要取消当前编辑并返回前页面？")) {
		return;
	}
	fncExtraFormCancel('<c:url value="/basicInfor/acconditionManage/accondition.action"/>');
}
</script>
</head>
<body onload="fncFixupListHead();">
	<div id="Lcontent">
		<SSTag:navigation />    
         <form id="formPage" method="post" >
			<!-- 滚动条设置 -->
			<c:if test="${!empty page.result}">
				<div id="resultDiv"
					style="width: 1000px;overflow-x:scroll;<c:if test="${page.pageSize >10}">overflow-y:scroll;height:280px;</c:if>">
					<table  id="listTab" style="width: 1000px;">
						</c:if>
						<c:if test="${empty page.result}">
							<table  id="listTab" style="width: 1000px;">
								</c:if>
									<tr>
										<td colspan="2"><b>添加</b></td>
									</tr>
									<tr>
										<td><font color="red">*</font>流程节点</td>
										<td nowrap="nowrap" align="left" class=''><input type="hidden" id="actype" name="actype">
										<input type="text" id="typename" name="typename"  size="60"/>
										<image src="/archive/images/pbf/Content_icon_search.gif" onclick="showArchiveTypeWindow()"/></td>
									</tr>
									<tr>
										<td><font color="red">*</font>条件名称</td>
										<td nowrap="nowrap"  align="left">
										<input type="text" id="acname" name="acname"  size="60"></td>
									</tr>
									<tr>
										<td><font color="red">*</font>条件描述</td>
										<td nowrap="nowrap"  align="left">
										<textarea id="acdesc" name="acdesc" rows="6" cols="60"></textarea>
										</td>
									</tr>
									<tr>
										<td><font color="red">*</font>条件重要性</td>
										<td nowrap="nowrap">
										  <select  id="acimpt" name="acimpt">
										  	<option value="0">必需</option>
										  	<option value="1">非必需</option>
										  </select>
				
										</td>
									</tr>
								<!-- 滚动条设置 -->
							</table>
							<fieldset>
						<legend>Button</legend>
							<ul class="LbtnArea">
								<li><input type="button" value="保存" onclick="fncInp()"
									id="btnSave" objType="bSave" /> <input type="button" value="取消"
									onclick="fncCancel()" id="btnCancel" objType="bCancel" />
								</li>
							</ul>
					 </fieldset>
							</div>
								</form>
							</div>	
								
				</div>			
</body>
</html>