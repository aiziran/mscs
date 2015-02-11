function JsCalendarMonth() {
}

var jsCalendarMonth = new JsCalendarMonth();

/**
 * ȣ���� Object�� ����
 * @private
 */
JsCalendarMonth.prototype.target = null;
var target;




/**
 * @private
 */
JsCalendarMonth.prototype.stime = null;
var stime;



/**
 * @private
 */
JsCalendarMonth.prototype.sDash = null;
var sDash;

/**
 * @private
 */
JsCalendarMonth.prototype.callFuncName = null;
var callFuncName;



JsCalendarMonth.prototype.hideShowCovered = hideShowCovered;
/**
 * @private
 */
function hideShowCovered () {
	var tags = new Array("select");
	var el = document.all.minical;

	var p = getAbsolutePos(el);
	var EX1 = p.x;
	var EX2 = el.offsetWidth + EX1;
	var EY1 = p.y;
	var EY2 = el.offsetHeight + EY1;

	for (var k = tags.length; k > 0; ) {
		var ar = document.getElementsByTagName(tags[--k]);
		var cc = null;

		for (var i = ar.length; i > 0;) {
			cc = ar[--i];

			if(cc == document.all.cal_month || cc == document.all.cal_year) continue;

			p = getAbsolutePos(cc);
			var CX1 = p.x;
			var CX2 = cc.offsetWidth + CX1;
			var CY1 = p.y;
			var CY2 = cc.offsetHeight + CY1;

			if (this.hidden || (CX1 > EX2) || (CX2 < EX1) || (CY1 > EY2) || (CY2 < EY1)) {
				cc.style.visibility = "visible";
			} else {
				cc.style.visibility = "hidden";
			}
		}
	}
}




JsCalendarMonth.prototype.getAbsolutePos = getAbsolutePos;
/**
 * ��ü�� 'ġ��; ����(left, top f��)
 * @private
 */
function getAbsolutePos (el) {
	var r = { x: el.offsetLeft, y: el.offsetTop };
	if (el.offsetParent) {
		var tmp = getAbsolutePos(el.offsetParent);
		r.x += tmp.x;
		r.y += tmp.y;
	}
	return r;
}




JsCalendarMonth.prototype.CalendarMonth = CalendarMonth;
/**
 * �޷� ���<br>
 * &nbsp;&nbsp;(�� : <br>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;var obj = new Object();<br>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;now = new Date();<br>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;obj.value = now.getYear() + '-' + (now.getMonth()+1)+ '-' + now.getDate();<br>
 * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CalendarMonth(obj, theform.sDate ,'-'); <br>
 * &nbsp;&nbsp;)
 * @param {Object} obj ���� ����� (obj.value ��: 2005-8-16)
 * @param {Object} param form object
 * @param {String} dash ����� ������ ������(-)
 */
function CalendarMonth(obj, param, dash, funcName) {

	if (dash == 'undefined'){
		sDash= '';
	}else{
		sDash = dash;
	}

	var now = obj;
	var x, y;
	target = param; // Object ����;

	var p = getAbsolutePos(param);
	x = (document.layers) ? loc.pageX : p.x-5;
	y = (document.layers) ? loc.pageY : p.y + param.offsetHeight;
	//页面宽度为 760.隐藏div宽度 160，2者相差 500，加上 50像素的调优，故frame的left最大为 550
	x= x>550?550:x;
	// x = (document.layers) ? loc.pageX : event.clientX;
	// y = (document.layers) ? loc.pageY : event.clientY;
	minical.style.pixelTop	= y;
	minical.style.pixelLeft	= x;
	minical.style.display = (minical.style.display == "block") ? "none" : "block";
	if (now.value.length ==6) {														// dȮ���� �˻�
		Show_cal_month(now.value.substring(0,4),now.value.substring(4,6),0);											// �Ѿ�� ��; ����Ϸ� �и�
	} else {
		now = new Date();
		Show_cal_month(now.getFullYear(), now.getMonth()+1, now.getDate());			// ���� ��/��/��; ��d�Ͽ� �ѱ�.
	}

	callFuncName = funcName;
}




JsCalendarMonth.prototype.doOver = doOver;
/**
 * ���콺�� Į����'�� ��; ���
 * @private
 */
