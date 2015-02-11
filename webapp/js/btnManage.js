var bCreate;
var bUpdate;
var bSave;
var bDelete;
var bRequest;
var bCancel;
var bCreate2;
var bUpdate2;
var bSave2;
var bDelete2;
var bRequest2;
var bRequest3;

function cfShowBtn(btnArr) {
	  var save =true;
	  var create =true;
	  var update =true;
	  var cancel =true;
	  var del =true;
	  var req =true;
	  var save2 =true;
	  var create2 =true;
	  var update2 =true;
	  var cancel2 =true;
	  var del2 =true;
	  var req2 =true;
	  var req3 =true;
	  
	  for (var i in btnArr) {
	    if (btnArr[i] == 'bSave' && bSave)
		save = false;
	    if (btnArr[i] == 'bCreate'&& bCreate)
	        create = false;
	    if (btnArr[i] == 'bSave2' && bSave2)
		save2 = false;
	    if (btnArr[i] == 'bCreate2'&& bCreate2)
	        create2 = false;
	    if (btnArr[i] == 'bUpdate' && bUpdate)
	        update = false;
	    if (btnArr[i] == 'bCancel' && bCancel)
	        cancel = false;
	    if (btnArr[i] == 'bDelete' && bDelete)
	        del = false;
	    if (btnArr[i] == 'bRequest' && bRequest)
	        req = false; 
	    if (btnArr[i] == 'bRequest2' && bRequest2)
	        req2 = false; 
	     if (btnArr[i] == 'bRequest3' && bRequest3)
	        req3= false; 
	  }
	    
		// 신규
		if (bCreate != null&& create)
	    	cfHiddenBtn(bCreate, 'none');
		if (bCreate2 != null&& create2)
	    	cfHiddenBtn(bCreate2, 'none');
		// 수정
		if (bUpdate != null && update)
	    	cfHiddenBtn(bUpdate, 'none');
		// 저장
		if (bSave != null && save)
	    	cfHiddenBtn(bSave, 'none');
		if (bSave2 != null && save2)
	    	cfHiddenBtn(bSave2, 'none');
		// 취소
		if (bCancel != null && cancel)
	    	cfHiddenBtn(bCancel, 'none');
		// 삭제
		if (bDelete != null && del)
	    	cfHiddenBtn(bDelete, 'none');
		// 결재요청
		if (bRequest != null && req)
	    	cfHiddenBtn(bRequest, 'none');
		if (bRequest2 != null && req2)
	    	cfHiddenBtn(bRequest2, 'none');
		if (bRequest3 != null && req3)
	    	cfHiddenBtn(bRequest3, 'none');
		
		
		// 수정
		if (bUpdate2 != null)
	    	cfHiddenBtn(bUpdate2, 'none');
		// 저장
		// 삭제
		if (bDelete2 != null)
	    	cfHiddenBtn(bDelete2, 'none');

	}


function cfHiddenBtn(ObjectItem, Status) {
	if(typeof(ObjectItem) == "string") 
		ObjectItem = $(ObjectItem); 
    switch (ObjectItem.tagName) {
        case 'INPUT':
		var type = ObjectItem.type.toUpperCase();
		if(type == 'BUTTON' ){
			if(ObjectItem.length > 1) {
				for(i=0;i<ObjectItem.length;i++)
				ObjectItem[i].style.display = Status;
			} else {
			    	
				ObjectItem.style.display = Status;
			}
		break;
		}
    }  
}

$(function(){
	for (i = 0; i < document.all.length; i++) {
		var curTagName = document.all[i].tagName.toUpperCase();
		if (curTagName == "INPUT" && (document.all[i].type.toUpperCase() == "BUTTON" || document.all[i].type.toUpperCase() == "FILE")) {
			if (document.all[i].objType == "fileBtn") {
				fileBtn[fileBtn.length] = document.all[i];
			}
			switch (document.all[i].objType) {
				// 신규 버튼
				case 'bCreate':
					bCreate = document.all[i];
					break;
				case 'bCreate2':
					bCreate2 = document.all[i];
					break;
				// 수정 버튼
				case 'bUpdate':
					bUpdate = document.all[i];
					break;
				// 저장 버튼
				case 'bSave':
					bSave = document.all[i];
					break;
				// 삭제 버튼
				case 'bDelete':
					bDelete = document.all[i];
					break;
				// 결재요청 버튼
				case 'bRequest':
					bRequest = document.all[i];
					break;
				// 신규 버튼2
				case 'bCancel':
					bCancel = document.all[i];
					break;
				// 수정 버튼2
				case 'bUpdate2':
					bUpdate2 = document.all[i];
					break;
				// 저장 버튼2
				case 'bSave2':
					bSave2 = document.all[i];
					break;
				// 삭제 버튼2
				case 'bDelete2':
					bDelete2 = document.all[i];
					break;
				// 결재요청 버튼
				case 'bRequest2':
					bRequest2 = document.all[i];
					break;
				// 결재요청 버튼
				case 'bRequest3':
					bRequest3 = document.all[i];
					break;
			}
			
		}
	}	
	if(typeof(btnRoleM)=='object' )
	    	cfShowBtn(btnRoleM);	        
}); 