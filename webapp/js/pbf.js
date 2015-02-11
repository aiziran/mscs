
document.attachEvent ("onreadystatechange", function() {
   if (document.readyState=="complete")   {
       try {
		var oInputType = document.getElementsByTagName("INPUT");
		for ( var k = 0; k < oInputType.length; k++) {
			if (oInputType[k].type.toUpperCase() == "TEXT"
					&& !oInputType[k].readOnly) {
				oInputType[k].focus();
				break;
			}
		}
		if (window.cbOnBeforeLoad)
			window.cbOnBeforeLoad();
	} catch (e) {
		
	}
   }
})
////////////////////////////////////////时间控件调用////////////////////////////////////////
	//调用日历,并返回日期值.yyyy-mm-dd
	function fcCallCalendar( Imgobj,objId ,fcName) {
    		var frmObj;
	    	if(Imgobj){
	    	    var obName= Imgobj.parentNode.getElementsByTagName("INPUT");
	    	    for(var i=0;i<obName.length;i++){
	    		if(obName[i].id==objId){
	    		    frmObj = obName[i];
	    		    break;
	    		}
	    	    }
	    	}
    
    
    
		var dt = frmObj.value;
		var obj = new Object();	
		if(dt == '') {
			now = new Date();
			obj.value = now.getYear() + '-' + (now.getMonth()+1)+ '-' + now.getDate();
		} else {
			obj.value = dt;
		}	
		Calendar(obj, frmObj, '-',fcName);
	} 
	
	
	//调用日历,并返回日期值.yyyymm
	function fcCalendarMonth( Imgobj,objId ,fcName) {
    		var frmObj;
	    	if(Imgobj){
	    	    var obName= Imgobj.parentNode.getElementsByTagName("INPUT");
	    	    for(var i=0;i<obName.length;i++){
	    		if(obName[i].id==objId){
	    		    frmObj = obName[i];
	    		    break;
	    		}
	    	    }
	    	}
    
    
    
		var dt = frmObj.value;
		var obj = new Object();	
		if(dt == '') {
			now = new Date();
			obj.value = now.getYear() + '-' + (now.getMonth()+1)+ '-' + now.getDate();
		} else {
			obj.value = dt;
			
		}	
		
		CalendarMonth(obj, frmObj, '',fcName);
	} 
	

//固定滚动条的头
function   fixupFirstRow(tab)   
  {   
      var	div   =	tab.parentNode; 
      var   tabId =	tab.id;
      var   oTab = tab;
      tab.style.position   =   "relative";   
      tab.rows[0].style.zIndex   =   "90";   
      tab.rows[0].style.position   =   "relative";   
      div.onscroll   =   function()   
      {  	
    	  if(!tab.rows[0]){
    		  for(var i =0;i<div.childNodes.length;i++){
    			  if(div.childNodes[i].id==tabId){
    				  oTab = div.childNodes[i]; 
    				  oTab.rows[0].style.zIndex   =   "90";   
    				  oTab.rows[0].style.position   =   "relative"; 
    				  break;
    			  }
    		  }   		  
    	  }
    	  
          var   tr   =   oTab.rows[0];   
          tr.style.top   =   this.scrollTop-(this.scrollTop==0?1:2);   
          tr.style.left   =   -1;   
      }   
  }   

//验证字符长度
function fncThreeChar(str){
		var strLength = str.replace(/[\u4e00-\u9fa5，。？：；‘’！“”—…、【】（）《》]/g, "aaa").length;
		return strLength;
} 
/* 엘리먼트를 리턴 */
function $(element_id) {
	var obj;
	if(isMSIE) {
		var obj = document.getElementById(element_id);
		if(obj == null) {
			obj = document.all[element_id];	// w3c 비표준
		}
	} else {
		obj = document.getElementById(element_id);
		if(obj == null) {
			obj = document.getElementsByName(element_id)[0];
		}
	}
	return obj;
}

/* 엘리먼트(또는 엘리먼트들)을 리턴 */
function $N(element_name) {
	return document.getElementsByName(element_name);
}

/* 엘리먼트의 값을 리턴 */
function $F(element_id) {
  return $(element_id).value;
}

function cfSetValue(element_id, value) {
  var obj = $(element_id);
  obj.value = value;
}

/**
 * @type   : function
 * @access : public
 * @desc   : 
 * @author : tkyushin
 */

function actSubmitValidate(oform, action, target) {
  if (target) oform.target = target;
  if (action) oform.action = action;
  if (!oform.method) oform.method = "post";
  if (oform.fireSubmit) oform.fireSubmit();
  else oform.submit();  
}

function actCancel(oform, action, target) {
  if (target) oform.target = target;
  if (action) oform.action = action;
  if (!oform.method) oform.method = "post";
	oform.reset();
  oform.submit();
}

function actSubmit(oform, action, target) {
  if (target) oform.target = target;
  if (action) oform.action = action;
  if (!oform.method) oform.method = "post";
  oform.submit();
}

function findParentTag(oTag, tagName) {
  while (oTag && oTag.tagName != "BODY") {
    if (oTag.tagName == tagName) return oTag;
    oTag = oTag.parentNode;
  }
  return null;
}

function findTagByName(oTag, tagName, name) {
	var tags = oTag.getElementsByTagName(tagName);
	for (var idx=0; idx<tags.length; idx++) {
		if (tags[idx].name == name) return tags[idx];
	}
  return null;
}

function flipCheckBox(oCheck) {
	if (!oCheck) return;
	if (oCheck.tagName && oCheck.tagName=="INPUT" && oCheck.type=="checkbox") {
		oCheck.checked = oCheck.checked ? false : true;	
	} else if (oCheck.length && oCheck.length > 1) {
		var until = oCheck.length;
		for (var idx=0; idx < until; idx++) {
			oCheck[idx].checked = oCheck[idx].checked ? false : true;	
		}		
	}
}

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

function cloneRow(sourceRowId, targetTableId) {
	var oTR = document.getElementById(sourceRowId);
	var tTable = document.getElementById(targetTableId);
	var tTbody = tTable.tBodies[0];
	var oNewTR = oTR.cloneNode(true);
	oNewTR.id = "";
	tTbody.appendChild(oNewTR);
	return oNewTR;
}

function getLength(inputs) {
	return (!inputs || !inputs.length) ?  0 : inputs.length;
}

function clearInput(oInput) {
	if (oInput.tagName == "FORM") {
		var until = oInput.elements.length;
		for (var idx=0; idx < until; idx++) {
			clearInput(oInput.elements[idx]);
		}
	} else if (oInput.tagName == "INPUT" ||  oInput.tagName == "SELECT" || oInput.tagName == "TEXTAREA") {
		  switch (oInput.type) {
		    case "text" :  case "hidden" : case "password" : case "textarea" : 
  			case "select-one" : case "select-multiple" :		    
		      oInput.value = "";
		    break;
		    case "radio" :  case "checkbox" :
		      oInput.checked = false;
		    break;
		  }
	} 
}

function removeOptions(oSelect) {
	if (oSelect.tagName != "SELECT") return;
		var until = oSelect.options.length;
  	for (var idx=0; idx < until ; idx++) oSelect.remove(0);	
	
}

// 메신저 공지사항 호출  
function cfMsngerCall(receiversEmpNo, content) {
  var oUrl = "/pbf.comm.messenger.sendMessege.laf?"
          + "Content=" + content
          + "&ReceiversEmpNo=" + receiversEmpNo;
  cfCreateAlert(oUrl);
}

function cfCreateAlert(oUrl) {
  var poppy = document.all("poppy");
  if (poppy == null) {
    document.body.insertAdjacentHTML("beforeEnd", "<IFRAME id='poppy' style='position:absolute; left:0px; top:0px; width:0; height:0' frameborder='0' src='"+oUrl+"' scrolling='no'></IFRAME>");
  } else {
    poppy.style.left=0;
    poppy.style.top=0;
    poppy.style.width=0;
    poppy.style.height=0;
    poppy.src=oUrl;
    poppy.style.visibility="hidden";
  }
}

