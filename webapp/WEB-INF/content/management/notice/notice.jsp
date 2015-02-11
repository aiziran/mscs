<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%--
/**
 * ------------------------------------------------------------------------
 * @source  : manageNoticeBoard.jsp
 * @desc    : 公告管理
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2011.05.20   lixinliang         初次建立
 * ------------------------------------------------------------------------ 
 */
--%>
<%@ include file="/common/taglibs.jsp" %>
<html>
<head>
<title>公告管理</title>
<%@ include file="/common/header.jsp" %>
<script src="${ctx}/js/DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="${ctx}/js/hmis.js"></script>
<script type="text/javascript" language="javascript">
  	
$(function(){
	fncAppend("formDetail");
	$("#formDetail").validate({
		wrapper: "p",
		submitHandler:function(form){
			form.submit();
		}	
	});
	$("#formSearch").validate({
		wrapper: "p",
		submitHandler:function(form){
			form.submit();
		}	
	});
	fncRetrvFirstRow();
});
  	
  	// 查询公告信息列表的第一行信息
  	function fncRetrvFirstRow() {  
  		if (!cfIsEmpty(document.getElementById("firstRowNoticeId").value)) {
  			cfTrClick($('#listTab').attr('rows')[1]);
	  		fncDetail(document.getElementById("firstRowNoticeId").value);
  		}
  		
  		var tab = document.getElementById("listTab");  
		if(tab) fixupFirstRow(tab);
		if (tab.rows.length < 12) {
			document.getElementById("resultDiv").style.height = "";
		}
  	}
  	
  	// 查询公告信息列表
    function fncSearch(){
    	var startDate = $('#formSearch').attr('queryStartDate').value 
		var endDate =  $('#formSearch').attr('queryEndDate').value
    	if (cfIsNotEmpty(startDate) && cfIsNotEmpty(endDate)) {
   			if(startDate>endDate){
   				alert("您输入的开始日期大于结束日期，请重新输入！");
   	   			document.getElementById('txtQueryStartDate').focus();
   	   			return false;
   			}
   		}
    	actSubmitValidate($('#formSearch'), "<c:url value="/management/notice/notice.action"/>");
    } 
  	
  	function onKeyBiaoTi(){
  		if(event.keyCode==13){
  			fncSearch();  			
  		}
  	}
  	
  	// 点击table时在下面的form中显示所选角色的详细信息
    function fncDetail(noticeId) {
  		$.ajax({
  			type:"POST",
  			url: "${ctx}/management/notice/notice!noticeDetail.action",
  			async:false,
  			data:'noticeId='+noticeId,
  			success:function(flag){				
  				 $(flag).find('key').each(function() {
                  // alert($(this).attr("id"));
                  //$('#formDetail').attr($(this).attr("id")).val()= $(this).text();
                  if($(this).attr("id")=='createBy'){
                	   $('#createBy').html($(this).text());
                   }else if($(this).attr("id")=='createDate'){
                	   $('#createDate').html($(this).text());
                   }else if($(this).attr("id")=='updateBy'){
                	   $('#updateBy').html($(this).text());
                   }else if($(this).attr("id")=='updateDate'){
                	   $('#updateDate').html($(this).text());
                   }else{
                	   setFormAjax('formDetail',$(this).attr("id"),$(this).text());
                   }
                  
                 });
  			}
  		});
  	}
  	
  	// 初始化角色信息
  	function fncAdd() {
    	//修改人和创建人默认为session值
    	var userId = "${data.userId}";
    	//修改日期和创建日期默认为当前日期
		var curDate = "${data.curDate}";
    	document.getElementById("createBy").innerHTML = userId;
    	document.getElementById("createDate").innerHTML = curDate;
    	document.getElementById("updateBy").innerHTML = userId;
    	document.getElementById("updateDate").innerHTML = curDate;
    	//默认开始日期为当前日期，结束日期为当前日期+7天
    	$('#startDate').val(curDate);
    	$('#endDate').val('${data.endDate}');//yyyy-mm-dd
    	$('#formDetail').attr('startDate').focus();
    	$('#noticeTitle').val('');
    	$('#noticeContent').val('');
    	$('#noticeId').val('');
  	}
  	
  	// 保存角色信息
  	function fncSave() {
  		var startDate = $('#startDate').val();
    	var endDate = $('#endDate').val();
    	
    	if (startDate > endDate){
    		alert("您输入的开始日期大于结束日期，请重新输入！");
   			document.getElementById('startDate').focus();
   			return false;
    	}
  	
    	<%--
    	if(!cfValidateAll()){
		 	return false;
		}
    	
    	$('#formDetail').queryNoticeTitle.value =  $('#formSearch').queryNoticeTitle.value;
    	$('#formDetail').queryStartDate.value =  $('#formSearch').queryStartDate.value;
    	$('#formDetail').queryEndDate.value =  $('#formSearch').queryEndDate.value;
   		--%>
   		if(!confirm("确定要保存吗？")) {
    		return false;
    	}
   		actSubmitValidate($('#formDetail'), "<c:url value="/management/notice/notice!saveNotice.action"/>");
  	}
  	
  	<%--
  	//控制公告内容字符个数输入
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
  	--%>
</script>
</head>

