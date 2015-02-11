<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>档案柜格子</title>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript" language="javascript">
	//进入修改页面
		function fncDetail(obj) {
		$('#gridid').val(obj);
		actSubmit($('#formPage'),
				'<c:url value="grid!select.action"/>');
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
				'<c:url value="grid!delete.action"/>');
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
	//新增
	 function fncCre(){  
		 window.location.href="grid!create.action";
     } 
</script>
</head>

<body onload="fncFixupListHead();">
	<div id="Lcontent">
	<SSTag:navigation/>
	<div id="LsearchArea">
	<form id="formSearch" name="formSearch" method="post" class="enterhandler" style="width: 1000px;"
				  action="<c:url value="/basicInfor/gridManage/grid.action"/>" onEnter="this.submit()">		
			<div>
				<ul>
					<li>
						<label for="gridId" style="width:60px">格子编号:</label> 
						<input type="text" name="queryGridId" class="Lbordercolor" 
								   value="${data.queryGridId}" size="13" style="margin-right: 10px;"/>
					</li>
					<li>
						<label for="cabinetId" style="width:60px">柜子编号:</label> 
						<input type="text" name="queryCabinetId" class="Lbordercolor" 
								   value="${data.queryCabinetId}" size="13" style="margin-right: 10px;"/>
					</li>
					<li>
						<label for="archiveId" style="width:70px">档案室编号:</label> 
						<input type="text" name="queryArchiveId" class="Lbordercolor" 
								   value="${data.queryArchiveId}" size="13" style="margin-right: 10px;"/>
					</li>
				</ul>
			</div>
			<p>
					<input id="LsearchIcon" type="image" src="${ctx}/images/btn_search_e_g.gif" alt="Search" />
				</p>
	</form>
	</div>
		<form id="formPage" method="post">
			<input type="hidden" name="gridid" id="gridid" />
				<div id="resultDiv"	style="width: 1000px;">
					<table class="LlistArea" id="listTab" style="width: 1000px;">
								<tr>
									<!-- 滚动条设置-end -->
									<th><input type="checkbox" name="selectAll" id="selectAll"  onclick="fncCheckAll(this);"/></th>
									<th>格子编号</th>
									<th>柜子编号</th>
									<th>所在档案室编号</th>
									<th>所在档案室名</th>
									<th>备注</th>
								</tr>
								<s:iterator value="page.result" status="st">
									<tr >
										<td><input type="checkbox" name="checkBox" id="checkBox" value="${gridid}"/></td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${gridid}')">${gridnum}</td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${gridid}')">${cabinetnum}</td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${gridid}')">${archivesnum}</td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${gridid}')">${archivesname}</td>
										<td nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										onClick="fncDetail('${gridid}')">${remark}</td>
									</tr>
								</s:iterator>
							</table>
							</div>
							<table class="LlistArea" style="width: 1000px;">
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
						<input type="button" value="删除" onclick="fncDel()" id="btnAdd" />
					</li>
					<li>
						<input type="button" value="新增" onclick="fncCre()" id="fncUpd" />
					</li>
				</ul>
			</fieldset>
							<br />
							</div>
							</div>
</body>
</html>