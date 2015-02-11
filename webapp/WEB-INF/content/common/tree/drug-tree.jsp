<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<%--
/**
 * ------------------------------------------------------------------------
 * @source  : drup-tree.jsp
 * @desc    : 药品树型弹出页(多选)
 * ------------------------------------------------------------------------
 * VER  DATE         AUTHOR             DESCRIPTION
 * ---  -----------  -----------------  -----------------------------------
 * 1.0  2011.05.05   shijinglong         初次建立
 * ------------------------------------------------------------------------ 
 */
--%>

<html>
<head>
<%@ include file="/common/header.jsp" %>
<link href="${ctx}/css/dtree.css" rel="stylesheet" type="text/css" />
<script src="${ctx}/js/dtree3.js"></script>
</head>
<body class="body_sub" onLoad="fcOnLoadInfo()" >
<form id="ifrForm" name="ifrForm">
    <input type="hidden" name="selectValue" value="<c:out value="${data.selectValue}"/>"/>
</form>
  <table border="0" cellspacing="1" cellpadding="0" class="search_select_outline">
	<tr>
      <td class="search_select_bg">
		<table border="0" cellspacing="0" cellpadding="0" class="search_select_contents">
          <tr>
            <td>
			  <div id="system_tree" >
			  <table border="0" cellspacing="0" cellpadding="0">
				<tr>
				  <td class="search_select_tree">
					<div id="treemenu" style="width:448;height:200;overflow-x:auto;overflow-y:auto;display:">
							<SCRIPT type=text/javascript>
							a = new dTree('a',jsBaseContent);
							a.config.useCookies=false;
							 <c:forEach items="${drugTypeTree}" var="drugType" varStatus="inx">				
							     <c:choose>
                 				 	<c:when test="${inx.index ==0 }">				
							    		a.add('<c:out value="${drugType.drugTypeCode}"/>',-1,'<c:out value="${drugType.drugTypeName}"/>',"javascript: void('S');");
							     	</c:when>
                 					<c:when test="${ inx.index > 0 }">
							    		a.add('<c:out value="${drugType.drugTypeCode}"/>','<c:out value="${drugType.pntTypeCode}"/>','<c:out value="${drugType.drugTypeName}"/>',"javascript: void('S');",'<c:out value="${drugType.drugTypeCode}"/>');
							   		</c:when>
               					</c:choose>
						    </c:forEach>
	
							document.write(a);	
							
							function fcOnLoadInfo(){
								var sed = document.ifrForm.selectValue.value;
								
								if( sed!=''){
									a.setCheckedNodesSelected(sed);
									
								}
							}
							function show(){
								var obj = '<c:out value="${data.objId}"/>';
								var res = new Array();   
								var reqName = new Array(); 
								res = a.getCheckedNodesByEndNode();
								reqName = a.getCheckedNodesByEndNodeName();
								parent.showData(obj,res,reqName);
							}
							
							function cancel(){
									parent.fncHiddenFrame();
							}
							function fnc_clear(){
								var obj = '<c:out value="${data.objId}"/>';
								var res ="";   
								var reqName =""; 
								parent.showData(obj,res,reqName);
							}
							</SCRIPT>
					</div>
				  </td>
				</tr>
			  </table>
			  </div>			  
			</td>
		  </tr>
		  <tr>
            <td style="width:100%; height:21px;  text-align:center">
			<img src="${ctx}/images/issm/btn/btn_sub_ok.gif" class="btn_img" onClick="show();">
			<img src="${ctx}/images/issm/btn/btn_sub_cancel.gif" class="btn_img" onClick="cancel();">
			<img src="${ctx}/images/issm/btn/btn_sub_clear.gif" class="btn_img" onClick="fnc_clear();">
			</td>
          </tr>
	    </table>
	  </td>
    </tr>
  </table>
</body>
</html>
