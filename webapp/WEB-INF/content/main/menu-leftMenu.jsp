<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/header.jsp" %>
<script type="text/javascript" language="javascript" src="/archive/js/menu/slidemenu.js"></script>

<script type="text/javascript">

  	function fncSetDefault() {
  		<c:if test="${!empty map[2].MENUAPPL}">
    		parent.mainFrame.location.href = "<c:url value="/management/welcome/welcome.action?selectMenuId=230"/>";
  		</c:if>
  		<c:if test="${empty map[2].MENUAPPL}">
    		parent.mainFrame.location.href = "<c:url value="/management/welcome/welcome.action?selectMenuId=230"/>";
  		</c:if>
  	}
  
  	function fncGoMenu(url) {
    	parent.mainFrame.location.href = url;
  	}
     
  	// Show Menu
  	  function fncShowMenu() {
    	var jsvPrevLeftMenuSize;
    
    	jsvPrevLeftMenuSize = $F('leftMenuSize');
    
    	window.parent.bodyFrame.cols = jsvPrevLeftMenuSize + ",*";
    
    	$('menuCtrlShow').style.visibility = "hidden";
    	$('menuCtrlHide').style.visibility = "visible";
  	}
  
  	// Hide Menu
  	function fncHideMenu() {
    	var jsvLeftMenuSize = new Array(2);
    
    	jsvLeftMenuSize = (window.parent.bodyFrame.cols).split(",");   
    
    	$('menuCtrlShow').style.visibility = "visible";
    	$('menuCtrlHide').style.visibility = "hidden";
    
    	$('leftMenuSize').value = jsvLeftMenuSize[0];
    
    	window.parent.bodyFrame.cols = "18,*";
  	}
 
  	  
</script>

</head>

<body onLoad="fncSetDefault();" style="background-color:#1765A9;">

<div id="LmiddleLayer"  >
<div id="Lsidebar" style="margin-left: 5px;">
  	<div id="LsubMenu" style="margin-bottom:10px;_margin-bottom:10px; width: 200px; height: 90%;_height: 120%;">
  	
  		<c:forEach items="${map}" var="menu" varStatus="index"> 
      		<c:choose>
      			<c:when test="${menu.MENULVL == '1' }" >
    				<h1>${menu.MENUNAME}</h1>
    				<ul id="LsubMenu-item"/>
      			</c:when>
      			<c:when test="${menu.MENULVL == '2' and menu.nextLV == '3'}" >
      					<li class="Ldepth1">
							<span class="Lclosed" onclick="slideMenu.change(<c:out value="${menu.menuSeq - 1}"/>)">
								<a href="#">${menu.MENUNAME}</a>
							</span>
        					<ul class="Ldepth2">
      			</c:when>
      			<c:when test="${menu.MENULVL == '2' and menu.nextLV != '3'}" >
      					<li class="Ldepth1">
							<span>
								<a href="<c:url value="${menu.MENUAPPL}"><c:param name="selectMenuId" value="${menu.MENUID}"/></c:url>" target="mainFrame">
										${menu.MENUNAME}
								</a>
							</span>
						</li>
      			</c:when>
      			<c:when test="${menu.MENULVL == '3' and menu.nextLV != '4'}" >
          						<li>
									<a href="<c:url value="${menu.MENUAPPL}">
										<c:param name="selectMenuId" value="${menu.MENUID}"/></c:url>" target="mainFrame">
											${menu.MENUNAME}
									</a>
								</li>
        				<c:if test="${menu.nextLV != '3'}">
       						</ul>
      					</li>
        				</c:if>
      			</c:when>

				<c:when test="${menu.MENULVL == '3' and menu.nextLV == '4'}" >
          						<li>
									<a href="<c:url value="${menu.MENUAPPL}">
										<c:param name="selectMenuId" value="${menu.MENUID}"/></c:url>" target="mainFrame">
											${menu.MENUNAME}
									</a>
								
        				
      			</c:when>
					<c:when test="${menu.MENULVL == '4' }" >
          						<ul>
									<a href="<c:url value="${menu.MENUAPPL}"><c:param name="selectMenuId" value="${menu.MENUID}"/></c:url>" target="mainFrame">
											${menu.MENUNAME}
									</a>
								</ul>
        				<c:if test="${menu.nextLV != '4'}">
							</li>       						
							</ul>
      					</li>
        				</c:if>
      			</c:when>
    		</c:choose>
  		</c:forEach>
    	</ul>
    <div id="LsubMenu-bot"><div></div></div> 
  </div>
</div>
</div>
<input type="hidden" name="leftMenuSize">
<script type="text/javascript" language="javascript">
 var slideMenu = new ssdev.LslideMenu("LsubMenu-item", 200, 1, true);

	  slideMenu.beforeOpen = function(LI, index) {
		  
	    LI[index].firstChild.className = "Lopen";
	  }
	  slideMenu.afterClose = function(LI, index) {
	    LI[index].firstChild.className = "Lclosed";
	  }

  slideMenu.setOpenMenu(0);
  
</script>  
<div>
</div>
</body>
</html>


