<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>邮件内容</title>
<link rel="stylesheet" type="text/css" href="${ctx}/css/css.css">
<script src="${ctx}/js/dropdown.js" type="text/javascript"></script>
<script type="text/javascript" src="/archive/ckeditor/ckeditor.js"></script>
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
	//答复
	function reply() {
		actSubmit($('#formPage'),
				'<c:url value="../emailManage/email!replyEmail.action "/>');
	}
	//转发
	function forward() {
		actSubmit($('#formPage'),
				'<c:url value="../emailManage/email!forwardEmail.action "/>');
	}

	//下载
	function down() {
		actSubmit($('#formPage'),
				'<c:url value="../emailManage/email!downAnnex.action "/>');
	}
</script>
</head>
<body onload="fncFixupListHead();">

	<div id="Lcontent">
		<c:if
			test="${emailDate.ownertype eq 2 and emailDate.owner eq userID }">
			<div id="header"></div>
			<div id="topmenu">
				<div id="navMenu">
					<ul>
						<li><a href="../emailManage/email!createEmail.action">新建</a>
						</li>
						<li><a href="#" onclick="reply()">答复</a></li>
						<li><a href="#" onclick="forward()">转发</a></li>

					</ul>
				</div>
				<div style="clear: both;"></div>
			</div>
			<script type="text/javascript">
				cssdropdown.startchrome("navMenu")
			</script>
		</c:if>
	
		<form id="formPage" method="post">
			<!-- 滚动条设置 -->
            
			<input type="hidden" name="sendto" value="${emailDate.sendto }">
			<input type="hidden" name="messagehidden" value="${emailDate.message }">
			<input type="hidden" name="annex" value="${emailDate.annex }">
			<input type="hidden" name="theme" value="${emailDate.theme }"> 
		
			<div style="clear:both;"></div>
			<div id="LsearchArea">
				<font color="blue">${userID}</font> <br> <br> <a
					href="../emailManage/email.action">收件箱</a> <a
					href="../emailManage/email!sendSuccess.action">发送箱</a> <a
					href="../emailManage/email!selectDeleted.action">删除箱</a> <a
					href="../emailManage/email!selectDelSuc.action">垃圾箱</a>
			</div>


			<table class="LlistArea" id="listTab">

				<c:choose>

					<c:when test="${emailDate.sendto eq userID }">
						<tr>
							<td><b>收件人</b></td>
							<td align="left">${emailDate.owner}</td>
						</tr>
					</c:when>


					<c:otherwise>
						<tr>
							<td><b>发件人</b></td>
							<td align="left">${emailDate.sendto}</td>
						</tr>
					</c:otherwise>

				</c:choose>


				<tr>
					<td><b> 主题</b></td>
					<td align="left">${emailDate.theme}</td>
				</tr>
				<tr>
					<td><b> 时间</b></td>
					<td align="right">${emailDate.createtime }</td>

				</tr>

				<tr>
					<td colspan="2"><a href="#" onclick="down()">
					${emailDate.filename}</a></td>
				</tr>

				<!-- 滚动条设置 -->
			</table>
          <div>
			<textarea cols="300" id="message" name="message" rows="100">
								      ${emailDate.message }</textarea>
			<script language="javascript">
				CKEDITOR
						.replace(
								'message',
								{
									fullPage : true,
									extraPlugins : 'docprops',
									filebrowserUploadUrl : '${ctx}/basicInfor/newsinfoManage/newsinfo!savepic.action'
								});
			</script>
			</div>
			<div style="clear:both;"></div>
	</div>

	</form>


	<!-- END content -->


</body>
</html>