<body>
<!-- ******************** PAGE BLOCK: CONTENT ******************** -->
	<div id="Lcontent"><!--AREA search-->
		<SSTag:navigation/>
		<div id="LsearchArea">
			<form id="formSearch" name="formSearch" method="post"
				class="enterhandler"
				action="<c:url value="/management/notice/notice.action"/>"
				onEnter="this.submit()">
				<div>
					<ul>
						<li>
							<label for="LskillSearch" style="width:55px">公告标题:</label> 
							<input type="text" id="txtQueryNoticeTitle" name="queryNoticeTitle" class="Lbordercolor" onkeydown="onKeyBiaoTi()"
								value="<c:out value="${data.queryNoticeTitle}"/>"/>
							<label for="startDate" style="width:60px"><font color="red">*</font>开始日期:</label>
							<input id="txtQueryStartDate" name="queryStartDate" type="text" style="margin-right:1px" class="Lbordercolor Wdate"
								onclick="WdatePicker({readOnly:true})" size="13" value="<c:out value="${data.queryStartDate}"/>" readonly validate="{required:true}">
							<label for="startDate" style="width:60px"><font color="red">*</font>结束日期:</label> 
							<input id="txtQueryEndDate" name="queryEndDate" type="text" style="margin-right:1px" class="Lbordercolor Wdate"
								onclick="WdatePicker({readOnly:true})" size="13" value="<c:out value="${data.queryEndDate}"/>" readonly validate="{required:true}">
						</li>
					</ul>
				</div>
				<p>
					<a href="#" target="_self" onclick="fncSearch(); return false;">
						<img src="${ctx}/images/btn_search_e_g.gif" alt="查询" id="LsearchIcon" border="0">
					</a>
				</p>
			</form>
		</div>
		<!--END box--> <!--AREA [View]-->
		<form id="formPage" name="formPage" method="post" action="${ctx}/management/notice/notice.action">
			<div>
			<input type="hidden" id="firstRowNoticeId" name="firstRowNoticeId" value="<c:out value="${noticeDetail.noticeId}" />"/>
			<c:if test="${!empty page.result}">
				<div id="resultDiv" style="width: 765px;overflow-x:scroll;overflow-y:scroll;">
				<table class="LlistArea" id="listTab">
			</c:if>
			<c:if test="${empty page.result}">
				<div id="resultDiv" style="width: 765px;">
				<table class="LlistArea" id="listTab">
			</c:if>
			<script>
				document.getElementById("resultDiv").style.width=document.getElementById("formSearch").clientWidth;
			</script>		
				<tr>
					<th><a href="javascript:sort('notice_title','asc')">公告标题</a></th>
					<th><a href="javascript:sort('start_date','asc')">开始日期</a></th>
					<th><a href="javascript:sort('end_date','asc')">结束日期</a></th>
					<th><a href="javascript:sort('create_date','asc')">创建日期</a></th>
				</tr>
				
				<s:iterator value="page.result" status="st">
					<tr style="cursor: hand;" onClick="cfTrClick(this);fncDetail('<c:out value="${noticeId}"/>') ">
						<td  style="text-align: left">${noticeTitle}</td>
						<td style="width:100px"><c:out value="${startDate}" /></td>
						<td style="width:100px">${endDate}</td>
						<td style="width:100px">${createDate}</td>
					</tr>
				</s:iterator>
				<!-- 滚动条设置 -->
			<c:if test="${!empty page.result}">
				</table>
				</div>
				<table class="LlistArea" id="pageTab">
			</c:if>
			<!-- 滚动条设置-end -->
					<tr>
						<td colspan="30" class="AreaLeft">
							<%@ include file="/common/page.jsp" %>
						</td>
					</tr>
				</table>
		</div>
		</form>
		<br/>
		<form id="formDetail" method="post"　action="<c:url value="/management/notice/notice!saveNotice.action"/>">
			<input type="hidden" name="noticeId" id="noticeId" value="<c:out value="${noticeDetail.noticeId }"/>"/>
			<table class="LDetailArea" summary="Menu and Auth.">
				<tr>
					<th><font color="red">*</font>开始日期</th>
					<td>
						<input id="startDate" name="startDate" type="text" class="Lbordercolor Wdate" 
							onclick="WdatePicker({readOnly:true})" size="13" value="<c:out value="${noticeDetail.startDate }"/>" readonly validate="{required:true}">
					</td>
					<th><font color="red">*</font>结束日期</th>
					<td>
						<input id="endDate" name="endDate" type="text" class="Lbordercolor Wdate"
							onclick="WdatePicker({readOnly:true})" size="13" value="<c:out value="${noticeDetail.endDate }"/>" readonly validate="{required:true}">
					</td>
				</tr>
				<tr>
					<th>创建人:</th>
					<td id="createBy">${noticeDetail.createBy}</td>
					<th>创建日期:</th>
					<td id="createDate">${noticeDetail.createDate}</td>
				</tr>
				<tr>
					<th>修改人:</th>
					<td id="updateBy">${noticeDetail.updateBy}</td>
					<th>修改日期:</th>
					<td id="updateDate">${noticeDetail.updateDate}</td>
				</tr>
				<tr>
					<th><font color="red">*</font>公告标题:</th>
					<td colspan="3">
						<input type="text" id="noticeTitle" maxlength="500" style="width:490px"
							name="noticeTitle" class="Lbordercolor" alt="公告标题:no:maxByteLength=500"/ value="<c:out value="${noticeDetail.noticeTitle }"/>"  validate="{required:true}">
					</td>
				</tr>
				<tr>
					<th>公告内容:</th>
					<td colspan="3">
						<textarea id="noticeContent" style="width: 490px" rows="10" name="noticeContent" validate="{maxlength:500}" ><c:out value="${noticeDetail.noticeContent }"/></textarea>
					</td>
				</tr>
			</table>
		</form>
		<fieldset><legend>Button</legend>
			<ul class="LbtnArea">
				<li>
					<input type="button" value="新增" onclick="fncAdd()" onkeypress="fncAdd()"
						id="btnAdd" objType="bCreate" />
					<input type="button" value="保存" onclick="fncSave()" onkeypress="fncSave()" id="btnSave"
						objType="bSave" />
				</li>
			</ul>
		</fieldset>
	</div>
</body>
</html>