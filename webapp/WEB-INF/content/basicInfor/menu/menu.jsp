<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
/**
 * ------------------------------------------------------------------------
 * @source  : manageMenu.jsp
 * @desc    : 菜单管理页面
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

<link href="${ctx}/css/dtree.css"    rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${ctx}/js/dtree.js"></script>
<script language="javascript">
	$(function(){
		$("#formDetail").validate({
			submitHandler:function(form){
				if (!confirm("请确认是否保存？")) return;
				form.submit();
			}	
		});
		$("#btnSave").bind("click",function(){
			fncSave();
		});
	});
	
	var mode="create";
	
	document.onmousedown=function(e){
		cfOnMouseDown(e);
	};

	// 新增菜单
	function fncAddMenu(menuId) {
		mode = "create";
		cfEnableObjs('btnSave', true);
		$('#formDetail')[0].reset();
	    
		$.get("<c:url value="/basicInfor/menu/menu!createMenu.action"/>",
				{menuId:menuId},
				function(xml,status){
					$(xml).find("key").each(function(i){	
						setFormAjax('formDetail',$(this).attr("id"),$(this).text());
					})
					fncSetCreateMode();
				},
				"xml"
		);
	}

	// 查询菜单详情
	function fncDetail(menuId) {
		mode = "update";
		cfEnableObjs('btnSave', true);
		var id='';
		var value='';
		var formId='';
		$.get("<c:url value="/basicInfor/menu/menu!retrieveMenu.action"/>",
				{menuId:menuId},
				function(xml,status){
					$(xml).find("key").each(function(i){	
						setFormAjax('formDetail',$(this).attr("id"),$(this).text());
					});
					fncSetUpdateMode();
				},
				"xml"
		);		
		cfEnableObjs('useFlag', true);
	}
	
	// 保存菜单
	function fncSave() {	
		var menuCode = $('#formDetail :input[id=menuCode]').attr("value");
		if (menuCode== '' || menuCode == null) {
			return;
		}

		if(mode=="create") 
			actSubmit($('#formDetail'), '<c:url value="/basicInfor/menu/menu!createMenuDo.action"/>');
		else if( mode == "update" )
			actSubmit($('#formDetail'), '<c:url value="/basicInfor/menu/menu!updateMenuDo.action"/>');
		
	}
	
	//设置创建模式
	function fncSetCreateMode() {
		//alert('ttttt')
		mode = "create";
		$('menuName').value = $('menuName').value + $('menuCode').value
		cfEnableObjs('menuName,menuSeq', true);
		cfEnableObjs('useFlag', false); 
		cfEnableObjs('btnSave', true); 
	
		fncSetMenuSeq();
	}
	
	//设置修改模式
	function fncSetUpdateMode() {
		mode = "update";
		cfEnableObjs('menuCode,menuLvl', false); 
		cfEnableObjs('menuName,menuSeq', true);  
		cfEnableObjs('btnSave', true); 
	
		fncSetMenuSeq();
	}
	
	//设置查看详情模式
	function fncSetNoneMode() {	    
	    <c:if test="${data.menuId != null}">
	    	fncDetail(<c:out value="${data.menuId}"/>);
	    </c:if>
	    <c:if test="${data.menuId == null}">
	    	cfEnableObjs('btnSave', false);
	    </c:if>   
	}  

	//  Sequence 生成
	function fncSetMenuSeq() {
		var minValue = 1;
		var maxValue = 1;
		 	maxValue = $('#maxMenuSeq')[0].value;
	}
	
	//刷新
	function fncReload() {
		$('#formDetail')[0].submit();
	}
	
	
	function fncDel() {
		
		var menuId=document.getElementById("menuId").value;
		if (!confirm("请确认是否删除？")) return;
		 window.location.href="${ctx}/basicInfor/menu/menu!deleteMenu.action?menuId="+menuId;
	
		
	}

</script>
</head>
<body onLoad="fncSetNoneMode()" onContextMenu="return false;">
	<div id="Lcontent">
	  	<SSTag:navigation/>
	   	<div class="table_layout" style="width:35%; height:479; float:left; 
	                                    border:1px solid #B9B9B9;
	                                    overflow:auto;background-color:#FFFFFF;">
	    	<div class="dtree">  
	          	<script type="text/javascript">
	             	treeMenu = new dTree('treeMenu','${ctx}');
	             	var aMenu = "新增下级菜单";
	             	<c:if test="${query.menuId == null }">
	             		treeMenu.clearCookie();
	             	</c:if>
	             	<c:forEach items="${menuList.menuId}" varStatus="inx">
		             	var aFunc = "fncAddMenu(\"" + <c:out value="${menuList.menuId[inx.index]}"/> + "\")";
		               	var treeName = "<span onContextMenu='cfContextMenuShow(" + aFunc + ", \"" + aMenu + "\");' "
		                             + "style='cursor:hand'><c:out value="${menuList.menuName[inx.index]}"/></span>";
		               	var treeUrl = "javascript:fncDetail(<c:out value="${menuList.menuId[inx.index]}"/>);";                    
		               	var treeIcon = "";
		               	var treeIconOpen = ""; 
		             
		               	<c:if test="${ menuList.useFlag[inx.index] == 'N' }" >
		                	treeIcon = "${ctx}/images/dTree_images/trash.gif";
		                	treeIconOpen = "${ctx}/images/dTree_images/trash.gif";
		               	</c:if>
		               	<c:choose>
		                 	<c:when test="${inx.index > 0 }">
		               			treeMenu.add(<c:out value="${menuList.menuId[inx.index]}"/>, <c:out value="${menuList.prntMenuId[inx.index]}"/>, treeName, treeUrl, "", "", treeIcon, treeIconOpen);
		                 	</c:when>
		                 	<c:when test="${ inx.index == 0 }">
		               			treeMenu.add(<c:out value="${menuList.menuId[inx.index]}"/>,<c:out value="${menuList.prntMenuId[inx.index]}"/>, treeName);
		                 	</c:when>
		               	</c:choose>  
	           		</c:forEach>
	           		
	            	document.write(treeMenu);
	            	<c:if test="${query.menuId != null }">
	            		treeMenu.openTo('<c:out value="${data.menuId}"/>', "true");
	            	</c:if>
	          	</script>
	       	</div> 
	   </div>
	   <%-- Tree Content Area End --%>
	   <div style="width:600px;float:left">
		    <form id="formDetail" name="formDetail" method="post" action="">
			    <input type="hidden" name="menuId" id="menuId" value=""/>
			    <input type="hidden" name="prntMenuId" id="prntMenuId"/>
		    	<input type="hidden" name="maxMenuSeq" id="maxMenuSeq"/>
			    <input type="hidden" name="menuSeqOrg" id="menuSeqOrg"/>
			    <table class="LDetailArea" summary="message information table">
			      	<tr>
			        	<th>菜单编号</th>
			        	<td>
			          		<input type="text" name="menuCode" id="menuCode" class="Lbordercolor" readonly style="background-color:#EEFFB6"/>
			        	</td>
			        	<th>菜单级别</th>
			        	<td>
			          		<input type="text" name="menuLvl" id="menuLvl" class="Lbordercolor" size="2" readonly style="background-color:#EEFFB6"/>
			        	</td>
			      	</tr>
			      	<tr>
			        	<th><font color="red">*</font>菜单名称</th>
			        	<td colspan="3">
			          		<input type="text" name="menuName" id="menuName" class="Lbordercolor LinputAddress" maxlength="100" validate="{required:true,maxlength:100}" />
			        	</td>
			      	</tr>
			      	<tr>
			        	<th>菜单描述</th>
			        	<td colspan="3">
			          		<input type="text" name="menuDesc" id="menuDesc" class="Lbordercolor LinputAddress" maxlength="150" validate="{maxlength:150}"/>
			        	</td>
			      	</tr>
			      	<tr>
			        	<th>菜单URL</th>
			        	<td colspan="3">
			          		<input type="text" name="menuAppl" id="menuAppl" class="Lbordercolor LinputAddress" maxlength="100" validate="{maxlength:100}"/>
			        	</td>
			      	</tr>
			      	<tr>
			        	<th>菜单序列</th>
			        	<td>
			            	<input type="text" name="menuSeq" id="menuSeq" class="Lbordercolor" size="2"  maxlength="15" validate="{number:true,maxlength:15}"
								onkeyup="if((event.keyCode==8 || event.keyCode==9 || event.keyCode==37 || event.keyCode==39) || (event.keyCode>=48 && event.keyCode<=57)) return;value=value.replace(/[^\d]/g,'')"/>
			        	</td>
						<th>可用与否</th>
			        	<td>
			            	<input type="radio" name="useFlag" id="useFlag" value="Y" checked/>在用
			            	<input type="radio" name="useFlag" id="useFlag" value="N"/>禁用
			        	</td>
			      	</tr>
			    </table>
		    </form>
		    
		    
		    <fieldset>
		    	<legend>Button</legend>
		      	<ul class="LbtnArea">
			        <li>
			          	<input type="button" value="保存" id="btnSave" objType="bSave"/>
			          	<input type="button" value="删除" onclick="fncDel()" id="menuId" />
			          
			        </li>
		      	</ul>
		    </fieldset>
		</div>
	</div>
<div id="poppy"></div> 
</body>
</html>


