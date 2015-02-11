<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<html>
<head>
<%@ include file="/common/taglibs.jsp"%>
<title>物料属性配置</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Bootstrap -->
<!-- Bootstrap -->
<link rel="stylesheet" href="${ctx}/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${ctx}/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="${ctx}/bootstrap/css/bootstrap-theme.css">
<link rel="stylesheet"
	href="${ctx}/bootstrap/css/bootstrap-theme.min.css">
<script src="${ctx}/bootstrap/js/jquery.min.js"></script>
<script src="${ctx}/bootstrap/js/bootstrap-dropdown.js"></script>
<script src="${ctx}/bootstrap/js/bootstrap.min.js"></script>
<script src="${ctx}/bootstrap/js/bootstrap.js"></script>
<script src="${ctx}/bootstrap/js/jquery.dataTables.js"></script>
<!--[if lt IE 9]>
        <script src="${ctx}/bootstrap/js/html5shiv.min.js"></script>
        <script src="${ctx}/bootstrap/js/respond.min.js"></script>
    <![endif]-->

<script src="${ctx}/bootstrap/js/jquery.dataTables.js"></script>
<style type="text/css" title="currentStyle">
@import "${ctx}/bootstrap/css/demo_page.css";

@import "${ctx}/bootstrap/css/demo_table_jui.css";

@import "${ctx}/bootstrap/css/jquery-ui-1.8.4.custom.css";

td {
	text-align: center;
}
</style>

<!-- datepicker -->
<script type="text/javascript"
	src="${ctx}/bootstrap/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript"
	src="${ctx}/bootstrap/js/bootstrap-dropdown.js" charset="UTF-8"></script>
<script type="text/javascript"
	src="${ctx}/bootstrap/js/locales/bootstrap-datetimepicker.zh-CN.js"
	charset="UTF-8"></script>
<link href="${ctx}/bootstrap/css/bootstrap.min.css" rel="stylesheet"
	media="screen">
<link href="${ctx}/bootstrap/css/bootstrap-datetimepicker.min.css"
	rel="stylesheet" media="screen">
<script src="${ctx}/js/DatePicker/WdatePicker.js"></script>
<!-- validate -->
<script type="text/javascript" src="${ctx}/js/validate/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}/js/validate/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx}/js/validate/messages_cn.js"></script>

