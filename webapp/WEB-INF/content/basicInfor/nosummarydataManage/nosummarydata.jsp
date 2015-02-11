<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>未汇总数据</title>

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

<script src="http://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script
	src="http://cdn.bootcss.com/twitter-bootstrap/3.0.2/js/bootstrap-dropdown.js"></script>
<script
	src="http://cdn.bootcss.com/twitter-bootstrap/3.0.2/js/bootstrap.min.js">
	
</script>
<script
	src="http://cdn.bootcss.com/twitter-bootstrap/3.0.2/js/bootstrap.js"></script>
<script src="${ctx}/bootstrap/js/jquery.dataTables.js"></script>
<style type="text/css" title="currentStyle">
@import "${ctx}/bootstrap/css/demo_page.css";

@import "${ctx}/bootstrap/css/demo_table_jui.css";

@import "${ctx}/bootstrap/css/jquery-ui-1.8.4.custom.css";

td {
	text-align: center;
}

th {
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

<script type="text/javascript">
	function setTabIndex(obj) {
		if (obj == "1") {
			window.location.href = "${ctx}/basicInfor/dtmonitoringManage/dtmonitoring.action";
		}
		if (obj == "2") {
			window.location.href = "${ctx}/basicInfor/dtmonitoringManage/dtmonitoring!passdata.action";
		}
		if (obj == "3") {
			window.location.href = "${ctx}/basicInfor/processdataanalysisManage/processdataanalysis.action";
		}
		if (obj == "4") {
			window.location.href = "${ctx}/basicInfor/lishiManage/lishi!chanPinShezhi.action";
		}
		if (obj == "5") {
			window.location.href = "${ctx}/basicInfor/dtmonitoringManage/dtmonitoring!tamuhistory.action";
		}
		if (obj == "6") {
			window.location.href = "${ctx}/basicInfor/nosummarydataManage/nosummarydata.action";
		}
		if (obj == "7") {
			window.location.href = "${ctx}/basicInfor/lishiManage/lishi!overpack.action";
		}
		if (obj == "8") {
			window.location.href = "${ctx}/basicInfor/lishiManage/lishi!weightFx.action";
		}
		if (obj == "9") {
			window.location.href = "${ctx}/basicInfor/lishiManage/lishi!tamuPool.action";
		}
		if (obj == "10") {
			window.location.href = "${ctx}/login/login!loginOut.action";
		}
		if (obj == "11") {
			window.location.href = "${ctx}/basicInfor/lishiManage/lishi!exportxjdc.action";
		}
	}

	function flash() {
		window.location.href = "${ctx}/basicInfor/nosummarydataManage/nosummarydata.action";

	}
</script>

<script type="text/javascript">
	function salesprotocol() {

		if (confirm("是否导出？")) {

			window.location.href = "${ctx}/basicInfor/nosummarydataManage/nosummarydata!salesprotocol.action";
		}
	}
</script>




</head>
<body>

	<div class='container-fluid'>
		<div class='row-fluid'>
			<div class='span12'>
				<input type="hidden" id="tab_index" value="1" />
				<div id='tabs-886386' class='tabbable'
					style="background-color: #CCCCCC">
					<ul class="nav nav-tabs">
						<li><a href="#panel-322615" data-toggle="tab" onclick="setTabIndex('1')">数据监控</a>
						</li>
						<li><a href="#panel-809020" data-toggle="tab" onclick="setTabIndex('2')">放行数据查询</a>
						</li>
						
						<li><a href="#panel-809020" data-toggle="tab" onclick="setTabIndex('5')">TAMU修改历史</a>
						</li>
						<li class='active'><a href="#panel-809020" data-toggle="tab" onclick="setTabIndex('6')">未汇总数据</a>
						</li>
						<li><a href="#panel-809020" data-toggle="tab" onclick="setTabIndex('7')">overpack数据</a>
						</li>
						<li><a href="#panel-809020" data-toggle="tab" onclick="setTabIndex('8')">重量分析表</a>
						</li>
						<li><a href="#panel-809020" data-toggle="tab" onclick="setTabIndex('11')">巡检记录导出</a>
						</li>
					</ul>
					<div class='container-fluid'>
						<div class='row-fluid'>
							<div class='span12'>

								<div class="panel panel-primary">

									<!-- <div class="col-sm-1">
						<div class="input-group">
							<img src="${ctx}/images/btn.jpg" class="btn_img" />
						</div>
					</div> -->
									<div class="panel-body">

										<div class="col-sm-2">
											<div class="input-group">
												<div class="input-group-btn">
													<input id="title" type="text" placeholder="实时显示未汇总数据。"
														class="form-control" readonly="readonly">
												</div>

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
										   <div class="input-group date form_date col-md-60"
												data-date="" data-date-format="yyyy-mm-dd"
												data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
												<input id="start_time" class="form-control" size="16"
													placeholder="开始时间" type="text" value="${data.statTime }" readonly> <span
													class="input-group-addon"><span
													class="glyphicon glyphicon-remove"></span> </span> <span
													class="input-group-addon"><span
													class="glyphicon glyphicon-calendar"></span> </span>
											</div>
										</div>
										<div class="col-sm-2" style="right: 39px">
											<div class="input-group date form_date col-md-60"
												data-date="" data-date-format="yyyy-mm-dd"
												data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
												<input id="end_time" class="form-control" size="16"
													placeholder="结束时间" type="text" value="${data.endTime }" readonly> <span
													class="input-group-addon"><span
													class="glyphicon glyphicon-remove"></span> </span> <span
													class="input-group-addon"><span
													class="glyphicon glyphicon-calendar"></span> </span>
											</div>
										</div>
										<div class="col-sm-5">
											<div class="input-group">
                                            <button id="cleanBtn" type="button" class="btn btn-info"
													onclick="lookfor()">查询</button>
												&nbsp; &nbsp;
												<button id="cleanBtn" type="button" class="btn btn-info"
													onclick="flash()">刷新</button>
												&nbsp; &nbsp;
												<button id="createPage" type="button"
													class="btn btn-warning" onclick="invaliddata()">删除无效数据</button>
												&nbsp; &nbsp;
												<button id="createPage" type="button"
													class="btn btn-warning" onclick="salesprotocol()">导出数据</button>
											</div>
										</div>
									</div>
								</div>
								<table cellpadding="0" cellspacing="0" border="0"
									class="display" id="example">
								</table>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>



		<div class="table-responsive">
			<form id="formPage" method="post"
				action='<c:url value="/basicInfor/nosummarydataManage/nosummarydata.action"/>'>
				<table class="table table-striped">
					<thead>
						<tr align="center">

							<th style="text-align: center">机器号</th>
							<th style="text-align: center">产品</th>
							<th style="text-align: center">采集时间</th>
							<th style="text-align: center">采样值</th>
							<th style="text-align: center">采样描述</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${rdata}" var="compan" varStatus="index">
							<tr align="center"
								<c:if test="${index.index%2==0}"> bgcolor="#f9f9f9"</c:if>>
								<td>${compan.lineno}</td>
								<td>${compan.productname}</td>
								<td>${compan.itemdatetime}</td>
								<td>${compan.itemvalue}</td>
								<td>${compan.itemsample}</td>

							</tr>
						</c:forEach>

					</tbody>
				</table>
			</form>
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
		
		
	</script>	
		<script type="text/javascript">
	function invaliddata() {

		window.location.href = "${ctx}/basicInfor/nosummarydataManage/nosummarydata!deleteInvilidata.action";

	}
	function  lookfor(){
		var statTime = document.getElementById("start_time").value;
		var endTime = document.getElementById("end_time").value;
		var d1 = new Date(statTime);
		var d2 = new Date(endTime);
		if (d1 > d2) {
			alert("起始日期必须小于终止日期！");
			start_date.focus();
			return;
		}
		window.location.href="${ctx}/basicInfor/nosummarydataManage/nosummarydata.action?statTime="
		 + statTime + "&endTime=" + endTime;
	}
	
</script>
</body>
</html>