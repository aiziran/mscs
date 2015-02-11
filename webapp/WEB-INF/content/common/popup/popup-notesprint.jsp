<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<html>
<head>
<title>打印记录列表</title>
<base target="_self">
<%@ include file="/common/header.jsp"%>
</head>
<body >	
		<form id="formPage" method="post" action="${ctx}/common/popup/popup!printNotes.action">								
					<table  class="LlistArea">
						<tr>
							<th>档案打印记录表id</th>
							<th>档案编号</th>
							<th>档案名称</th>
							<th>使用人</th>
							<th>打印时间</th>
							<th>操作用户</th>
							
						</tr>
						<c:forEach items="${page.result}" var="printnotes" varStatus="inx">
								<c:set var="index" value="${inx.index}" />
							<tr onMouseOver="cfListOver(this)" onMouseOut="cfListOut(this)" >
							   <td>
							   	    <c:out value="${printnotes.id}" />
							   </td>
								<td>
									<c:out value="${printnotes.aid}" />
								</td>
								<td>
									
									<c:out value="${printnotes.aname}" />
								</td>
								<td>
									<c:out value="${printnotes.user}" />
								</td>
								<td>
									<c:out value="${printnotes.printtime}" />
								</td>
								<td>
									<c:out value="${printnotes.operateuser}" />
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
