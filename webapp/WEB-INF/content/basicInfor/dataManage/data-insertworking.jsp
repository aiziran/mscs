<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--
/**
 * ------------------------------------------------------------------------
 * @source  : dept-input.jsp
 * @desc    : 数据权限管理创建页面
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2011.12.18   SSQ                 初次建立
 * ------------------------------------------------------------------------ 
 */
--%>
<%@ include file="/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/common/header.jsp" %>

<script type="text/javascript"
	src="${ctx }/js/DatePicker/WdatePicker.js"></script>
<script type="text/javascript" language="javascript">
	$(function(){
		$("#name").focus();	
		fncAppend("formDetail"); //传入主页面的查询参数值
		$("#formDetail").validate({
			submitHandler:function(form){
				if (!confirm("请确认是否提交？")) return;
				form.submit();
			}	
		});
	});
  	
	//取消当前编辑
  	function fncCancel() {
    	if(!confirm("是否要取消当前编辑并返回前页面？")) {
    		return;
    	}    	    	
    	fncExtraFormCancel('<c:url value="/basicInfor/dataManage/data!handerWorking.action"/>');
  	}
	
  	
  	//保存操作
  	function fncSave() { 
  		
  		actSubmitValidate($('#formDetail'), '<c:url value="/basicInfor/dataManage/data!insertWorkoing.action"/>');
  	}
  	
  	//控制备注字符输入
  	var textarea_maxlen = {
		isMax : function (){
		   var textarea = document.getElementById("area");
		   var max_length = textarea.maxlength;
		if(textarea.value.length > max_length){ 
		   textarea.value = textarea.value.substring(0, max_length);
		   }
		},
		disabledRightMouse : function (){
		document.oncontextmenu = function (){ return false; }},
		enabledRightMouse : function (){
		document.oncontextmenu = null;}
	};
	
  	
  	 function showChildWindow1() 
		{ 
	  		
			var url = "<c:url value='/basicInfor/userManage/user!handerDetail.action'/>"; 
			var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
			var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
			if(!aa){
				 aa = window.returnValue;
			 } 
			if(aa){
				$('#userid').val(aa.split(";")[0])
				$('#username').val(aa.split(";")[1])
			 
				} 
		}
	 
	 function showChildWindow2() 
		{ 
	  		
			var url = "<c:url value='/basicInfor/dataManage/data!classesdetail.action'/>"; 
			var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
			var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
			if(!aa){
				 aa = window.returnValue;
			 } 
			if(aa){
				$('#classesid').val(aa.split(";")[1])
				$('#classesname').val(aa.split(";")[2])
			 
				} 
		}
  	
</script>
</head>
   

<body>
<div id="Lcontent">
<SSTag:navigation/>
	<!-- <pbf:navigation/> -->
  	<form id="formDetail" method="post">
  		<input type="hidden" name="operateModel" value="create"/>
  		<table class="LDetailArea" summary="Dept information.">
    		
    		    <tr>

      			<th><font color="red">*</font><span>机手姓名</span></th>
      			<td>
					 <input type="hidden" id="userid" name="userid"  />
							 <input type="text" id="username" name="username" value="${data.username}" readonly onClick="javascript:showChildWindow1();"
											style="cursor: hand; margin-right: 10px"  />
				</td>
	            </tr>
	            <tr>
      			<th><font color="red">*</font><span> 班次</span></th>
      			<td>
					<input type="hidden" id="classesid" name="classesid" />
				    <input type="text" id="classesname" name="classesname" value="${data.classesname}" readonly onClick="javascript:showChildWindow2();"
											style="cursor: hand; margin-right: 10px"  />
				</td>
	            </tr>
	            <tr>
      			<th><font color="red">*</font><span> 日期</span></th>
      			<td>
					<input type="text" name="date" id="date" class="Wdate"
								onclick="WdatePicker({dateFmt:'yyyy-M-d'})" readonly="readonly" value="${data.date}" 
								style="margin-right: 0px;" >
				</td>
	            </tr>
	            <tr>
      			
	            </tr>
    		
    		
  		</table>
  	</form>
  	<fieldset>
  		<legend>Button</legend>
    	<ul class="LbtnArea">
      		<li>
      			<input type="button" value="保存" onclick="fncSave()" id="btnSave" objType="bSave"/>
        		<input type="button" value="取消" onclick="fncCancel()" id="btnCancel" objType="bCancel"/>
			</li>
    	</ul>
  	</fieldset>
</div>
</body>
</html>


