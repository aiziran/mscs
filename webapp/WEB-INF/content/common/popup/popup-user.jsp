<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<html>
<head>
<title>员工列表</title>
<base target="_self">
<%@ include file="/common/header.jsp"%>
<script type="text/javascript" language="javascript">
function getCheckedOnly(inputs) {
	var result = new Array();
	if (inputs && inputs.tagName == "INPUT" && inputs.checked) result[0] = inputs;
	else if (inputs && inputs.length && inputs.length > 0 ) {
		var until = inputs.length;
		for (var idx=0; idx<until; idx++) {
			if (inputs[idx].tagName == "INPUT" && inputs[idx].checked) result[result.length] = inputs[idx];
		}
	}
	return result;
}


function selectCheckBoxAndClose(id,name){
	window.returnValue =id+";"+ name;
	//alert(id+";"+ name);
	window.close(); 
	
}
function fncRevert() 
{ 
	var chked = getCheckedOnly(document.getElementsByName("checkbox"));
	var str="";
	if(chked.length > 1){
		//alert(chked.length);
		for(var i = 0 ; i < chked.length ; i++){
			var oTd = chked[i].parentNode.parentNode.getElementsByTagName("td");
			//alert($(oTd[1]).text());
			str +=chked[i].value+":"+$.trim($(oTd[1]).text())+";";
		}
		window.returnValue = str;
	}else if(chked.length = 1){
		var oTd = chked[0].parentNode.parentNode.getElementsByTagName("td");
		str +=chked[0].value+";"+$.trim($(oTd[1]).text());
		//alert(str);
		window.returnValue = str;
	}else
		window.returnValue = "";
	
	 window.close(); 
} 

//复选框全选
 function fncCheckAll(field){  
   var checkboxes = document.getElementsByName("checkbox");  
   for(var i=0;i<checkboxes.length;i++){  
       checkboxes[i].checked = field.checked;  
    }  
} 
 function CheckedSelf(obj){
	 
		saveCheckedValue();
	}
 function saveCheckedValue(){
		var id="";

		var all=document.getElementsByName('checkbox');
		
		var checkedid=document.getElementById('checkedid');
	
		for(var i=0;i<all.length;i++){
			if(all[i].checked){
				if(id.length==0){
					id=all[i].value;
					continue;
				}
				id=id+","+all[i].value;
			}
		}
		checkedid.value=id;
	}
	 
// 	function fncSelectAllId(){
// 		var id="";
// 		var name="";
// 		var value=document.getElementsByName("checkbox");  
// 		for(i=0;i<value.length;i++){
// 			if(value[i].checked){
// 				var oTd=value[i].parentNode.parentNode.getElementsByTagName("td");
// 				if(name){
// 					name=name+','+$(oTd[1]).text();
// 				}
// 				else{
// 					name=$(oTd[1]).text();
// 				}
// 				if(id){
// 				 id=id+','+value[i].value;
// 				}else{
// 					id=value[i].value;
// 				}
// 			}
// 		}
// 		if(id&&name){return id+':'+name;}
// 		else return null;
// 	}
// 	function fncRevert() 
// 	{ 
// 		var data=fncSelectAllId();
// 		window.returnValue =data;
// 		 window.close(); 
// 	} 
</script>
</head>
<body class="body_sub">	
	<div id ="groupSupply" style="position:absolute; background-color:#ffffff;width:500px;display:block">
		<br/>
		<div id="LsearchArea" >		
			
		</div>
		<!-- END sbox --> <!--AREA [View]-->
		<form id="formPage" method="post" action="${ctx}/common/popup/popup!cartype.action">	
		<input type="hidden" name="checkedid" id="checkedid" value="" />							
					<table class="LlistArea" >
						<tr>
							<th><input type="checkbox" name="selectAll" id="selectAll"  onclick="fncCheckAll(this);"/></th>
							<th>姓名</th>
						</tr>
						<c:forEach items="${page.result}" var="com_user_m" varStatus="inx">
							<c:set var="index" value="${inx.index}" />
							<tr onMouseOver="cfListOver(this)" onMouseOut="cfListOut(this)" 
								ondblclick="selectCheckBoxAndClose('<c:out value="${com_user_m.USER_ID}" />','<c:out value="${com_user_m.USER_NAME}" />');">
								
								<td>
									<input type="checkbox" id="checkbox" name="checkbox"  value="${com_user_m.USER_ID}"/>
									</td>
								
								<td>
									
									<c:out value="${com_user_m.USER_NAME}" />
								</td>
								
							</tr>
						</c:forEach>
						
						<tr>
							<td colspan="4" class="AreaLeft"><!-- LPAGE JavaScript Start --> 
								<%@ include file="/common/page.jsp" %>														
							</td>
						</tr>
					</table>
			</form>			
			<fieldset>
				<legend>Button</legend>
				<ul class="LbtnArea">
					<li>
						<input type="button" value="确定" onclick="fncRevert()" id="btnAdd"/>
					</li>
				</ul>
			</fieldset>
	</div>
	<!-- END content -->
</div>			
</body>

</html>