function doOver() {																// ���콺�� Į����'�� ��8��
	var el = window.event.srcElement;
	cal_Day = el.title;

	if (cal_Day.length > 7) {
		//el.style.Color = "#DAE2F2";
		//el.style.backgroundColor = "#6688CC";                                               // ���� ���� ��8��.
		el.style.borderTopColor = el.style.borderLeftColor = "#4D628C";
		el.style.borderRightColor = el.style.borderBottomColor = "#4D628C";
	}

	window.clearTimeout(stime);													// Clear
}




JsCalendarMonth.prototype.doClick = doClick_month;
/**
 * ���ڸ� �����Ͽ�; ���
 * @private
 */
function doClick_month() {															// ���ڸ� �����Ͽ�; ���
	//window.event.srcElement.style.Color = "#DAE2F2";
	//window.event.srcElement.style.backgroundColor = "#black";	                        // �׵θ� ��; ������8��
	window.event.srcElement.style.borderColor = "#4D628C";
	var month = parseInt(document.all.cal_month.value)<10?("0"+document.all.cal_month.value):document.all.cal_month.value;
	target.value=document.all.cal_year.value+month;
	
	minical.style.display='none';												// ȭ�鿡�� ���

	if( callFuncName != null && callFuncName.length > 0)
		if( eval( callFuncName  )!= null ) {
			eval( callFuncName + "(target);" );
	}

}




JsCalendarMonth.prototype.doOut = doOut;
/**
 * ���콺�� ��� ���
 * @private
 */
function doOut() {
	var el = window.event.fromElement;
	cal_Day = el.title;

	if (cal_Day.length > 7) {
		//el.style.backgroundColor = "#002266";
		el.style.borderColor = "#4D628C";
	}
	//stime=window.setTimeout("minical.style.display='none';", 200);
}



JsCalendarMonth.prototype.otherClick = otherClick;
/**
 * �޷¿����� �ƴѰ�; Ŭ���� ���
 * @private
 */
function otherClick() {
	var el = window.event.srcElement;
	if(el.name!='calbut' && el.name!='')
		minical.style.display='none';

}




JsCalendarMonth.prototype.day2 = day2;
/**
 * ��,��; 2�ڸ� ���ڷ� ����
 * @private
 */
function day2(d) {																// 2�ڸ� ���ڷ� ����
	var str = new String();

	if (parseInt(d) < 10) {
		str = "0" + parseInt(d);
	} else {
		str = "" + parseInt(d);
	}
	return str;
}




JsCalendarMonth.prototype.Show_cal_month = Show_cal_month;
/**
 * �޷� ���
 * @private
 * @param {String} sYear �⵵
 * @param {String} sMonth ��
 * @param {String} sDay ��
 */
