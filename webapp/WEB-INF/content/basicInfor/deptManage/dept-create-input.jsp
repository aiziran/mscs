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
<script type="text/javascript" language="javascript">
	$(function(){
		$("#deptName").focus();	
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
    	fncExtraFormCancel('<c:url value="/basicInfor/deptManage/dept.action"/>');
  	}
	
  	
  	//保存操作
  	function fncSave() { 
  		actSubmitValidate($('#formDetail'), '<c:url value="/basicInfor/deptManage/dept!save.action"/>');
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
	function showChildWindow6() 
	{ 
  		
		var url = "<c:url value='/common/popup/popup!selectDeputy.action'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
		if(aa){
			$('#usrename').val(aa.split(";")[1])
			$('#deptManager').val(aa.split(";")[0])
			
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
      			<th><font color="red">*</font><span>数据权限名称</span></th>
      			<td>
					<input type="text" id="deptName" name="deptName" size="20" class="Lbordercolor" value="" validate="{required:true,maxlength:50}"/>
				</td>
      			<th><font color="red">*</font><span>数据权限类型</span></th>
      			<td>
      				<s:select name="deptType" id="deptType" list="deptTypeList" listKey="code" listValue="value"   style="width:96px;margin-right: 10px;" theme="simple" />
				</td>
	      </tr>
    		
    		<tr>
      			<th><font color="red">*</font><span>负责人编号</span></th>
      			<td><input type="text" name="usrename" id="usrename" class="Lbordercolor" value="" validate="{required:true,maxlength:20}"/>
      			<input type="hidden" id="deptManager" name="deptManager" />
										<img src="/archive/images/pbf/Content_icon_search.gif" class="btn_img"
											onClick="javascript:showChildWindow6();"
											style="cursor: hand; margin-right: 10px" /></td>
    			<th>负责人电话</th>
      			<td><input type="text" name="deptTel" class="Lbordercolor" value="" maxlength="50" onkeyup="if((event.keyCode==8 || event.keyCode==9 || event.keyCode==37 || event.keyCode==39) || (event.keyCode>=48 && event.keyCode<=57)) return;value=value.replace(/[^\d|^-]/g,'')" validate="{phone_mobile:true,maxlength:50}"/></td>
			</tr>
    		
    		<tr>
      			<th>负责人地址</th>
      			<td colspan="3"><input type="text" name="deptAddress" style="width: 500px" class="Lbordercolor" value="" maxlength="200" validate="{maxlength:200}"/></td>
    		</tr>
			<tr>
      			<th>备注</th>
      			<td colspan="3">
					<textarea id="area" rows="3" style="width: 500px" name="deptNotes"  maxlength="500" validate="{maxlength:500}" onkeyup="textarea_maxlen.isMax()" onfocus="textarea_maxlen.disabledRightMouse()" onblur="textarea_maxlen.enabledRightMouse()"></textarea>
				</td>
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


