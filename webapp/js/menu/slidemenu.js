if (typeof(ssdev) == "undefined") {
  ssdev = new Object();
}
 
/*
 *  ssdev.Lslide 
 */
ssdev.Lslide = function (element, slideStepSize, slideTime, callbackReceiver) {
	this.slideElement = (typeof(element) == "string") ? document.getElementById(element) : element;
	this.slideStepSize = slideStepSize; // px
	this.slideTime = slideTime;
	this.slideTimer = null;
	this.slideHeight = 0;
	this.nowSlideHeight = 0;
  this.callbackReceiver = callbackReceiver; // state def. : 0:none, 1:opening, 2:opened, 3:closing, 4:closed
	this.listIndex = ssdev.Lslide.list.length;
	ssdev.Lslide.list[this.listIndex] = this;
	
	this.change = function() {
		alert('........');
  	if (this.slideElement.style.display == "none") this.slide();
  	else this.close();
	}
	
  this.slide = function() {
  	if (this.slideTimer) return;
		if (this.callbackReceiver) this.callbackReceiver.onStateChange(ssdev.Lslide.state.NONE);
	 	var element = this.slideElement;
	 	var oldPosition = element.style.position;
	 	var oldVisibility = element.style.visibility;
	 	var oldDisplay = element.style.display;
	 	
    element.style.position = "absolute";  // absolute�� �ƴҰ�� ȭ�鿵��; �����ϰ� ��
    element.style.visibility = "hidden";  // ȭ�鿡 ����; �����ϰ� �Ͽ� ���̸� ����
	 	element.style.display = "block";
	 	this.slideHeight = element.offsetHeight;
    element.style.position = oldPosition;
    element.style.visibility = oldVisibility;
    element.style.overflow = "hidden";    // ��d�� height��ŭ�� ������� ��
	 	element.style.height = "0px";
	 	element.style.display = "block";
	 	this.slideTimer = setInterval("ssdev.Lslide.list["+this.listIndex+"].slideOneStep()", this.slideTime);
  }
  
  this.slideOneStep = function() {
	  this.nowSlideHeight += this.slideStepSize;
	  
    if (this.nowSlideHeight >= this.slideHeight) {
    	this.slideElement.style.height = this.slideHeight+"px";
    	this.stopSlide();
		  if (this.callbackReceiver) this.callbackReceiver.onStateChange(ssdev.Lslide.state.OPENED);
    } else {
	    this.slideElement.style.height = this.nowSlideHeight+"px";
		  if (this.callbackReceiver) this.callbackReceiver.onStateChange(ssdev.Lslide.state.OPENING);
    }
  }
  
  this.close = function() {
  	if (this.slideTimer) return;
		if (this.callbackReceiver) this.callbackReceiver.onStateChange(ssdev.Lslide.state.NONE);
	 	this.nowSlideHeight = this.slideElement.offsetHeight;
    this.slideElement.style.overflow = "hidden";
	 	this.slideTimer = setInterval("ssdev.Lslide.list["+this.listIndex+"].closeOneStep()", this.slideTime);
  }
  
  this.closeOneStep = function () {
	  this.nowSlideHeight -= this.slideStepSize;
	  
    if (this.nowSlideHeight <= 0) {
    	this.slideElement.style.height = "";
    	this.slideElement.style.display = "none";
    	this.stopSlide();
		if (this.callbackReceiver) this.callbackReceiver.onStateChange(ssdev.Lslide.state.CLOSED);
    } else {
	    this.slideElement.style.height = this.nowSlideHeight+"px";
		if (this.callbackReceiver) this.callbackReceiver.onStateChange(ssdev.Lslide.state.CLOSING);
    }
  }
  
  this.stopSlide = function() {
	  clearInterval(this.slideTimer);
	  this.slideTimer = null;
	  this.nowSlideHeight = 0;
  }
  
  this.setState = function(state) {
    switch (state) {
      case 2: this.slideElement.style.display = "block";break;
      case 4: this.slideElement.style.display = "none";break;
    }
  }
} 

