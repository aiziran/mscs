<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>页面</title>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript"
	src="${ctx }/js/DatePicker/WdatePicker.js">
</script>
<script type="text/javascript" language="javascript">
	
	function fncDel() {
		 var a = document.getElementsByName("checkBox"); 
		   var n = a.length;
		   var k = 0;
		   for (var i=0; i<n; i++){
		        if(a[i].checked){
		            k = 1; }
		   }     
		        if(k==0){
		        alert("请选中所要删除的信息！!");
		        return; 
		   }
	 if (!confirm("请确认是否提交？")) return;       
		actSubmit($('#formPage'),
				'<c:url value="/basicInfor/logManage/log!deleteDo.action"/>');
	}
	
	function fncDelAll() {
		
	 if (!confirm("请确认是否删除所有日志"));     
		actSubmit($('#formPage'),
				'<c:url value="/basicInfor/logManage/log!deleteAll.action"/>');
	}
	
	 function fncCheckAll(field){  
         var checkboxes = document.getElementsByName("checkBox");  
         for(var i=0;i<checkboxes.length;i++){  
             checkboxes[i].checked = field.checked;  
          }  
      } 
	 

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
</script>
</head>

<body onload="fncFixupListHead();">
	<div id="Lcontent">
	<SSTag:navigation/>
		<div id="LsearchArea">
			<form id="formSearch" name="formSearch" method="post" class="enterhandler" 
				   action="<c:url value="/basicInfor/logManage/log.action"/>" onEnter="this.submit()">
					<input type="hidden" id="mark" name="mark" value="search"/>
					<div>
			<ul>
			<li>
					<label for="actionname" style="width:56px">操作名称:</label> 
					<input type="text"   name="actionname" id="actionname"  
					 maxlength="50" class="Lbordercolor"  size="20"
					  style="float:left;margin-right: 10px;"
					  value="${seachInfor.actionname }"   />
			</li>
			
			<li>
				<label for="loginuser" style="width:65px">操作人姓名:</label> 
				
				   <input type="text" name="loginuser2" id="loginuser2" maxlength="150" 
						class="Lbordercolor" style="float:left;margin-right: 10px;"
						value="${seachInfor.loginuser2}" /> 
			
			</li>
					
			<li>
					<label for="TimeStart2" style="width:28px">时间:</label> 
					<input type="text" name="TimeStart2" id="TimeStart2" maxlength="150" 
						class="Wdate" onclick="WdatePicker()" readonly="readonly" size="12"
						 style="BACKGROUND-COLOR: #EEFFB6;float:left;margin-right: 5px;"
						 value="${seachInfor.TimeStart2}" />
				    <label for="TimeEnd2" style="width:5px">~</label> 
					<input type="text" name="TimeEnd2" id="TimeEnd2" maxlength="150" 
						class="Wdate" onclick="WdatePicker()" readonly="readonly" size="12"
						 style="BACKGROUND-COLOR: #EEFFB6;float:left;margin-right: 5px;"
						 value="${seachInfor.TimeEnd2}" />		
			</li>
					</ul>
				</div>
					<input id="LsearchIcon" type="image" src="${ctx}/images/btn_search_e_g.gif" alt="Search" />
				</p>
			</form>
		</div>
	<form id="formPage" method="post"
		action="<c:url value="/basicInfor/logManage/log.action"/>">
		<input type="hidden" name="id" id="id" value="${id}" />
		<!-- 滚动条设置 -->
		<c:if test="${!empty page.result}">
			<div id="resultDiv"
				style="width: 1000px;overflow-x:scroll;<c:if test="${page.pageSize >10}">overflow-y:scroll;height:280px;</c:if>">
				<table class="LlistArea" id="listTab" style="width: 1000px;">
					</c:if>
					<c:if test="${empty page.result}">
						<table class="LlistArea" id="listTab">
							</c:if>
							<tr>
							<th>
							<input type="checkbox" name="selectAll" id="selectAll"  onclick="fncCheckAll(this);"/></th>
							<th>操作名称</th>
							<th>执行时间</th>
							<th>IP地址</th>
							<th>操作人姓名</th>
								
							</tr>
							<s:iterator value="page.result" status="st">
								<tr onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)">
									<td><input type="checkbox" name="checkBox" id="checkBox" value="${id}"/></td>
									<td >${actionname}</td>
									<td >${actiontime}</td>
									<td >${actionip}</td>
									<td >${loginuser}</td>
									
									
					</tr>
							</s:iterator>
							
			
							
							<!-- 滚动条设置 -->
							<c:if test="${!empty page.result}">
						</table>
						</div>
						<table class="LlistArea">
							</c:if>
							<!-- 滚动条设置-end -->
							<tr>
								<td colspan="20" class="AreaLeft">
								<%@ include file="/common/page.jsp" %>
									<!-- LPAGE JavaScript Start --></td>
							</tr>
						</table>

						</form>
						<!-- 滚动条设置-end -->
						<fieldset>
							<legend>Button</legend>
							<ul class="LbtnArea">
								
								<li><input type="button" value="删除" onclick="fncDel()"
									id="fncDel" objType="fncDel" />
								</li>
								<li><input type="button" value="清空日志" onclick="fncDelAll()"
									id="fncDelAll" objType="fncDelAll" />
								</li>
							</ul>
						</fieldset>
						<br />
						</div>
						</div>

						<!-- END content -->
</body>
</html>