function Show_cal_month(sYear, sMonth, sDay) {
	var Months_day = new Array(0,31,28,31,30,31,30,31,31,30,31,30,31)
	var Weekday_name = new Array('#res("sun")', '#res("mon")', '#res("tue")', '#res("wed")', '#res("thur")', '#res("fri")', '#res("sat")');
	var intThisYear = new Number(), intThisMonth = new Number(), intThisDay = new Number();
	document.all.minical.innerHTML = "";
	datToday = new Date();													// ���� ���� ��d
	intThisYear = parseInt(sYear);
	intThisMonth = parseInt(sMonth);
	intThisDay = parseInt(sDay);
	if (intThisYear == 0) intThisYear = datToday.getFullYear();				// ���� ��; ���
	if (intThisMonth == 0) intThisMonth = parseInt(datToday.getMonth())+1;	// �� ��: ��f�� ���� -1 �� ���� �ŵ��� ���.
	if (intThisDay == 0) intThisDay = datToday.getDate();

	switch(intThisMonth) {
		case 1:
				intPrevYear = intThisYear -1;
				intPrevMonth = 12;
				intNextYear = intThisYear;
				intNextMonth = 2;
				break;
		case 12:
				intPrevYear = intThisYear;
				intPrevMonth = 11;
				intNextYear = intThisYear + 1;
				intNextMonth = 1;
				break;
		default:
				intPrevYear = intThisYear;
				intPrevMonth = parseInt(intThisMonth) - 1;
				intNextYear = intThisYear;
				intNextMonth = parseInt(intThisMonth) + 1;
				break;
	}

	NowThisYear = datToday.getFullYear();										// ���� ��
	NowThisMonth = datToday.getMonth()+1;										// ���� ��
	NowThisDay = datToday.getDate();											// ���� ��

	datFirstDay = new Date(intThisYear, intThisMonth-1, 1);						// ���� ���� 1�Ϸ� ���� ��ü ��(��: 0���� 11������ d��(1����� 12��))
	intFirstWeekday = datFirstDay.getDay();										// ���� �� 1���� ����; ���� (0:�Ͽ���, 1:�����)

	intSecondWeekday = intFirstWeekday;
	intThirdWeekday = intFirstWeekday;

	datThisDay = new Date(intThisYear, intThisMonth, intThisDay);				// �Ѿ�� ���� ���� ��
	intThisWeekday = datThisDay.getDay();										// �Ѿ�� ������ �� ����

	varThisWeekday = Weekday_name[intThisWeekday];								// ���� ���� ����

	intPrintDay = 1																// ���� ���� ����
	secondPrintDay = 1
	thirdPrintDay = 1

	Stop_Flag = 0

	if ((intThisYear % 4)==0) {													// 4�⸶�� 1���̸� (��γ����� �������)
		if ((intThisYear % 100) == 0) {
			if ((intThisYear % 400) == 0) {
				Months_day[2] = 29;
			}
		} else {
			Months_day[2] = 29;
		}
	}
	intLastDay = Months_day[intThisMonth];										// ���� ���� ����
	Stop_flag = 0

	Cal_HTML = '<TABLE WIDTH=100% BORDER=0 CELLPADDING=0 CELLSPACING=0 ONMOUSEOVER=doOver(); ONMOUSEOUT=doOut(); STYLE=font-size:8pt;font-family:Tahoma;>'
			+ '<TR ALIGN=CENTER><TD COLSPAN=7 nowrap=nowrap ALIGN=CENTER><SPAN TITLE="以前" STYLE=cursor:hand; onClick=Show_cal_month('+intPrevYear+','+intPrevMonth+',1);><img src="/images/issm/body/bullet_prev.gif"></SPAN> '
			+ '<B STYLE=color:#A3B1CC>'+get_Yearinfo_month(intThisYear,intThisMonth,intThisDay)+'年'+get_Monthinfo_month(intThisYear,intThisMonth,intThisDay)+'月</B>'
			+ ' <SPAN TITLE="下一个" STYLE=cursor:hand; onClick=Show_cal_month('+intNextYear+','+intNextMonth+',1);><img src="/images/issm/body/bullet_next.gif"></SPAN><B STYLE=color:#A3B1CC STYLE=cursor:hand; title="" onClick="doClick_month()">选定时间</B></TD></TR>';
	Cal_HTML += "</TR>";
	Cal_HTML += "</TABLE>";
	
	document.all.minical.innerHTML = Cal_HTML;
}




JsCalendarMonth.prototype.get_Yearinfo_month = get_Yearinfo_month;
/**
 * �⵵�� �޺��ڽ��� ǥ��
 * @private
 * @param {String} year �⵵
 * @param {String} month ��
 * @param {String} day ��
 */
function get_Yearinfo_month(year, month, day) {											// �� d���� �޺� �ڽ��� ǥ��
	var min = parseInt(year) - 10;
	var max = parseInt(year) + 5;
	var i = new Number();
	var str = new String();
	if ( min <=0 ) {
		min = 1;
	}

	str = "<SELECT id='cal_year' onChange='Show_cal_month(this.value,"+month+","+day+");' ONMOUSEOVER=doOver();>";
	for (i=min; i<=max; i++) {
		if (i == parseInt(year)) {
			str += "<OPTION VALUE="+i+" selected ONMOUSEOVER=doOver();>"+i+"</OPTION>";
		} else {
			str += "<OPTION VALUE="+i+" ONMOUSEOVER=doOver();>"+i+"</OPTION>";
		}
	}
	str += "</SELECT>";
	return str;
}




JsCalendarMonth.prototype.get_Monthinfo_month = get_Monthinfo_month;
/**
 * �� d���� �޺��ڽ��� ǥ��
 * @private
 * @param {String} year �⵵
 * @param {String} month ��
 * @param {String} day ��
 */
