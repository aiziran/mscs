<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!--  
/**
 * ------------------------------------------------------------------------
 * @source  : listCode.jsp
 * @desc    : 查询公告详细信息popup页面
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.05.29  houyingchang       初次建立
 * ------------------------------------------------------------------------ 
 */
 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查询公告详细信息popup页面</title>
</head>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript"
	src="${ctx }/js/DatePicker/WdatePicker.js"></script>
<body >
	<div id="Lcontent">
  	<div>
    	<form id="formDetail" name="formDetail" method="post" class="enterhandler" onEnter="fncSearch()">
	    	<table class="LDetailArea">
				<tr>
					<th style="width:5%">标题:</th>
					<td><c:out value="${data.noticeTitle}"/></td>
				</tr>
				<tr>
					<th style="width:5%">日期:</th>
					<td><c:out value="${data.createDate}"/></td>
				</tr>
				<tr>
					<th vAlign="top" style="width:5%">内容:</th>
					<td vAlign="top" id="content"></td>
					<textarea id="area" style="width: 0px" rows="0"><c:out value="${data.noticeContent }"/></textarea>
					<script>
						document.getElementById("content").innerText = document.getElementById("area").value;
					</script>
				</tr>
			</table>
		</form>
	</div>
  	<fieldset>
  		<legend>Button</legend>
    	<ul class="LbtnArea">
      		<li><label for="btnClose">Close</label><input type="button" value="关闭" onclick="window.close()" id="btnClose"/></li>
    	</ul>
  	</fieldset>
</div>
</body>
</html>