<script type="text/javascript" charset="utf-8">
	/**
	按钮权限
	*/
	$(function(){
		var savebutton = $("#savebutton2").val();
		var updatebutton = $("#updatebutton2").val();
		var deletebutton = $("#deletebutton2").val();
		if(savebutton==null || savebutton.trim().length<=0 || savebutton.trim()!='1') {
			$("#savebutton").css("display","none");
		}
		if(updatebutton==null || updatebutton.trim().length<=0 || updatebutton.trim()!='1') {
			$("#tableid2 tr td").each(function(){
				$(this).removeAttr("onclick");
			});
		}
		if(deletebutton==null || deletebutton.trim().length<=0 || deletebutton.trim()!='1') {
			$("#tableid2").find("tr:first").find("th:last").remove();
			$("#tableid2 tr td:last-child").each(function(){
				$(this).remove();
			});
		}
	});
	/**
	验证元件分类
	*/
	function verifycomponentclassify() {
		if($("#componentclassify").val()==null || $("#componentclassify").val().trim().length<=0) {
			alert("请选择元件分类");
			return ;
		}
	}
	/**
	获取属性名称
	*/
	function getAttrName(obj) {
		$.ajax({
			type:'post',//可选get
			url:'${ctx}/basicInfor/materialcodingManage/materialcoding!classifyEcho.action?componentclassify3='+$("#componentclassify").val(),//这里是接收数据的程序
			data:'',//传的数据，多个参数用&连接
			dataType:'json',
			async:false,
			success:function(data){
				if(data!=null && data.length>0) {
					if(obj.value==="1") {
						$("#attrname").val(data[0].attrname);
					} else if(obj.value==="2") {
						$("#attrname").val(data[0].attrname2);
					} else {
						$("#attrname").val("");
					}
				} else {
					$("#attrname").val("");
				}
			}
		});
	}
	/**
	模态框
	*/
	function getModal(id) {
		//获取所有物料属性
		if(id==='attrname3') {
			findInfo("物料属性", "selectAllAttr.action", id, "tableid", 'attrname', 'myModal1');
		}
		//获取元件类型
		if(id==='componenttypes') {
			findInfo("元件类型", "selectAllTypes.action", id, "tableid", 'componenttypes', 'myModal1');
		}
		var componenttypesVal = $("#componenttypes").val();
		//获取元件分类
		if(id==='componentclassify') {
			if(componenttypesVal==null || componenttypesVal==="") {
				alert("请选择元件类型");
				return ;
			}
			findInfo("元件分类", "selectAllClassify.action?componenttypes="+componenttypesVal, id, "tableid", 'componentclassify', 'myModal1');
		}
		//元件分类value
		var ccVal = $("#componentclassify").val();
		//获取第一属性名称
		if(id==='attrname') {
			if(ccVal===null || ccVal==="") {
				alert("请选择元件分类");
				return ;
			}
			findInfo("第一属性名称", "selectAllAttr.action?whichattr=1&componentclassify="+ccVal, id, "tableid", 'attrname', 'myModal1');
		}
		//获取元素第一属性参数
		if(id==='arguments') {
			if(ccVal===null || ccVal==="") {
				alert("请选择元件分类");
				return ;
			}
			var anVal = $("#attrname").val();
			if(anVal===null || anVal==="") {
				alert("请选择第一属性的物料属性");
				return ;
			}
			findInfo("第一属性参数", "getArguments.action?whichattr=1&componentclassify="+ccVal+"&attrname="+anVal, id, "tableid", 'arguments', 'myModal1');
		}
		//获取第二属性名称
		if(id==='attrname2') {
			if(ccVal===null || ccVal==="") {
				alert("请选择元件分类");
				return ;
			}
			findInfo("第二属性名称", "selectAllAttr.action?whichattr=2&componentclassify="+ccVal, id, "tableid", 'attrname', 'myModal1');
		}
		//获取元素第二属性参数
		if(id==='arguments2') {
			if(ccVal===null || ccVal==="") {
				alert("请选择元件分类");
				return ;
			}
			var anVal = $("#attrname2").val();
			if(anVal===null || anVal==="") {
				alert("请选择第二属性的物料属性");
				return ;
			}
			findInfo("第二属性参数", "getArguments.action?whichattr=2&componentclassify="+ccVal+"&attrname2="+anVal, id, "tableid", 'arguments', 'myModal1');
		}
	}
	/**
	获取信息公用方法
	@val 标题
	@methodVal 要跳转的action
	@id 表单中要获取选中内容的id
	@tableid 表格id
	@args 模态框中显示内容的参数名称
	@modalid 模态框id
	*/
	function findInfo(val, methodVal, id, tableid, args, modalid) {
		$("#h3id").text(val);
		$.ajax({
			type:'post',//可选get
			url:'${ctx}/basicInfor/materialcodingManage/materialcoding!'+methodVal,//这里是接收数据的程序
			data:'',//传的数据，多个参数用&连接
			dataType:'json',
			async:true,
			success:function(data){
				$("#"+tableid).html("");
				$.each(data, function(i, list){
					$html = $('<tr>'+
								'<td style="text-align: center">'+
									'<label><input type="radio" id="chkRadio1" name="chkRadio1" value='+list[args]+' onclick="fncRevert(this, '+'\''+id+'\''+','+'\''+modalid+'\''+')" />'+list[args]+'</label>'+
								'</td>'+
							'</tr>');
					$("#"+tableid).append($html);
				});
				$("#"+modalid).modal("show");
			}
		});
	}
	//公用模态框内容保存到表单
	function fncRevert(obj, id, modalid) {
		$('#'+id).val(obj.value);
		//元件类型的值发生改变
		if(id==="componenttypes") {
			$("#componentclassify").val("");
			$("#attrname").val("");
			$("#whichattr").val("");
		}
		if(id=="componentclassify") {
			$("#attrname").val("");
			$("#whichattr").val("");
		}
		$('#'+modalid).modal("hide");
	}
	/**
	清空表单
	*/
	function clearForm() {
		$('#saveCpform')[0].reset();
	}
	/**
	清空查询
	*/
	function clearSearch() {
		$(':input','#postform')  
	     .not(':button, :submit, :reset, :hidden')  
	     .val('')  
	     .removeAttr('checked')  
	     .removeAttr('selected');
	}
	/**
	查询
	*/
	function chaXun() {
		postform.action="${ctx}/basicInfor/materialcodingManage/materialcoding!attrconfig.action";
		postform.submit();
	}
	
	/**
	新增物料属性模态框
	*/
	function saveOverpack() {
		clearForm();
		$('#updatebtn').hide();
		$('#savebtn').show();
		$("#hid1").text("新增物料属性");
		$('#myModal').modal("show");
	}
	//修改物料属性模态框
	function showDetail(id) {
		$.ajax({
			type:'post',//可选get
			url:'${ctx}/basicInfor/materialcodingManage/materialcoding!attrEcho.action',//这里是接收数据的程序
			data:'id='+id,//传的数据，多个参数用&连接
			dataType:'json',
			async:true,
			success:function(data){
				if(data!=null && data.length>0) {
					$.each(data, function(i, list){
						$("#attrname").val(list.attrname);
						$("#componenttypes").val(list.componenttypes);
						$("#componentclassify").val(list.componentclassify);
						$("#whichattr").val(list.whichattr);
						$("#arguments").val(list.arguments);
						$("#codednum").val(list.codednum);
					});
				}
				$('#updatebtn').show();
				$('#savebtn').hide();
				$("#hid1").text("修改物料属性");
				$("#id").val(id);
				$('#myModal').modal("show");
			}
		});
	}
	/**
	删除物料属性
	*/
	function deleteattr(id) {
		if (!confirm("确认要删除吗？")) {
			return;
		}
		window.location.href = "${ctx}/basicInfor/materialcodingManage/materialcoding!deleteattr.action?id="+id;
	}
	/**
	新增/修改物料属性
	*/
	function saveAllInfo(status) {
		if($("#componenttypes").val()==="") {
			alert("请选择元件类型");
			return ;
		}
		if($("#componentclassify").val()==="") {
			alert("请选择元件分类");
			return ;
		}
		if($("#whichattr").val()==="") {
			alert("请选择所属元件第几属性");
			return ;
		}
		if($("#attrname").val()==="") {
			alert("请选择属性名称");
			return ;
		}
		if($("#arguments").val()==="") {
			alert("请选择参数");
			return ;
		}
		var regNum = /^\d{2}$/;
		if(!regNum.test($("#codednum").val())) {
			alert("请输入正确的编码号,应为两位数字,个位数请在前面填写数字零");
			return ;
		}
		if(status==="save") {
			$("#id").val("");
		}
		var dataVal = {
				id: $("#id").val(),
				componenttypes: $("#componenttypes").val(),
				componentclassify: $("#componentclassify").val(),
				whichattr: $("#whichattr").val(),
				attrname: $("#attrname").val(),
				arguments: $("#arguments").val(),
				codednum: $("#codednum").val()
	    };
		//物料属性参数和编码号有重复报警提示
		$.ajax({
			type:'post',//可选get
			url:"${ctx}/basicInfor/materialcodingManage/materialcoding!isrepeatattr.action?status="+status,//这里是接收数据的程序
			data:dataVal,//传的数据，多个参数用&连接
			dataType:'json',
			async:false,
			success:function(data){
				if(data!=null && data.length>0) {
					var argumentsVal = "";
					var codednumVal = "";
					$.each(data, function(i, list){
						argumentsVal += list.arguments + ",";
						codednumVal += list.codednum + ",";
					});
					if(argumentsVal.length>0) {
						argumentsVal = argumentsVal.substring(0, argumentsVal.length-1);
					}
					if(codednumVal.length>0) {
						codednumVal = codednumVal.substring(0, codednumVal.length-1);
					}
					alert("当前输入的参数或编码号与以前保存数据有重复,请修改参数或编码后再添加!已经存在的参数为：["+argumentsVal+"],编码号为：["+codednumVal+"]");
					return;
				}
				if (!confirm("确认保存?")) {
					return;
				}
			    saveCpform.action = "${ctx}/basicInfor/materialcodingManage/materialcoding!saveattr.action?status="+status;
			    saveCpform.submit();
			}
	    });
	}