function get_Monthinfo_month(year, month, day) {										// �� d���� �޺� �ڽ��� ǥ��
	var i = new Number();
	var str = new String();

	str = "<SELECT id='cal_month' onChange='Show_cal_month("+year+",this.value,"+day+");' ONMOUSEOVER=doOver();>";
	for (i=1; i<=12; i++) {
		if (i == parseInt(month)) {
			str += "<OPTION VALUE="+i+" selected ONMOUSEOVER=doOver();>"+i+"</OPTION>";
		} else {
			str += "<OPTION VALUE="+i+" ONMOUSEOVER=doOver();>"+i+"</OPTION>";
		}
	}
	str += "</SELECT>";
	return str;
}




/**
 * Key Code List
 * @private
 */
JsCalendarMonth.prototype.lastKeyCodeList = new Array(0, 49, 56, 49, 48, 49, 48, 49, 49, 48, 49, 48, 49);
//var lastKeyCodeList = new Array(0, 49, 56, 49, 48, 49, 48, 49, 49, 48, 49, 48, 49);




JsCalendarMonth.prototype.f_checkDateFormat = f_checkDateFormat;
/**
 * ��¥ �Է½� �ڵ�8�� ������(-) �߰�
 * @private
 * @param {Object} obj from object
 */
function f_checkDateFormat(obj) {

	if (event.keyCode == 8)	return;
	var val = obj.value;

	var ref = /-/g;
	val = val.replace(ref,"");

	checkDateKeyInDash(val);

	var chr = "";
	for(var i=0 ; i < val.length ; i++ )
	{
		chr = val.charAt(i);
		if ( !( chr >= '0' && chr <= '9' ) ) {
			val = val.substring(0,i);
			obj.blur();
			obj.focus();
			break;
		}
	}

	if (val.length >= 6) {
		val = val.substring(0,4) + "-" + val.substring(4,6) + "-" + val.substring(6,val.length);
	} else if (val.length >= 4) {
		val = val.substring(0,4) + "-" + val.substring(4,val.length);
	}

	obj.value = val;

}




JsCalendarMonth.prototype.checkDateKeyInDash = checkDateKeyInDash;
/**
 * ��¥�˻�
 * @private
 * @param {String} value ���
 * @type boolean
 */
function checkDateKeyInDash(value) {

	var year;
	var month;

	if (event.keyCode == 13 || event.keyCode == 9) {
		event.returnValue = true;
	} else {
		if (event.keyCode < 48 || event.keyCode > 57) {
			event.returnValue = false;
		}

		if (value.length >= 6) {
			year = parseInt(value.substring(0, 4));
			if (value.charAt(4) == '0') {
				month = parseInt(value.substring(5, 6));
			}
			else {
				month = parseInt(value.substring(4, 6));
			}
		}

		switch (value.length) {
			case 0:
				if (event.keyCode < 49 || event.keyCode > 50) {
					event.returnValue = false;
				}
			break;
			case 3:
				if (parseInt(value.substring(0, 3)) == 0) {
					if (event.keyCode == 48) {
						event.returnValue = false;
					}
				}
			break;
			case 4:
				if (event.keyCode < 48 || event.keyCode > 49) {
					event.returnValue = false;
				}
			break;
			case 5:
				if (value.charAt(4) == '1') {
					if (event.keyCode < 48 || event.keyCode > 50) {
						event.returnValue = false;
					}
				}
				else if (value.charAt(4) == '0') {
					if (event.keyCode == 48) {
						event.returnValue = false;
					}
				}
			break;
			case 6:
				if (event.keyCode < 48 || event.keyCode > 51) {
					event.returnValue = false;
				}
				if (month == 2) {
					if (event.keyCode < 48 || event.keyCode > 50) {
						event.returnValue = false;
					}
				}
			break;
			case 7:
				if (month != 2) {
					if (value.charAt(6) >= '3') {
						if (event.keyCode > lastKeyCodeList[month]) {
							event.returnValue = false;
						}
					}
				}
				else {
					if (value.charAt(6) >= '2') {
						if (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) {
							if (event.keyCode > lastKeyCodeList[month] + 1) {
								event.returnValue = false;
							}
						}
						else if (event.keyCode > lastKeyCodeList[month]) {
							event.returnValue = false;
						}
					}
					else if (value.charAt(6) == '0' && event.keyCode == 48) {
						event.returnValue = false;
					}
				}
			break;
			case 8:
				event.returnValue = false;
			break;

		}
	}
}


