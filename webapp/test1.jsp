<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<html>
<head>
<title>历史分析数据查询</title>
<%@ include file="/common/taglibs.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Bootstrap -->
<link rel="stylesheet"
	href="http://cdn.bootcss.com/twitter-bootstrap/3.0.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="http://cdn.bootcss.com/twitter-bootstrap/3.0.2/css/bootstrap.css">
<link rel="stylesheet"
	href="http://cdn.bootcss.com/twitter-bootstrap/3.0.2/css/bootstrap-theme.css">
<link rel="stylesheet"
	href="http://cdn.bootcss.com/twitter-bootstrap/3.0.2/css/bootstrap-theme.min.css">
<!--   <link rel="stylesheet" href="${ctx}/bootstrap/js/bootstrap-dropdown.js">-->

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="http://cdn.bootcss.com/html5shiv/3.7.0/html5shiv.min.js"></script>
        <script src="http://cdn.bootcss.com/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="http://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script
	src="http://cdn.bootcss.com/twitter-bootstrap/3.0.2/js/bootstrap-dropdown.js"></script>
	<script src="http://cdn.bootcss.com/twitter-bootstrap/3.0.2/js/bootstrap.min.js">
</script>
<script src="http://cdn.bootcss.com/twitter-bootstrap/3.0.2/js/bootstrap.js"></script>
<script src="${ctx}/bootstrap/js/jquery.dataTables.js"></script>
<style type="text/css" title="currentStyle">
@import "${ctx}/bootstrap/css/demo_page.css";

@import "${ctx}/bootstrap/css/demo_table_jui.css";

@import "${ctx}/bootstrap/css/jquery-ui-1.8.4.custom.css";
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
<script type="text/javascript" charset="utf-8">
	$(document).ready(
					function() {
						$.extend($.fn.dataTable.defaults, {
							"bFilter" : false
						});
						oTable = $('#example').dataTable({
											"bJQueryUI" : true,
											"bServerSide" : true,
											"bDestroy": true,
											"sPaginationType" : "full_numbers",
											"sAjaxSource" : "${ctx}/basicInfor/tbManage/tb!BootstrapData.action?tab_index="+$('#tab_index').val(),
											"fnServerData" : function(sUrl,
													aoData, fnCallback,
													oSettings) {
												oSettings.jqXHR = $.ajax({
													"url" : sUrl,
													"data" : aoData,
													"success" : fnCallback,
													"dataType" : "json",
													"cache" : false
												});
											},
											"aoColumns" : [ {
												"sTitle" : "生产线"
											}, {
												"sTitle" : "产品"
											}, {
												"sTitle" : "开始时间"
											}, {
												"sTitle" : "结束时间"
											}, {
												"sTitle" : "采样数"
											}, {
												"sTitle" : "平均值"
											}, {
												"sTitle" : "标准差"
											}, {
												"sTitle" : "不合格率"
											}, {
												"sTitle" : "班组"
											} , {
												"sTitle" : "是否放行"
											}, {
												"sTitle" : "放行人"
											}, {
												"sTitle" : "备注"
											}],
											"aoColumnDefs" : [
													{
														"mRender" : function(data, type, row) {
															return "<a href='javascript:void(0)' onclick='jumpPage(\""+ data+ "\");'>"+ data+ "</a>";
														},
														"aTargets" : [ 0 ]
													}, {
														"bVisible" : false,
														"aTargets" : [ 3 ]
													}, {
														"sClass" : "center",
														"aTargets" : [ 4 ]
													} ]
										});
					});

	function jumpPage(flag) {
		//window.open("http://localhost:8080/ynportal/basicInfor/tbManage/tb.action?transId="+flag);
		window.location.href = "${ctx}/basicInfor/tbManage/tb.action?transId="
				+ flag;
	}
	function setTabIndex(obj){
		$("#tab_index").val(obj);
		 $('#example').dataTable(
					{
						"bJQueryUI" : true,
						"bServerSide" : true,
						"bDestroy": true,
						"sPaginationType" : "full_numbers",
						"sAjaxSource" : //"${ctx}/basicInfor/tbManage/tb!BootstrapData.action?title="+$('#title').val()+"&apply_name="+$('#apply_name').val()+"&start_time="+$('#start_time').val()+"&end_time="+$('#end_time').val()+"&tab_index="+$('#tab_index').val(),
						"fnServerData" : function(sUrl,aoData, fnCallback,oSettings) {
							oSettings.jqXHR = $.ajax({
								"url" : sUrl,
								"data" : aoData,
								"success" : fnCallback,
								"dataType" : "json",
								"cache" : false
							});
						},
						"aoColumns" :  [ {
							"sTitle" : "生产线"
						}, {
							"sTitle" : "产品"
						}, {
							"sTitle" : "开始时间"
						}, {
							"sTitle" : "结束时间"
						}, {
							"sTitle" : "采样数"
						}, {
							"sTitle" : "平均值"
						}, {
							"sTitle" : "标准差"
						}, {
							"sTitle" : "不合格率"
						}, {
							"sTitle" : "班组"
						} , {
							"sTitle" : "是否放行"
						}, {
							"sTitle" : "放行人"
						}, {
							"sTitle" : "备注"
						}],
						"aoColumnDefs" : [
								{
									"mRender" : function(
											data, type, row) {
										// alert(JSON.stringify(row));
										return "<a href='javascript:void(0)' onclick='jumpPage(\""
												+ data
												+ "\");'>"
												+ data
												+ "</a>";
									},
									"aTargets" : [ 0 ]
								}, {
									"bVisible" : false,
									"aTargets" : [ 3 ]
								}, {
									"sClass" : "center",
									"aTargets" : [ 4 ]
								} ]
					});
	}
