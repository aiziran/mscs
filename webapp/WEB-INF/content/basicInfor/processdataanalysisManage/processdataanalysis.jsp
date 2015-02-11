<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<html>
<head>
<title>工艺数据分析</title>
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
td{
  text-align:center;
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
	
	
	function setTabIndex(obj){
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
		
		
	}
	
	</script>
	<script type="text/javascript">
	
	function lookfor(){
	
		      var lineNo=document.getElementById("lineNo").value;
			  var weightsize=document.getElementById("weightsize").value;
			  var statTime=document.getElementById("start_time").value;
			  var endTime=document.getElementById("end_time").value;
			  var d1 = new Date(statTime);
			  var d2 =  new Date(endTime);
	          if(d1>d2){alert("起始日期必须小于终止日期！");start_date.focus();return;};
			  window.location.href="${ctx}/basicInfor/processdataanalysisManage/processdataanalysis.action?lineNo="+lineNo+"&weightsize="+weightsize+"&statTime="+statTime+"&endTime="+endTime;
			
	}
	
	function exportResult(){
		if (confirm("是否导出？")) {
			 var lineNo=document.getElementById("lineNo").value;
			  var weightsize=document.getElementById("weightsize").value;
			  var statTime=document.getElementById("start_time").value;
			  var endTime=document.getElementById("end_time").value;
			window.location.href="${ctx}/basicInfor/processdataanalysisManage/processdataanalysis!salesprotocol.action?lineNo="+lineNo+"&weightsize="+weightsize+"&statTime="+statTime+"&endTime="+endTime;
		}
	}
	
	
function selectData(obj){
		
		var s_value=obj;
		var s_list=document.getElementById("lineNo");

		// 遍历s_list，选中上次的值
		for(var i=0;i<s_list.options.length;i+=1){
		   if(s_list.options[i].value==s_value){
		    s_list.options[i].selected=true;
		    break;
		   }
		}
		
	}
	
	function selectProductor(obj1){
		
		var s_value=obj1;
		var s_list=document.getElementById("weightsize");

		// 遍历s_list，选中上次的值
		for(var i=0;i<s_list.options.length;i+=1){
		   if(s_list.options[i].value==s_value){
		    s_list.options[i].selected=true;
		    break;
		   }
		}
		
	}
	
	</script>

</head>
<body onload="selectData('${data.lineNo}');selectProductor('${data.weightsize}')">


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
						<li class='active'><a href="#panel-809020" data-toggle="tab" onclick="setTabIndex('3')">工艺数据分析</a>
						</li>
						<li><a href="#panel-809020" data-toggle="tab" onclick="setTabIndex('4')">产品设置</a>
						</li>
						<li><a href="#panel-809020" data-toggle="tab" onclick="setTabIndex('5')">TAMU修改历史</a>
						</li>
						<li><a href="#panel-809020" data-toggle="tab" onclick="setTabIndex('6')">未汇总数据</a>
						</li>
						<li><a href="#panel-809020" data-toggle="tab" onclick="setTabIndex('7')">overpack数据</a>
						</li>
						<li><a href="#panel-809020" data-toggle="tab" onclick="setTabIndex('8')">重量分析表</a>
						</li>
						<li><a href="#panel-809020" data-toggle="tab" onclick="setTabIndex('9')">TAMU汇总</a>
						</li>
						<li ><a href="#panel-809020" data-toggle="tab" onclick="setTabIndex('10')">退出</a>
						</li>
					</ul>

					<div class="panel panel-primary">
					
						<div class="panel-body">
							<div class="col-sm-2">
								<div class="input-group">
									<div class="input-group-btn">
										<button type="button" class="btn btn-warning">机器号</button>
									</div>
									<select class="form-control" id="lineNo" >
									    <option value="">全部</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
									</select>

								</div>
							</div> 
							<div class="col-sm-2">
								<div class="input-group">
									<div class="input-group-btn">
										<button type="button" class="btn btn-warning">重量规格</button>
									</div>
									<select class="form-control" id="weightsize">
									    <option value=""> 请选择</option>
									    <option value="1">3800</option>
										<option value="2">2400</option>
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
										placeholder="请选择开始时间" type="text" value="${data.statTime}" readonly> <span
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
										placeholder="请选择结束时间" type="text" value="${data.endTime }" readonly> <span
										class="input-group-addon"><span
										class="glyphicon glyphicon-remove"></span> </span> <span
										class="input-group-addon"><span
										class="glyphicon glyphicon-calendar"></span> </span>
								</div>
							</div>

							<div class="col-sm-3">
								<div class="input-group">
									&nbsp; &nbsp;
									<button id="searchBtn"  type="button" class="btn btn-primary"
										onclick="lookfor()">查询</button>
									&nbsp; &nbsp;
									<button id="searchBtn" type="button" class="btn btn-info"
										onclick="exportResult()">导出</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</form>
	</div>




<div class="table-responsive">
		<form id="formPage" method="post"
			action='<c:url value="/basicInfor/processdataanalysisManage/processdataanalysis.action"/>'>
			<table class="table table-striped">
				<thead>
					<tr>
						<th style="text-align:center">机器号</th>
						<th style="text-align:center">采集时间</th>
						<th style="text-align:center">采样值</th>
						<th style="text-align:center">采样描述</th>
						

					</tr>
				</thead>
				<tbody>
					<c:forEach items="${rdata}" var="compan" varStatus="index">
						<tr align="center"
							<c:if test="${index.index%2==0}"> bgcolor="#f9f9f9"</c:if>>
							<td>${compan.lineno}</td>
							<td>${compan.itemdatetime}</td>
							<td>${compan.itemvalue}</td>
							<td>${compan.itemsample}</td>
						</tr>
					</c:forEach>
				
					
				</tbody>
			</table>
		
	</div>


	<%--<div style="float: left; height: 400px; width: 20%">
		<div class="panel-body">
			<div class="row">
				<div class="col-sm-6">
					<label class="control-label">计算参数</label>

				</div>
			</div>
			</br>


                      <div class="row">
				          <div class="col-sm-8">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-primary">标准值</button>
								</div>
								<input id="normalvalue" type="text" placeholder="请输入参数"
									class="form-control">
							</div>
						  </div>
						</div>
						</br>
						
						
						   <div class="row">
				          <div class="col-sm-8">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-primary">Target</button>
								</div>
								<input id="target" type="text" placeholder="请输入参数"
									class="form-control">
							</div>
						  </div>
						</div>
						</br>

			 <div class="row">
				          <div class="col-sm-8">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-primary">LSL</button>
								</div>
								<input id="lsl" type="text" placeholder="请输入参数"
									class="form-control">
							</div>
						  </div>
						</div>
						</br>
			
			<div class="row">
				<div class="col-sm-6">
					<label class="control-label">计算结果</label>

				</div>
			</div>
			</br>

               <div class="row">
				          <div class="col-sm-8">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-primary">BDCTH</button>
								</div>
								<input id="bacth" type="text" placeholder=""
									class="form-control">
							</div>
						  </div>
						</div>
						</br>
			
              <div class="row">
				          <div class="col-sm-8">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-primary">TAVG</button>
								</div>
								<input id="tavg" type="text" placeholder=""
									class="form-control">
							</div>
						  </div>
						</div>
						</br>
			

             <div class="row">
				          <div class="col-sm-8">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-primary">SAVG</button>
								</div>
								<input id="savg" type="text" placeholder=""
									class="form-control">
							</div>
						  </div>
						</div>
						</br>
						
						<div class="row">
				          <div class="col-sm-8">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-primary">取样数</button>
								</div>
								<input id="samplenumber" type="text" placeholder=""
									class="form-control">
							</div>
						  </div>
						</div>
						</br>
						
						<div class="row">
				          <div class="col-sm-8">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-primary">Tz</button>
								</div>
								<input id="tz" type="text" placeholder=""
									class="form-control">
							</div>
						  </div>
						</div>
						</br>
						
						
						<div class="row">
				          <div class="col-sm-8">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-primary">Cr  </button>
								</div>
								<input id="cr" type="text" placeholder=""
									class="form-control">
							</div>
						  </div>
						</div>
						</br>
						
						<div class="row">
				          <div class="col-sm-8">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-primary">缺陷率</button>
								</div>
								<input id="defectrate" type="text" placeholder=""
									class="form-control">
							</div>
						  </div>
						</div>
						</br>
		
	

			



		</div>



	</div> --%>


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
</body>
</html>