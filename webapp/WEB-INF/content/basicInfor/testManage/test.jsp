<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp" %>
<html>
<head>
	<title>档案室列表</title>
	<%@ include file="/common/header.jsp" %>
	<script type="text/javascript" language="javascript">
	//进入修改页面
	function fncDetail(obj) {
		$('#detailUserId').val(obj);		
		actSubmit($('#formPage'),'<c:url value="test!SelectOne.action"/>');
	}
	
	//进入新增页面
	function fncAdd() {
		actSubmit($('#formPage'),'<c:url value="test!create.action"/>');
	}
	//删除复选框选择
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
				'<c:url value="test!deleteAll.action"/>');
	}
	//复选框全选
	 function fncCheckAll(field){  
        var checkboxes = document.getElementsByName("checkBox");  
        for(var i=0;i<checkboxes.length;i++){  
            checkboxes[i].checked = field.checked;  
         }  
     } 
	 
	// 固定表头
    function fncFixupListHead(){  
	    var tab = document.getElementById("listTab");
		if(tab) fixupFirstRow(tab);
		
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
		<form id="formPage" method="post">	
			<input type="hidden" name="detailUserId" id="detailUserId" />		
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
							<th><input type="checkbox" name="selectAll" id="selectAll"  onclick="fncCheckAll (this);"/></th>
							<th>档案室编号</th>
							<th>档案室名称</th>
							<th>删除</th>
						</tr>
							<s:iterator value="page.result" status="st">
									<tr >
								<td><input type="checkbox" name="checkBox" id="checkBox" value="${id}"/></td>
								<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
									onClick="fncDetail('${id}')">${archivesnum}</td>
								<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
									onClick="fncDetail('${id}')">${archivesname}</td>
								<td nowrap="nowrap"><a href="test!deleteDo.action?aid=${id}">删除</a></td>
							</tr>
							</s:iterator>
							
			
							
							<!-- 滚动条设置 -->
							<c:if test="${!empty page.result}">
						</table>
						</div>
						<table class="LlistArea" style="width: 1000px;">
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
				<ul class="LbtnArea" >
					<li>
						<input type="button" value="删除" onclick="fncDel()" id="btnDel" />
					</li>
					<li>
						<input type="button" value="新增" onclick="fncAdd()" id="btnAdd" />
					</li>
					
				</ul>
			</fieldset>
			<br />
							</div>
							</div>
		<br/>
	</div>
	
<!-- END content -->
</body>
</html>