JsCalendarMonth.prototype.callCalendarMonth = callCalendarMonth;
/**
 * �޷� ���
 * @private
 * @param {String} frmObj form input ��ü
 * @param {String} delimeter ����� ������(default '-')
 * @type 
 */
function callCalendarMonth(frmObj, delimeter) {
  	if(delimeter == undefined){
  		delimeter = '-';
  	}
  	var dt = frmObj.value;
  	var obj = new Object();

  	if(dt == '') {
		now = new Date();
  		obj.value = now.getYear() + '-' + (now.getMonth()+1)+ '-' + now.getDate();
  	} else {
		obj.value = dt;
  	}
  	CalendarMonth(obj, frmObj, delimeter);  //2005-12-12 ���࿡ /�� �ְ� �ʹٸ� '-'��ſ� �Ķ���͸� '/'��8�ø� 2005/12/12 �˴ϴ�.
}

function Show_StYear() {
	var year = new Number(), month = new Number(), day = new Number();
	now = new Date();
	year = parseInt(now.getFullYear());
	month = parseInt(now.getMonth()+1);
	day = parseInt(now.getDate()-7);

	var min = parseInt(year) - 100;
	var max = parseInt(year) + 10;
	var i = new Number();
	var str = new String();

	str = "<SELECT id='ComboStYear'>";
	for (i=min; i<=max; i++) {
		if (i == parseInt(year)) {
			str += "<OPTION VALUE="+i+" selected>"+i+"</OPTION>";
		} else {
			str += "<OPTION VALUE="+i+">"+i+"</OPTION>";
		}
	}
	str += "</SELECT>";

	document.all.regStDate.style.display="none";
	document.all.stBtn.style.display="none";
	document.all.StDate.style.display="";
	document.all.StDate.innerHTML=str;
}

function Show_EdYear() {
	var year = new Number(), month = new Number(), day = new Number();
	now = new Date();
	year = parseInt(now.getFullYear());
	month = parseInt(now.getMonth()+1);
	day = parseInt(now.getDate());

	var min = parseInt(year) - 100;
	var max = parseInt(year) + 10;
	var i = new Number();
	var str = new String();

	str = "<SELECT id='ComboEdYear'>";
	for (i=min; i<=max; i++) {
		if (i == parseInt(year)) {
			str += "<OPTION VALUE="+i+" selected>"+i+"</OPTION>";
		} else {
			str += "<OPTION VALUE="+i+">"+i+"</OPTION>";
		}
	}
	str += "</SELECT>";

	document.all.regEdDate.style.display="none";
	document.all.edBtn.style.display="none";
	document.all.EdDate.style.display="";
	document.all.EdDate.innerHTML=str;
}

function Show_diffStYear() {
	var year = new Number(), month = new Number(), day = new Number();
	now = new Date();
	year = parseInt(now.getFullYear());
	month = parseInt(now.getMonth()+1);
	day = parseInt(now.getDate()-7);

	var min = parseInt(year) - 100;
	var max = parseInt(year) + 10;
	var i = new Number();
	var str = new String();

	str = "<SELECT id='ComboDiffStYear'>";
	for (i=min; i<=max; i++) {
		if (i == parseInt(year)) {
			str += "<OPTION VALUE="+i+" selected>"+i+"</OPTION>";
		} else {
			str += "<OPTION VALUE="+i+">"+i+"</OPTION>";
		}
	}
	str += "</SELECT>";

	document.all.diffStDate.style.display="none";
	document.all.compStBtn.style.display="none";
	document.all.compStDate.style.display="";
	document.all.compStDate.innerHTML=str;
}

function Show_diffEdYear() {
	var year = new Number(), month = new Number(), day = new Number();
	now = new Date();
	year = parseInt(now.getFullYear());
	month = parseInt(now.getMonth()+1);
	day = parseInt(now.getDate());

	var min = parseInt(year) - 100;
	var max = parseInt(year) + 10;
	var i = new Number();
	var str = new String();

	str = "<SELECT id='ComboDiffEdYear'>";
	for (i=min; i<=max; i++) {
		if (i == parseInt(year)) {
			str += "<OPTION VALUE="+i+" selected>"+i+"</OPTION>";
		} else {
			str += "<OPTION VALUE="+i+">"+i+"</OPTION>";
		}
	}
	str += "</SELECT>";

	document.all.diffEdDate.style.display="none";
	document.all.compEdBtn.style.display="none";
	document.all.compEdDate.style.display="";
	document.all.compEdDate.innerHTML=str;
}

