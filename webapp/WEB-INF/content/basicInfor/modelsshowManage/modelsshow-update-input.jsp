<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--
/**
 * ------------------------------------------------------------------------
 * @source  : modelsshow-input.jsp
 * @desc    :库存管理修改和删除页面
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2012.02.16   HYJ                 初次建立
 * ------------------------------------------------------------------------ 
 */
--%>
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript" src="${ctx }/js/DatePicker/WdatePicker.js"></script>
<script type="text/javascript" language="javascript">
	$(function(){
		$("#cartypename").focus();
		fncAppend("formDetail"); //传入主页面的查询参数值,及分页的信息
		Validator = $("#formDetail").validate({
			wrapper: "p", 		
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
    	fncExtraFormCancel('<c:url value="/basicInfor/modelsshowManage/modelsshow.action"/>');
  	}
  	
  	//保存操作
  	function fncSave() { 
  		actSubmitValidate($('#formDetail'), '<c:url value="/basicInfor/modelsshowManage/modelsshow!save.action"/>');
  	}
  	
 // 删除数据信息
 	function fncDelete(inventoryId) { 		
 		actSubmit($('#formDetail'), "/car/basicInfor/modelsshowManage/modelsshow!deleteDo.action");
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
  
/*   	function showChildWindow(obj,cartypeId,cartypeName,cartypeColors) 
	{ 
		var url = "<c:url value='/common/popup/popup!cartype.action'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
		//alert(aa)
		if(aa){
			$('#cartypeId').val(aa.split(";")[0])
			$('#cartypeName').val(aa.split(";")[1]);
		    var colorstr=aa.split(";")[2];
			var NewOperator =document.createElement("<select name='Operator'></select>");
			//alert(colorstr.split(",")[0]);
			
			if(colorstr)
				NewOperator.length =colorstr.split(",").length;
			var carray = colorstr.split(",");
			for(var i=0;i<carray.length;i++){
				NewOperator.options[i] =new Option(carray[i], carray[i]);
			}
			document.getElementById("colortd").appendChild(NewOperator);
		} else {
			$('#cartypeId').val("")
			$('#cartypeName').attr("");
			$('#cartypeColors').val("");
		}
	} */
  	function showChildWindow1(obj,cartypeid,cartypename,cartypedesc) 
	{ 
		var url = "<c:url value='/common/popup/popup!cartypedic.action'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
		//alert(aa)
		if(aa){
			$('#cartypeid').val(aa.split(";")[0])
			$('#cartypename').val(aa.split(";")[1]);
			$('#cartypedesc').val(aa.split(";")[2]);
		} else {
			$('#cartypeid').val("")
			$('#cartypename').attr("");
			$('#cartypedesc').val("");
		}
	}
  	
  	
  	function showChildWindow2(obj,configid,configname,color) 
	{ 
		var url = "<c:url value='/common/popup/popup!cartypeconfigdic.action'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
		//alert(aa)
		if(aa){
			$('#configid').val(aa.split(";")[0])
			$('#configname').val(aa.split(";")[1]);
			$('#color').val(aa.split(";")[2]);
		} else {
			$('#configid').val("")
			$('#configname').attr("");
			$('#color').val("");
		}
	}
  	
  	function showChildWindow3(obj,color) 
	{ 
		var url = "<c:url value='/common/popup/popup!configpic.action'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
		//alert(aa)
		if(aa){
			$('#color').val(aa.split(";")[0]);
		} else {
			$('#color').val("");
		}
	}
  	
</script>
</head>

<body>
	<div id="messageBox" style="display: none;"></div>
	<div id="Lcontent">
		<SSTag:navigation />
		<form id="formDetail" method="post">
			<input type="hidden" name="operateModel" value="update" />
			<input type="hidden" name="cartypeid" id="cartypeid" value="${modelsshow.cartypeid}"/>
			<table class="LDetailArea" summary="Modelsshow information.">
	
	
				    <tr>
					<th><font color="red">*</font><span>车型</span></th> <!-- 从车型字典表中查询出来 showwindow1 -->
					<td>
					<input type="text" name="cartypename" id="cartypename" value="<c:out value="${modelsshow.cartypename}"/>"  maxlength="150" class="Lbordercolor" readonly style="BACKGROUND-COLOR: #EEFFB6;float:left"/>
					<img src="/car/images/pbf/Content_icon_search.gif" class="btn_img" onClick="javascript:showChildWindow1(this,'cartypeid','cartypename','cartypedesc');" style="cursor:hand;margin-right:10px"/>
					</td>
					<th>售价</th>
					<td><input type="text" name="cartypeprice" maxlength="150" class="Lbordercolor" value="${modelsshow.cartypeprice}"/></td>
				</tr>
			
				<tr>
					<th>颜色</th>
					<td><input type="text" name="cartypecolor" maxlength="150" class="Lbordercolor" value="${modelsshow.cartypecolor}"/></td>
					<th>特点</th>
					<td><input type="text" name="cartypecharacteristic" maxlength="150" class="Lbordercolor" value="${modelsshow.cartypecharacteristic}"/></td>
				</tr>
				<tr>
					<th>参数</th>
					<td><input type="text" name="cartypeparameter" maxlength="150" class="Lbordercolor" value="${modelsshow.cartypeparameter}"/></td>
					<th>库存</th>
					<td><input type="text" name="cartypeinventory" maxlength="150" class="Lbordercolor" value="${modelsshow.cartypeinventory}"/></td>
				</tr>
				<tr>
					<th>图片</th>
					<td><input type="text" name="cartypepic" maxlength="150" class="Lbordercolor" value="${modelsshow.cartypepic}"/></td>
				</tr>
	
			</table>
		</form>
		<fieldset>
			<legend>Button</legend>
			<ul class="LbtnArea">
				<li><input type="button" value="保存" onclick="fncSave()"
					id="btnSave" objType="bSave" />
					 <input type="button" value="删除"
					onclick="fncDelete('${cartypeid}')" id="btnDelete"
					objType="bDelete" />
					 <input type="button" value="取消"
					onclick="fncCancel()" id="btnCancel" objType="bCancel" />
				</li>
			</ul>
		</fieldset>
	</div>
</body>
</html>