</script>
</head>
<body>
	<div class='container-fluid'>
		<div class='row-fluid'>
			<div class='span12'>
			<input type="hidden" id="tab_index" value="1"/>
				<div id='tabs-886386' class='tabbable' style="background-color:#CCCCCC">
				<ul class="nav nav-tabs">
						<li><a href="#panel-322615" data-toggle="tab" onclick="setTabIndex('1')">数据监控</a>
						</li>
						<li><a href="#panel-809020" data-toggle="tab" onclick="setTabIndex('2')">未汇总数据</a>
						</li>
						<li><a href="#panel-809020" data-toggle="tab" onclick="setTabIndex('3')">历史数据分析</a>
						</li>
						<li  class='active'><a href="#panel-809020" data-toggle="tab" onclick="setTabIndex('4')">历史分析数据查询</a>
						</li>
						<li><a href="#panel-809020" data-toggle="tab" onclick="setTabIndex('4')">工艺数据分析</a>
						</li>
					</ul>

				</div>
				<div class="panel panel-primary">
					
					<div class="panel-body">
						<div class="col-sm-2">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-warning">生产线</button>
								</div>
								<select class="form-control">
								  <option value="">全部</option>
								</select>
	
							</div>
						</div>
						<div class="col-sm-2">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-warning">产品</button>
								</div>
								<select class="form-control">
								  <option value="">全部</option>
								</select>
							</div>
						</div>

						<div class="col-sm-1">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-warning">选择时间</button>
								</div>
							</div>
						</div>
						<div class="col-sm-2" style="right: 39px">
						
							<div class="input-group date form_date col-md-60" data-date=""
								data-date-format="yyyy-mm-dd" data-link-field="dtp_input2"
								data-link-format="yyyy-mm-dd">
								<input id="start_time" class="form-control" size="16"
									placeholder="请选择开始时间" type="text" value="" readonly> <span
									class="input-group-addon"><span
									class="glyphicon glyphicon-remove"></span> </span> <span
									class="input-group-addon"><span
									class="glyphicon glyphicon-calendar"></span> </span>
							</div>
						</div>
						<div class="col-sm-2" style="right: 39px">
							<div class="input-group date form_date col-md-60" data-date=""
								data-date-format="yyyy-mm-dd" data-link-field="dtp_input2"
								data-link-format="yyyy-mm-dd">
								<input id="end_time" class="form-control" size="16"
									placeholder="请选择结束时间" type="text" value="" readonly> <span
									class="input-group-addon"><span
									class="glyphicon glyphicon-remove"></span> </span> <span
									class="input-group-addon"><span
									class="glyphicon glyphicon-calendar"></span> </span>
							</div>
						</div>

						<div class="col-sm-3">
							<div class="input-group">
							&nbsp;	&nbsp;
								<button id="searchBtn" type="button" class="btn btn-primary">查询</button>
								
							</div>
						</div>
					</div>
				</div>
				<table cellpadding="0" cellspacing="0" border="0" class="display" id="example">
				</table>
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
		$('#createPage').click(function(){ 
			window.location.href = "${ctx}/basicInfor/tbManage/tb!stock_repair_report.action";
		})
		$('#cleanBtn').click(function(){ 
			$('#title').val("");
			$('#apply_name').val("");
			$('#start_time').val("");
			$('#end_time').val("");
		});
		$('#searchBtn').click(function(){ 
			 $('#example').dataTable(
						{
							"bJQueryUI" : true,
							"bServerSide" : true,
							"bDestroy": true,
							"sPaginationType" : "full_numbers",
							"sAjaxSource" : "${ctx}/basicInfor/tbManage/tb!BootstrapData.action",
							"fnServerData" : function(sUrl,aoData, fnCallback,oSettings) {
								oSettings.jqXHR = $.ajax({
									"type": 'POST',
									"url" : sUrl,
									"data" : "title="+$('#title').val()+"&apply_name="+$('#apply_name').val()+"&start_time="+$('#start_time').val()+"&end_time="+$('#end_time').val()+"&tab_index="+$('#tab_index').val(),
									"success" : fnCallback,
									"dataType" : "json",
									"cache" : false
								});
							},
							"aoColumns" : [ {
								"sTitle" : "生产线"
							}, {
								"sTitle" : "产品"
							}, {
								"sTitle" : "开始时间"
							}, {
								"sTitle" : "结束时间"
							}, {
								"sTitle" : "采样数"
							}, {
								"sTitle" : "平均值"
							}, {
								"sTitle" : "标准差"
							}, {
								"sTitle" : "不合格率"
							}, {
								"sTitle" : "班组"
							} , {
								"sTitle" : "是否放行"
							}, {
								"sTitle" : "放行人"
							}, {
								"sTitle" : "备注"
							}],
							"aoColumnDefs" : [
									{
										"mRender" : function(
												data, type, row) {
											// alert(JSON.stringify(row));
											return "<a href='javascript:void(0)' onclick='jumpPage(\""
													+ data
													+ "\");'>"
													+ data
													+ "</a>";
										},
										"aTargets" : [ 0 ]
									}, {
										"bVisible" : false,
										"aTargets" : [ 3 ]
									}, {
										"sClass" : "center",
										"aTargets" : [ 4 ]
									} ]
						});
		});
	</script>
</body>
</html>