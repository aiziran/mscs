<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--
/**
 * ------------------------------------------------------------------------
 * @source  :secondhandcar-input.jsp
 * @desc    : 	创建用户页面
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2011.12.18   SSQ                 初次建立
 * ------------------------------------------------------------------------ 
 */
--%>
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<script type="text/javascript"
	src="${ctx }/js/DatePicker/WdatePicker.js"></script>
<%@ include file="/common/header.jsp"%>
<script src="${ctx}/js/hmis.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
$(function(){
	$("#id").focus();
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
    	fncExtraFormCancel('<c:url value="/basicInfor/archiveManage/archive.action"/>');
  	}
  	
  	//保存操作
  	function fncSave() { 
  		if(document.getElementById("scan").value!=""){
  			var str = document.getElementById("scan").value.split(".")[1]
  			   if(str != "pdf"){
  				   alert("扫描件只能为pdf类型!");
  				 return false;
  			   }
		}
  		
  		if(document.getElementById("archivenum").value==""){
			   alert("档案编号不能为空");
			   return false;
		}
		if(document.getElementById("typename").value==""){
		   alert("档案类型不能为空");
		   return false;
		}
		if(document.getElementById("name").value==""){
			   alert("档案名称不能为空");
			   return false;
		}
		if(document.getElementById("contractname").value==""){
			   alert("合同名称不能为空");
			   return false;
		}
		if(document.getElementById("mark").value==""){
			   alert("文号不能为空");
			   return false;
		}
		if(document.getElementById("archivepeople").value==""){
			   alert("存档人不能为空");
			   return false;
		}
		if(document.getElementById("archivesname").value==""  || document.getElementById("cabinetname").value=="" 
				|| document.getElementById("gridname").value==""){
			   alert("位置不能为空");
			   return false;
		}
  		actSubmitValidate($('#formDetail'), '<c:url value="/basicInfor/archiveManage/archive!save.action"/>');
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
  	function cfIsNull(value) {
    	if ($.trim(value) == ""){
    		return true;
    	}
    	return false;
    }
  	
  	
	function showChildWindow1() 
	{ 
  		
		var url = "<c:url value='/common/popup/popup!myDept.action'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
		alert(aa.split(";")[0]);
		if(aa){
			$('#manageid').val(aa.split(";")[0])
			$('#deptname').val(aa.split(";")[1])
		} 
	}
	function showChildWindow2() 
	{ 
  		
		var url = "<c:url value='/common/popup/popup!archives.action'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.

		if(aa){
			$('#archivesid').val(aa.split(";")[2])
			$('#archivesname').val(aa.split(";")[1])
		} 
	}
	function showChildWindow3() 
	{ 
  		var archivesid=document.getElementById('archivesid');
		var url = "<c:url value='/common/popup/popup!cabinet.action?archivesid="+archivesid.value+"'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.

		if(aa){
			$('#cabinetid').val(aa.split(";")[1])
			$('#cabinetname').val(aa.split(";")[0])
		} 
	}
	function showChildWindow4() 
	{ 
		var archivesid=document.getElementById('archivesid');
		var cabid=document.getElementById('cabinetid');
		var url = "<c:url value='/common/popup/popup!grid.action?archivesid="+archivesid.value+"&cabinetid="+cabid.value+"'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
		if(aa){
			$('#gridid').val(aa.split(";")[1])
			$('#gridname').val(aa.split(";")[0])
		} 
	}
	//档案类型
	function showChildWindow5() 
	{ 
  		
		var url = "<c:url value='/common/popup/popup!myType.action'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
		
		if(aa){
			$('#type').val(aa.split(";")[0])
			$('#typename').val(aa.split(";")[1])
		} 
	}
	//合同类型
	function showChildWindow6() 
	{ 
  		
		var url = "<c:url value='/common/popup/popup!contractType.action'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
		if(aa){
			$('#contractid').val(aa.split(";")[0])
			$('#contractname').val(aa.split(";")[1])
			$('#name').val(aa.split(";")[1])
			$('#type').val("47")
			$('#typename').val("合同")
		} 
	}
	//验证档案室编号是否重复
	function fncCheckRepeat() {
		var archivenum = $("#archivenum").val();
		if (archivenum == "")
			return;

		$
				.ajax({
					type : "POST",
					url : '<c:url value="/basicInfor/archiveManage/archive!checkArchivenum.action"/>',
					data : "archivenum=" + archivenum,
					async : false,
					success : function(flag) {
						if (flag == "false") {
							alert("编号（" + archivenum + "）已使用 !");
							$("#archivenum").val("").focus();
							return false;
						} else
							return true;
					}
				});
	}
	function showChildWindowProject()
	{
		var url = "<c:url value='/common/popup/popup!archiveProject.action'/>"; 
		var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
		var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
		
		if(!aa){
			 aa = window.returnValue;
		 }
		//alert(aa);
		if(aa){
			$('#projectid').val(aa.split(";")[0]);
			$('#projectname').val(aa.split(";")[1]);
		} 
	}
</script>
</head>

<body>

	<div id="Lcontent">
		<SSTag:navigation />
		<form id="formDetail" method="post"  enctype="multipart/form-data">
			<input type="hidden" name="operateModel" value="create" />
			<input type="hidden" name="archivesid" id="archivesid" />
			<input type="hidden" name="cabinetid" id="cabinetid" />
			<input type="hidden" name="gridid" id="gridid" />
			<table class="LDetailArea" summary="Secondhandcar information.">
				<tr>
					<th><font color="red">*</font><span>档案编号</span>
					</th>
					<td><input type="text" id="archivenum" name="archivenum"
						class="Lbordercolor" value="" onblur="fncCheckRepeat()"/>
					</td>
					<th><font color="red">*</font><span>档案类型</span>
					</th>
					<td><input type="text" id="typename" name="typename" class="Lbordercolor" readonly />	
							<input type="hidden" id="type" name="type" />
									<img src="/archive/images/pbf/Content_icon_search.gif" class="btn_img"
											onClick="javascript:showChildWindow5();"
											style="cursor: hand; margin-right: 10px" />
					</td>
				</tr>
				<tr>
					<th><font color="red">*</font><span>档案名称</span>
					</th>
					<td><input type="text" id="name" name="name"
						class="Lbordercolor" value=""/>
					</td>
					<th><font color="red">*</font><span>位置</span>
					</th>
					<td>
						<input type="text" size="5" id="archivesname" name="archivesname" onclick="javascript:showChildWindow2();" readonly>
						<input type="text" size="5" id="cabinetname" name="cabinetname" onclick="javascript:showChildWindow3();" readonly>
						<input type="text" size="5" id="gridname" name="gridname" onclick="javascript:showChildWindow4();" readonly>
					</td>
				</tr>
				<tr>
						<th> <span>档案所属部门</span>
					</th>
					<td><input type="text" id="deptname" name="deptname" on readonly>
					 	<input type="hidden" id="manageid" name="manageid" />
										<img src="/archive/images/pbf/Content_icon_search.gif" class="btn_img"
											onClick="javascript:showChildWindow1();"
											style="cursor: hand; margin-right: 10px" />
					</td>
					<th><span>是否原件</span>
					</th>
					<td>
						<select name="isoriginal" id="isoriginal" >
						  <option value ="0">是</option>
						  <option value ="1">否</option>
						</select>
					</td>
				</tr>
				<tr>
					<th><span>档案数量</span>
					</th>
					<td><input type="text" id="archivecount" name="archivecount"
						class="Lbordercolor" value="1"/>
					</td>
					<th><font color="red">*</font><span>档案密级</span>
						
					</th>
					<td>
					<select name="secretlevel" id="secretlevel">
					  <option value ="0">所有人均可见</option>
					  <option value ="1">仅本部门及以上可见</option>
					   <option value="2">仅经理及以上可见</option>
					  <option value="3">仅副总及以上可见</option>
					  <option value="4">仅总经理及以上可见</option>
					   <option value="5">仅董事长可见</option>
					   <option value ="6">仅管理员可见</option>
					</select>
					</td>
				</tr>
				
				<tr>
			
					<th>扫描件：</th>
					<td>
					<input type="file" name="scan" id="scan" maxlength="150" class="Lbordercolor"/>
					</td>
						<th>附件：</th>
					<td>
					<input type="file" name="upload" id="upload" maxlength="150" class="Lbordercolor"/>
					</td>
				</tr>
					<tr>
					<th><font color="red">*</font>合同名称：</th>
					<td>
					<input type="text" name="contractname" id="contractname" maxlength="150" class="Lbordercolor"/>
					<input type="hidden" id="contractid" name="contractid" />
										<img src="/archive/images/pbf/Content_icon_search.gif" class="btn_img"
											onClick="javascript:showChildWindow6();"
											style="cursor: hand; margin-right: 10px" />
					</td>
					<th><font color="red">*</font>文号：</th>
					<td>
					<input   name="mark" id="mark" maxlength="150" class="Lbordercolor"/>
					</td>
				</tr>
				<tr>
					<th><font color="red">*</font>存档人</th>
					 <td >
					 <input   name="archivepeople" id="archivepeople" maxlength="150" class="Lbordercolor"/>
					 </td>
					 <th>档案过期时间：</th>
					<td nowrap="nowrap">
					<input type="text" name="expirationdate" id="expirationdate" class="Wdate"
						onclick="WdatePicker()" readonly="readonly" 
						style="margin-right: 0px;" value="${carinfo.expirationdate}" />
					</td>
				</tr>
				<tr>
					<th><font color="red">*</font>所属项目</th>
					<td>
					<input type="hidden" id="projectid" name="projectid">
					<input type="text" id="projectname" name="projectname" readonly>
					<img src="/archive/images/pbf/Content_icon_search.gif" class="btn_img"
											onClick="javascript:showChildWindowProject();"
											style="cursor: hand; margin-right: 10px" />
					</td>
					<th></th>
					<td></td>
				</tr>
				
			</table>
		</form>
		<fieldset>
			<legend>Button</legend>
			<ul class="LbtnArea">
				<li><input type="button" value="保存" onclick="fncSave()"
					id="btnSave" objType="bSave" /> <input type="button" value="取消"
					onclick="fncCancel()" id="btnCancel" objType="bCancel" />
				</li> 
			</ul>
		</fieldset>
	</div>
</body>
</html>