function cfOpenModalPopup(url, condi, width, height, winName){
    condi   = condi  ==null? "":condi;
    width   = width  ==null? "770":width;
    height  = height ==null? "550":height;

    var popupGubun = 'Y';

    url += "?" + condi;
    var arrRtn = window.showModalDialog(url,'',"center:yes; dialogWidth:"+width+"px; dialogHeight:"+height+"px; status:yes; help:no; scroll:yes");
}
  
// move to main frame
// url = "/jsp/sample/gauce/p41.jsp"
function cfChangeMain(url, condi) {
    url += "?" + condi;
    document.location = url;
}  

// add quick menu
function cfAddQuickMenuCd(menuCd) {
	var paramArray = [cfConvertLang("즐겨찾기")];
	if(!cfConfirmMsg(MSG_COM_CRM_010, paramArray)) return;
	
	stringXsyncResult = '';
	var aJax = new lafj.xSync("/pbf.comm.quickMenu.cmd.cudQuickMenu2.laf");
	aJax.addQuery("event", "INSERT");
	aJax.addQuery("menuCd", menuCd);
	aJax.async=false;
	aJax.fire();
	
	return stringXsyncResult;
}

function cfChangeQuickMenu() {
	var url = '/jsp/pbf/comm/quickmenu/quickMenu.jsp';
	cfChangeMain(url, '');
}

