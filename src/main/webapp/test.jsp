<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Bootstrap 101 Template</title>
<%@ include file="/common/header.jsp"%>
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

</head>
<body>
	<div class='container-fluid'>
		<div class='row-fluid'>
			
		
					<div class="panel-heading">
						<h3 class="panel-title">查询</h3>
					</div>
					<div class="panel-body">
						<div class="col-sm-2">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-warning">标题</button>
								</div>
								<input id="title" type="text" placeholder="请输入标题"
									class="form-control">
							</div>
						</div>
						<div class="col-sm-2">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-warning">申请人</button>
								</div>
								<input id="apply_name" type="text" placeholder="请输入申请人姓名"
									class="form-control">
							</div>
						</div>

						<div class="col-sm-1">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-warning">申请时间</button>
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
								<button id="searchBtn" type="button" class="btn btn-success">查询</button>
								&nbsp;	&nbsp;
								<button id="cleanBtn" type="button" class="btn btn-warning">清空</button>
							</div>
						</div>
						<div class="col-sm-3">
							</br>
							<div class="input-group">
									<button id="createPage" type="button" class="btn btn-warning">新增</button>
									<button type="button" class="btn btn-danger">退出</button>
							</div>
						</div>
					</div>
				</div>
				<table cellpadding="0" cellspacing="0" border="0" class="display" id="example">
				</table>
			</div>
		</div>
	</div>
	
</body>
</html>