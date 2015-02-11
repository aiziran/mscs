<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<html>
<head>
<%@ include file="/common/taglibs.jsp"%>
<title>物料编码查询</title>
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
	导出
	*/
	function exportData() {
		if(confirm("是否导出？")) {
			postform.action="${ctx}/basicInfor/materialcodingManage/materialcoding!export.action";
			postform.submit();
		}
	}
	/**
	模糊查询模态框
	*/
	function searchModal(val) {
		//元件类型
		if(val==="componenttypes2") {
			fuzzysearchpublic('componenttypes3', "元件类型", "componenttypes", "componenttypes3", val, "selectAllTypes.action");
		}
		//元件分类
		if(val==="componentclassify2") {
			fuzzysearchpublic('componentclassify3', "元件分类", "componentclassify", "componentclassify2", val, "selectAllClassify.action");
		}
		//第一物料属性
		if(val==="attrname3") {
			fuzzysearchpublic('attrname5', "第一物料属性", "attrname", "attrname", val, "selectAttr.action");
		}
		//第二物料属性
		if(val==="attrname4") {
			fuzzysearchpublic('attrname6', "第二物料属性", "attrname2", "attrname2", val, "selectAttr.action");
		}
		//物料编码
		if(val==="codednum2") {
			fuzzysearchpublic('codednum3', "物料编码", "codednum", "codednum2", val, "infoEcho.action");
		}
	}
	/**
	模糊查询公用方法
	@inputid
	@title 标题
	@args 数据库中字段名
	@ajaxargs sql语句中参数名
	@val
	@urlVal
	*/
	function fuzzysearchpublic(inputid, title, args, ajaxargs, val, urlVal) {
		document.getElementById("my2").style.display = "block";
		$("#h3id2").text(title);
		$("#searchId").html("");
		$("#divid").html("");
		$html=$('<input type="text" id="'+inputid+'" name="'+inputid+'"'+
				'class="form-control" onkeyup="searchVal(this.id, '+'\''+args+'\''+','+'\''+ajaxargs+'\''+','+'\''+val+'\''+','+'\''+urlVal+'\''+');" placeholder="请输入'+title+'关键字" />');
		$("#divid").append($html);
		$('#myModal2').modal("show");
	}
	/**
	 * 模糊搜索产品
	 */
	function searchVal(inputid, args, ajaxargs, id, urlVal) {
		$.ajax({
			type:"post",
			url: "${ctx}/basicInfor/materialcodingManage/materialcoding!"+urlVal,
			data: ajaxargs+'='+$("#"+inputid).val(),
			dataType: "json",
			//async:false,
			success:function(data){
				if(data!=null && data.length>0) {
					$("#searchId").html("");
					$.each(data,function(i,list){ 
						$html = $('<tr>'+
								'<td style="text-align: center">'+
									'<label><input type="radio" id="chkRadio2" name="chkRadio2" value='+list[args]+' onclick="fncRevert2(this, '+'\''+id+'\''+')" />'+list[args]+'</label>'+
								'</td>'+
							'</tr>');
						 $("#searchId").append($html);
					}) ;
					$("#myModal2").modal("show");
				}
			}
		});
	}
	/**
	获取模糊查询的结果
	*/
	function fncRevert2(obj, id) {
		$("#"+id).val(obj.value);
		document.getElementById("my2").style.display = "none";
		$('#myModal2').modal("hide");
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
			$("#arguments").val("");
			$("#attrname2").val("");
			$("#arguments2").val("");
		}
		if(id=="componentclassify") {
			//元件分类value
			var ccVal = $("#componentclassify").val();
			//获取第一、第二属性名称
			$.ajax({
				type:'post',//可选get
				url:'${ctx}/basicInfor/materialcodingManage/materialcoding!classifyEcho.action',//这里是接收数据的程序
				data:'componentclassify3='+ccVal,//传的数据，多个参数用&连接
				dataType:'json',
				async:false,
				success:function(data){
					console.info(data);
					if(data!=null && data.length>0) {
						$("#attrname").val(data[0].attrname);
						$("#arguments").val("");
						$("#attrname2").val(data[0].attrname2);
						$("#arguments2").val("");
					} else {
						$("#attrname").val("");
						$("#arguments").val("");
						$("#attrname2").val("");
						$("#arguments2").val("");
					}
				}
			});
			$('#'+modalid).modal("hide");
			if($("#attrname").val()==="") {
				alert("请在物料属性配置界面添加第一物料属性");
				return ;
			}
			if($("#attrname2").val()==="") {
				alert("请在物料属性配置界面添加第二物料属性");
				return ;
			}
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
		postform.action="${ctx}/basicInfor/materialcodingManage/materialcoding!search.action";
		postform.submit();
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
				onclick="setTabIndex('2')">物料编码查询</a></li>
			<li><a href="#panel-809020" data-toggle="tab"
				onclick="setTabIndex('1')">退出</a></li>
			<li><a href="#panel-809020" data-toggle="tab"
				onclick="setTabIndex('7')">返回跳转页面</a></li>
		</ul>
	</div>
	<div class="panel panel-primary">
		<form id="postform" action="#" method="post">
			<div class="panel-body">
				<div class="row">
					<div class="col-sm-3">
						<div class="input-group">
							<div class="input-group-btn">
								<button type="button" class="btn btn-primary">元件类型</button>
							</div>
							<input style="background: #FFFFFF" id="componenttypes2" name="componenttypes2" type="text" class="form-control" value="${data.componenttypes2 }" onclick="searchModal('componenttypes2');" />
						</div>
					</div>
					<div class="col-sm-2" style="padding-left: 0px;">
						<div class="input-group">
							<div class="input-group-btn">
								<button type="button" class="btn btn-primary">元件分类</button>
							</div>
							<input style="background: #FFFFFF" id="componentclassify2" name="componentclassify2" type="text" class="form-control" value="${data.componentclassify2 }" onclick="searchModal('componentclassify2');" />
						</div>
					</div>
					<div class="col-sm-2" style="padding-left: 0px;">
						<div class="input-group">
							<div class="input-group-btn">
								<button type="button" class="btn btn-primary">第一物料属性</button>
							</div>
							<input style="background: #FFFFFF" id="attrname3" name="attrname3" type="text" class="form-control" value="${data.attrname3 }" onclick="searchModal('attrname3');" />
						</div>
					</div>
					<div class="col-sm-2" style="padding-left: 0px;">
						<div class="input-group">
							<div class="input-group-btn">
								<button type="button" class="btn btn-primary">第二物料属性</button>
							</div>
							<input style="background: #FFFFFF" id="attrname4" name="attrname4" type="text" class="form-control" value="${data.attrname4 }" onclick="searchModal('attrname4');" />
						</div>
					</div>
					<div class="col-sm-3" style="padding-left: 0px;">
						<div class="input-group">
							<div class="input-group-btn">
								<button type="button" class="btn btn-primary">物料编码</button>
							</div>
							<input style="background: #FFFFFF" id="codednum2" name="codednum2" type="text" class="form-control" value="${data.codednum2 }" onclick="searchModal('codednum2');" />
						</div>
					</div>
				</div>
				<br />
				<div class="row">
					<div class="col-sm-3">
						<div class="input-group">
							<div class="input-group-btn">
								<button type="button" class="btn btn-primary">原厂物料码</button>
							</div>
							<input style="background: #FFFFFF" id="productname2" name="productname2" type="text" class="form-control" value="${data.productname2 }" />
						</div>
					</div>
					<div class="col-sm-3" style="padding-left: 0px;">
						<div class="input-group">
							<div class="input-group-btn">
								<button type="button" class="btn btn-primary">产品信息</button>
							</div>
							<input style="background: #FFFFFF" id="productinfo2" name="productinfo2" type="text" class="form-control" value="${data.productinfo2 }" />
						</div>
					</div>
					<div class="col-sm-3" style="padding-left: 0px;">
						<div class="input-group">
							<div class="input-group-btn">
								<button type="button" class="btn btn-primary">制造商</button>
							</div>
							<input style="background: #FFFFFF" id="manufacturer2" name="manufacturer2" type="text" class="form-control" value="${data.manufacturer2 }" />
						</div>
					</div>
					<div class="col-sm-3" style="padding-left: 0px;">
						<div class="input-group">
							<div class="input-group-btn">
								<button type="button" class="btn btn-primary">单位</button>
							</div>
							<input style="background: #FFFFFF" id="units2" name="units2" type="text" class="form-control" value="${data.units2 }" />
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="searchBtn" type="button" class="btn btn-primary"
					onclick="chaXun()">查询</button>
				&nbsp;&nbsp;
				<!-- <span id="savebutton"><button id="cleanBtn" type="button" class="btn btn-primary"
					onclick="saveOverpack()">录入物料信息</button>
				&nbsp;&nbsp;</span> -->
				<button id="clear" type="button" class="btn btn-primary"
					onclick="clearSearch()">清空</button>
				&nbsp;&nbsp;
				<button id="clear" type="button" class="btn btn-primary"
					onclick="exportData()">导出数据</button>
			</div>
		</form>
	</div>

	<div class="panel panel-primary">
		<div class="panel-heading">
			<h3 class="panel-title">物料信息</h3>
		</div>
		<div class="panel-body" style="padding: 0px;">
			<div class="table-responsive">
				<form id="formPage" action="${ctx}/basicInfor/materialcodingManage/materialcoding!search.action" method="post">
					<input type="hidden" id="componenttypes2" name="componenttypes2" value="${data.componenttypes2 }" />
					<input type="hidden" id="componentclassify2" name="componentclassify2" value="${data.componentclassify2 }" />
					<input type="hidden" id="attrname3" name="attrname3" value="${data.attrname3 }" />
					<input type="hidden" id="attrname4" name="attrname4" value="${data.attrname4 }" />
					<input type="hidden" id="codednum2" name="codednum2" value="${data.codednum2 }" />
					<input type="hidden" id="productname2" name="productname2" value="${data.productname2 }" />
					<input type="hidden" id="productinfo2" name="productinfo2" value="${data.productinfo2 }" />
					<input type="hidden" id="manufacturer2" name="manufacturer2" value="${data.manufacturer2 }" />
					<input type="hidden" id="units2" name="units2" value="${data.units2 }" />
					<table id="tableid2" class="table table-striped table-hover">
						<thead>
							<tr>
								<th nowrap="nowrap" style="text-align: center">物料编码</th>
								<th nowrap="nowrap" style="text-align: center;">元件类型</th>
								<th nowrap="nowrap" style="text-align: center">元件分类</th>
								<th nowrap="nowrap" style="text-align: center">SMT/THT</th>
								<th nowrap="nowrap" style="text-align: center">第一物料属性</th>
								<th nowrap="nowrap" style="text-align: center">第一属性参数</th>
								<th nowrap="nowrap" style="text-align: center">第二物料属性</th>
								<th nowrap="nowrap" style="text-align: center">第二属性参数</th>
								<th nowrap="nowrap" style="text-align: center">原厂物料码</th>
								<th nowrap="nowrap" style="text-align: center">数量</th>
								<th nowrap="nowrap" style="text-align: center">产品信息</th>
								<th nowrap="nowrap" style="text-align: center">制造商</th>
								<th nowrap="nowrap" style="text-align: center">单位</th>
								<th nowrap="nowrap" style="text-align: center">备注</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.result}" var="info" varStatus="index">
								<tr>
									<td nowrap="nowrap">${info.codednum}</td>
									<td nowrap="nowrap">${info.componenttypes}</td>
									<td nowrap="nowrap">${info.componentclassify}</td>
									<td nowrap="nowrap">
										<c:if test="${info.smttht eq '1'}">SMT</c:if>
										<c:if test="${info.smttht eq '2'}">THT</c:if>
										<c:if test="${info.smttht eq '3'}">NA</c:if>
									</td>
									<td nowrap="nowrap">${info.attrname}</td>
									<td nowrap="nowrap">${info.arguments}</td>
									<td nowrap="nowrap">${info.attrname2}</td>
									<td nowrap="nowrap">${info.arguments2}</td>
									<td nowrap="nowrap">${info.productname}</td>
									<td nowrap="nowrap">${info.counts}</td>
									<td nowrap="nowrap">${info.productinfo}</td>
									<td nowrap="nowrap">${info.manufacturer}</td>
									<td nowrap="nowrap">${info.units}</td>
									<td nowrap="nowrap">${info.remark}</td>
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
											<input style="background: #FFFFFF" type="text" id="componenttypes" name="componenttypes" class="form-control" readonly onclick="getModal('componenttypes');" />
										</div>
									</div>
									<div class="col-sm-6">
										<div class="input-group">
											<div class="input-group-btn">
												<button type="button" class="btn btn-primary">SMT/THT</button>
											</div>
											<select id="smttht" name="smttht" class="form-control">
												<option value="">请选择</option>
												<option value="1">SMT</option>
												<option value="2">THT</option>
												<option value="3">NA</option>
											</select>
										</div>
									</div>
								</div>
								</br>
								<div class="row">
									<div class="col-sm-6">
										<div class="input-group">
											<div class="input-group-btn">
												<button type="button" class="btn btn-primary">元件分类</button>
											</div>
											<input style="background: #FFFFFF" type="text" id="componentclassify" name="componentclassify" class="form-control" readonly onclick="getModal('componentclassify');" />
										</div>
									</div>
								</div>
								</br>
								<div class="row">
									<div class="col-sm-6">
										<div class="input-group">
											<div class="input-group-btn">
												<strong>第一属性</strong>
											</div>
										</div>
									</div>
								</div>
								</br>
								<div class="row">
									<div class="col-sm-6">
										<div class="input-group">
											<div class="input-group-btn">
												<button type="button" class="btn btn-primary">物料属性</button>
											</div>
											<input style="background: #FFFFFF" type="text" id="attrname" name="attrname" class="form-control" readonly />
										</div>
									</div>
									<div class="col-sm-5">
										<div class="input-group">
											<div class="input-group-btn">
												<button type="button" class="btn btn-primary">参数</button>
											</div>
											<input style="background: #FFFFFF" type="text" id="arguments" name="arguments" class="form-control" readonly onclick="getModal('arguments');" />
										</div>
									</div>
								</div>
								</br>
								<div class="row">
									<div class="col-sm-6">
										<div class="input-group">
											<div class="input-group-btn">
												<strong>第二属性</strong>
											</div>
										</div>
									</div>
								</div>
								</br>
								<div class="row">
									<div class="col-sm-6">
										<div class="input-group">
											<div class="input-group-btn">
												<button type="button" class="btn btn-primary">物料属性</button>
											</div>
											<input style="background: #FFFFFF" type="text" id="attrname2" name="attrname2" class="form-control" readonly />
										</div>
									</div>
									<div class="col-sm-5">
										<div class="input-group">
											<div class="input-group-btn">
												<button type="button" class="btn btn-primary">参数</button>
											</div>
											<input style="background: #FFFFFF" type="text" id="arguments2" name="arguments2" class="form-control" readonly onclick="getModal('arguments2');" />
										</div>
									</div>
								</div>
								</br>
								<div class="row">
									<div class="col-sm-6">
										<div class="input-group">
											<div class="input-group-btn">
												<button type="button" class="btn btn-primary">原厂物料码</button>
											</div>
											<input style="background: #FFFFFF" type="text" id="productname" name="productname" class="form-control" />
										</div>
									</div>
									<div class="col-sm-6">
										<div class="input-group">
											<div class="input-group-btn">
												<button type="button" class="btn btn-primary">数量</button>
											</div>
											<input style="background: #FFFFFF" type="text" id="counts" name="counts" class="form-control" />
										</div>
									</div>
								</div>
								</br>
								<div class="row">
									<div class="col-sm-6">
										<div class="input-group">
											<div class="input-group-btn">
												<button type="button" class="btn btn-primary">产品信息</button>
											</div>
											<input style="background: #FFFFFF" type="text"
												id="productinfo" name="productinfo" class="form-control" />
										</div>
									</div>
									<div class="col-sm-6">
										<div class="input-group">
											<div class="input-group-btn">
												<button type="button" class="btn btn-primary">制造商</button>
											</div>
											<input style="background: #FFFFFF" id="manufacturer"
												name="manufacturer" type="text" class="form-control">
										</div>
									</div>

								</div>
								</br>
								<div class="row ">
									<div class="col-sm-6">
										<div class="input-group">
											<div class="input-group-btn">
												<button type="button" class="btn btn-primary">单位</button>
											</div>
											<input style="background: #FFFFFF" id="units" name="units"
												type="text" class="form-control">
										</div>
									</div>
									<div class="col-sm-6">
										<div class="input-group">
											<div class="input-group-btn">
												<button type="button" class="btn btn-primary">备注</button>
											</div>
											<input style="background: #FFFFFF" style="background:#FFFFFF"
												id="remark" name="remark" type="text" class="form-control">
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
	<!-- 模糊搜索模态框 -->
	<div class="modal fade" id="myModal2" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">
					<div id="my2" style="display: none">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h3 id="h3id2" class="panel-title"></h3>
							</div>
							<div class="panel-body">
								<div class="row center-block">
									<div class="col-sm-8" id="divid">
										
									</div>
								</div>
								<br />
								<table class="table table-striped" id="searchId">
								</table>
							</div>
						</div>
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
			window.location.href = "${ctx}/basicInfor/materialcodingManage/materialcoding!search.action";
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
