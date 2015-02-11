var isDOM=document.getElementById?true:false;
var isOpera=isOpera5=window.opera && isDOM;
var isOpera6=isOpera && window.print;
var isOpera7=isOpera && document.readyState;
var isMSIE=isIE=document.all && document.all.item && !isOpera;
var isStrict=document.compatMode=='CSS1Compat';
var isNN=isNC=navigator.appName=="Netscape";
var isNN4=isNC4=isNN && !isDOM;
var isMozilla=isNN6=isNN && isDOM;

function actSubmit(oform, action, target) {
  if (target) oform.attr("target", target);
  if (action) oform.attr("action",action);
  oform.submit();
}

function actSubmitValidate(oform, action, target) {
	  if (target) oform.attr("target", target);
	  if (action) oform.attr("action",action);
	  oform.submit();
}

function cfTrOver(table_row) {
	  if(table_row.style.backgroundColor=='#fafad2')return;
	  table_row.style.backgroundColor='#F7F9E7';
	  table_row.style.cursor='pointer';
	}

function cfTrOut(table_row) {	
	  if(table_row.style.backgroundColor=='#fafad2')return;
	  table_row.style.backgroundColor='#FFFFFF';
}

function cfListOver(table_row) {
	  if(table_row.style.backgroundColor=='#fafad2')return;
	  table_row.style.backgroundColor='#F7F9E7';
	  //table_row.style.cursor='pointer';
}
function cfListOut(table_row) {	
	  if(table_row.style.backgroundColor=='#fafad2')return;
	  table_row.style.backgroundColor='#FFFFFF';
}
	
//固定滚动条的头
function   fixupFirstRow(tab)   
  {   
      var	div   =	tab.parentNode; 
      var   tabId =	tab.id;
      var   oTab = tab;
      div.style.position   =   "relative";
      tab.style.position   =   "relative";   
      tab.rows[0].style.zIndex   =   "90";   
      tab.rows[0].style.position   =   "relative";   
      div.onscroll   =   function(){  	
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

//ajax form方式赋值
function setFormAjax(formId,id,value){
	$('#'+formId+' :input[id='+id+'][type=text]').attr("value",value);
	$('#'+formId+' :input[id='+id+'][type=hidden]').attr("value",value);
	$('#'+formId+' :input[id='+id+'][type=password]').attr("value",value);
	//$('#'+formId+' :textarea[id='+id+']').val(value);
    $('#'+formId+' :input[id='+id+'][type=radio][value='+value+']').attr("checked","true");
	$('#'+formId+' :input[id='+id+'][value='+value+'][type=checkbox]').attr("checked","true");
	//$('#'+formId+' :select[id='+id+']>option [value='+value+']').attr("selected","true");
	$('#'+formId+' select[id='+id+']').val(value);
	$('#'+formId+' textarea[id='+id+']').val(value);
}

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
function cfOnClick(e) {
	if ( e== null) {
	  $mouseX = event.clientX;
	  $mouseY = event.clientY;
    } else {
	  $mouseX = e.pageX;
	  $mouseY = e.pageY;;
    }
}
function cfCreateContextPopup() { 
	var poppy = document.getElementById("poppy");
	var popup = document.getElementById("popup");
	if (popup == null) {
		poppy.innerHTML = "<div id='popup' style='position:absolute; left:252px; top:130px; width:100px; height:22px;disply z-index:1'></div>"; 
	}	
}
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
function cfHideObj(aObj){
	}

function cfEnableObjs(ObjectItems, Status) {
	return;
	var objs;
	if(ObjectItems.indexOf(",") > 0) {
		objs = ObjectItems.advancedSplit(",", "it");
		for(i=0;i<objs.length;i++){
			cfEnableObj(objs[i], Status);
		}
	} else {
		cfEnableObj(ObjectItems, Status);
	}
}  
function cfEnableObj(ObjectItem, Status) {
	if(typeof(ObjectItem) == "string") {
		ObjectItem = $(ObjectItem); //document.getElementById(ObjectItem);
	}
	
	// 권한이 없으면 enable 수행 안 함
	if (Status == true && ObjectItem.userAuth && cfCheckAuth(ObjectItem.userAuth) == false) {
		return;
	}
	
    switch (ObjectItem.tagName) {
        case 'INPUT':
        	var type = ObjectItem.type.toUpperCase();
            if(type == 'FILE' || type == 'BUTTON' || type == 'IMAGE' || type == 'RESET' || type == 'SUBMIT'){
            	if(!isMSIE) ObjectItem.style.color = "#888888";
            	ObjectItem.disabled = (!Status);
            	break;
            } else if(type == 'CHECKBOX' || type == 'RADIO') {
            	var objNm = ObjectItem.name;
            	if(objNm == null) objNm = ObjectItem.id;
            	ObjectItem = document.getElementsByName(objNm);
            	if(ObjectItem.length > 1) {
                	for(i=0;i<ObjectItem.length;i++){
                    	ObjectItem[i].disabled = (!Status);
                	}
            	} else {
                	ObjectItem.disabled = (!Status);
            	}
            	break;
            } else if (type == 'PASSWORD' || type == 'TEXT') {
            	if(Status==false){
            		ObjectItem.setAttribute('readOnly','readOnly');
            		ObjectItem.style.backgroundColor = "#EEFFB6";
            	} else {
            		ObjectItem.removeAttribute('readOnly');
            		ObjectItem.style.backgroundColor = "#FFFFFF";
            	}
            	break;
            }
        case 'SELECT':
            ObjectItem.disabled = (!Status);
            break;
        case 'TEXTAREA':
            ObjectItem.readOnly = (!Status);
            break;
        case 'A':
            ObjectItem.disabled = (!Status);
            break;
        case "IMG":
            ObjectItem.disabled = (!Status);
            break;
        case "TABLE":
            ObjectItem.disabled = (!Status);
            break;
        case "TR":
            ObjectItem.disabled = (!Status);
            break;
        case "TD":
            ObjectItem.disabled = (!Status);
            break;
    }
}  
// 检验所给的值是否为空
	function fncValidate(varValue) {
		if (varValue.trim() == "" || varValue == null) {
			return false;
		} else {
			return true;
		}
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