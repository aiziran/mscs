<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<html>
<head>
	<%@ include file="/common/meta.jsp" %>	
	<%@ include file="/common/header.jsp" %>
<title>天庆房产公司办公系统</title>
<style type="text/css">
*{
	margin:0 auto;
	padding:0;
	list-style-type:none;
	}
.login {
	background-image: url(${ctx}/images/pbf/login_2.jpg);
	background-repeat: no-repeat;
	width: 693;
	height: 420;
	margin-bottom: 200px;
}
body{
	
	width:100%;
	background-image:url(${ctx}/images/back_bg.png);
	height:100%;}
.title{
	
	width:613px;
	height:55px;
	padding-top:80px;
	margin-left:auto;
	margin-right:auto;
 
	}
.center{
	margin-left:auto;
	margin-right:auto;
	width:642px;
	height:407px;
	padding-top:20px;
	background-image:url(${ctx}/images/back_login.jpg);
	}
.yh{
	width:642px;
	margin-top:120px;
	height:60px;
	_margin-left: 480px;
	*margin-left: -80px;
	}
.mm{
	width:642px;
	margin-top:0px;
	height:60px;
	_margin-left: 400px;
	*margin-left: -80px;
	}
.font1{
	width:60px;
	font-size:14px;
	font-weight:400;
	margin-left:180px;
	_margin-left:180px;
	float:left;
	}
input{
    float:left;
    font-size:12px;
	margin:0px 10px 3px 10px;
    padding:4px 2px;
    border:solid 1px  #CCC;
	width:200px;
	_margin-left: 280px;
	*margin-left: 270px;
	_margin-top: -20px;
}
.btn_login{
	margin-left:180px;_margin-left:0px;*margin-left:130px;
	margin-right:60px;
	float:left
	
	}
</style>
<script type="text/javascript">
  	if (self != window.top) {
    	window.top.location.href=self.location.href;
  	}
</script>

<script language="JavaScript" type="text/JavaScript">
  	function setCookie(name, value) {
    	var expires = new Date();
    	expires.setTime(expires.getTime() + 1000*60*60*24*30); //30일간 유지
    	document.cookie = name + "=" + escape(value) + "; expires="+ expires.toGMTString();
  	}
  	function getCookie(sName) {
    	var aCookie = document.cookie.split("; ");
    	for (var i=0; i < aCookie.length; i++)  {
	      	var aCrumb = aCookie[i].split("=");
	      	if (sName == aCrumb[0]) {
	        	if (typeof(aCrumb[1]) == "undefined" || aCrumb[1] =="" || aCrumb[1] == null) return "";
	        	return unescape(aCrumb[1]);
	      	}
    	}
    	return "";
 	}

  	function fncLogin() {
  	
	  	if ($('#userId').val() == ""){
	   		alert("请输入用户名");    
	   		$('#userId').focus();
	  	}else if ($('#userPassword').val() == ""){
	  		alert("请输入密码");
			$('#userPassword').focus();
	  	}else{
			var userId =$('#userId');
			var passwd = $('#userPassword');
			setCookie('rememberId', $('#rememberId').attr("checked"));
			setCookie('userId', $('#rememberId').attr("checked") ? $('#userId').val() : '');
			setCookie('department', $('#rememberId').attr("checked") ? $('#department').val() : '');
			actSubmitValidate($('#loginForm'), '<c:url value="/login/login!login.action"/>');
	  	}
  	}
  
  //切换图片样式 onMouseOut
  	function MM_swapImgRestore() { //v3.0
    	var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
  	}
  	
  	//切换图片样式 onMouseOver
  	function MM_swapImage() { //v3.0
    	var i,j=0,x,a=MM_swapImage.arguments; 
    	document.MM_sr=new Array; 
    	for(i=0;i<(a.length-2);i+=3)
     		if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
  	}
    //图片样式切换功能辅助
  	function MM_findObj(n, d) { //v4.01
    	var p,i,x;  
    	if(!d) d=document; 
    	if((p=n.indexOf("?"))>0&&parent.frames.length) {
      		d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);
      	}
    	if(!(x=d[n])&&d.all) x=d.all[n]; 
    	for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
    	for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
    	if(!x && d.getElementById) x=d.getElementById(n); return x;
  	}  
    function clearErrMessage(){
    	$("#message").html("");
    }
    
  	function clearForm()
  	{
  		$('#userId').val("");
  		$('#userPassword').val("");
  	}
</script>

</head>

<body>
<br><br>
<center>
<form id="loginForm" method="post" class="enterhandler"  onkeydown="if(event.keyCode==13) fncLogin();"/">
	
	
	
	<div class="title">
</div>
<div class="center">

	<div  class="yh">
		   <ul>
      <li class="font1">用户名:</li>
	  	<li class="input">	
	  	<input type="text" size="16" class="Lbordercolor" id="userId" name="j_username" tabindex="1" value="" onkeyup="clearErrMessage();"/>
	  		<input type="checkbox" class="Lbordercolor" id="rememberId" checked="checked" alt="ID REMEMBER" style="width: 20px;_width: 20px;_margin-left: 470px;_margin-top: -20px;"'/>
	  		</li>
		</ul>
	</div>	
	<div class="mm">
   	<ul>
      <li class="font1">密码:</li>
	  		
	  <li class="input">	
	  	<input type="password" size="18"  value=""   class="Lbordercolor" id="userPassword" name="j_password" tabindex="2"  onkeyup="clearErrMessage();" />
	  </li>
	 </ul>
	 </div>
	
	  
	  <div >
      <ul>
	  
	    <li class="btn_login">	<img onclick="fncLogin()" style="cursor: pointer;" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','${ctx}/images/btn_login.png',1)"
	       		src="${ctx}/images/btn_login.png" name="Image2" border="0" align="left">
	     </li>
	       	
	       <li><img src="${ctx}/images/btn_reset.png" width="114" height="32" onclick="clearForm()" style="_margin-left: -150px;margin-left: -100px;"/></li>
	       </ul>
	  </div>	  
	  <!-- 
	  <div style="margin-top:25px; margin-left: 240px;">
	  		<lable style="margin-left:10px">部 &nbsp;&nbsp;门 </label>
	  		<s:select name="j_department" id="department" list="deptList" 
	  		listKey="code" listValue="value" value="" theme="simple" cssStyle="width:115px;"/>        			       			
	  </div>
	   -->
	  <div id="message" style="color:red;font-size:12px;margin-top:10px;_margin-top:30px;margin-left:30px;"><s:actionmessage/></div>	  
	</div>
</form>
</center>

<script type="text/javascript" language="javascript">
$('#userId').focus();
$('#userId').val(getCookie('userId'));
$('#department').val(getCookie('department'));
if (getCookie('rememberId')=='true') {
  $('#rememberId').attr("checked","true");
}
</script>

</body>
</html>


