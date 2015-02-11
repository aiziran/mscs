<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<html>
<head>
<title>导出日志录列表</title>
<base target="_self">
<%@ include file="/common/header.jsp"%>
</head>
<body >	
		<form id="formPage" method="post" action="${ctx}/common/popup/popup!exportNotes.action">								
					<table  class="LlistArea">
						<tr>
							<th>导出日志表id</th>
							<th>档案名称</th>
							<th>使用人</th>
							<th>导出时间</th>
							<th>操作员</th>
							
						</tr>
						<c:forEach items="${page.result}" var="exportnotes" varStatus="inx">
								<c:set var="index" value="${inx.index}" />
							<tr onMouseOver="cfListOver(this)" onMouseOut="cfListOut(this)" >
							   <td>
							   	    <c:out value="${exportnotes.id}" />
							   </td>
								<td>
									<c:out value="${exportnotes.archivename}" />
								</td>
								<td>
									<c:out value="${exportnotes.user}" />
								</td>
								<td>
									<c:out value="${exportnotes.exporttime}" />
								</td>
								<td>
									<c:out value="${exportnotes.operateuser}" />
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
