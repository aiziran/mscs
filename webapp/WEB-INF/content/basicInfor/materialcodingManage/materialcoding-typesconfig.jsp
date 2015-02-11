<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<html>
<head>
<%@ include file="/common/taglibs.jsp"%>
<title>元件类型配置</title>
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
		postform.action="${ctx}/basicInfor/materialcodingManage/materialcoding!typesconfig.action";
		postform.submit();
	}
	
	/**
	新增模态框
	*/
	function saveOverpack() {
		clearForm();
		$('#updatebtn').hide();
		$('#savebtn').show();
		$("#hid1").text("新增元件类型");
		$('#myModal').modal("show");
	}
	//修改元件类型模态框
	function showDetail(id) {
		$.ajax({
			type:'post',//可选get
			url:'${ctx}/basicInfor/materialcodingManage/materialcoding!typesEcho.action',//这里是接收数据的程序
			data:'id='+id,//传的数据，多个参数用&连接
			dataType:'json',
			async:true,
			success:function(data){
				if(data!=null && data.length>0) {
					$.each(data, function(i, list){
						$("#componenttypes").val(list.componenttypes);
						$("#codednum").val(list.codednum);
					});
				}
				$('#updatebtn').show();
				$('#savebtn').hide();
				$("#hid1").text("修改元件类型");
				$("#id").val(id);
				$('#myModal').modal("show");
			}
		});
	}
	/**
	删除元件类型
	*/
	function deleteInfo(id) {
		if (!confirm("确认要删除吗？")) {
			return;
		}
		$.ajax({
			type:'post',//可选get
			url:"${ctx}/basicInfor/materialcodingManage/materialcoding!deletetypes.action",//这里是接收数据的程序
			data:'id='+id,//传的数据，多个参数用&连接
			dataType:'json',
			async:false,
			success:function(data){
				if(data!=null && data.length>0) {
					if(data[0].flag===true) {
						alert("删除成功");
						window.location.href = "${ctx}/basicInfor/materialcodingManage/materialcoding!typesconfig.action";
					} else {
						alert("删除失败,元件类型和元件分类有关联,请先删除元件分类");
					}
				}
			}
		});
	}
	/**
	新增/修改元件类型
	*/
	function saveAllInfo(status) {
		if($("#componenttypes").val()==="") {
			alert("请选择元件类型");
			return ;
		}
		var regNum = /^[A-Z]?$/;
		if(!regNum.test($("#codednum").val())) {
			alert("请输入正确的编码号,应为A-Z大写单个字母");
			return ;
		}
		if(status==="save") {
			$("#id").val("");
		}
		var dataVal = {
				id: $("#id").val(),
				componenttypes: $("#componenttypes").val(),
				codednum: $("#codednum").val()
	    };
		//元件类型和编码号有重复提示
		$.ajax({
			type:'post',//可选get
			url:"${ctx}/basicInfor/materialcodingManage/materialcoding!isrepeattypes.action?status="+status,//这里是接收数据的程序
			data:dataVal,//传的数据，多个参数用&连接
			dataType:'json',
			async:false,
			success:function(data){
				if(data!=null && data.length>0) {
					var componenttypesVal = "";
					var codednumVal = "";
					$.each(data, function(i, list){
						componenttypesVal += list.componenttypes + ",";
						codednumVal += list.codednum + ",";
					});
					if(componenttypesVal.length>0) {
						componenttypesVal = componenttypesVal.substring(0, componenttypesVal.length-1);
					}
					if(codednumVal.length>0) {
						codednumVal = codednumVal.substring(0, codednumVal.length-1);
					}
					alert("当前输入的元件类型或编码号与以前保存数据有重复,请修改元件类型或编码后再添加!已经存在的元件类型为：["+componenttypesVal+"],编码号为：["+codednumVal+"]");
					return;
				}
				if (!confirm("确认要保存吗？")) {
					return;
				}
			    saveCpform.action = "${ctx}/basicInfor/materialcodingManage/materialcoding!savetypes.action?status="+status;
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
				onclick="setTabIndex('5')">元件类型配置</a></li>
		</ul>
	</div>
	<div class="panel panel-primary">
		<form id="postform" action="#" method="post">
			<div class="panel-body">
				<div class="col-sm-3">
					<div class="input-group">
						<div class="input-group-btn">
							<button type="button" class="btn btn-primary">元件类型</button>
						</div>
						<input style="background: #FFFFFF" id="componenttypes2" name="componenttypes2" type="text" class="form-control" value="${data.componenttypes2 }" />
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="searchBtn" type="button" class="btn btn-primary"
					onclick="chaXun()">查询</button>
				&nbsp;&nbsp;
				<span id="savebutton"><button id="cleanBtn" type="button" class="btn btn-primary"
					onclick="saveOverpack()">新增元件类型</button>
				&nbsp;&nbsp;</span>
				<button id="clear" type="button" class="btn btn-primary"
					onclick="clearSearch()">清空</button>
			</div>
		</form>
	</div>

	<div class="panel panel-primary">
		<div class="panel-heading">
			<h3 class="panel-title">元件类型配置</h3>
		</div>
		<div class="panel-body" style="padding: 0px;">
			<div class="table-responsive">
				<form id="formPage" action="${ctx}/basicInfor/materialcodingManage/materialcoding!typesconfig.action" method="post">
					<input type="hidden" id="componenttypes2" name="componenttypes2" value="${data.componenttypes2 }" />
					<table id="tableid2" class="table table-striped table-hover">
						<thead>
							<tr>
								<th nowrap="nowrap" style="text-align: center">元件类型</th>
								<th nowrap="nowrap" style="text-align: center">编码号</th>
								<th nowrap="nowrap" style="text-align: center">删除</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.result}" var="info" varStatus="index">
								<tr>
									<td onclick="showDetail(${info.id})" nowrap="nowrap">${info.componenttypes}</td>
									<td onclick="showDetail(${info.id})" nowrap="nowrap">${info.codednum}</td>
									<td nowrap="nowrap"><button type="button" class="btn btn-primary" onclick="deleteInfo(${info.id })">删除</button></td>
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
								<div class="row ">
									<div class="col-sm-6">
										<div class="input-group">
											<div class="input-group-btn">
												<button type="button" class="btn btn-primary">元件类型</button>
											</div>
											<input style="background: #FFFFFF" id="componenttypes" name="componenttypes"
												type="text" class="form-control">
										</div>
									</div>
									<div class="col-sm-6">
										<div class="input-group">
											<div class="input-group-btn">
												<button type="button" class="btn btn-primary">编码号</button>
											</div>
											<input style="background: #FFFFFF" style="background:#FFFFFF"
												id="codednum" name="codednum" type="text" class="form-control">
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
