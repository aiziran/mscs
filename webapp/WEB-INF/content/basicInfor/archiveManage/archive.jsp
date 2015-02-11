<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--
/**
 * ------------------------------------------------------------------------
 * 档案列表界面
 * ------------------------------------------------------------------------
 * ------------------------------------------------------------------------ 
 */
--%>
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>页面</title>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript" language="javascript">
	//进入修改页面
	function fncDetail(obj) {
		$('#id').val(obj);
		actSubmit($('#formPage'),
				'<c:url value="/basicInfor/archiveManage/archive!updateInput.action"/>');
	}

	//进入新增页面
	function fncAdd() {
		actSubmit($('#formPage'),
				'<c:url value="/basicInfor/archiveManage/archive!createInput.action"/>');
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
	function fncDel() {
		 var a = document.getElementsByName("checkself"); 
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
				'<c:url value="archive!deleteAll.action"/>');
	}
	//复选框全选
	 function CheckedAll(field){  
	        var checkboxes = document.getElementsByName("checkself");  
	        for(var i=0;i<checkboxes.length;i++){  
	            checkboxes[i].checked = field.checked;  
	         }  
	     } 
	  
	function saveCheckedValue(name){
		
		var id="";
		var names="";
		var all=document.getElementsByName('checkself');
		var allnames=document.getElementsByName(name);
		var checkedid=document.getElementById('checkedid');
		var checkednames=document.getElementById('checkednames');
		for(var i=0;i<all.length;i++){
			if(all[i].checked){
				if(id.length==0){
					id=all[i].value;
					names=allnames[i].value;
					
					continue;
				}
				id=id+","+all[i].value;
				names=names+","+allnames[i].value;
			}
		}
		checkedid.value=id;
		checkednames.value=names;
	}
	function CheckedSelf(obj){
		saveCheckedValue('names');
	}
	function loan(){
		saveCheckedValue('names');
		var checkedid=document.getElementById('checkedid');
		var checkednames=document.getElementById('checkednames');
		var url = "<c:url value='/common/popup/popup!loan.action?checkedid="+checkedid.value+"&checkednames="+checkednames.value+"'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=400px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
	}
	//借出记录
	function showChildWindow2(){
		var url = "<c:url value='/common/popup/popup!loanNotes.action'/>"; 
		var strFeatures="dialogWidth=550px;dialogHeight=500px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
	}
	//打印记录 
	function showChildWindow3(){
		var url = "<c:url value='/common/popup/popup!printNotes.action'/>"; 
		var strFeatures="dialogWidth=550px;dialogHeight=500px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
	}
	
	//打印二维码 
	function showChildWindow5(){
		 var a = document.getElementsByName("checkself"); 
		   var n = a.length;
		   var k = 0;
		   for (var i=0; i<n; i++){
		        if(a[i].checked){
		            k = 1; }
		   }     
		        if(k==0){
		        alert("请选中所要操作的信息！!");
		        return; 
		   }
		        actSubmit($('#formPage'),
				'<c:url value="archive!exportDimension.action"/>');
// 		var url = "<c:url value='/common/popup/popup!exportDimension.action'/>"; 
// 		var strFeatures="dialogWidth=550px;dialogHeight=500px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
// 		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
	}

	//档案类型
	function showChildWindow1() 
	{ 
  		
		var url = "<c:url value='/common/popup/popup!myType.action'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
		if(aa){
			$('#type').val(aa.split(";")[0])
			$('#typename').val(aa.split(";")[1])
		} 
	}
</script>
</head>