// mvoe quick help page
function cfChangeQuickHelp(atchFileBunchNo) {
  var w = 1000;
  var h = 600;
  var left = (screen.width - w)/2
  var top = (screen.height - h)/2
  helpWindow = window.open("/jsp/pbf/comm/file/helpDownload.jsp?atchFileBunchNo=" + atchFileBunchNo, "helpTarget", "height="+h+",width="+w+",left="+left+",top="+top+",status=no,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
}

function comboMap() {
  this.names = new Array();
  this.values = new Array();
  this.indexes = new Array();
  this.count = 0;
  // methods
  this.getValue          = comboMap_getValue;
  this.getIndex          = comboMap_getIndex;
  this.put               = comboMap_put;
}

function comboMap_getValue(name) {
  for (var i = 0; i < this.count; i++) {
    if (this.names[i] == name) {
      return this.values[i];
    }
  }
  return null;
}

function comboMap_getIndex(name) {
  for (var i = 0; i < this.count; i++) {
    if (this.names[i] == name) {
      return this.indexes[i];
    }
  }
  return null;
}

function comboMap_put(name, value, index) {
  for (var i = 0; i < this.count; i++) {
    if (this.names[i] == name) {
      this.values[i] = value;
      this.indexes[i] = index;
      return;
    }
  }
  this.names[this.count] = name;
  this.values[this.count++] = value;
  this.indexes[this.count++] = index;
}

function cfOpenSsnPopup(empNm, ssn, obj) {
	var condition = "?empNm=" + empNm;
	condition += "&edSsn=" + ssn;
	cfCreatePopup("/jsp/pbf/comm/srch/ssnCheckPopup.jsp" + condition, 350, 195, obj);
}

function cfGetFrameDoc(frm){
	if(cfGetFrame(frm)) {
		return cfGetFrame(frm).document;	
	} else {
		return null;
	}
}

function cfGetFrame(frm){
    var aFrame;
    if(frm == 'tabFrame') {
		if(parent.tabFrame) {
			aFrame = parent.tabFrame;
		} else if(top.tabFrame) {
			aFrame = top.tabFrame;
		}
    } else if(frm == 'topFrame') {
		if(parent.topFrame) {
			aFrame = parent.topFrame;
		} else if(top.topFrame) {
			aFrame = top.topFrame;
		}
    } else if(frm == 'leftFrame') {
		if(parent.leftFrame) {
			aFrame = parent.leftFrame;
		} else if(top.leftFrame) {
			aFrame = top.leftFrame;
		}
    }
    if(aFrame) return aFrame;
    return null;
}

function cfLeftMenuShow(imagePath, frameseq, flag){
    var obj = parent.document.all.tags('FRAMESET');
    if(!obj) return;
    oObj=parent.document.all.tags('FRAMESET')[frameseq];
    
    var aDoc = cfGetFrameDoc('topFrame');
    var atDoc = cfGetFrameDoc('tabFrame');
    var alDoc = cfGetFrameDoc('leftFrame');
    if(atDoc == null || atDoc.all.bFixMenu.value == 'false') return;
	if(!oObj) return;
    if(flag == true){
      oObj.cols = "200,*";
      alDoc.all('tree_leftMenu').width = '99%';
      atDoc.all.img_leftMenuShow.src= imagePath + "/menu_off.gif";
      atDoc.all.img_leftMenuShow.alt="메뉴닫기"
    } else {
      //alert("넓게 보는 화면입니다.");
      oObj.cols = "0,*";
      alDoc.all('tree_leftMenu').width = '1%';
      atDoc.all.img_leftMenuShow.src= imagePath + "/menu_on.gif";
      atDoc.all.img_leftMenuShow.alt="메뉴열기"
    }
}

function cfLeftMenuShow2(imagePath, frameseq){
    var obj = parent.document.all.tags('FRAMESET');
    if(!obj) return;
    oObj=parent.document.all.tags('FRAMESET')[frameseq];
    
    var aDoc = cfGetFrameDoc('topFrame');
    var atDoc = cfGetFrameDoc('tabFrame');
    var alDoc = cfGetFrameDoc('leftFrame');
    if(atDoc == null || atDoc.all.bFixMenu.value == 'false') return;
    if(oObj.cols != "200,*"){
      oObj.cols = "200,*";
      alDoc.all('tree_leftMenu').width = '99%';
      atDoc.all.img_leftMenuShow.src= imagePath + "/menu_on.gif";
      atDoc.all.img_leftMenuShow.alt="메뉴닫기"
    } else {
      //alert("넓게 보는 화면입니다.");
      oObj.cols = "0,*";
      alDoc.all('tree_leftMenu').width = '1%';
      atDoc.all.img_leftMenuShow.src= imagePath + "/menu_off.gif";
      atDoc.all.img_leftMenuShow.alt="메뉴열기"
    }
}

function cfTopFrameShow(){
	var atDoc = cfGetFrameDoc('tabFrame');
	var obj = top.TOP_FRAMESET;
	var epFrame = top.menubodyFrame;
	
	if(epFrame) {
		var obj2 = parent.TOP_FRAMESET;
		if(obj.rows == '28,*') {
			obj.rows = '0,*';
			obj2.rows = '0,*';
			atDoc.all.btn_up.style.display='none';
			atDoc.all.btn_dn.style.display='';
		} else if(obj.rows == '0,*') {
			obj.rows = '28,*';
			obj2.rows = '28,*,0';
			atDoc.all.btn_up.style.display='';
			atDoc.all.btn_dn.style.display='none';
		}
	} else {
		var obj2 = parent.TOP_FRAMESET;
		if(obj.rows == '54,*,0') {
			obj.rows = '0,*';
			atDoc.all.btn_up.style.display='none';
			atDoc.all.btn_dn.style.display='';
		} else {
			obj.rows = '54,*,0';
			atDoc.all.btn_up.style.display='';
			atDoc.all.btn_dn.style.display='none';
		}
	}
}

// UTF-8에서 한글 처리
function cfHangle(val){
	return encodeURIComponent(val);
}

//-------------------------------------------------------------------------
// 쿠키 처리
//-------------------------------------------------------------------------	
    function cfGetcookValue (offset) {
		var finstr = document.cookie.indexOf (";", offset);
		if (finstr == -1)
			finstr = document.cookie.length;
		return decodeURIComponent(document.cookie.substring(offset, finstr));
    }

    function cfGetCookie (name) {
		var arg = name + "=";
		var alen = arg.length;
		var clen = document.cookie.length;
		var i = 0;
		while (i < clen) {
			var j = i + alen;
			if (document.cookie.substring(i, j) == arg)
				return cfGetcookValue (j);
			i = document.cookie.indexOf(" ", i) + 1;
			if (i == 0) break; 
		}
		return null;
    }

    function cfSetCookie (name, value) {
		var argv = cfSetCookie.arguments;
		var argc = cfSetCookie.arguments.length;
//		var expires = (argc > 2) ? argv[2] : null;
		var path = (argc > 3) ? argv[3] : null;
		var domain = (argc > 4) ? argv[4] : null;
		var secure = (argc > 5) ? argv[5] : false;
		var now = new Date();
		var expires = new Date(now.getTime() + 31536000000);//쿠키 유지기간을 365 일로 합니다.
		document.cookie = name + "=" + encodeURIComponent (value) +
		((expires == null) ? "" : ("; expires=" + expires.toGMTString())) +
 		((path == null) ? "" : ("; path=" + path)) +
		((domain == null) ? "" : ("; domain=" + domain)) +
		((secure == true) ? "; secure" : "");
    }  	
    
    function cfDeleteCookie(name) {
		var exp = new Date();
		var cval = cfGetCookie (name);
		if (cval != null) {
			document.cookie = name + "=";
		}
    }
    
    function cfDeleteMenuCookie() {
		for (var i = 1 ; i <= 5 ; i++) {
			cfDeleteCookie(i);
		}
    }    
    
	function cfGetLeftDoc() {
		var $aDoc;
		var $aFrame;
		if(parent.leftFrame) {
	  		$aFrame = parent.leftFrame;
	  	} else if(top.leftFrame) {
	  		$aFrame = top.leftFrame;
		}
		if($aFrame) {
			$aDoc = $aFrame.document;
	  	}
		return $aDoc;
	}

	function cfGetCommonTabFrame(ep) {
		if(ep == 'ep' || $port == '80') {
			return parent ;
		} else {
			return parent.parent ;
		}
	} 
	  
	function cfGetMainDoc(ep) {
	    var targetFrameNum = cfGetCommonTabFrame(ep).tabFrame.ACTIVATED_FRAME_INDEX;
	    var aFrm = parent.frames["bodyFrame"+targetFrameNum];
		return aFrm.document;
	}

   	function cfGetMenuUrl(value) {
		var menu_nm = cfFindMenu(value);
		if(menu_nm.length < 2) return;
		menu_nm = menu_nm.substring(1, menu_nm.length);
		
		stringXsyncResult = '';
		var aJax = new lafj.xSync("/pbf.comm.menu.getMenuUrl.laf");
		aJax.addQuery("menuNm", menu_nm);
		aJax.addQuery("ajax", "true");
		aJax.async=false;
		aJax.fire();
		
		return stringXsyncResult;
	}
  
	function cfMoveToMenu(ep, value) {
	  	var $aDoc = cfGetMainDoc(ep);
	  	cfGetMenuUrl(value);
	
	  	lafj.xSync.handler.string = function(json) {
		  stringXsyncResult = json.$text;
		}
	  	$aDoc.body.insertAdjacentHTML("beforeEnd", "<form name=aForm method=post></form>");
	  	aForm.action = stringXsyncResult;
	  	aForm.submit();
	}
  
	// 월 차수 확인
	function cfGetMonthDegree(year, month, init) {
	    stringXsyncResult = '';
	    var aJax = new lafj.xSync("/pbf.comm.util.GetMonthDegree.laf");
	    aJax.addQuery("init", init);
	    aJax.addQuery("year", year);
	    aJax.addQuery("month", month);
	    aJax.fire();
	    return stringXsyncResult;
	}  
	
	// 월 차수 변경
	function cfChangeMonthDegree(obj, year, month, init) {
	  var arry = obj.CBData.split(",");
	  for(var i=0;i<arry.length;i++){
	    obj.DeleteData(i); 
	  }
	  var cBData = cfGetMonthDegree(year, month, init);
	  obj.CBData = cBData;
	  var arry = cBData.split(",");
	  for(var i=1;i<=arry.length;i++){
	    obj.AddData(i);
	  }
	  return cBData;	
	}
	
	// 월 차수의 일자 기간 조회
	function cfGetDaysDegree(year, month, degree, init) {
	    stringXsyncResult = '';
	    var aJax = new lafj.xSync("/pbf.comm.util.GetDaysDegree.laf");
	    aJax.addQuery("init", init);
	    aJax.addQuery("year", year);
	    aJax.addQuery("month", month);
	    aJax.addQuery("degree", degree);
	    aJax.fire();
	    return stringXsyncResult;
	}    
	
  // div 콤보 팝업 처리
  var gvActiveButton = null;

  function cfResetCombo(objMnuButton) {
    // 펼쳐진 풀다운 메뉴를 감춰줌
    if (objMnuButton.menu) {
      objMnuButton.menu.style.visibility  = "hidden";
      objMnuButton.menu.style.display   = "none";
    }

    // 현재 활성화된 메뉴 버튼이 없는 것으로 설정
    gvActiveButton = null;
  }

  function cfClickCombo(objMnuButton, strMenuName) {
    // 이 메뉴 버튼에 하위 풀다운 메뉴 객체를 관장할 menu 란 이름의 객체 생성
    if (!objMnuButton.menu) objMnuButton.menu = document.getElementById(strMenuName);

    // 현재 활성화된 메뉴 버튼을 처음 상태로 되돌림.
    if (gvActiveButton && gvActiveButton != objMnuButton) cfResetCombo(gvActiveButton);

    // 메뉴 버튼 활성화 여부에 따라 활성화/비활성화 토글.
    if(gvActiveButton) {
    	cfResetCombo(objMnuButton);
		document.all("frm_" + strMenuName).contentWindow.f_CallBack(strMenuName);
    } else {
	    cfPullDownCombo(objMnuButton);
    }

    return false;
  }
  
  function cfCloseCombo(strMenuName) {
	var objMnuButton = parent.document.getElementById(strMenuName);
	objMnuButton.style.visibility  = "hidden";
	objMnuButton.style.display   = "none";
	gvActiveButton = null;
	f_CallBack(strMenuName);
  }
  
  function cfPullDownCombo(objMnuButton) {
    /***************************************************************************************
    // 익스플로러의 경우, 첫 번째 메뉴 아이템에 대한 명확한 폭을 명시해 주도록 한다.
    // 만일 이 부분을 설정하지 않으면 마우스로 메뉴 아이템 오버시 텍스트 위에 올려놓을 때만
    // 반전된다. 만일 텍스트가 아닌 메뉴 아이템 영역 위로만 갖다 놔도 반전시키려면
    // 이 부분을 설정해 줘야 한다.
    if (objDetectBrowser.isIE && !objMnuButton.menu.firstChild.style.width) {
      objMnuButton.menu.firstChild.style.width = objMnuButton.menu.firstChild.offsetWidth + "px";
    }

    // 브라우저마다 각자 환경에 맞는 드롭 다운 메뉴의 위치를
    // 결정해 줘야 한다.
    x = objMnuButton.offsetLeft;
    y = objMnuButton.offsetTop + objMnuButton.offsetHeight;

    if (objDetectBrowser.isIE) {
      x += -1;
      y += 1;
    }
    if (objDetectBrowser.isNS && objDetectBrowser.version < 6.1) y--;

    // 위치 결정 및 풀다운 메뉴를 보여줌
    objMnuButton.menu.style.left = x + "px";
    objMnuButton.menu.style.top  = y + "px";
    **************************************************************************/
    objMnuButton.menu.style.visibility  = "visible";
    objMnuButton.menu.style.display   = "block";

    // 현재 활성화된 메뉴 객체를 저장하는 전역변수 gvActiveButon에
    // 현재 선택된 메뉴 객체를 설정
    gvActiveButton = objMnuButton;
  }	
  
	function cf_oz_activex_build(parent, tag, paramTag){
		var OZViewerObjectElement = document.createElement(tag);
		for(var i = 0 ; i < paramTag.length; i++){
			var OZViewerParamElement = document.createElement(paramTag[i]);
			OZViewerObjectElement.appendChild(OZViewerParamElement);
			parent.appendChild(OZViewerObjectElement);	
		}
	}

/**
 * @type   : function
 * @access : public
 * @desc   : oz viewer 호출, option -> 0: 내부 호출, 1:팝업
 * @desc   : win parameter add  - shkim 2008.01.24 modalWindow에서 session Lost 처리(팝업을 다르게 호출함)
 * <pre>
 * ex) cfOzReportByDB(mrdFileNm, exParam, isOpenWindow, innerObj, width, height, option, win)
 * </pre>
 */
	function cfOzReportByDB(mrdFileNm, exParam, isOpenWindow, innerObj, width, height, option, win) {
	  // 파라메터 설정
	  var actionUrl = '/jsp/pbf/ozReport/dbReport.jsp';
	  //exParam += $rdAgentParam;
	  // 고정
	  width = 820;
	  height = 650;
	  cfOzReportView(actionUrl, mrdFileNm, exParam, null, isOpenWindow, innerObj, width, height, option, win);
	}

	function cfOzReportView(actionUrl, mrdFileNm, exParam, rdData, isOpenWindow, innerObj, width, height, option, win) {
		var target = "";
		var mainObj = null;
		
		if(typeof(innerObj) == "undefined" || innerObj == null){
		  mainObj = document;
		}else{
		  mainObj = innerObj;
		}
	
		if(typeof(isOpenWindow) == "undefined") isOpenWindow = true;                                                                                                                                        
	                                                                                                                                                                                                      
		if(isOpenWindow){
		if(typeof(width) == "undefined") width = screen.width/2 + 100;
		if(typeof(height) == "undefined") height = screen.height/2 + 100;
		
			var top = (screen.height-height)/2;
			var left = (screen.width-width)/2;
			target = "reportTargetWindow";
			
			if(win == null){
				window.open("/jsp/pbf/loadsignal/blank.jsp", target, "top="+top+", left="+left+", height="+height+",width="+width+",status=no,toolbar=no,menubar=no,location=no,scrollbars=no,resizable=no");
			}else{
				win.window.open("/jsp/pbf/loadsignal/blank.jsp", target, "top="+top+", left="+left+", height="+height+",width="+width+",status=no,toolbar=no,menubar=no,location=no,scrollbars=no,resizable=no");
			}
	  	}else{
		  	if(typeof(width) == "undefined") width="100%";
		  	if(typeof(height) == "undefined") height="460px";
		
		  	if(typeof(mainObj.id) != "undefined"){
		  		target = "reportTargetFrame_" + mainObj.id;
			}else{
				target = "reportTargetFrame";
			}
	
			if(typeof(mainObj.all.reportContents) == "undefined"){
				iFrame = null;
			if(typeof(innerObj) == "undefined" || innerObj == null){
				iFrame = document.createElement("<div id='reportContents' class='layout_page' style='padding: 0px 0px 100px 0px'>");
			  	mainObj.body.insertAdjacentElement("beforeEnd", iFrame);
			}else{
				iFrame = document.createElement("<div id='reportContents'>");
				innerObj.insertAdjacentElement("beforeEnd", iFrame);
			}
				var reportFrame = document.createElement("<iframe id='reportFrame' name='" + target + "' frameborder='0' border='0' scrolling='no' width=" + width + " height=" + height + "></iframe>");
				iFrame.insertAdjacentElement("beforeEnd", reportFrame);
			}else{
				// 있을 경우에는 사이즈만 재조절
				document.all.reportFrame.width = width;
				document.all.reportFrame.height = height;
			}
		}
		var parameterForm = mainObj.all("reportForm");
		if ( parameterForm != null ) {
			if( typeof(mainObj.body) != "undefined"){
				// 주석 처리
				//mainObj.body.removeChild(parameterForm);
			}
		}
		parameterForm = document.createElement("<FORM id=reportForm method=post action='" +  actionUrl + "' target='" + target + "'>");
		
		if( typeof(mainObj.body) != "undefined"){
			mainObj.body.insertAdjacentElement("beforeEnd", parameterForm);
		}else{
			mainObj.insertAdjacentElement("beforeEnd", parameterForm);
		}
		
		var paramObj = document.createElement("<INPUT>");
		paramObj.name = "mrdFileNm";
		paramObj.type = "hidden";
		paramObj.value = mrdFileNm;
		parameterForm.insertAdjacentElement("beforeEnd", paramObj);
		
		var paramObj1 = document.createElement("<INPUT>");
		paramObj1.name = "rdParam";
		paramObj1.type = "hidden";
		paramObj1.value = exParam;
		parameterForm.insertAdjacentElement("beforeEnd", paramObj1);
		
		var paramObj2 = document.createElement("<INPUT>");
		paramObj2.name = "isOpenWindow";
		paramObj2.type = "hidden";
		paramObj2.value = isOpenWindow;
		parameterForm.insertAdjacentElement("beforeEnd", paramObj2);
		
		if(rdData != null && typeof(rdData) != "undefined"){
			var paramObj3 = document.createElement("<INPUT>");
			paramObj3.name = "rdData";
			paramObj3.type = "hidden";
			paramObj3.value = rdData;
			parameterForm.insertAdjacentElement("beforeEnd", paramObj3);
		}
		
		if(option != null && typeof(option) != "undefined"){
			var paramObj4 = document.createElement("<INPUT>");
			paramObj4.name = "option";
			paramObj4.type = "hidden";
			paramObj4.value = option;
			parameterForm.insertAdjacentElement("beforeEnd", paramObj4);
		}
		parameterForm.submit();
	}  
	
/**
 * @type   : function
 * @access : public
 * @desc   : DB 조회를 통해 특정 값을 조회
 * @sig    : qId, urlQuery
 * @param  : qId required 키값을 조회하는 쿼리 아이디.
 * @param  : urlQuery required 문자열
 */
function cfRetrieveSingleDataFromDB(qId, urlQuery) {
    stringXsyncResult = '';
    var aJax = new lafj.xSync("/pbf.comm.xsync.retrieveSingleData.laf");
    aJax.addQuery("qId", qId);
    aJax.addStringQuery(urlQuery);
    aJax.async=false;
    aJax.fire();
    
    return stringXsyncResult;
}	

/**
 * @type   : function
 * @access : public
 * @desc   : 단어를 다국어로 변환
 * @param  : param 원하는 단어
 */
function cfConvertLang(param) {
    stringXsyncResult = '';
    var aJax = new lafj.xSync("/pbf.comm.xsync.ConvertLang.laf");
    aJax.addQuery("param", param);
    aJax.async=false;
    aJax.fire();
    
    return stringXsyncResult;
}	
	
/**
 * @type   : function
 * @access : public
 * @desc   : DB 조회된 단어를 다국어로 변환하여 리턴
 * @sig    : qId, urlQuery
 * @param  : qId required 키값을 조회하는 쿼리 아이디.
 * @param  : urlQuery required 문자열
 */
function cfRetrieveSingleDataWithLang(qId, urlQuery) {
    stringXsyncResult = '';
    var aJax = new lafj.xSync("/pbf.comm.xsync.RetrieveSingleDataWithLang.laf");
    aJax.addQuery("qId", qId);
    aJax.addStringQuery(urlQuery);
    aJax.async=false;
    aJax.fire();
    
    return stringXsyncResult;
}	
	
/**
 * @type   : function
 * @access : public
 * @desc   : ajax로 구현된 자동완성 기능
 * @param  : objId input box명
 */
	function cfCompleteText(objId, navi) {
	    var strVal = document.getElementById(objId);
	    if (strVal.value.length > 1) {
	        var arg = cfSearchText(objId, navi);
	        cfSetTexts(objId, arg);
	    } else {
	        cfClearTexts(objId);
	    }
	    return arg;
	}
	
	function cfSearchText(objId, navi) {
	    var strVal = document.getElementById(objId);
	    stringXsyncResult = '';
	    var aJax = new lafj.xSync("/pbf.comm.util.CompleteText.laf");
	    aJax.addQuery("navi", navi);
	    aJax.addQuery("search", encodeURI(strVal.value));
	    aJax.async=false;
	    aJax.fire();
	    
	    return stringXsyncResult;
	}
	
	function cfSetTexts(objId, arg) {  
	    cfClearTexts(objId);
	    
	    var texts = arg.split(",");
	    var size = texts.length;
	    
	    cfSetOffsets(objId);
	
	    var row, cell, txtNode;
	    for (var i = 0; i < size; i++) {
		    row = document.createElement("tr");
		    cell = document.createElement("td");
		    
		    cell.onmouseout = function() {this.className='mouseOver';};
		    cell.onmouseover = function() {this.className='mouseOut';};
		    cell.setAttribute("bgcolor", "#FFFAFA");
		    cell.setAttribute("border", "0");
		    cell.onclick = function() { cfPopulateText(objId, this); } ;                             
		
		    txtNode = document.createTextNode(texts[i]);
		    cell.appendChild(txtNode);
		    row.appendChild(cell);
		    var nameTableBody = document.getElementById(objId + "TableBody");          
		    nameTableBody.appendChild(row);
	    }
	}
	
	function cfSetOffsets(objId) {
	    var completeDiv = document.getElementById(objId + "Div");
	    var nameTable = document.getElementById(objId + "Table");
	    var strVal = document.getElementById(objId);
	    var end = strVal.offsetWidth;
	    var left = cfCalculateOffsetLeft(strVal);
	    var top = cfCalculateOffsetTop(strVal) + strVal.offsetHeight;
	
	    completeDiv.style.border = "black 1px solid";
	    completeDiv.style.left = left + "px";
	    completeDiv.style.top = top + "px";
	    nameTable.style.width = end + "px";
	}
	
	function cfCalculateOffsetLeft(field) {
	  return cfCalculateOffset(field, "offsetLeft");
	}
	
	function cfCalculateOffsetTop(field) {
	  return cfCalculateOffset(field, "offsetTop");
	}
	
	function cfCalculateOffset(field, attr) {
	  var offset = 0;
	  while(field) {
	    offset += field[attr]; 
	    field = field.offsetParent;
	  }
	  return offset;
	}
	
	function cfPopulateText(objId, cell) {
	    var strVal = document.getElementById(objId);
        strVal.value = cell.firstChild.nodeValue;
	    cfClearTexts(objId);
	}
	
	function cfClearTexts(objId) {
	    var nameTableBody = document.getElementById(objId + "TableBody");
	    var completeDiv = document.getElementById(objId + "Div");
	    var ind = nameTableBody.childNodes.length;
	    for (var i = ind - 1; i >= 0 ; i--) {
	         nameTableBody.removeChild(nameTableBody.childNodes[i]);
	    }
	    completeDiv.style.border = "none";
	}  

/**
 * @type   : function
 * @access : public
 * @desc   : ajax로 구현된 자동완성 기능
 * @param  : objId input box명
 */
 	var _rowCnt = -1;
	function cfCompleteText(objId, navi) {
	    var strVal = document.getElementById(objId);
	    if (strVal.value.length > 1) {
	        var arg = cfSearchText(objId, navi);
	        cfSetTexts(objId, arg);
	    } else {
	        cfClearTexts(objId);
	    }
	    cfKeyEvent(objId);
	    return arg;
	}

	function cfKeyEvent(objId) {
		var strVal = document.getElementById(objId);
		if(strVal.value == "" || strVal.value == null) _rowCnt = -1;
		var key = window.event.keyCode; 
		var row = "";
		if(key == 38) { // 위
			_rowCnt	= eval(_rowCnt) - 1;
			row = "" + _rowCnt;
			if(document.all(row)) {
				document.all(row).bgColor="#708090"; 
			} else {
				_rowCnt	= eval(_rowCnt) + 1;
				row = "" + _rowCnt;
				document.all(row).bgColor="#708090"; 
			}
		} else if(key == 40) { // 아래
			_rowCnt	= eval(_rowCnt) + 1;
			row = "" + _rowCnt;
			if(document.all(row)) {
				document.all(row).bgColor="#708090"; 
			} else {
				_rowCnt	= eval(_rowCnt) - 1;
				row = "" + _rowCnt;
				document.all(row).bgColor="#708090"; 
			}
		} else if(key == 13) { // 엔터
			if(_rowCnt > 0) {
				row = "" + _rowCnt;
				var cell = document.all(row);
		        strVal.value = cell.firstChild.data;
			    cfClearTexts(objId);
			} else {
			    cfClearTexts(objId);
			}
		}
	}
	
	function cfSearchText(objId, navi) {
	    var strVal = document.getElementById(objId);
	    stringXsyncResult = '';
	    var aJax = new lafj.xSync("/pbf.comm.util.CompleteText.laf");
	    aJax.addQuery("navi", navi);
	    aJax.addQuery("search", encodeURI(strVal.value));
	    aJax.async=false;
	    aJax.fire();
	    
	    return stringXsyncResult;
	}
	
	function cfSetTexts(objId, arg) {  
	    cfClearTexts(objId);
	    
	    var texts = arg.split(",");
	    var size = texts.length;
	    
	    cfSetOffsets(objId);
	
	    var row, cell, txtNode;
	    for (var i = 0; i < size; i++) {
		    row = document.createElement("tr");
		    cell = document.createElement("td");
		    
		    cell.onmouseout = function() {this.className='mouseOver';};
		    cell.onmouseover = function() {this.className='mouseOut';};
		    cell.setAttribute("bgcolor", "#FFFAFA");
		    cell.setAttribute("border", "0");
		    cell.setAttribute("id", i);
		    cell.onclick = function() { cfPopulateText(objId, this); } ;                             
		
		    txtNode = document.createTextNode(texts[i]);
		    cell.appendChild(txtNode);
		    row.appendChild(cell);
		    var nameTableBody = document.getElementById(objId + "TableBody");          
		    nameTableBody.appendChild(row);
	    }
	}
	
	function cfSetOffsets(objId) {
	    var completeDiv = document.getElementById(objId + "Div");
	    var nameTable = document.getElementById(objId + "Table");
	    var strVal = document.getElementById(objId);
	    var end = strVal.offsetWidth;
	    var left = cfCalculateOffsetLeft(strVal);
	    var top = cfCalculateOffsetTop(strVal) + strVal.offsetHeight;
	
	    completeDiv.style.border = "black 1px solid";
	    completeDiv.style.left = left + "px";
	    completeDiv.style.top = top + "px";
	    nameTable.style.width = end + "px";
	}
	
	function cfCalculateOffsetLeft(field) {
	  return cfCalculateOffset(field, "offsetLeft");
	}
	
	function cfCalculateOffsetTop(field) {
	  return cfCalculateOffset(field, "offsetTop");
	}
	
	function cfCalculateOffset(field, attr) {
	  var offset = 0;
	  while(field) {
	    offset += field[attr]; 
	    field = field.offsetParent;
	  }
	  return offset;
	}
	
	function cfPopulateText(objId, cell) {
	    var strVal = document.getElementById(objId);
        strVal.value = cell.firstChild.nodeValue;
	    cfClearTexts(objId);
	}
	
	function cfClearTexts(objId) {
	    var nameTableBody = document.getElementById(objId + "TableBody");
	    var completeDiv = document.getElementById(objId + "Div");
	    var ind = nameTableBody.childNodes.length;
	    for (var i = ind - 1; i >= 0 ; i--) {
	         nameTableBody.removeChild(nameTableBody.childNodes[i]);
	    }
	    completeDiv.style.border = "none";
	}  
	
	function cfSetTextBox(e, objId, navi) {
		
	}
 
/**
 * @type   : function
 * @access : public
 * @desc   : 메뉴 코드로 메뉴명 조회
 * @param  : menuCd 메뉴 코드명
 */	
  function cfFindMenuNm(menuCd) {
  	return cfRetrieveSingleDataWithLang("retrieveMenuNm", "menuCd="+ menuCd);
  }
 
/**
 * @type   : function
 * @access : public
 * @desc   : 메뉴 URL로 메뉴명 조회
 * @param  : menuUrl 메뉴 Url
 */	
  function cfFindMenuNmWithUrl(menuUrl) {
  	return cfRetrieveSingleDataWithLang("retrieveMenuNm", "menuUrl="+ menuUrl);
  }
 
/**
 * @type   : function
 * @access : public
 * @desc   : menuCd로 menuUrl 조회
 * @param  : menuCd 메뉴 코드명
 */	
  function cfFindMenuUrl(menuCd) {
  	return cfRetrieveSingleDataFromDB("retrieveMenuUrl", "menuCd="+ menuCd);
  }

// 파일 실행 호출
function cfFileLink(file) {
  helpWindow = window.open("/jsp/pbf/comm/file/fileLink.jsp?file=" + file, "fileTarget", "height=0,width=0,left=3000,top=3000,status=no,toolbar=no,menubar=no,location=no,scrollbars=no,resizable=no");
}

/**
 * @type   : function
 * @access : public
 * @desc   : 입력란에 들어간 값을 대(소)문자로 변경
 * @usage  : OnKeyup="javascript:gfn_toUpper(this, true);"
 */
 function cfToUpperLower(arg, flag) {
	if(arg) {
		var method = '';
		if(flag) {
			method = 'toUpperCase';
		} else {
			method = 'toLowerCase';
		}
	  	if(arg.value == undefined) {
	    	return eval('arg.' + method + '()');
			} else {
	    	arg.value = eval('arg.value.' + method + '()');    
			}
		} else {
	  	return eval('arg.' + method + '()');
	}
}

/**
 * @type   : function
 * @access : public
 * @desc   : 조회 조건 유효성 체크
 * <pre>
 *     cfCheckPeriod(aFrom, aTo);
 * </pre>
 * @author : 홍두희 
 */
function cfCheckPeriod(aFrom, aTo) {
    if(document.all(aFrom).text > document.all(aTo).text) {
      cfAlertMsg(MSG_COM_ERR_039);
      document.all(aFrom).focus();
      return false;
    } else {
    	return true;
    }
}

function cfToUpperObj() {
  cfToUpperLower(event.srcElement, true);
}

function cfToLowerObj() {
    cfToUpperLower(event.srcElement, false);
}

/**
 * @type   : function
 * @access : public
 * @desc   : 툴팁 도움말 처리
 * <pre>
 * 	onmousemove="cfMoveMsg()" onmouseover="cfSetMsg(this);return true;"  onmouseout="cfHideMsg();return true;"
 * 	<div id="msg" style="position:absolute;left:0;top:0;width:0;height:0;"></div> 
 * </pre>
 * @author : 홍두희
 */
 function cfMoveMsg(){ 
   msg.style.posLeft = event.x + 20 + document.body.scrollLeft 
   msg.style.posTop = event.y - 20 + document.body.scrollTop 
 } 

 function cfSetMsg(aMsg){
    var strMsg = "";
    if(aMsg.type) {
      var curType = aMsg.type.toUpperCase();
      if(curType == "INPUT" || curType == "BUTTON") {
        strMsg = aMsg.value;
      }
    } else {
      strMsg = aMsg;
    }
    var aLength = aMsg.length;
    aLength = aLength * 15;
    text ='<table width='+aLength+' bgcolor=#FFD700 style="border:1 black solid;"><tr><td>' + strMsg + '</td></tr></table>' 
    msg.innerHTML=text 
 } 

 function cfHideMsg(){ 
   msg.innerHTML='' 
 } 

/**
 * @type   : function
 * @access : public
 * @desc   : 휴무일 정보 조회
 * <pre>	type -> isHoliday, getLastWorkingDay, getWorkingDayCnt
 * </pre>
 * @author : 홍두희
 */
  function cfGetHoliday(aType, aDate) {
      stringXsyncResult = '';
      var aJax = new lafj.xSync("/pbf.comm.util.GetHoliday.laf");
      aJax.addQuery("type", aType);
      aJax.addQuery("date", aDate);
      aJax.fire();
      return stringXsyncResult;
  }  

  function cfConvertToAutoWSCol(aCols, condition) {
    stringXsyncResult = '';
    var aJax = new lafj.xSync("/pbf.admin.ws.ConvertToAutoWSCol.laf" + condition);
//    aJax.addQuery("type", "toAWS");
    aJax.addQuery("cols", aCols);
    aJax.fire();
    return stringXsyncResult;
  }
   
  function cfEquals(arg, val) {
    arg = cfReplaceAll(arg, "\n", "");
    val=cfReplaceAll(val, '\n', "");
    val=cfReplaceAll(val, '\r', "");
    if(arg == val) {
      return true
    } else {
      return false
    }
  }

  // 1개의 column 가져오기
  function cfGetOneColmAjax(aUrl, arrParam) {
	    stringXsyncResult = '';
	    var aJax = new devon.xSync(aUrl);
	    for(var i=0;i<arrParam.length;i++){
	    	var tmp = arrParam[i];
	    	var arrTmp = tmp.split("=");
	    	if(arrTmp.length > 0) {
			    aJax.addQuery(arrTmp[0], arrTmp[1]);
	    	} else {
			    aJax.addQuery(arrTmp[0], "");
	    	}
	    }
	    aJax.fire();
	    return stringXsyncResult.trim();
	}

  devon.xSync.handler.string = function(json) {
		stringXsyncResult = json.$text;
	  }
  
/**
 * @type   : function
 * @access : public
 * @desc   : 사용자 기본 정보 조회
 * <pre>	
 * </pre>
 * @author : 홍두희
 */
  var userInfo;
  function cfRetrieveUserSimpleInfo(qUserId) {
    var aJax = new lafj.xSync("/pbf.comm.security.RetrieveUserSimpleInfo.laf");
    aJax.addQuery("userId", qUserId);
    aJax.fire();
  	return userInfo;
  }

  function cfCheckValue(obj) {
  	if(obj.checked == true) {
      obj.value = 'Y';
    } else {
      obj.value = 'N';
    }
  }

 /**
 * @type   : function
 * @access : public
 * @desc   : 건수만큼 공백및 문자를 리턴;
 * <pre>	cfFill(5, 'N'); => 'NNNNN', cfFill(5); => '     '
 * </pre>
 * @author : 김진중
 */ 
 function cfFill(sCnt, tText){
	var RetText = "";
	for (var i = 0; i < sCnt; i++) {
		if (null != tText) {
			RetText += tText;
		} else {
			RetText += " ";
		}
	}
	return RetText;
}
  
 /**
 * @type   : function
 * @access : public
 * @desc   : frame 내의 document의 domain을 변경
 * <pre>	cfSetDomain("hansolcsn.com");
 * </pre>
 * @author : 홍두희
 */ 
 function cfSetDomain(aDomain){
	var oObj=top.document.all.tags('frameset');
	for(i=0;i<oObj.length;i++) {
		//alert(oObj[i].id + oObj[i].name);
		oObj[i].document.domain = aDomain;
	}
	var oObj=top.document.all.tags('frame');
	for(i=0;i<oObj.length;i++) {
    	//alert(oObj[i].id + oObj[i].name);
		oObj[i].document.domain = aDomain;
	}
 }	
 
 /**
 * @type   : function
 * @access : public
 * @desc   : url에서 param의 value 가져오기
 * <pre>	cfGetUrlParam("http:~~", "menuCd");
 * </pre>
 * @author : 홍두희
 */  
  function cfGetUrlParam(aUrl, aCol){
    var strRslt = "";
    if(aUrl.indexOf("?") > 0) {
      var tmp = aUrl.substring(aUrl.indexOf("?") + 1, aUrl.length);
      var tmpArry = tmp.split("&");
      for(i=0;i<tmpArry.length;i++){
        var tmp2Arry = tmpArry[i].split("=");
        if(tmp2Arry[0] == aCol) {
          strRslt = tmp2Arry[1];
        }
      }
    }
    return strRslt;
  } 
 
 /**
 * @type   : function
 * @access : public
 * @desc   : url에서 param의 value 가져오기
 * <pre>	cfGetParam("aaa=bbb;ccc=ddd", "menuCd");
 * </pre>
 * @author : 홍두희
 */  
	function cfGetParam(tmpArry, aCol){
	  var strRslt = "";
	  for(i=0;i<tmpArry.length;i++){
	    var tmp2Arry = tmpArry[i].split("=");
	    if(tmp2Arry[0] == aCol) {
	      strRslt = tmp2Arry[1];
	      return strRslt;
	    }
	  } 
	  return "";
	} 

 /**
 * @type   : function
 * @access : public
 * @desc   : 외부 시스템 오픈
 * <pre>	cfOtherSysOpen("http:~~");
 * </pre>
 * @author : 홍두희
 */  
  function cfOtherSysOpen(aUrl){
    var bizSctnCd = cfGetUrlParam(aUrl, "bizSctnCd");
    if(bizSctnCd == 'FW' || bizSctnCd == 'WM' || bizSctnCd == 'TM' || bizSctnCd == 'ED') {
      var menuCd = cfGetUrlParam(aUrl, "menuCd");
      var menuUrl = cfFindMenuUrl(menuCd);
	  var w = screen.width - 10;
	  var h = screen.height - 10;
	  var left = 0;
	  var top = 0;
	  window.open(menuUrl, "", "height="+h+",width="+w+",left="+left+",top="+top+",status=no,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes");
      //window.open(menuUrl, '', "channelmode,scrollbars");
      return true;
    }
   	return false;
  }
   	
 /**
 * @type   : function
 * @access : public
 * @desc   : 템플릿 파일 받기
 * @author : 홍두희
 */    	
 function cfDownloadTemplete(fileNm){
 	var aUrl = "/pbf.comm.file.downloadFile.laf?spec=template&fileNm=" + cfHangle(fileNm);
 	document.location.href = aUrl;
 }

 /**
 * @type   : function
 * @access : public
 * @desc   : 로컬 파일 열기 (현재 액세스 오류로 오픈 안됨)
 * @author : 홍두희
 */      	
  function openLocalFile(aForm, pcFilePath) {
    aForm.action = 'file:///' + pcFilePath;
    aForm.encType = "post";
    aForm.target = "_blank";
	aForm.submit();
  }

 /**
 * @type   : function
 * @access : public
 * @desc   : 필수 처리 변경 ex) cfChangeTDMand("empNm", "txt_empNm", "사원명", true);
 * @author : 홍두희
 */    
  function cfChangeTDMand(spId, objId, colNm, mandYn) {
    var sp = document.all('sp_' + spId);
    if(!sp) return;
    var obj = document.all(objId);
    if(mandYn) {
      sp.innerText = "* ";
      if(obj.validExp) {
        obj.validExp = obj.validExp.replace(":no", ":yes");
      } else {
        obj.validExp= colNm + ":yes:";
      }
    } else {
      sp.innerText = "  ";
      if(obj.validExp) {
        obj.validExp = obj.validExp.replace(":yes", ":no");
      } else {
        obj.validExp= colNm + ":no:";
      }
    }
  }  
  
 /**
 * @type   : function
 * @access : public
 * @desc   : 배치 프로그램 실행 ex) cfExecBatch('az01.ExcuteBatch', '2008-03-06', 'aaa^111;bbb^222');
 * @author : 홍두희
 */   
   function cfExecBatch(srvIds, calcYm, srvArgs) {
	    srvArgs = cfReplaceAll(srvArgs, "=", "^");
	    srvArgs = cfReplaceAll(srvArgs, "&", ";");
   	
		var url = "/pbf.comm.batch.ExecBatch.laf?calcYm=" + calcYm + "&srvIds=" + srvIds + "&srvArgs=" + srvArgs;
		var aForm = $aDoc.all("aForm");
		if(aForm == null){
			$aDoc.body.insertAdjacentHTML("beforeEnd", "<form name=aForm method=post></form>");
		}
		aForm = $aDoc.all('aForm');
		aForm.action = url;
		aForm.target = "hiddenFrame"; 
		aForm.submit();   
  } 
 
  function cfGetFileExt(filePath) {
    var lastIndex = -1;
    lastIndex = filePath.lastIndexOf('.');
    var extension = "";
    if ( lastIndex != -1 ) {
      extension = filePath.substring( lastIndex+1, filePath.len );
    } else {
      extension = "";
    }
    return extension;
  }

  function cfUploadExtFile(aForm, obj, aExt) {
    aForm.extra_file.value = obj.value;
    var inputValue = cfGetFileExt(aForm.extra_file.value);
    this.blur();
    if(aForm.extra_file.value == "") {
       aForm.reset();
       cfAlertMsg("<sf:ez>pbf.warn.al.nofileselected</sf:ez>");
       return;
    } else if ( inputValue.toLowerCase() != aExt) {
       aForm.reset();
       cfAlertMsg('확장자가(.' + aExt + ')만 업로드 가능합니다.');
       return;
    }
    aForm.encType="multipart/form-data";
    aForm.submit();
  }
  
  function cfCheckTimeFormat(sValue, oracleTimeformat) {
  	  switch(oracleTimeformat.toUpperCase()) {
  	  	case 'HHMMSS':
  	  		if (sValue.length() != 6) {
  	  			return false;
  	  		}
  	  		if (sValue.substring(0, 2) < '00' || sValue.substring(0, 2) > '23') {
  	  			return false;
  	  		}
  	  		if (sValue.substring(2, 4) < '00' || sValue.substring(2, 4) > '59') {
  	  			return false;
  	  		}
  	  		if (sValue.substring(4, 6) < '00' || sValue.substring(4, 6) > '59') {
  	  			return false;
  	  		}
  	  	break;
  	  }
  	  return true;
  }

 /**
 * @type   : function
 * @access : public
 * @desc   : 기준일자와의 차이일자를 계산
 * Argument : sdate : 기준일자 (string : yyyymmdd)
 *            sdiff : 차이 (init)
 *	          stype : 계산형식 (Y:Year  M:Month  D:Date)
 * return = yyyymmdd
 * @author : rsb
 */
	function cfDiffDate(sdate, sdiff, stype) {
	  var tyy = sdate.substring(0,4);
	  var tmm = sdate.substring(4,6) - 1;
	  var tdd = sdate.substring(6,8);
	
	  currdate = new Date(tyy,tmm,tdd);
	
	  switch (stype) {
	  case "Y" : diffdate = new Date(currdate.getYear() + sdiff,currdate.getMonth(),currdate.getDate()); break;
	  case "M" : diffdate = new Date(currdate.getYear(),currdate.getMonth() + sdiff,currdate.getDate()); break;
	  default  : diffdate = new Date(currdate.getYear(),currdate.getMonth(),currdate.getDate() + sdiff); break;
	  }
	
	  var tmpyy = diffdate.getYear();
	  var ls_yy = (tmpyy > 99) ? tmpyy : 1900 + tmpyy;
	
	  var tmpmm = diffdate.getMonth();
	  var ls_mm = (tmpmm < 9)  ? "0" + (tmpmm + 1) : tmpmm + 1;
	
	  var tmpdd = diffdate.getDate();
	  var ls_dd = (tmpdd < 10) ? "0" + tmpdd : tmpdd;
	
	  return ls_yy.toString() + ls_mm.toString() + ls_dd.toString() ;
	}

 /**
 * @type   : function
 * @access : public
 * @desc   : 오브젝트 표시/숨김
 * Argument : objId : image id
 *            altTxt : alt text
 *            imagePath : image path
 * @author : rsb
 */
  function cfShowHideObject(objId, altTxt, imagePath) {
    var img = event.srcElement;
    var obj = document.getElementById(objId);

    if (obj.style.display == "none") {
      img.src = imagePath + "/pbf/page_off.gif";
      img.alt = altTxt + " 접기";
      obj.style.display = "block";

    } else {
      img.src = imagePath + "/pbf/page_on.gif";
      img.alt = altTxt + " 펼치기";
      obj.style.display = "none";
    }
  }
  

  /* 지정된 엘리먼트에 오늘날짜 값을 할당한다.(datetime.js 필요) */
  function cfToday(element_id) {
    $(element_id).value = new Date().format("yyyy-MM-dd");
  }

  /* 지정된 엘리먼트에 어제날짜 값을 할당한다.(datetime.js 필요) */
  function cfYesterday(element_id) {
    $(element_id).value = new Date().add('d', -1).format("yyyy-MM-dd");
  }  
  
  /*
   * 지정된 라디오버튼 or 체크박스에 선택된 항목이 있는지 여부
   * => 하나라도도 있으면 true, 하나도 없으면 false
   */
  function cfAnyCheck(input_name) {
    var inputs = $N(input_name);
    if (inputs && inputs.checked) {
      return true;
    } else if (inputs && inputs.length && inputs.length > 0) {
      for (var inx = 0; inx < inputs.length; inx++) {
          if (inputs[inx].checked) return true;
      }
    }
    return false;
  }  
  
  /*
   * 지정된 라디오버튼 or 체크박스에 선택된 항목이 없는지 여부
   * => 하나도 없으면 true, 하나라도 있으면 false
   */
  function cfNoCheck(input_name) {
    return !cfAnyCheck(input_name);
  }  
  
  function cfIsEmpty(value) {
	  if (value == null || value.replace(/ /gi,"") == "") {
	    return true;
	  }
	  return false;
	}

	function cfIsNotEmpty(value) {
	  return !cfIsEmpty(value);
	}
  
	/* 테이블 레코드 피아노 효과 */
	function cfTrOver(table_row) {
	  if(table_row.style.backgroundColor=='#fafad2')return;
	  table_row.style.backgroundColor='#F7F9E7';
	  table_row.style.cursor='pointer';
	}
	function cfTrOut(table_row) {	
	  if(table_row.style.backgroundColor=='#fafad2')return;
	  table_row.style.backgroundColor='#FFFFFF';
	}	//没有手形
	function cfListOver(table_row) {
	  if(table_row.style.backgroundColor=='#fafad2')return;
	  table_row.style.backgroundColor='#F7F9E7';
	  //table_row.style.cursor='pointer';
	}
	function cfListOut(table_row) {	
	  if(table_row.style.backgroundColor=='#fafad2')return;
	  table_row.style.backgroundColor='#FFFFFF';
	}
	// 单击某一行时保留颜色
	function cfTrClick(table_row) {
	    if(table_row.style.backgroundColor=='#fafad2')return;
	    var varTable = table_row.parentNode;
	    for(var i=1; i< varTable.rows.length; i++) 
            { 
                varTable.rows[i].style.backgroundColor = '#FFFFFF';
            }
            table_row.style.backgroundColor = '#F7F9E7';
	}
	
	function cfTrDown(table_row) {		
		  var nodelength =table_row.parentNode.childNodes.length;
		  var nodes =table_row.parentNode.childNodes;
		  for(var i=0;i<nodelength;i++){
			  if(nodes[i].style.backgroundColor=='#fafad2'){
				  nodes[i].style.backgroundColor='#FFFFFF';
			  }
		  }	  
		  table_row.style.backgroundColor='#fafad2';
	}	
	function cfOpenPopupWithName(sURL, sName, iWidth, iHeight) {

	  var sFeatures = "scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,resizable=no";
	  iWidth = iWidth == null ? 600: iWidth;
	  iHeight = iHeight == null ? 400: iHeight;
	  var x = window.screenLeft;
	  var y = window.screenTop;
	  var l = x + ((document.body.offsetWidth - iWidth) / 2);
	  var t = y + ((document.body.offsetHeight - iHeight) / 2);
	  sFeatures += ",width=";
	  sFeatures += iWidth;
	  sFeatures += ",height=";
	  sFeatures += iHeight;
	  sFeatures += ",top=";
	  sFeatures += t;
	  sFeatures += ",left=";
	  sFeatures += l;

	  window.open(sURL, sName, sFeatures).focus();
	}

	function cfOpenPopup(sURL, iWidth, iHeight) {
	  cfOpenPopupWithName(sURL, "popup", iWidth, iHeight);
	}	
	
	/* 풍선도움말 보이기 */
	function cfShowToolTip(id, iWidth, iHeight) {
	  popup = window.createPopup();
	  popup.document.write('<pre>'+$(id).innerHTML+'</pre>');
	  popup.document.body.style.border = "solid black 1px";
	  popup.document.body.style.fontFamily = "Gulim, Arial, Verdana";
	  popup.document.body.style.fontSize = "12px";
	  popup.document.body.style.overflow= "hidden";

	  iX = event.screenX;
	  iY = event.screenY;

	  $(id).style.display="inline";

	  iWidth = iWidth == null ? $(id).offsetWidth+25 : iWidth;
	  iHeight = iHeight == null ? $(id).offsetHeight+25 : iHeight;

	  $(id).style.display="none";

	  popup.show(iX, iY, iWidth, iHeight);
	}
	
	// 마우스 클릭 이벤트 정보 얻기
	function cfGetButtonEvent(e) {
		var aButton;
		if (isMSIE == true) {
			aButton = (event.button < 2) ? "LEFT" :
		              ((event.button == 4) ? "MIDDLE" : "RIGHT");
		} else {
			aButton = (e.which < 2) ? "LEFT" :
		              ((e.which == 2) ? "MIDDLE" : "RIGHT");
		}
		return aButton;
	}
	
	$mouseX = 0;
	$mouseY = 0;
	  
	// 마우스 클릭 포인트 위치 얻기
	function cfOnClick(e) {
		if ( e== null) {
		  $mouseX = event.clientX;
		  $mouseY = event.clientY;
	    } else {
		  $mouseX = e.pageX;
		  $mouseY = e.pageY;;
	    }
	}

	// 트리 컨텍스트 버튼 생성 
	function cfCreateContextPopup() { 
		var poppy = document.getElementById("poppy");
		var popup = document.getElementById("popup");
		if (popup == null) {
			poppy.innerHTML = "<div id='popup' style='position:absolute; left:252px; top:130px; width:100px; height:22px;disply z-index:1'></div>"; 
		}	
	}
		  
	// 트리 컨텍스트 버튼 보이기 
	function cfOnMouseDown(e) {
		if(typeof(e)!="undefined") {
		    cfOnClick(e);
		} else {
			cfOnClick();
		}
		if(cfGetButtonEvent(e) != "RIGHT"){
			cfHideObj("popup");
		}
	}
		  
	// 컨텍스트 메뉴 view
	function cfContextMenuShow( aFunc, aMenu) {
		cfCreateContextPopup();
		var div = document.getElementById("popup");
		div.innerHTML = "<table width='100px' border='1' style='border-top:1px solid #CFD6DC;border-collapse:collapse;font-size:9pt' > "
		    + "<tr><td style='text-align:center;padding: 3 4 3 4;background-color:#EDEDED'> "
		    + "<span onmousedown='" + aFunc + ";document.getElementById(\"popup\").style.display = \"none\";' style='cursor:hand'>"
		    + aMenu
		    + "</span></td></tr></table>";
		div.style.left = $mouseX;
		div.style.top = $mouseY;
		div.style.backgroundColor = "#F4F4F4";
		div.style.border = "solid black 1px";   
		div.style.display = "block";
	}

	// 국가 전환
	function cfSwichCountry(aForm, obj) {
		var form = document.getElementById(aForm);
		form.action="/pbf.common.locale.ChangeCountry.dev";
		form.submit();
	}
	
	// 언어 전환
	function cfSwichLocale(aForm, obj) {
		var form = document.getElementById(aForm);
		form.action="/pbf.common.locale.ChangeLocale.dev";
		form.submit();
	}
	