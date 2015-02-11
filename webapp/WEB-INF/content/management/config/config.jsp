<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!--  
/**
 * ------------------------------------------------------------------------
 * @source  : listCode.jsp
 * @desc    : 系统设置
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
<title>系统设置</title>
</head>
<%@ include file="/common/header.jsp"%>
<script src="${ctx}/js/common.js" type="text/javascript"></script>
<script type="text/javascript"
	src="${ctx }/js/DatePicker/WdatePicker.js"></script>
<script type="text/javascript" language="javascript">
	//保存操作
	function fncSave() {
		if($('#formDetail #saftyFactorHigh').val()==""){
			alert("安全系数是必填项");
			$('#formDetail #saftyFactorHigh').focus();
			return false;
			}
		if($('#formDetail #saftyFactorLow').val()==""){
			alert("安全系数是必填项");
			$('#formDetail #saftyFactorLow').focus();
			return false;
			}
		if($('#formDetail #expFilePath').val()==""){
			alert("数据库备份路径是必填项");
			$('#formDetail #expFilePath').focus();
			return false;
			}
		if($('#formDetail #saftyFactorHigh').val()<$('#formDetail #saftyFactorLow').val()){
			alert("安全系数高应该大于安全系数低！");
			$('#formDetail #saftyFactorHigh').focus();
			return false;
		}
		actSubmit($('#formDetail'), '<c:url value="/management/config/config!saveConfig.action"/>');
	}
	function fncFixupListHead(){
		 $('#formDetail :input[id=purRuleRoundMethod][type=radio][value='+document.getElementById("rule").value+']').attr("checked","true");
		 $('#formDetail :input[id=purPlanRoundMethod][type=radio][value='+document.getElementById("plan").value+']').attr("checked","true");
		}
</script>
<body  onLoad="fncFixupListHead();">
	<div id="Lcontent"><SSTag:navigation />
	<form name="formDetail" id="formDetail" method="post" class="enterhandler" >
	<input type="hidden" value="<c:out value='${data.purRuleRoundMethod}'/>" id="rule">
	<input type="hidden" value="<c:out value='${data.purPlanRoundMethod}'/>" id="plan">
    	<table class="LDetailArea">	
				<tr>
					<th>数据库备份路径</th>
		   		<td>
			    	<input name="expFilePath" id="expFilePath" value="<c:out value='${data.newFilePath}'/>" class="Lbordercolor" style="width:300" maxlength="200" alt="数据库备份路径:yes:maxByteLength=200" required/>
		    	</td>
		   	</tr>
				<tr>
					<th>采购原则舍入方式</th>
			    <td>
			      <input type="radio" name="purRuleRoundMethod" id="purRuleRoundMethod" value="0" />四舍五入
			      <input type="radio" name="purRuleRoundMethod" id="purRuleRoundMethod" value="1" />全舍
			      <input type="radio" name="purRuleRoundMethod" id="purRuleRoundMethod" value="2"/>全入
			    </td>
		   	</tr>
				<tr>
					<th>采购计划舍入方式</th>
			    <td>
			      <input type="radio" name="purPlanRoundMethod" id="purPlanRoundMethod" value="0"/>四舍五入  
			      <input type="radio" name="purPlanRoundMethod" id="purPlanRoundMethod"  value="1" />全舍    
			      <input type="radio" name="purPlanRoundMethod" id="purPlanRoundMethod" value="2"/>全入    
			    </td>
		   	</tr>
				<tr>
					<th>安全系数</th>
		   		<td>
			 
			    	高：<input name="saftyFactorHigh" id="saftyFactorHigh" value="<c:out value='${data.saftyFactorHigh}'/>" class="Lbordercolor" style="width:60" maxlength="40" alt="安全系数高:yes:number=(6.2)" />
			    	低：<input name="saftyFactorLow" id="saftyFactorLow"  value="<c:out value='${data.saftyFactorLow}'/>" class="Lbordercolor" style="width:60" maxlength="40" alt="安全系数低:yes:number=(6.2)" />
		    	</td>
		   	</tr>
    	</table>
	</form>  	
	<div style="width:700px;">
		<font color="red">数据库备份路径和上传路径为服务器的文件目录，保存设置前请确保相应的目录已创建。</font>
	</div>
	<fieldset>
		<legend>Button</legend>
		<ul class="LbtnArea">
			<li><input value="保存" onclick="fncSave()" onkeypress="fncSave()" type="button" objType="bSave"></li>
		</ul>
	</fieldset> 
</div>
</body>
</html>