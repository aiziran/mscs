<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>柜子列表</title>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript" language="javascript">
	//进入修改页面
		function fncDetail(obj) {
		
		$('#cabinetid').val(obj);
		actSubmit($('#formPage'),
				'<c:url value="cabinet!select.action"/>');
	}
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
				'<c:url value="cabinet!delete.action"/>');
	}
	//复选框全选
	 function fncCheckAll(field){  
         var checkboxes = document.getElementsByName("checkBox");  
         for(var i=0;i<checkboxes.length;i++){  
             checkboxes[i].checked = field.checked;  
          }  
      } 
	//新增
	 function fncAdd(){  
        window.location.href="cabinet!create.action";
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
		<div id="LsearchArea">
	<form id="formSearch" name="formSearch" method="post" class="enterhandler" style="width: 1000px;"
				  action="<c:url value="/basicInfor/cabinetManage/cabinet.action"/>" onEnter="this.submit()">		
			<div>
				<ul>
					
					<li>
						<label for="cabinetId" style="width:60px">柜子编号:</label> 
						<input type="text" name="queryCabinetId" class="Lbordercolor" 
								   value="${data.queryCabinetId }" size="13" style="margin-right: 10px;"/>
					</li>
					<li>
						<label for="archiveId" style="width:70px">档案室编号:</label> 
						<input type="text" name="queryArchiveId" class="Lbordercolor" 
								   value="${data.queryArchiveId }" size="13" style="margin-right: 10px;"/>
					</li>
					<li>
						<label for="archiveName" style="width:60px">档案室名:</label> 
						<input type="text" name="queryArchiveName" class="Lbordercolor" 
								   value="${data.queryArchiveName }" size="13" style="margin-right: 10px;"/>
					</li>
				</ul>
			</div>
			<p>
					<input id="LsearchIcon" type="image" src="${ctx}/images/btn_search_e_g.gif" alt="Search" />
				</p>
	</form>
	</div>
		<form id="formPage" method="post">
			<input type="hidden" name="cabinetid" id="cabinetid" />
			<!-- 滚动条设置 -->
			<c:if test="${!empty page.result}">
				<div id="resultDiv"
					style="width: 1000px;">
					<table class="LlistArea" id="listTab" style="width: 1000px;">
						</c:if>
						<c:if test="${empty page.result}">
							<table class="LlistArea" id="listTab">
								</c:if>
								<tr>
									<!-- 滚动条设置-end -->
									<th><input type="checkbox" name="selectAll" id="selectAll"  onclick="fncCheckAll(this);"/></th>
									<th>柜子编号</th>
									<th>所在档案室编号</th>
									<th>所在档案室名</th>
								</tr>
								<s:iterator value="page.result" status="st">
									<tr >
										<td><input type="checkbox" name="checkBox" id="checkBox" value="${cabinetid}"/></td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${cabinetid}')">${cabinetnum}</td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${cabinetid}')">${archivesnum}</td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${cabinetid}')">${archivesname}</td>
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
							<!-- END content -->
</body>
</html>