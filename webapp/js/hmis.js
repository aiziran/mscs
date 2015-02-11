	var hObj;
	var hObjNm;
	var func;
	////////////////////////////////药品分类树-查询用-start/////////////////////////////////////////
	
	/**
         * @type   : function
         * @access : public
         * @desc   : 隐藏frame
         * @usage  : 
         */
	function fncHiddenFrame(){
		var sFrame = document.getElementById("groupDiv");
		sFrame.style.display = 'none';
		document.getElementById("groupFrame").src="";
		sFrame.style.top=2;
		sFrame.style.left= 0;
		
	}
	
	/**
         * @type   : function
         * @access : public
         * @desc   : 隐藏frame的id必须为groupFrame，并且该frame必须被div包围，该div的id为：groupDiv
         * 	      例如：
         * 		<div id ="groupDiv" style="position:absolute; z-index:10;top:2;left:0;display:none">
 	 *			<iframe id='groupFrame' name='groupFrame' src='/hmim.example.drugType.retrieveDtreeList.dev?queryDrugType=S03' 
         *             			width="482" height="248" style="text-align:left;" marginheight='0' marginwidth='0' framespacing='0' frameborder='0' marginborder='0' scrolling='no' noresize></iframe>
	 *		</div>
	 *           药品分类编码索引：
	 *           		S01	药物分类
         *               	S02	医保标识
         *               	S03	剂型
         *               	S04	药理
         *               	S05	处方标识
         *               	S06	用药途径
         *              	S07	军队药品
         *               	S08	ABC分类
         *               	S09	特殊管理药品分类
         *              	S10	急救标识
         *               	S11	国家基本药物
         *               	S12	招标采购品种
         * @param  :obj ：需要显示名字的控件。objId：需要保存分类id的控件。code：药品分类代码，详见上。type:1:增加未录入项
         * @usage  : onClick="javascript: groupFrameView(this,'queryChinWest','S03','1');" 
         */
	
	function groupFrameView(obj,objId,code,type){
	    	if(obj) this.hObjNm = obj;
	    	if(obj){
	    	    var obName= obj.parentNode.getElementsByTagName("INPUT");
	    	    for(var i=0;i<obName.length;i++){
	    		if(obName[i].id==objId){
	    		    this.hObj = obName[i];
	    		    break;
	    		}
	    	    }
	    	}	    	    
	    	
                	    		
		var sFrame = document.getElementById("groupDiv");
		if(sFrame.style.display == 'block'){
			fncHiddenFrame();
		}else{
			document.getElementById("groupFrame").src=jsBaseContent+"/common/tree/drug-tree.action?queryDrugType="+code
								+"&selectValue="+this.hObj.value
								+"&objId="+objId
		    						+"&type="+type;
			var leftpos = obj.offsetLeft;
			var toppos = obj.clientHeight;
			do {
			   obj     =  obj.offsetParent;
			   leftpos += obj.offsetLeft-obj.scrollLeft;
			   toppos  += obj.offsetTop;
			}while(obj.offsetParent);			
			sFrame.style.top=toppos;
			//页面宽度为 760.隐藏frame宽度为 482，2者相差 278，加上 50像素的调优，故frame的left最大为 328
			sFrame.style.left= leftpos>328?328:leftpos;
			sFrame.style.display = 'block'
		}
	}
	/**
         * @type   : function
         * @access : public
         * @desc   : 药品分类单选
         * @param  :obj ：需要显示名字的控件。objId：需要保存分类id的控件。code：药品分类代码，详见上。funcName:选中后需要执行的function
         * @usage  : onClick="javascript: groupFrameViewRadio(this,'queryChinWest','S03');" 
         */
	
	function groupFrameViewRadio(obj,objId,code,funcName){
	    	if(obj)  this.hObjNm = obj;
	    	if(funcName)  this.func = eval(funcName);
	    	if(obj){
	    	    var obName= obj.parentNode.getElementsByTagName("INPUT");
	    	    for(var i=0;i<obName.length;i++){
	    		if(obName[i].id==objId){
	    		    this.hObj = obName[i];
	    		    break;
	    		}
	    	    }
	    	}
	    	
		var sFrame = document.getElementById("groupDiv");
		if(sFrame.style.display == 'block'){
			fncHiddenFrame();
		}else{
			document.getElementById("groupFrame").src=jsBaseContent+"/common/tree/drug-tree!radio.action?queryDrugType="+code
								+"&selectValue="+this.hObj.value
								+"&objId="+objId;
			var leftpos = obj.offsetLeft;
			var toppos = obj.clientHeight+10;
			do {
			   obj     =  obj.offsetParent;
			   leftpos += obj.offsetLeft-obj.scrollLeft;
			   toppos  += obj.offsetTop;
			}while(obj.offsetParent);			
			sFrame.style.top=toppos;
			//页面宽度为 760.隐藏frame宽度为 482，2者相差 278，加上 50像素的调优，故frame的left最大为 328
			sFrame.style.left= leftpos>328?328:leftpos;
			sFrame.style.display = 'block'
		}
	}
	/**
         * @type   : function
         * @access : public
         * @desc   : 选择后进行赋值，其中需要显示的分类名的规则是：分类id+Name
         * 		例如：
         *                 药物分类分类：  queryChinWest
         *                 药物分类分类名：queryChinWestName 	
         * @usage  : 
         */
	function showData(obj,res,resName){
		fncHiddenFrame();
		this.hObj.value=res;
		this.hObjNm.title=resName;
		this.hObjNm.value=resName;
		if(this.func) this.func();
	}
	////////////////////////////////药品分类树-查询用-end////////////////////////////////////////
	
    ////////////////////////////////查询条件的显示隐藏////////////////////////////////////////
    var type  = "none";
   
  	// 显示隐藏
    function fncShowHidden(obj,cls){
	   if(cls){
	      if(cls=='1'){
		  type  = "block";
	    }else{
		  type  = "none";   
	    }
	   }
	    var ul = obj.parentNode.childNodes[0];
	    if(type  == "block") type= "none";
	    else type  = "block";
	    if(type  == "block"){
		for(var k=0;k<document.getElementsByName("queryShowImgCLoseOpen").length;k++)
		    document.getElementsByName("queryShowImgCLoseOpen")[k].value='0';
	    	obj.src=jsBaseContent+"/images/pbf/h01_03_a.gif";
	    	obj.title="隐藏 ";
	    }
	    else{
		for(var k=0;k<document.getElementsByName("queryShowImgCLoseOpen").length;k++)
		    document.getElementsByName("queryShowImgCLoseOpen")[k].value='1';
	    	obj.src=jsBaseContent+"/images/pbf/h01_03_b.gif";
	    	obj.title="显示";
	    }
	    for(var i=2;i<ul.childNodes.length;i++)
	    	ul.childNodes[i].style.display = type;
	    
  	}