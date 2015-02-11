<%@ page language="java" pageEncoding="UTF-8" %>
<c:set var="pageNumTemp2" >	
	<fmt:formatNumber maxFractionDigits="0" value="${(page2.totalCount%page2.pageSize==0)?(page2.totalCount-page2.totalCount%page2.pageSize)/page2.pageSize:((page2.totalCount-page2.totalCount%page2.pageSize)/page2.pageSize+1)}"/>
</c:set>
<c:set var="pageAreaTemp2" >
	<fmt:formatNumber maxFractionDigits="0" value="${page2.pageNo-page2.pageNo%page2.pageSize}"/>
</c:set>
<fmt:parseNumber var="pageNum2" type="number" value="${pageNumTemp2}" />
<fmt:parseNumber var="pageArea2" type="number" value="${pageAreaTemp2}" />
<c:if test="${empty page2.result}">
<table id="pageTb2" border="0" cellspacing="0" cellpadding="0" align="left" style="display:none">
</c:if>
<c:if test="${!empty page2.result}">
<table id="pageTb2" border="0" cellspacing="0" cellpadding="0" align="left" >
</c:if>
  	<tr align="left">
		<td align="left" style="border:0;width=20%;text-align:center">
			<input type="hidden" id="selPageRow" name="selPageRow" value="${data.selPageRow}"/>		
			<input type="hidden" id="selPageOrderBy" name="selPageOrderBy" value="${data.selPageOrderBy}"/>
			<input type="hidden" id="selPageOrder" name="selPageOrder" value="${data.selPageOrder}"/>
			
			<label for="LskillSearch">分页条数:</label>						
	  		<select id="selShowpageNO" name="selShowpageNO" onChange="pagination(this);"> 
				<option value="10" <c:if test="${page2.pageSize==10}">selected</c:if>>10</option>
				<option value="15" <c:if test="${page2.pageSize==15}">selected</c:if>>15</option>
				<option value="20" <c:if test="${page2.pageSize==20}">selected</c:if>>20</option>
				<option value="40" <c:if test="${page2.pageSize==40}">selected</c:if>>40</option>
				<option value="50" <c:if test="${page2.pageSize==50}">selected</c:if>>50</option>
				<option value="100" <c:if test="${page2.pageSize==100}">selected</c:if>>100</option>
				<option value="200" <c:if test="${page2.pageSize==200}">selected</c:if>>200</option>
				<option value="500" <c:if test="${page2.pageSize==500}">selected</c:if>>500</option>
				<option value="1000" <c:if test="${page2.pageSize==1000}">selected</c:if>>1000</option>
				<option value="100000000" <c:if test="${page2.pageSize==100000000}">selected</c:if>>全部</option>
			</select>
  				<!-- 下拉选择页面 -->	
			<c:if test="${pageNum2>0 }">
		      Total ${page2.totalCount}(
		      	<select onchange="changePage(this)">
		      		<c:forEach var="inx" begin="1" end="${pageNum2}" step="1">
		      			<option value="${inx}"<c:if test="${inx==page2.pageNo}">selected</c:if> >${inx}</option>
		      		</c:forEach>
				</select>/${pageNum2})
			</c:if>
			<!-- 页面选择图标，向后选择 -->
			  <c:if test="${page2.pageNo==1}">
		     	<a href="#"><IMG border = 0 src='${ctx}/images/btn_pag_dfront.jpg'></a>
		      	<a href="#"><IMG border = 0 src='${ctx}/images/btn_pag_dprev.jpg'></a>
		      </c:if>
		      <c:if test="${page2.pageNo!=1}">
		     	<a href="#" onclick="goPage('1'); return false;"><IMG border = 0 src='${ctx}/images/btn_pag_dfront.jpg'></a>
		      	<a href="#" onclick="goPage('${page2.pageNo-1}'); return false;"><IMG border = 0 src='${ctx}/images/btn_pag_dprev.jpg'></a>
		      </c:if>
		      <!-- 页面数字选择 -->
		      <c:forEach var="inx" begin="1" end="10" step="1">		      	
		      	<c:if test="${(inx+pageArea2)==page2.pageNo}">
		      		<font class="paging_current"> ${page2.pageNo}</font> 
		      	</c:if>
		      	<c:if test="${(inx+pageArea2)!=page2.pageNo&&(inx+pageArea2)<=pageNum2}">
		      		<a href="#"  class="paging_num" onclick="goPage('${inx+pageArea2}'); return false;">${inx+pageArea2}</a>  
		      	</c:if>
		      </c:forEach>
		      <!-- 页面选择图标，向前选择 -->
		      <c:if test="${pageNum2==page2.pageNo}">
		     	<a href="#"><IMG border = 0 src='${ctx}/images/btn_pag_next.jpg'></a>
		      	<a href="#"><IMG border = 0 src='${ctx}/images/btn_pag_dlast.jpg'></a>
		      </c:if>
		      <c:if test="${pageNum2!=page2.pageNo}">
		     	<a href="#" onclick="goPage('${page2.pageNo+1}'); return false;"><IMG border = 0 src='${ctx}/images/btn_pag_next.jpg'></a>
		      	<a href="#" onclick="goPage('${pageNum2}'); return false;"><IMG border = 0 src='${ctx}/images/btn_pag_dlast.jpg'></a>
		      </c:if>	
		   <%
		      ssdevframework.core.collection.CData dataPageList2 = (ssdevframework.core.collection.CData)request.getAttribute("data");
		      for (java.util.Iterator iterator = dataPageList2.keySet().iterator(); iterator.hasNext();) {
					String type2 = (String) iterator.next();
					if(type2.startsWith("query")||type2.endsWith("Check")){
					%>
					<input type="hidden" id="<%=type2 %>" name="<%=type2 %>" value="<%=dataPageList2.get(type2)%>"/>
					<%
					}
				} 
		      
		      %>
			 
		</td>
	</tr>
</table>
<script type="text/javascript" language="javascript">				
				var obj = document.getElementsByName("selShowpageNO");	
				var selPageRow = document.getElementById("selPageRow")
				var selShowpageNO;
				
				if(obj.length>0 ){
					selShowpageNO = obj[0].cloneNode(true);
					selShowpageNO.selectedIndex = obj[0].selectedIndex;
					selShowpageNO.style.display="none";
				}	
				function pagination(obj){
					selShowpageNO.selectedIndex = obj.selectedIndex;
					pagePost(obj.form.action);
				}
				
				function goPage(row){
					  var pageForm = document.getElementById("selPageRow").form;
					  selPageRow.value = row;
					  pageForm.submit();
				}
				
				function goOrderByPage(row,orderBy){
				  var pageForm = document.getElementById("selPageRow").form;
				  selPageRow.value = row;
				  pageForm.submit();
				}
				
				function changePage(pageSelect) {
				  var pageForm = pageSelect.form;
				  selPageRow.value = pageSelect.value;
				  pageForm.submit();
				}
				
				function pagePost(action) {
					$("#formPage2").action = action;
					$("#formPage2").submit();
				}
	            $("#pageTb2").css("width",$("#formPage2").width()-10);
				//document.getElementById("pageTb2").style.width=document.getElementById("formSearch").clientWidth-10;
			</script>