function Show_StQuarter() {
	var quarter = new Number();
	now = new Date();
	quarter = parseInt((now.getMonth()+1)/4) + 1;

	var i = new Number();
	var str = new String();

	str = "<SELECT id='ComboStQuarter'>";
	for (i=1; i<=4; i++) {
		if (i == quarter) {
			str += "<OPTION VALUE="+i+" selected>"+i+"</OPTION>";
		} else {
			str += "<OPTION VALUE="+i+">"+i+"</OPTION>";
		}
	}
	str += "</SELECT>";

	document.all.regStDate.style.display="none";
	document.all.stBtn.style.display="none";
	document.all.StDate.innerHTML+= "&nbsp;&nbsp;" + str;
}

function Show_EdQuarter() {
	var quarter = new Number();
	now = new Date();
	quarter = parseInt((now.getMonth()+1)/4) + 1;

	var i = new Number();
	var str = new String();

	str = "<SELECT id='ComboEdQuarter'>";
	for (i=1; i<=4; i++) {
		if (i == quarter) {
			str += "<OPTION VALUE="+i+" selected>"+i+"</OPTION>";
		} else {
			str += "<OPTION VALUE="+i+">"+i+"</OPTION>";
		}
	}
	str += "</SELECT>";

	document.all.regEdDate.style.display="none";
	document.all.edBtn.style.display="none";
	document.all.EdDate.innerHTML+= "&nbsp;&nbsp;" + str;
}

function Show_diffStQuarter() {
	var quarter = new Number();
	now = new Date();
	quarter = parseInt((now.getMonth()+1)/4) + 1;

	var i = new Number();
	var str = new String();

	str = "<SELECT id='ComboDiffStQuarter'>";
	for (i=1; i<=4; i++) {
		if (i == parseInt(month)) {
			str += "<OPTION VALUE="+i+" selected>"+i+"</OPTION>";
		} else {
			str += "<OPTION VALUE="+i+">"+i+"</OPTION>";
		}
	}
	str += "</SELECT>";

	document.all.regStDate.style.display="none";
	document.all.compStBtn.style.display="none";
	document.all.compStDate.innerHTML+= "&nbsp;&nbsp;" + str;
}

function Show_diffEdQuarter() {
	var quarter = new Number();
	now = new Date();
	quarter = parseInt((now.getMonth()+1)/4) + 1;

	var i = new Number();
	var str = new String();

	str = "<SELECT id='ComboDiffEdQuarter'>";
	for (i=1; i<=4; i++) {
		if (i == quarter) {
			str += "<OPTION VALUE="+i+" selected>"+i+"</OPTION>";
		} else {
			str += "<OPTION VALUE="+i+">"+i+"</OPTION>";
		}
	}
	str += "</SELECT>";

	document.all.regEdDate.style.display="none";
	document.all.compEdBtn.style.display="none";
	document.all.compEdDate.innerHTML+= "&nbsp;&nbsp;" + str;
}

function Show_StMonth() {
	var month = new Number();
	now = new Date();
	month = parseInt(now.getMonth()+1);

	var i = new Number();
	var str = new String();

	str = "<SELECT id='ComboStMonth'>";
	for (i=1; i<=12; i++) {
		if (i == parseInt(month)) {
			i = day2(i)
			str += "<OPTION VALUE="+i+" selected>"+i+"</OPTION>";
		} else {
			i = day2(i)
			str += "<OPTION VALUE="+i+">"+i+"</OPTION>";
		}
	}
	str += "</SELECT>";

	document.all.regStDate.style.display="none";
	document.all.stBtn.style.display="none";
	document.all.StDate.innerHTML+= "&nbsp;&nbsp;" + str;
}

function Show_EdMonth() {
	var month = new Number();
	now = new Date();
	month = parseInt(now.getMonth()+1);

	var i = new Number();
	var str = new String();

	str = "<SELECT id='ComboEdMonth'>";
	for (i=1; i<=12; i++) {
		if (i == parseInt(month)) {
			i = day2(i)
			str += "<OPTION VALUE="+i+" selected>"+i+"</OPTION>";
		} else {
			i = day2(i)
			str += "<OPTION VALUE="+i+">"+i+"</OPTION>";
		}
	}
	str += "</SELECT>";

	document.all.regEdDate.style.display="none";
	document.all.edBtn.style.display="none";
	document.all.EdDate.innerHTML+= "&nbsp;&nbsp;" + str;
}