</script>
</head>
<body>
	<input type="hidden" id="savebutton2" value='${buttonlist[0].savebutton }' />
	<input type="hidden" id="updatebutton2" value='${buttonlist[0].updatebutton }' />
	<input type="hidden" id="deletebutton2" value='${buttonlist[0].deletebutton }' />
	<div id='tabs-886386' class='tabbable'
		style="background-color: #CCCCCC">
		<ul class="nav nav-tabs" id="tabid">
			<li class="active"><a href="#panel-809020" data-toggle="tab"
				onclick="setTabIndex('3')">物料属性配置</a></li>
		</ul>
	</div>
	<div class="panel panel-primary">
		<form id="postform" action="" method="post">
			<div class="panel-body">
				<div class="col-sm-3">
					<div class="input-group">
						<div class="input-group-btn">
							<button type="button" class="btn btn-primary">物料属性</button>
						</div>
						<input style="background: #FFFFFF" id="attrname3" name="attrname3" type="text" class="form-control" value="${data.attrname3 }" />
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="searchBtn" type="button" class="btn btn-primary"
					onclick="chaXun()">查询</button>
				&nbsp;&nbsp;
				<span id="savebutton"><button id="cleanBtn" type="button" class="btn btn-primary"
					onclick="saveOverpack()">新增物料属性</button>
				&nbsp;&nbsp;</span>
				<button id="clear" type="button" class="btn btn-primary"
					onclick="clearSearch()">清空</button>
			</div>
		</form>
	</div>

	<div class="panel panel-primary">
		<div class="panel-heading">
			<h3 class="panel-title">物料属性配置</h3>
		</div>
		<div class="panel-body" style="padding: 0px;">
			<div class="table-responsive">
				<form id="formPage" action="${ctx}/basicInfor/materialcodingManage/materialcoding!attrconfig.action" method="post">
					<input type="hidden" id="attrname3" name="attrname3" value="${data.attrname3 }" />
					<table id="tableid2" class="table table-striped table-hover">
						<thead>
							<tr>
								<th nowrap="nowrap" style="text-align: center">元件类型</th>
								<th nowrap="nowrap" style="text-align: center">元件分类</th>
								<th nowrap="nowrap" style="text-align: center">属性名称</th>
								<th nowrap="nowrap" style="text-align: center">所属元件第几属性</th>
								<th nowrap="nowrap" style="text-align: center">参数</th>
								<th nowrap="nowrap" style="text-align: center">编码号</th>
								<th nowrap="nowrap" style="text-align: center">删除</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.result}" var="info" varStatus="index">
								<tr>
									<td onclick="showDetail(${info.id})" nowrap="nowrap">${info.componenttypes}</td>
									<td onclick="showDetail(${info.id})" nowrap="nowrap">${info.componentclassify}</td>
									<td onclick="showDetail(${info.id})" nowrap="nowrap">${info.attrname}</td>
									<td onclick="showDetail(${info.id})" nowrap="nowrap">${info.whichattr}</td>
									<td onclick="showDetail(${info.id})" nowrap="nowrap">${info.arguments}</td>
									<td onclick="showDetail(${info.id})" nowrap="nowrap">${info.codednum}</td>
									<td nowrap="nowrap"><button type="button" class="btn btn-primary" onclick="deleteattr(${info.id })">删除</button></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<%@ include file="/common/bspage.jsp"%>
				</form>
			</div>
		</div>
	</div>
	<!--录入/修改物料信息对话框  -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>

				</div>
				<form id="saveCpform" action="" method="post">
					<div class="modal-body">
						<div class="panel panel-info" style="border: 1px #3276b1 solid">
							<div class="panel-heading"
								style="background: #3276b1; color: #FFF; border-bottom: none">
								<h3 id="hid1" class="panel-title"></h3>
							</div>
							<input type="hidden" id="id" name="id" />
							<div class="panel-body">
								<div class="row">
									<div class="col-sm-6">
										<div class="input-group">
											<div class="input-group-btn">
												<button type="button" class="btn btn-primary">元件类型</button>
											</div>
											<input type="text" id="componenttypes"
												name="componenttypes" class="form-control" readonly onclick="getModal('componenttypes')" />
										</div>
									</div>
									<div class="col-sm-6">
										<div class="input-group">
											<div class="input-group-btn">
												<button type="button" class="btn btn-primary">元件分类</button>
											</div>
											<input type="text" id="componentclassify" name="componentclassify" class="form-control" readonly onclick="getModal('componentclassify');" />
										</div>
									</div>
								</div>
								</br>
								<div class="row">
									<div class="col-sm-6">
										<div class="input-group">
											<div class="input-group-btn">
												<button type="button" class="btn btn-primary">所属元件第几属性</button>
											</div>
											<select id="whichattr" name="whichattr" class="form-control" onclick="verifycomponentclassify();" onchange="getAttrName(this);">
												<option value="">请选择</option>
												<option value="1">1</option>
												<option value="2">2</option>
											</select>
										</div>
									</div>
									<div class="col-sm-6">
										<div class="input-group">
											<div class="input-group-btn">
												<button type="button" class="btn btn-primary">属性名称</button>
											</div>
											<input type="text" id="attrname" name="attrname" class="form-control" readonly />
										</div>
									</div>
								</div>
								</br>
								<div class="row">
									<div class="col-sm-6">
										<div class="input-group">
											<div class="input-group-btn">
												<button type="button" class="btn btn-primary">参数</button>
											</div>
											<input style="background: #FFFFFF" type="text" id="arguments" name="arguments" class="form-control" />
										</div>
									</div>
									<div class="col-sm-6">
										<div class="input-group">
											<div class="input-group-btn">
												<button type="button" class="btn btn-primary">编码号</button>
											</div>
											<input style="background: #FFFFFF" type="text" id="codednum"
												name="codednum" class="form-control" />
										</div>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button id="savebtn" type="button" class="btn btn-primary"
									onclick="saveAllInfo('save')">保存</button>
								<button id="updatebtn" type="button" class="btn btn-primary"
									onclick="saveAllInfo('update')">修改</button>
								<button id="clear" type="button" class="btn btn-primary"
									onclick="clearForm()">清空</button>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 元件类型 -->
	<div class="modal fade" id="myModal1" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
				</div>
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 id="h3id" class="panel-title"></h3>
					</div>
					<div class="panel-body">
						<table class="table table-striped" id="tableid">
							
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	
	$('.form_date').datetimepicker({

		language : 'zh-CN',
		weekStart : 1,
		todayBtn : 1,
		autoclose : 1,
		todayHighlight : 1,
		startView : 2,
		minView : 2,
		forceParse : 0

	});

	function setTabIndex(obj) {
		if(obj == "1") {
			window.location.href = "${ctx}/login/login.action";
		}
		if(obj == "2") {
			window.location.href = "${ctx}/basicInfor/materialcodingManage/materialcoding.action";
		}
		if(obj == "3") {
			window.location.href = "${ctx}/basicInfor/materialcodingManage/materialcoding!attrconfig.action";
		}
		if(obj == "4") {
			window.location.href = "${ctx}/basicInfor/materialcodingManage/materialcoding!classifyconfig.action";
		}
		if(obj == "5") {
			window.location.href = "${ctx}/basicInfor/materialcodingManage/materialcoding!typesconfig.action";
		}
		if (obj == "7") {
			 var username='<%if (session.getAttribute("username") != null)
			out.print(session.getAttribute("username"));%>'; 
			 var password='<%if (session.getAttribute("password") != null)
			out.print(session.getAttribute("password"));%>';
			  parent.location.href="${ctx}/login/login!login.action?j_username="+username+"&j_password="+password;
		}
	}
</script>
    
</body>
</html>
