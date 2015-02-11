<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<html>
<head>
	<title>个人通讯录</title>
	<%@ include file="/common/header.jsp" %>
	<script type="text/javascript" language="javascript">
	//进入修改页面
	function fncDetail(obj) {
		$('#tid').val(obj);		
		actSubmit($('#formPage'),'<c:url value="/basicInfor/addressManage/address!ownselectOne.action"/>');
	}
	//进入新增页面
	function fncAdd() {
		actSubmit($('#formPage'),'<c:url value="/basicInfor/addressManage/address!owncreate.action"/>');
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
				'<c:url value="address!owndeleteAll.action"/>');
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
	
	function showChildWindow1() 
	{ 
  		
		var url = "<c:url value='/common/popup/popup!myDept.action'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
		if(aa){
			$('#dept').val(aa.split(";")[0])
			$('#deptname').val(aa.split(";")[1])
		} 
	}
	</script>
</head>

<body onload="fncFixupListHead();">
	<div id="Lcontent">
	<SSTag:navigation/>
		<div id="LsearchArea">
			<form id="formSearch" name="formSearch" method="post" class="enterhandler" style="width: 1000px;"
				  action="<c:url value="/basicInfor/addressManage/address!own.action"/>" onEnter="this.submit()">
					<div>
					
					<table width="800">
					    <tr>
					        <th>姓名:</th><td ><input type="text" id="name" name="name" value="${data.name }" /></td>
					        <th>QQ:</th><td><input type="text" name="qq" id="qq" value="${data.qq }" /></td>
					        <th>部门</th>
								<td nowrap="nowrap"><input type="text" id="deptname" name="deptname" value="${data.deptname }" readonly>
									<input type="hidden" id="dept" name="dept" value="${data.dept }">
										
									<img src="/archive/images/pbf/Content_icon_search.gif" class="btn_img"
											onClick="javascript:showChildWindow1();"
											style="cursor: hand; margin-right: 10px" />
										
								</td>
					    </tr>
					     <tr>
					        <th>电话:</th><td ><input type="text" id="mobile" name="mobile" value="${data.mobile }" /></td>
					        <th>Email:</th><td><input type="text" name="email" id="email" value="${data.email }" /></td>
					        <th>职位:</th>
					        <td>
					        	<input type="text" name="post" id="post" value="${data.post }"  />
							</td>
					    </tr>
					</table>
				    </div>
				 <input id="LsearchIcon" type="image" src="${ctx}/images/btn_search_e_g.gif" alt="Search" />
				</p>
			</form>
		</div>

		<!-- END sbox --> <!--AREA [View]-->
		<form id="formPage" method="post">
			<input type="hidden" name="tid" id="tid" />
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
									<th>姓名</th>
									<th>手机号</th>
									<th>座机</th>
									<th>QQ</th>
									<th>Email</th>
									<th>职位</th>
									<th>部门</th>
									<th>删除</th>
									
								</tr>
								<s:iterator value="page.result" status="st">
									<tr nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)"
										>
										<td ><input type="checkbox" name="checkBox" id="checkBox" value="${id}"/></td>
										<input type="hidden" name="tid" id="tid" value="${id}" /> 
										<td onClick="fncDetail('${id}')">${name}</td>
										<td onClick="fncDetail('${id}')">${mobileone}</td>
										<td onClick="fncDetail('${id}')">${mobiletwo}</td>
										<td onClick="fncDetail('${id}')">${qq}</td>
										<td onClick="fncDetail('${id}')">${email}</td>
										<td onClick="fncDetail('${id}')">${post}</td>
										<td onClick="fncDetail('${id}')">${deptname}</td>
										<td><a href="address!owndeleteId.action?tid=${id}">删除</a>
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
			<!-- 滚动条设置-start -->
			<c:if test="${!empty page.result}">
			<script>
				document.getElementById("resultDiv").style.width=document.getElementById("formSearch").clientWidth;
			</script>
			</c:if>
			<!-- 滚动条设置-end -->
			
				<fieldset>
				<legend>Button</legend>
				<ul class="LbtnArea" style="margin-right: 20px;">
					<li>
						<input type="button" value="新增" onclick="fncAdd()" id="btnAdd" />
						<input type="button" value="删除" onclick="fncDel()" id="checkBox" />
					</li>
			
					</ul>
		    </fieldset>	
		<br/>
	</div>
	
<!-- END content -->
</body>
</html>