<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>档案新增</title>
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
	//验证表单
	function fncInp(){
		if(document.getElementById("archivesnum").value==""){
			alert("档案室编号不能为空");
			return false;
		}
		if(!/^[0-9]*$/.test(document.getElementById("archivesnum").value)){
			alert("档案室编号只能是数字！！！");
			return false;
		}
		if(document.getElementById("archivesname").value==""){
			alert("档案室名称不能为空");
			return false;
		}
		actSubmit($('#formPage'),'<c:url value="test!input.action"/>');
	}
	//返回操作
	function fncDel(){
		window.location.href="test.action";
	}
	//验证档案室编号是否重复
	function fncCheckRepeat() {
		var archivesnum = $("#archivesnum").val();
		if (archivesnum == "")
			return;

		$
				.ajax({
					type : "POST",
					url : '<c:url value="/basicInfor/testManage/test!checkArchivesnum.action"/>',
					data : "archivesnum=" + archivesnum,
					async : false,
					success : function(flag) {
						if (flag == "false") {
							alert("编号（" + archivesnum + "）已是使用 !");
							$("#archivesnum").val("").focus();
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
	<SSTag:navigation/>
		<form id="formPage" method="post" >
				<div id="resultDiv"	style="width: 800px;"">
					<table class="LDetailArea" id="listTab" style="width:800px">
								<tr><td colspan="2"><h1 align="center">新增档案室</h1></td></tr>
										<tr>
										<th ><font color="red">*</font>档案室名称：</th>
										<td  >
										<input type="text" id="archivesname" name="archivesname"  >
										</td>
									</tr>	
									<tr>
										<th><font color="red">*</font>档案室编号：</th>
										<td nowrap="nowrap">
										<input type="text" id="archivesnum" name="archivesnum" onblur="fncCheckRepeat()" >
										</td>
									</tr>
								</div>
							</table>
								</form>
								<fieldset>
				<legend>Button</legend>
				<ul class="LbtnArea" >
					<li>
						<input type="button" value="返回" onclick="fncDel()" id="btnAdd" />
					</li>
					<li>
						<input type="button" value="增加" onclick="fncInp()" id="fncUpd" />
					</li>
				</ul>
			</fieldset>
							</div>
							</div>
							<!-- END content -->
</body>
</html>