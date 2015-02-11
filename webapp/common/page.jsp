<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<c:set var="pageNumTemp" >	
	<fmt:formatNumber maxFractionDigits="0" value="${(page.totalCount%page.pageSize==0)?(page.totalCount-page.totalCount%page.pageSize)/page.pageSize:((page.totalCount-page.totalCount%page.pageSize)/page.pageSize+1)}"/>
</c:set>
<c:set var="pageAreaTemp" >
	<fmt:formatNumber maxFractionDigits="0" value="${page.pageNo-page.pageNo%page.pageSize}"/>
</c:set>
<fmt:parseNumber var="pageNum" type="number" value="${pageNumTemp}" />
<fmt:parseNumber var="pageArea" type="number" value="${pageAreaTemp}" />
<c:if test="${empty page.result}">
<table id="pageTb" border="0" cellspacing="0" cellpadding="0" align="left" style="display:none">
</c:if>
<c:if test="${!empty page.result}">
<table id="pageTb" border="0" cellspacing="0" cellpadding="0" align="left" >
</c:if>
  	<tr align="left">
		<td align="left" style="border:0;width=20%;text-align:center">
			<input type="hidden" id="selPageRow" name="selPageRow" value="${data.selPageRow}"/>		
			<input type="hidden" id="selPageOrderBy" name="selPageOrderBy" value="${data.selPageOrderBy}"/>
			<input type="hidden" id="selPageOrder" name="selPageOrder" value="${data.selPageOrder}"/>
			
			<label for="LskillSearch">分页条数:</label>						
	  		<select id="selShowpageNO" name="selShowpageNO" onChange="pagination(this);"> 
				<option value="10" <c:if test="${page.pageSize==10}">selected</c:if>>10</option>
				<option value="15" <c:if test="${page.pageSize==15}">selected</c:if>>15</option>
				<option value="20" <c:if test="${page.pageSize==20}">selected</c:if>>20</option>
				<option value="40" <c:if test="${page.pageSize==40}">selected</c:if>>40</option>
				<option value="50" <c:if test="${page.pageSize==50}">selected</c:if>>50</option>
				<option value="100" <c:if test="${page.pageSize==100}">selected</c:if>>100</option>
				<option value="200" <c:if test="${page.pageSize==200}">selected</c:if>>200</option>
				<option value="500" <c:if test="${page.pageSize==500}">selected</c:if>>500</option>
				<option value="1000" <c:if test="${page.pageSize==1000}">selected</c:if>>1000</option>
				<option value="100000000" <c:if test="${page.pageSize==100000000}">selected</c:if>>全部</option>
			</select>
  				<!-- 下拉选择页面 -->	
			<c:if test="${pageNum>0 }">
		      Total ${page.totalCount}(
		      	<select onchange="changePage(this)">
		      		<c:forEach var="inx" begin="1" end="${pageNum}" step="1">
		      			<option value="${inx}"<c:if test="${inx==page.pageNo}">selected</c:if> >${inx}</option>
		      		</c:forEach>
				</select>/${pageNum})
			</c:if>
			<!-- 页面选择图标，向后选择 -->
			  <c:if test="${page.pageNo==1}">
		     	<a href="#"><IMG border = 0 src='${ctx}/images/issm/btn/btn_pag_dfront.gif'></a>
		      	<a href="#"><IMG border = 0 src='${ctx}/images/issm/btn/btn_pag_dprev.gif'></a>
		      </c:if>
		      <c:if test="${page.pageNo!=1}">
		     	<a href="#" onclick="goPage('1'); return false;"><IMG border = 0 src='${ctx}/images/issm/btn/btn_pag_front.gif'></a>
		      	<a href="#" onclick="goPage('${page.pageNo-1}'); return false;"><IMG border = 0 src='${ctx}/images/issm/btn/btn_pag_prev.gif'></a>
		      </c:if>
		      <!-- 页面数字选择 -->
		      <c:forEach var="inx" begin="1" end="10" step="1">		      	
		      	<c:if test="${(inx+pageArea)==page.pageNo}">
		      		<font class="paging_current"> ${page.pageNo}</font> 
		      	</c:if>
		      	<c:if test="${(inx+pageArea)!=page.pageNo&&(inx+pageArea)<=pageNum}">
		      		<a href="#"  class="paging_num" onclick="goPage('${inx+pageArea}'); return false;">${inx+pageArea}</a>  
		      	</c:if>
		      </c:forEach>
		      <!-- 页面选择图标，向前选择 -->
		      <c:if test="${pageNum==page.pageNo}">
		     	<a href="#"><IMG border = 0 src='${ctx}/images/issm/btn/btn_pag_dnext.gif'></a>
		      	<a href="#"><IMG border = 0 src='${ctx}/images/issm/btn/btn_pag_dlast.gif'></a>
		      </c:if>
		      <c:if test="${pageNum!=page.pageNo}">
		     	<a href="#" onclick="goPage('${page.pageNo+1}'); return false;"><IMG border = 0 src='${ctx}/images/issm/btn/btn_pag_next.gif'></a>
		      	<a href="#" onclick="goPage('${pageNum}'); return false;"><IMG border = 0 src='${ctx}/images/issm/btn/btn_pag_last.gif'></a>
		      </c:if>	
		   <%
		      ssdevframework.core.collection.CData dataPageList = (ssdevframework.core.collection.CData)request.getAttribute("data");
		      for (java.util.Iterator iterator = dataPageList.keySet().iterator(); iterator.hasNext();) {
					String type = (String) iterator.next();
					if(type.startsWith("query")||type.endsWith("Check")){
					%>
					<input type="hidden" id="<%=type %>" name="<%=type %>" value="<%=dataPageList.get(type)%>"/>
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
				if(document.getElementById("formSearch")&&selShowpageNO ){
					document.getElementById("formSearch").appendChild(selShowpageNO);
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
					document.getElementById("formSearch").action = action;
					document.getElementById("formSearch").submit();
				}
	            $("#pageTb").css("width",$("#formSearch").width()-10);
				//document.getElementById("pageTb").style.width=document.getElementById("formSearch").clientWidth-10;
			</script>
