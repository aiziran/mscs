<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<title>房地产新闻列表</title>
<%@ include file="/common/header.jsp"%>
<script type="text/javascript" language="javascript">
 	//进入添加页面
	function fncAdd() {
		actSubmit($('#formPage'),'<c:url value="/basicInfor/estatenManage/estaten!create.action"/>');
   }
	//进入修改页面
	function fncDetail(obj) {
		$('#id').val(obj);
		actSubmit($('#formPage'),
				'<c:url value="estaten!detail.action"/>');
	}

	//复选框全选
	 function fncCheckAll(field){  
         var checkboxes = document.getElementsByName("checkBox");  
         for(var i=0;i<checkboxes.length;i++){  
             checkboxes[i].checked = field.checked;  
          }  
      } 
	// 固定表头
	function fncFixupListHead() {
		var tab = document.getElementById("listTab");
		if (tab)
			fixupFirstRow(tab);

		if (tab.rows.length < 12) {
			if (document.getElementById("resultDiv")) {
				document.getElementById("resultDiv").style.height = "";
			}
		}
	}
</script>
</head>

<body onload="fncFixupListHead();">
	<div id="Lcontent">
		<SSTag:navigation />
		
		<form id="formPage" method="post">
			<input type="hidden" name="id" id="id" />
			<!-- 滚动条设置 -->
			<c:if test="${!empty page.result}">
				<div id="resultDiv"
					style="width: 1000px;overflow-x:scroll;<c:if test="${page.pageSize >10}">overflow-y:scroll;height:280px;</c:if>">
					<table class="LlistArea" id="listTab" style="width: 1000px;">
						</c:if>
						<c:if test="${empty page.result}">
							<table class="LlistArea" id="listTab">
								</c:if>
								<tr>
									<th>新闻主题</th>
									<th>发布人</th>
									<th>发布时间</th>
								</tr>
								<s:iterator value="page.result" status="st">
									<tr nowrap="nowrap" onMouseOver="cfTrOver(this)" onMouseOut="cfTrOut(this)">
										<td onClick="fncDetail('${id}')" style="text-align:left;">&nbsp;&nbsp;${subject}</td>
										<td onClick="fncDetail('${id}')">${createusername}</td>
										<td onClick="fncDetail('${id}')">${createtime}</td>
									</tr>
								</s:iterator>
								<!-- 滚动条设置 -->
								<c:if test="${!empty page.result}">
							</table>
							</div>
							<table class="LlistArea" style="width: 1000px;">
								</c:if>
								<!-- 滚动条设置-end -->
								<tr>
									<td colspan="20" class="AreaLeft"><%@ include
											file="/common/page.jsp"%> <!-- LPAGE JavaScript Start --></td>
								</tr>
							</table>
							</form>
							<fieldset>
				<legend>Button</legend>
				<ul class="LbtnArea" style="margin-right: 20px;">
					<li>
						<input type="button" value="新增" onclick="fncAdd()" id="btnAdd" objType="bCreate"/>
					
					</li>
			
					</ul>
		              </fieldset>			
			<br />
							</div>
							</div>
							<!-- END content -->
</body>
</html>