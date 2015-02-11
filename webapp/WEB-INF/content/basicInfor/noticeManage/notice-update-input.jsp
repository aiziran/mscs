<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>修改公告</title>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript"
	src="${ctx }/js/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="/archive/ckeditor/ckeditor.js"></script>
</head>
<script type="text/javascript" language="javascript">


function showChildWindow2(obj,archivesnum,archivesname) 
{ 
		
	var url = "<c:url value='/common/popup/popup!myDept.action'/>"; 
	var strFeatures="dialogWidth=510px;dialogHeight=560px;center=yes;middle=yes;help=no;status=no;scroll=no"; 
	var aa = window.showModalDialog(url,"window",strFeatures); //取得子窗口传回的值.
	//alert(aa)
	if(aa){
		$('#location').val(aa.split(";")[0])
		$('#locationname').val(aa.split(";")[1])
		;
	} 
	document.getElementById("checkboxl").checked=false;
}
function fncRes(){
	$('#locationname').val('');
	$('#location').val('');
}
function fncBack(){
	window.location.href="notice.action";
}
function fncSave(){
	
	
	if(document.getElementById("title").value==""){
		alert("标题不能为空！！！");
		return false;
	}
	if(document.getElementById("content").value==""){
		alert("内容不能为空！！！");
		return false;
	}
	if(document.getElementById("startdate").value==""){
		alert("日期不能为空！！！");
		return false;
	}
	var a=document.getElementById("ethours").value;
	if(a==""){
			alert("小时不能为空！！！");
			return false;
		}
	if(!/^[0-9]*$/.test(a)){
			alert("小时处请输入数字！！！");
			return false;
		}
	if(a<8|a>20){
			alert("时间区间为8:00-20:00");
			return false;
		}
	if(a.length==1){
			$('#ethours').val('0'+a);
		}
	if(a.length>2){
			alert("输入结束小时有误！！！");
			return false;
		}
		 a=document.getElementById("etminutes").value;
		
	if(a==""){
			$('#etminutes').val("00");
			}
	if(a<0|a>59){
  			alert("分钟为0-59");
  			return false;
  		}
	if(a.length==1){
			$('#etminutes').val("0"+a);
		}
	$('#validity').val(document.getElementById("startdate").value+' '+document.getElementById("ethours").value+':'+document.getElementById("etminutes").value);
	a=document.getElementById("checkbox");
	if(a.checked){
		$('#ishomepage').val("1");
	}else{
		$('#ishomepage').val("0");
	}
	a=document.getElementById("checkboxl");
	if(a.checked&&document.getElementById("locationname").value!=""){
		 alert("选择全部部门就不能再选其他部门！！！");
		 return false; 
	 }
	if(a.checked){
		$('#location').val("-1");
	}
	if(!a.checked&&document.getElementById("locationname").value==""){
		alert("显示部门不能为空！！！");
		return false;
	}
	
	actSubmitValidate($('#formDetail'), 'notice!update.action');
}
function downFile(){
	 actSubmit($('#formDetail'),
		'<c:url value="notice!downFile.action "/>');
}
</script>
<body onload="fncFixupListHead();">
  <div id="Lcontent">
	<SSTag:navigation/>
		<form id="formDetail" method="post" enctype="multipart/form-data">
		<div id="resultDiv"	style="width: 1000px;">
					<table class="LDetailArea" id="listTab" style="width:1000px">
					<s:iterator value="page.result" status="st">
									<tr>
										<td colspan="4"><b>修改公告</b></td>
									</tr>
									<tr>
										<th ><font color="red">*</font>标题：</th>
										<td>
										<input type="hidden" id="id" name="id" value="${id }">
										<input type="text" id="title" name="title" value="${title }">
										</td>
									</tr>
									 
									<tr>
									<th>附件：</th>
									<td >
								 
									<c:if test="${annex==''}">没有附件</c:if>
										<c:if test="${annex!=''}">	<a href="#" onclick="downFile()">${file }</a></c:if>
									<input type="button" id="clean" value="clean" onClick="fncClean()">
									 
									</tr>
									<tr>
									<th>修改附件：</th>
									<td >
									<input type="hidden" id="annex" name="annex" value=${annex }> 
									<input type="file" value="上传" name="upload" id="upload"></td>
									</tr>
									<tr>
										<th><font color="red">*</font>有效期：</th>
										<td>
										<input type="hidden" id="validity" name="validity" >
										<input type="text" name="startdate" id="startdate" class="Wdate"
								onclick="WdatePicker()" readonly="readonly" value="${date}" 
								style="margin-right: 0px;" >&nbsp;&nbsp;日
										<input type="text" id="ethours" name="ethours" style="width:30px" value="${hour }">&nbsp;&nbsp;时
										<input type="text" id="etminutes" name="etminutes" style="width:30px" value="${minute }">&nbsp;&nbsp;分
										</td>
									</tr>
									
									<tr>
										<th><font color="red">*</font>显示位置：</th>
										<td colspan="3">
											<input type="hidden" id="location" name="location" value="${location }">
											<input type="checkbox" id="checkboxl" name="checkboxl"
											<c:if test="${location==-1 }">checked</c:if>>全部&nbsp;&nbsp;部门
											<input type="text" id="locationname" name="locationname" <c:if test="${location!=-1 }">value="${dname }"</c:if>> 
											<img src="/archive/images/pbf/Content_icon_search.gif" class="btn_img"
											onClick="javascript:showChildWindow2(this,'archivesnum','archivesname');"
											style="cursor: hand; margin-right: 10px" name="img" id="img" />
											<input type="button" id="resetdept" name="resetdept" value="清空部门" onClick="fncRes()">
										</td>
									</tr>
									<tr>
									<th>其他：</th>
									<td>
										<input type="hidden" id="ishomepage" name="ishomepage" > 
										<input type="checkbox" id="checkbox" name="checkbox"  <c:if test="${ishomepage==1 }">checked</c:if>>置顶
									</td>
							</tr>
							<tr>
									 <td colspan="2" align="center"><font color="red">*</font>内容：</td>
									</tr>
									</table>											<textarea id="content" name="content" rows="15" >${ content}</textarea>
									<script language="javascript">
				CKEDITOR.replace( 'content',
			{
			fullPage : true,
			extraPlugins : 'docprops',
			filebrowserUploadUrl : '${ctx}/basicInfor/newsinfoManage/newsinfo!savepic.action'
			});
				</script>
							</s:iterator>		
							
								</form>
								<fieldset>
				<legend>Button</legend>
				<ul class="LbtnArea" >
					<li>
						<input type="button" value="返回" onclick="fncBack()" id="fncUpd" />
					</li>
					<li>
						<input type="button" value="修改" onclick="fncSave()" id="fncUpd" />
					</li>
				</ul>
			</fieldset>
							</div>
							</div>
							<!-- END content -->
</body>
</html>