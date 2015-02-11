<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<html>
<head>
<title>Insert title here</title>

<!-- Bootstrap -->
<link rel="stylesheet" href="/archive/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="/archive/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="/archive/bootstrap/css/bootstrap-theme.css">
<link rel="stylesheet" href="/archive/bootstrap/css/bootstrap-theme.min.css">
<script src="/archive/bootstrap/js/jquery.min.js"></script>
<script src="/archive/bootstrap/js/bootstrap-dropdown.js"></script>
<script src="/archive/bootstrap/js/bootstrap.min.js"></script>
<script src="/archive/bootstrap/js/bootstrap.js"></script>
<script src="/archive/bootstrap/js/jquery.dataTables.js"></script>
<!--[if lt IE 9]>
        <script src="/archive/bootstrap/js/html5shiv.min.js"></script>
        <script src="/archive/bootstrap/js/respond.min.js"></script>
    <![endif]-->

<script src="/archive/bootstrap/js/jquery.dataTables.js"></script>
<style type="text/css" title="currentStyle">
@import "/archive/bootstrap/css/demo_page.css";

@import "/archive/bootstrap/css/demo_table_jui.css";

@import "/archive/bootstrap/css/jquery-ui-1.8.4.custom.css";

</style>
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/MessagePush.js"></script>
<!-- datepicker -->
<script type="text/javascript"
	src="/archive/bootstrap/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript"
	src="/archive/bootstrap/js/bootstrap-dropdown.js" charset="UTF-8"></script>
<script type="text/javascript"
	src="/archive/bootstrap/js/locales/bootstrap-datetimepicker.zh-CN.js"
	charset="UTF-8"></script>
<link href="/archive/bootstrap/css/bootstrap.min.css" rel="stylesheet"
	media="screen">
<link href="/archive/bootstrap/css/bootstrap-datetimepicker.min.css"
	rel="stylesheet" media="screen">
<script type="text/javascript">
	function onPageLoad(){
	    var userId = '${jihao}';
	    MessagePush.onPageLoad(userId);
	 }
	function showMessage(msg){
		alert(msg)
	}
	function dwrtest(data){ 
		var tmp=data.split(",");
		$('#currvalue').val(tmp[0]);
		$('#sendStatus').val(tmp[1]);
	}
	function averageValue(data){
		var tmp=data.split(",");
		$('#averagevalue').val(tmp[0]);
	}
	function loadSettings(){
		onPageLoad();
		dwr.engine.setNotifyServerOnPageUnload(true);
		dwr.engine.setActiveReverseAjax(true);
		dwr.engine.setAsync(false);
		dwr.engine._errorHandler = function(message, ex) {dwr.engine._debug("Error: " + ex.name + ", " + ex.message, true);};
	}
	var oldWeight=null;
	var t;
	function resetStatus(){
		var currvalue=$('#currvalue').val();
		if(oldWeight==null){
			oldWeight=currvalue;
		}else{
			if(oldWeight==currvalue){
				$('#sendStatus').val("中断");
			}else{
				oldWeight=currvalue;
			}
		}
		t=setTimeout("resetStatus()",30000);
	}
	window.setTimeout("resetStatus()",30000);
</script>
</head>
<body onload="loadSettings()" >
	<div class="panel panel-primary">
							
								<div class="panel-body">
								
									<div class="col-sm-4">
										<div class="input-group">
											<div class="input-group-btn">
												<button type="button" class="btn btn-primary">当前小时的重量的平均值</button>
											</div>
											<input id="averagevalue" name="averagevalue" type="text" placeholder=""
												class="form-control">
										</div>
									</div>
									<div class="col-sm-3">
										<div class="input-group">
											<div class="input-group-btn">
												<button type="button" class="btn btn-primary">当前采样的重量值</button>
											</div>
											<input id="currvalue" name="currvalue" type="text" placeholder=""
												class="form-control">
										</div>
									</div>
									<div class="col-sm-2">
										<div class="input-group">
											<div class="input-group-btn">
												<button type="button" class="btn btn-primary">通信状态</button>
											</div>
											<input id="sendStatus" name="sendStatus" type="text" placeholder="中断" value="中断"
												class="form-control">
										</div>
									</div>
								</div>
							
						</div>
</body>
</html>