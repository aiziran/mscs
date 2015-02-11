<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Insert title here</title>
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/MessagePush.js"></script>
<script type="text/javascript">
	
	function dwrtest(data){ 
		var tmp=data.split(",");
		var newTr = document.getElementById("area").insertRow();
		//添加两列
		var newTd1 = newTr.insertCell();
		newTd1.innerHTML = "</br><tr><td>"+tmp[0]+"</td> <td>"+tmp[1]+"</td> <td>"+tmp[2]+"</td></tr>";
	}
	
	function send(msg){
		if(event.keyCode == 13){
			MessagePush.send(msg)
		}
	}
</script>
</head>
<body onload="dwr.engine.setActiveReverseAjax(true);">
	<table id="area">
	</table>
</body>
</html>