<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<html>
<head>
<title>借出记录列表</title>
<base target="_self">
<%@ include file="/common/header.jsp"%>
</head>
<body >	
		<form id="formPage" method="post" action="${ctx}/common/popup/popup!loanNotes.action">								
					<table class="LlistArea">
						<tr>
							<th>档案借出记录id</th>
							<th>档案名称</th>
							<th>借出时间</th>
							<th>借阅人</th>
							<th>归还时间</th>
							<th>借阅原因</th>
							
						</tr>
						<c:forEach items="${page.result}" var="loannotes" varStatus="inx">
								<c:set var="index" value="${inx.index}" />
							<tr >
							   <td>
							       ${loannotes.id} 
							   </td>
								<td>
									${loannotes.archivename}
								</td>
								<td>
								   ${loannotes.lendtime}
								</td>
								<td>
								   ${loannotes.user}
								</td>
								<td>
									${loannotes.returntime}
								</td>
								<td>
								    ${loannotes.reason}
								</td>
							</tr>
						</c:forEach>
						
						<tr>
							<td colspan="6" ><!-- LPAGE JavaScript Start --> 
								<%@ include file="/common/page.jsp" %>														
							</td>
						</tr>
					</table>
			</form>	
					
			<fieldset>
				<legend>Button</legend>
				<ul class="LbtnArea">
					<li>
						<input type="button" value="确定" onclick="fncRevert()" id="btnAdd"/>
					</li>
				</ul>
			</fieldset>	
</body>
<script type="text/javascript" language="javascript">
function fncRevert() 
{ 
	 window.close(); 
} 
</script>
</html>
