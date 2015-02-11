<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<html>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript" src="/archive/ckeditor/ckeditor.js"></script>
<meta http-equiv="refresh" content="5" />
<script type="text/javascript" language="javascript">
	//进入修改页面
	function fncDetail(obj) {
		$('#id').val(obj);		
		actSubmit($('#formPage'),'<c:url value="/basicInfor/acconditionManage/accondition!selectOne.action"/>');
	}
	//进入新增页面
	function fncAdd() {
		actSubmit($('#formPage'),'<c:url value="/basicInfor/acconditionManage/accondition!create.action"/>');
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
				'<c:url value="accondition!deleteAll.action"/>');
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
	
	function deleteRelation(id)
	{
		//archivecondition!deleteId.action?id=${id}
		$.ajax({
			type:"POST",
			url: "<c:url value="/basicInfor/archiveconditionManage/archivecondition!deleteId.action"/>",
			data: 'id='+id,
			async:true,
			success:function(flag){
				alert("删除成功!");
				//alert('2222'+top.window.parent.frames[1].id);
				//window.close();
			}
		});
	}
	
</script>

<body onload="fncFixupListHead();">
	<div id="Lcontent">
		<SSTag:navigation />
			<div id="LsearchArea">

<form id="formPage" method="post">
			<input type="hidden" name="id" id="id" />
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
									<!-- 滚动条设置-end -->
									<th><input type="checkbox" name="selectAll" id="selectAll"  onclick="fncCheckAll(this);"/></th>
									<th>id</th>
									<th>archiveid</th>
									<th>acconid</th>
									<th>conddesc</th>
									
									
									<th>删除</th>
									
								</tr>
								<s:iterator value="page.result" status="st">
									<tr nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)">
									
										<td ><input type="checkbox" name="checkBox" id="checkBox" value="${id}"/></td>
										
										<td onClick="fncDetail('${id}')">${id}</td>
										<td onClick="fncDetail('${id}')">${archiveid}</td>
										<td onClick="fncDetail('${id}')">${acconid}</td>
										<td onClick="fncDetail('${id}')">${conddesc}</td>
										
										
										<td><a href="#" onclick="deleteRelation('${id}')">删除</a>
										
										</td>
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
									<td colspan="20" class="AreaLeft"><%@ include
											file="/common/page.jsp"%> <!-- LPAGE JavaScript Start --></td>
								</tr>
							</table>
				</form>
				
				
				
				
				
				
				
					
		   
		    <fieldset>
				<legend>Button</legend>
				<ul class="LbtnArea">
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
							<!-- END content -->
	</body>
	</html>