<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>公告列表</title>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript" language="javascript">
	//进入查询页面
		function fncDetail(obj) {
		
		$('#id').val(obj);
		actSubmit($('#formPage'),
				'<c:url value="notice!select.action"/>');
	}
	//删除操作
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
				'<c:url value="notice!delete.action"/>');
	}
	//修改操作
	function btnUpd() {
		 var a = document.getElementsByName("checkBox"); 
		   var n = a.length;
		   var k = 0;
		   var b=0;
		   for (var i=0; i<n; i++){
		        if(a[i].checked){
		            k = 1; 
		            b=b+k;
		            }
		   } 
		   		if(b>1){
		   			alert("只能修改一条信息！");
		   			return;
		   		}
		        if(k==0){
		        alert("请选中所要修改的信息！");
		        return; 
		   }
	 if (!confirm("请确认是否提交？")) return;       
		actSubmit($('#formPage'),
				'<c:url value="notice!selectOne.action"/>');
	}
	//增加操作
	function fncAdd() {
		actSubmit($('#formPage'),
		'<c:url value="notice!create.action"/>');
	}
	//置顶操作
	function fncChange(id) {
		window.location.href="notice!homePage.action?id="+id;
	}
	//复选框全选
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
		<SSTag:navigation />
		<form id="formPage" method="post">
			<input type="hidden" name="id" id="id" />
			<!-- 滚动条设置 -->
			<c:if test="${!empty page.result}">
				<div id="resultDiv"	style="width: 1000px;<c:if test="${page.pageSize >10}">overflow-y:scroll;height:280px;</c:if>">
					<table class="LlistArea" id="listTab" style="width: 1000px;">
						</c:if>
						<c:if test="${empty page.result}">
							<table class="LlistArea" id="listTab">
								</c:if>
								<tr>
									<!-- 滚动条设置-end -->
									<th>
									<input type="checkbox" name="selectAll" id="selectAll"  onclick="fncCheckAll(this);"/></th>
									<th>添加人</th>
									<th>公告标题</th>
									<th>置顶时间</th>
									<th>所属部门</th>
									<th>有效期</th>
									<th>置顶</th>
								</tr>
								<s:iterator value="page.result" status="st">
									<tr >
										<td><input type="checkbox" name="checkBox" id="checkBox" value="${id}"/></td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${id}')">${uname}</td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${id}')">${title}</td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${id}')">${sethomepagetime }</td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${id}')">${dname}</td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${id}')">${validity}</td>
										<td >
										<c:if test="${ishomepage==1 }">已置顶</c:if>
										<c:if test="${ishomepage==0 }"><input type="button" value="置顶" onClick="fncChange(${id})"></c:if>
										</td>
									</tr>
								</s:iterator>
							<!-- 滚动条设置 -->	
						<c:if test="${!empty page.result}">
							</table>
							</div>
							<table class="LlistArea" >
									</c:if>
								<tr>
									<td colspan="20" class="AreaLeft"><%@ include
											file="/common/page.jsp"%> <!-- LPAGE JavaScript Start --></td>
								</tr>
							</table>
							</form>
								<fieldset>
				<legend>Button</legend>
				<ul class="LbtnArea" >
					<li>
						<input type="button" value="删除" onclick="fncDel()" id="btnDel" />
					</li>
						<li>
						<input type="button" value="修改" onclick="btnUpd()" id="btnUpd" />
					</li>
					<li>
						<input type="button" value="新增" onclick="fncAdd()" id="btnAdd" />
					</li>
					
				</ul>
			</fieldset>
							<br />
							</div>
							</div>
							<!-- END content -->
</body>
</html>