<body onload="fncFixupListHead();">
<div id="Lcontent">
	<SSTag:navigation/>
		<div id="LsearchArea">
			<form id="formSearch" name="formSearch" method="post" style="width: 1000px;"
				class="enterhandler"  action="<c:url value="/basicInfor/archiveManage/archive.action"/>">
				<div><table>
					<tr>
							<th>联系人:</th> 
							<td><input type="text" id="qlinkman" name="linkman" class="Lbordercolor" value="${data.linkman}" />
								<input type="hidden" id="contractid" name="contractid value="${data.contractid }"></td>
						
							<th>档案类型:</th> 
							<td><input type="text" id="typename" name="typename" class="Lbordercolor" value="${data.typename}" readonly />	
							<input type="hidden" id="type" name="type" value="${data.type }">
									<img src="/archive/images/pbf/Content_icon_search.gif" class="btn_img"
											onClick="javascript:showChildWindow1();"
											style="cursor: hand; margin-right: 10px" /></td>
				
							<th>档案名称:</th> 
							<td><input type="text" id="name" name="name" class="Lbordercolor" value="${data.name}"/></td>
							<th>合同单位:</th> 
							<td><input type="text" id="unit" name="unit" class="Lbordercolor" value="${data.unit}"/></td>
					</tr>	
				</table>
				</div>
				<p>
					<input id="LsearchIcon" type="image" src="${ctx}/images/btn_search_e_g.gif" alt="Search" />
				</p>
			</form>
		</div>
	<!-- END sbox -->
	<!--AREA [View]-->
	<form id="formPage" method="post">
		<input type="hidden" name="id" id="id" value="${id}" />
			<input type="hidden" name="contractid" id="contractid" value="${contractid }" />
		<input type="hidden" name="checkedid" id="checkedid" value="" />
		<input type="hidden" name="checkednames" id="checkednames" value="" />
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
								
								<th><input type="checkbox" id="checkedALl" name="checkedALl" onclick="CheckedAll(this)"/></th>
								<th>档案编号</th>
								<th>档案名称</th>
								<th>存档人</th>
								<th>档案类型</th>
								<th>归档时间</th>
								<th>扫描件</th>
								<th>附件</th>
								<th>档案数量</th>
								<th>是否原件</th>
								<th>录入人</th>
								<th>档案过期时间</th>
								<th>状态(借出 在档)</th>
							</tr>
							<s:iterator value="page.result" status="st">
								<tr onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
									>
									
									<td ><input type="checkbox" id="checkself" name="checkself" value="${id}" onClick="CheckedSelf(this)"/></td>
									<td onClick="fncDetail('${id}')">${archivenum}</td>
									<input type="hidden" name="names" id="names" value="${name}" />
									<td onClick="fncDetail('${id}')">${name}</td>
										<td onClick="fncDetail('${id}')">${archivepeople}</td>
									<td onClick="fncDetail('${id}')">${typename}</td>
								
									<td onClick="fncDetail('${id}')">${createtime}</td>
									<td onClick="fncDetail('${id}')">${scancount}</td>
									<td onClick="fncDetail('${id}')">${annexcount}</td>
									<td onClick="fncDetail('${id}')">${archivecount}</td>
									<td onClick="fncDetail('${id}')">
									<c:if test="${isoriginal eq 0 }">是</c:if>
									<c:if test="${isoriginal eq 1 }">否</c:if>
									<td onClick="fncDetail('${id}')">${inputuser}</td>
									<td onClick="fncDetail('${id}')">${expirationdate}</td>
									<td onClick="fncDetail('${id}')">
									<c:if test="${status eq 0 }">在库</c:if>
									<c:if test="${status eq 1 }">借出</c:if>
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
								<td colspan="20" class="AreaLeft">
								<%@ include file="/common/page.jsp" %>
									<!-- LPAGE JavaScript Start --></td>
							</tr>
						</table>

			</form>
			<!-- 滚动条设置-end -->
			<c:if test="${userRoleId == '1000005' }">
			<fieldset>
				<legend>Button</legend>
				<ul class="LbtnArea" style="margin-right: 20px;">
					<li>
					
						<input type="button" value="新增" onclick="fncAdd()" id="btnAdd" objType="bCreate" />
						<input type="button" value="借出记录" onclick="javascript:showChildWindow2();" id="btnAdd" objType="bCreate" />
						<input type="button" value="打印记录" onclick="javascript:showChildWindow3();" id="btnAdd" objType="bCreate" />
						<input type="button" value="导出记录" onclick="javascript:showChildWindow4()" id="btne" objType="bCreate" />
<!-- 						<input type="button" value="批量打印" onclick="print()" id="btnAdd" objType="bCreate" /> -->
						<input type="button" value="打印二维码" onclick="javascript:showChildWindow5()" id="btnAdd" objType="bCreate" />
						
						<input type="button" value="申请借阅" onclick="loan()" id="btnAdd" objType="bCreate" />
						<input type="button" value="更换位置" onclick="fncAdd()" id="btnAdd" objType="bCreate" />
						<input type="button" value="删除" onclick="fncDel()" id="checkself" objType="bCreate" />
					</li>
				</ul>		
			</fieldset>
			</c:if>
		<br />
		</div>
	</div>
   <!-- END content -->
</body>
<script type="text/javascript">
function print() {
	actSubmit($('#formPage'),
	'<c:url value="/basicInfor/archiveManage/archive!print.action"/>');
}
function exportPDF() {
	actSubmit($('#formPage'),
	'<c:url value="/basicInfor/archiveManage/archive!print.action"/>');
}
</script>
</html>