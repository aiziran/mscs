<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!--  
/**
 * ------------------------------------------------------------------------
 * @source  : listCode.jsp
 * @desc    : 欢迎界面
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2010.05.29  houyingchang       初次建立
 * ------------------------------------------------------------------------ 
 */
 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equivmetahttp-equiv="x-ua-compatible"content="IE=7"/> 
<title>欢迎界面</title>
<style>
*{margin:0;padding:0;}	
body { font-size: 13px; line-height: 130%; padding: 20px }
#rowpanel { float:left; MARGIN-RIGHT: auto; MARGIN-LEFT: auto;width:810px;margin: 6px ;}
#panel { width: 400px;height:200px; border: 1px solid #178BF1; }

.head { padding: 5px; background: #1765A9;color:white }

.content { padding: 10px; text-indent: 2em; border-top: 1px solid #178BF1;}
</style>
</head>
<%@ include file="/common/header.jsp"%>
<script src="${ctx}/js/common.js" type="text/javascript"></script>
<script type="text/javascript">
  //固定表头
  	function fncFixupListHead()   
  		{  
  		}
  
  function my(){
	  var topid="<%if (session.getAttribute("topMenuId") != null) out.print(session.getAttribute("topMenuId"));%>";
	  if(topid!=10){
		  actSubmit($('#formPage'),
	  		'<c:url value="/basicInfor/dtmonitoringManage/dtmonitoring!exportWeightpass.action"/>');
	  }else{
		  if(parent.bodyFrame.cols=="210,*,1")
		  {
			 parent.bodyFrame.cols="0,*,1";
		  }
		  else
		  {
			  parent.bodyFrame.cols="210,*,1";
		  }
		  document.getElementById("my2").style.display = "block";
	  }
    	  

  }
</script>
<body  onload="fncFixupListHead();my()" >
						<form id="formPage" name="formPage" method="post"   class="enterhandler">
						 <input type="hidden" name="id" id="id">
						 <input type="hidden" name="eid" id="eid">
                       </form>
                     
 <div id="my2"  style="display:none ;width:100% ;height:600px ;background-image:url('${ctx}/images/baojie.jpg'); background-position: center ;background-repeat: no-repeat; margin:0 auto;"  >

</div>

</body>
</html>