ssdev.Lslide.list = new Array();

ssdev.Lslide.state = {
  "NONE" : 0,
  "OPENING" : 1,
  "OPENED" : 2,
  "CLOSING" : 3,
  "CLOSED" : 4
}

/*
 *  ssdev.LslideMenu 
 */
ssdev.LslideMenu = function (rootUL, slideStepSize, slideTime, sync) {
	if (typeof(rootUL) == "string") rootUL = document.getElementById(rootUL);
	
	this.menuItems = new Array();
	this.selectedMenuIndex = -1;
  this.closedMenuIndex = -1;
  this.openMenuIndex
	this.sync = sync;
	this.LI = new Array();
	this.slideState = ssdev.Lslide.state.NONE;
	
	// set LI
	var cnt = 0;
	for (var i=0; i<rootUL.childNodes.length; i++) 
    if (rootUL.childNodes[i].tagName == "LI") 
      this.LI[cnt++] = rootUL.childNodes[i];
  
	// this is callback from Lslide close action.
	this.onStateChange = function(state) { // state def. : 0:none, 1:opening, 2:opened, 3:closing, 4:closed
	  this.slideState = state;
	  switch (state) {
	    case 2 : this.afterOpen(this.LI, this.selectedMenuIndex); break;
	    case 4 : this.afterClose(this.LI, this.closedMenuIndex); break;
	  }
	  
		if (state == 4 && this.menuItems[this.selectedMenuIndex] != null && this.selectedMenuIndex != this.closedMenuIndex) {
		  this.beforeOpen(this.LI, this.selectedMenuIndex);    
		  this.menuItems[this.selectedMenuIndex].slide();
		  this.openMenuIndex = this.selectedMenuIndex;
  	}
	}
	
	// make menu items
	for (var i=0; i<this.LI.length; i++) {
    var UL = this.LI[i].getElementsByTagName("UL")[0];
    var callbackReceiver = (sync) ? this : null;
   	this.menuItems[i] = UL ? new ssdev.Lslide(UL, slideStepSize, slideTime, callbackReceiver) : null;
//   	this.LI[i].slideMenu = this;  // for attaching event
   	this.LI[i].index = i;  // for attaching event
	}
	
  /*
   * change
   */
	this.change = function(menuIndex) {
	  
	  if (this.slideState == 1 || this.slideState == 3) return; 
	  
	  this.selectedMenuIndex = menuIndex;
		this.closedMenuIndex = -1;
		
		
		
		// close menu opened before.
		if (this.openMenuIndex >= 0) { 
		  this.beforeClose(this.LI, this.openMenuIndex);    
			this.closedMenuIndex = this.openMenuIndex;
			this.menuItems[this.openMenuIndex].close();
			this.openMenuIndex = -1;
		}
	
    // no sub menu items
    if (this.menuItems[menuIndex] == null) return;
    
    // open clicked menu
  
		if (this.closedMenuIndex < 0 ||       // all menu is closed before click.
		     (this.closedMenuIndex != menuIndex && !this.sync)) {  // if sync mode, callback will be called.(set before)
			
			
		    this.beforeOpen(this.LI, menuIndex);    
			this.menuItems[menuIndex].slide();
			this.openMenuIndex = menuIndex;
		}
  }	
  
  // attach onclick event to LI
/*  
	for (var i=0; i<this.LI.length; i++) 
  	this.LI[i].onclick = function() {
  		this.slideMenu.change(this.index);
  	}
*/  
  this.setOpenMenu = function(menuIndex) {
    if (this.menuItems[menuIndex]) {
      this.menuItems[menuIndex].setState(2);
	  	this.openMenuIndex = menuIndex;
	  }
  }
  
  // this is callback interface
  this.beforeOpen = function (LI, index) {} 
  this.beforeClose = function (LI, index) {} 
  this.afterOpen = function (LI, index) {} 
  this.afterClose = function (LI, index) {} 
}