function Show_diffStMonth() {
	var month = new Number();
	now = new Date();
	month = parseInt(now.getMonth()+1);

	var i = new Number();
	var str = new String();

	str = "<SELECT id='ComboDiffStMonth'>";
	for (i=1; i<=12; i++) {
		if (i == parseInt(month)) {
			i = day2(i)
			str += "<OPTION VALUE="+i+" selected>"+i+"</OPTION>";
		} else {
			i = day2(i)
			str += "<OPTION VALUE="+i+">"+i+"</OPTION>";
		}
	}
	str += "</SELECT>";

	document.all.regStDate.style.display="none";
	document.all.compStBtn.style.display="none";
	document.all.compStDate.innerHTML+= "&nbsp;&nbsp;" + str;
}

function Show_diffEdMonth() {
	var month = new Number();
	now = new Date();
	month = parseInt(now.getMonth()+1);

	var i = new Number();
	var str = new String();

	str = "<SELECT id='ComboDiffEdMonth'>";
	for (i=1; i<=12; i++) {
		if (i == parseInt(month)) {
			i = day2(i)
			str += "<OPTION VALUE="+i+" selected>"+i+"</OPTION>";
		} else {
			i = day2(i)
			str += "<OPTION VALUE="+i+">"+i+"</OPTION>";
		}
	}
	str += "</SELECT>";

	document.all.regEdDate.style.display="none";
	document.all.compEdBtn.style.display="none";
	document.all.compEdDate.innerHTML+= "&nbsp;&nbsp;" + str;
}

function Hide_StYear() {
	document.all.StDate.style.display="none";
	document.all.regStDate.style.display="";
	document.all.stBtn.style.display="";
}

function Hide_EdYear() {
	document.all.EdDate.style.display="none";
	document.all.regEdDate.style.display="";
	document.all.edBtn.style.display="";
}

function Hide_diffStYear() {
	document.all.compStDate.style.display="none";
	document.all.diffStDate.style.display="";
	document.all.compStBtn.style.display="";
}

function Hide_diffEdYear() {
	document.all.compEdDate.style.display="none";
	document.all.diffEdDate.style.display="";
	document.all.compEdBtn.style.display="";
}

function Hide_StMonth() {
	document.all.StDate.style.display="none";
	document.all.regStDate.style.display="";
	document.all.stBtn.style.display="";
}

function Hide_EdMonth() {
	document.all.EdDate.style.display="none";
	document.all.regEdDate.style.display="";
	document.all.edBtn.style.display="";
}

function Hide_diffStMonth() {
	document.all.compStDate.style.display="none";
	document.all.regStDate.style.display="";
	document.all.compStBtn.style.display="";
}

function Hide_diffEdMonth() {
	document.all.compEdDate.style.display="none";
	document.all.regEdDate.style.display="";
	document.all.compEdBtn.style.display="";
}

function Hide_Ed()
{
	document.all.TermString.style.display="none";
	
	document.all.EdDate.style.display="none";
	document.all.regEdDate.style.display="none";
	document.all.edBtn.style.display="none";

	document.all.EdDate.style.display="none";
	document.all.regEdDate.style.display="none";
	document.all.edBtn.style.display="none";
}

function Hide_diffEd()
{
	document.all.compTermString.style.display="none";
	
	document.all.compEdDate.style.display="none";
	document.all.diffEdDate.style.display="";
	document.all.compEdBtn.style.display="";

	document.all.compEdDate.style.display="none";
	document.all.regEdDate.style.display="none";
	document.all.compEdBtn.style.display="none";
}

function getLastDay(year,month) {
	var Months_day = new Array(0,31,28,31,30,31,30,31,31,30,31,30,31)
	month = parseInt(month * 10 / 10);

	if ((year % 4)==0) {													// 4�⸶�� 1���̸� (��γ����� �������)
		if ((year % 100) == 0) {
			if ((year % 400) == 0) {
				Months_day[2] = 29;
			}
		} else {
			Months_day[2] = 29;
		}
	}
	intLastDay = Months_day[month];										// ���� ���� ����
	return intLastDay;
}