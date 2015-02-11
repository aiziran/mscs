String.prototype.trim = function() {
	return this.replace(/(^[\s]*)|([\s]*$)/g, "");
}

function StringToption(str) {
	var Options = str.split("|");
	var len = Options.length;
	for ( var i = 0; i < len; i++) {
		document.write("<option value='" + Options[i] + "'>" + Options[i]
				+ "</option>");
	}

}

function chk_one_input(v_obj, v_msg) {
	if (v_msg == null) {
		v_msg = "";
	}
	if (v_obj.value.trim() == '') {
		alert(v_msg + "不能为空!");
		v_obj.focus();
		return false;
	}
	if (isNaN(v_obj.value)) {
		alert(v_msg + "必须为数字!");
		v_obj.focus();
		return false;
	}

	if (parseFloat(v_obj.value) < 0) {
		alert(v_msg + "必须为正数!");
		v_obj.focus();
		return false;
	}
	return true;
}

function f_write_yhmc() {
	var str = "不限|中国工商银行|招商银行|中国农业银行|中国建设银行|中国银行|中国民生银行|中国光大银行|中信银行|交通银行";
	str += "|兴业银行|上海浦东发展银行|华夏银行|广东发展银行|深圳发展银行|北京银行|上海银行|宁波银行|南京银行|中国邮政储蓄银行|花旗银行";
	str += "|汇丰银行|渣打银行|东亚银行|恒生银行|华侨银行|荷兰银行|浙商银行";
	StringToption(str);
}
function f_write_szdq() {
	var str = "全国|北京|上海|天津|重庆|河北|山西|内蒙古|辽宁|吉林|黑龙江|江苏|浙江|安徽|福建|江西|山东|河南|湖北|湖南|广东|广西|海南|四川|贵州|云南|西藏|陕西|甘肃|青海|宁夏|新疆";
	StringToption(str);
}

function f_write_anqaun() {
	var str = "不限|保本|保收益|即不保本也不保收益";
	StringToption(str);
}
function f_write_sylx() {
	var str = "任意|固定|浮动";
	StringToption(str);
}
function f_write_tzqx() {
	var str = "不限|于1年|1~3年(含3年)|3~5年(含5年)|5年以上";
	StringToption(str);
}
function f_write_qwsy() {
	var str = "任意|0~3%(含3%)|3~5%(含5%)|5~10%(含10%)|10%以上";
	StringToption(str);
}
function f_write_tzaq() {
	var str = "不限|守储蓄型|投资进取型|风险投机型";
	StringToption(str);
}
function f_write_whlc() {
	var str = "不限|中国工商银行|招商银行|中国农业银行|中国建设银行|中国银行|中国民生银行|中国光大银行|中信银行|交通银行|兴业银行|上海浦东发展银行|华夏银行| 广东发展银行|深圳发展银行|北京银行|上海银行|宁波银行|南京银行|中国邮政储蓄银行|花旗银行|汇丰银行|渣打银行|东亚银行|恒生银行|华侨银行|荷兰银行";
	StringToption(str);
}
function f_write_bizh() {
	var str = "不限|人民币|美元|港币|欧元|加拿大元|日元|瑞士法郎|英镑|澳元|新加坡元|澳大利亚元";
	StringToption(str);
}
function f_write_fksyyh() {
	var str = "不限|中国工商银行|中国建设银行|中国农业银行|交通银行|中国银行|招商银行|中国光大银行|中信银行|华夏银行|深圳发展银行|浦发银行|广东发展银行|上海银行|北京银行|民生银行|国家邮政储汇局|恒丰银行|AE(Amercian Express)|JCB|VISA|兴业银行|深圳市商业银行|花旗银行|宁波市商业银行|成都市农村信用社|厦门市农村信用合作社|江苏省农村信用社|武汉农信联社|沧州商业银行|南宁市商业银行|广州发展银行|石家庄市商业银行|宁波鄞州银行";
	StringToption(str);
}
function f_write_yhklx() {
	f_write_xyklx();
}
function f_write_xyklx() {
	var str = "不限|借记卡|信用卡";
	StringToption(str);
}
function f_write_yhkdj() {
	var str = "不限|普卡|金卡|白金卡|钻石卡";
	StringToption(str);
}
function f_write_yhknf() {
	var str = "不限|0-180元|180元-360元|360元以上";
	StringToption(str);
}

function f_write_ckcpyh() {
	var str = "不限|中国工商银行|招商银行|中国农业银行|中国建设银行|中国银行|中国民生银行|中国光大银行|中信银行|交通银行|兴业银行|上海浦东发展银行|华夏银行| 广东发展银行|深圳发展银行|北京银行|上海银行|宁波银行|南京银行|中国邮政储蓄银行|花旗银行|汇丰银行|渣打银行|东亚银行|恒生银行|华侨银行|荷兰银行";
	StringToption(str);
}
function f_write_ckcpbz() {
	var str = "人民币|美元|港币|欧元|加拿大元|日元|瑞士法郎|英镑|澳元|新加坡元|台币";
	StringToption(str);
}
function f_write_ckcpzl() {
	var str = "不限|活期储蓄|定期|整存整取|零存整取|整存零取|存本取息|通知存款|本外币一本通定期储蓄存款|外币定期储蓄存款|教育储蓄|定活两便储蓄|储蓄服务|外币协议储蓄";
	StringToption(str);
}

function f_write_dkcpzl() {
	var str = "不限|住房贷款|汽车贷款|创业贷款|保证贷款|自助贷款|质押贷款|教育助学贷款|综合消费贷款|信用贷款|个人委托贷款|法人账户透支";
	StringToption(str);
}
function f_write_dkcpyh() {
	var str = "不限|中国工商银行|招商银行|中国农业银行|中国建设银行|中国银行|中国民生银行|中国光大银行|中信银行|交通银行|兴业银行|上海浦东发展银行|华夏银行| 广东发展银行|深圳发展银行|北京银行|上海银行|宁波银行|南京银行|中国邮政储蓄银行|花旗银行|汇丰银行|渣打银行|东亚银行|恒生银行|华侨银行|荷兰银行|巴黎银行";
	StringToption(str);
}

function f_write_dzcpyh() {
	var str = "不限|中国工商银行|招商银行|中国农业银行|中国建设银行|中国银行|中国民生银行|中国光大银行|中信银行|交通银行|兴业银行|上海浦东发展银行|华夏银行| 广东发展银行|深圳发展银行|北京银行|上海银行|宁波银行|南京银行|中国邮政储蓄银行|花旗银行|汇丰银行|渣打银行|东亚银行|恒生银行|华侨银行|荷兰银行";
	StringToption(str);
}
function f_write_dzcpzl() {
	var str = "不限|网上银行|电话银行|家居银行|掌上银行|手机银行|自助银行|短信通知服务";
	StringToption(str);
}

function f_write_zjywyh() {
	var str = "不限|中国工商银行|招商银行|中国农业银行|中国建设银行|中国银行|中国民生银行|中国光大银行|浙商银行|中信银行|交通银行|兴业银行|上海浦东发展银行|华夏银行| 广东发展银行|深圳发展银行|北京银行|南京商业银行|上海银行|宁波银行|南京银行|中国邮政储蓄银行|花旗银行|汇丰银行|渣打银行|东亚银行|恒生银行|华侨银行|荷兰银行|巴黎银行|恒丰银行";
	StringToption(str);
}
function f_write_zjywzl() {
	var str = "不限|代收代付业务|代理保险业务|代销开放式基金|代理、兑付凭证式国债|银证转帐|银证通业务|代理信托业务|柜台记账式债券交易|个人外汇买卖业务|支付结算中间业务|中间业务组合服务|存款证明业务|外币携带证业务|账户证明书|汇款业务|托收业务|个人结算账户|个人支票账户|汇入汇出汇款|外币兑换|因私购买外汇|代缴费业务|买入外币票据|保管箱|出国金融服务|理财咨询服务";
	StringToption(str);
}
var $C = function(tag) {
	return document.createElement(tag);
}
var $N = function(s) {
	return document.getElementsByName(s);
}

var $ = function(s) {
	return document.getElementById(s);
}

var Url = {
	getVar : function(name) {
		var reg = new RegExp("(&|\\u003F)" + name + "=([^&]*)(&|$)")
		var arr = window.location.href.match(reg);

		if (arr != null) {
			return arr[2];
		}

		return null;
	}
};

function onstartsearch(name, form, selectvalue, index) {
	var names = $N(name);
	var formx = $(form)
	var len = names.length;
	var listvalue = new Array();
	var listtext = new Array();
	var name = $(selectvalue + index).value.split("|");

	for ( var i = 0; i < len; i++) {
		var value = names[i].options[names[i].selectedIndex].value;
		if (value != "不限" && value != "任意") {
			listvalue.push(value);
			listtext.push(name[i])
		}
	}

	$("libid").value = $("libid" + index).value;
	$("orderby").value = $("orderby" + index).value
	$("FilterValueAND").value = listvalue.join("|");
	$("FilterAttrAND").value = listtext.join("|");
	// lert($("FilterValueAND").value+" "+$("FilterAttrAND").value);
	formx.action = formx.action + "?t=" + index;
	formx.submit();
}
function preonstartsearch() {

	if ($("tzbz").value != "人民币") {
		onstartsearch('ckcp5', 'formx', 'selectvalue', 5);
	} else {
		onstartsearch('ckcp5', 'formx', 'selectvalue', 6);
	}
}

function onclicklink(obj, libid, keyword, values) {
	if ($(values).value != "") {
		obj.href = "/cgi-bin/search?libid=" + libid + "&orderby=F" + keyword
				+ "&FilterAttrAND=" + keyword + "&FilterValueAND="
				+ $(values).value
	} else {
		alert("请输入查询关键字!")
		$(values).focus();
		obj.href = "javascript:void(0)";
	}

}

function fonclicklink(obj) {

	if ($("tzbz").value != "人民币") {

		onclicklink(obj, 91, '2156', 'key6');
	} else {
		onclicklink(obj, 94, '2155', 'key6');
	}

}

function object_table(name, bank, renqi) {
	this.renqi = renqi;
	this.name = name;
	this.bank = bank;
}
function create_table(name1, name2, name3) {

	var td1 = $(name1);
	var td2 = $(name2);
	var td3 = $(name3);
	var arraylist1 = new Array();
	var arraylist2 = new Array();
	sys_table(arraylist1, td1);
	sys_table(arraylist2, td2);
	sort_table(arraylist1, arraylist2, td3);

}
function sys_table(array, parent) {
	var obj = parent.childNodes;
	var len = obj.length;
	var newobject = null;
	for ( var i = 0; i < len; i++) {
		newobject = new object_table(obj[i].childNodes[1].innerHTML,
				obj[i].childNodes[2].innerHTML, obj[i].childNodes[3].innerHTML);
		array.push(newobject);
	}

}
function sort_table(array1, array2, td3) {
	var len = array2.length;
	for ( var i = 0; i < len; i++) {
		array1 = shift_table(array1, array2[i]);
	}

	showpaihangtable(array1, td3)

}

function shift_table(array, key) {
	var len = array.length;
	var newarray = new Array();
	var ispop = false;
	for ( var i = 0; i < len; i++) {
		if (parseFloat(check_istrue(array[i].renqi)) <= parseFloat(check_istrue(key.renqi))) {
			if (!ispop) {
				newarray.push(key);
				ispop = true;
			}
		}
		newarray.push(array[i]);

	}
	return newarray.slice(0, 5);
}
function check_istrue(str) {
	return str.split("%")[0];
}

function showpaihangtable(array, td) {

	for ( var i = 0; i < array.length; i++) {

		createpaihangtable(array[i], td);
	}

}
function createpaihangtable(newobj, tdobj) {
	var tr = $C("tr");
	var td1 = $C("td");
	var td2 = $C("td");
	var td3 = $C("td");
	var td4 = $C("td");
	td1.height = "23";
	td2.className = "zpbcssleft pl3";
	td3.className = "zpbcsscenter";
	td4.className = "zpbcsscenter";
	td2.innerHTML = newobj.name;
	td3.innerHTML = newobj.bank;
	td4.innerHTML = newobj.renqi;
	tr.appendChild(td1);
	tr.appendChild(td2);
	tr.appendChild(td3);
	tr.appendChild(td4);
	tdobj.appendChild(tr)

}

function getmyurltormb(obj, index) {
	if (index == 1) {
		obj.href = "/cgi-bin/search?libid=94&orderby=F2107&FilterValueAND="
				+ obj.innerHTML + "&FilterAttrAND=2107";

	} else if (index == 2) {
		obj.href = "/cgi-bin/search?libid=91&orderby=F2042&FilterValueAND="
				+ obj.innerHTML + "&FilterAttrAND=2042";

	} else {
		obj.href = "/cgi-bin/search?libid=15&oderby=F339&FilterValueAND="
				+ obj.innerHTML + "&FilterAttrAND=339";

	}

}

function pagerun(maxpage, curpage, id) {
	var td = $(id);
	var span;
	var str = window.location + "";

	if (str.indexOf("CurPage") != -1) {
		str = str.split("CurPage")[0];
	} else {
		str += "&";
	}
	for ( var i = 1; i < (maxpage + 1); i++) {
		span = $C("div");
		span.className = "page";
		if (i != curpage) {
			span.innerHTML = "[<a href=" + str + "CurPage=" + i + ">" + i
					+ "</a>]";
		} else {
			span.innerHTML = "[<font color='#ff0000'>" + i + "</font>]";
		}
		td.appendChild(span);

	}

}

function checkall(obj, values, name, page, type) {
	var value = obj.value + "," + values
	var allcookies = getCookie(name);
	if (allcookies == null) {
		allcookies = "";
	}

	if (obj.checked) {
		var checkboxs = allcookies.split("|");
		var len = checkboxs.length;
		if (len > 5) {
			obj.checked = false;
			alert("对不起,最多只能选择5项进行比较,请查看已选产品列表!");
			return false;
		} else {
			var parent = obj.parentNode;
			parent.innerHTML = "<font color='red'>*</font>" + parent.innerHTML;

			if (allcookies) {
				if (allcookies.indexOf(value) == -1) {
					delCookie(name);
					allcookies = allcookies + value + "|";
					setCookie(name, allcookies)
				}
			} else {
				setCookie(name, value + "|");

			}

			createlist(value, page, type, name); // alert($(obj.value+"")).id
		}
	} else {

		if (allcookies) {
			if (allcookies.indexOf(value) != -1) {
				var strs = allcookies.split(value + "|");
				delCookie(name);
				setCookie(name, strs[0] + strs[1])
			}
		}

		var parent = obj.parentNode;
		parent.removeChild(parent.firstChild);
		var listobj = $(obj.value);
		listobj.parentNode.removeChild(listobj);

	}
	$("showproduct").className = "show";
	$("showall").innerHTML = "产品列表已展开(点击隐藏)";
}
function showproduct(obj) {
	var showproduct = $("showproduct");
	if (showproduct.className == "hide") {
		showproduct.className = "show";
		obj.innerHTML = "产品列表已展开(点击隐藏)";
	} else {
		showproduct.className = "hide";
		obj.innerHTML = "产品列表已隐藏(点击展开)";

	}

}
function openwindow(name, page, index) {
	var div = $C("ul");
	document.body.appendChild(div);
	div.className = "openwindow";
	div.id = "comparewindow";
	div.innerHTML = '<div style="color:#ff0000;font-size:14px;cursor:pointer;" onclick="showproduct(this)" id="showall">产品列表已隐藏(点击展开)</div><div class="hide" id="showproduct"><ol  id="list"></ol><p align="center"><a href="javascript:void(0)" onclick="compareopen(this,\''
			+ name
			+ '\')"><img src="http://mat1.qq.com/finance/bank/botton_03.gif" width="53"height="22"></a></div>';

	setInterval("autowidth()", 100);

	var allcookies = getCookie(name);
	if (allcookies) {
		var checkboxs = $N("checkbox");
		var len = checkboxs.length;
		var arraylist;
		for ( var i = 0; i < len; i++) {
			arraylist = syscookie(allcookies);
			for ( var j = 0; j < arraylist.length; j++) {
				if (arraylist[j] == checkboxs[i].value) {
					checkboxs[i].checked = true;
					var parent = checkboxs[i].parentNode;
					parent.innerHTML = "<font color='red'>*</font>"
							+ parent.innerHTML;
				}
			}
		}
		createAllist(allcookies, page, index, name);

	}

}

function delchoose(obj, name, values) {
	var allcookies = getCookie(name);
	var parent = obj.parentNode;
	var id = parent.id;
	var value = id + "," + values;
	parent.parentNode.removeChild(parent);
	if (allcookies) {
		if (allcookies.indexOf(value) != -1) {
			var strs = allcookies.split(value + "|");
			delCookie(name);
			setCookie(name, strs[0] + strs[1])
		}
	}
	var checkbox = $N("checkbox");
	var len = checkbox.length;
	var obj;
	if (len > 0) {
		for ( var i = 0; i < len; i++) {
			if (checkbox[i].value == id) {
				checkbox[i].checked = false;
				obj = checkbox[i].parentNode;
				obj.removeChild(obj.firstChild);

			}
		}
	}

}
function createlist(list, type, index, name) {

	var strs = list.split(",");
	var li = $C("li");
	$("list").appendChild(li);
	li.id = strs[0];
	li.innerHTML = "<img border='0' style='margin-right:5px;width:10px;height:10px;cursor:pointer;' onclick='delchoose(this,\""
			+ name
			+ "\",\""
			+ strs[1]
			+ "\")' title='删除此行' src='http://mat1.qq.com/finance/bank/close.jpg' /><a href='/"
			+ type
			+ "/"
			+ strs[0]
			+ "/"
			+ index
			+ ".shtml' target='_blank' title='序号:"
			+ strs[0]
			+ "'>"
			+ strs[1]
			+ "</a>";

}
function createAllist(allcookies, type, index, name) {

	var strs = allcookies.split("|");
	for ( var i = 0; i < strs.length - 1; i++) {
		createlist(strs[i], type, index, name);
	}

}

function syscookie(cookie) {
	var strs, arraylist = [];
	strs = cookie.split("|");
	for ( var i = 0; i < strs.length; i++) {
		arraylist.push(strs[i].split(",")[0]);
	}
	return arraylist;
}

function autowidth() {
	var div = $("comparewindow");
	div.style.top = parseInt(document.documentElement.scrollTop, 10)
			+ (document.documentElement.clientHeight - div.offsetHeight);
	div.style.left = parseInt((document.documentElement.clientWidth
			- div.offsetWidth - 40), 10);
}

function compareopen(obj, tag) {
	if ($("list").childNodes.length > 0) {
		var list = syscookie(getCookie(tag));
		if (list.length >= 3) {
			var str = list.join("|");
			obj.target = "_blank";
			obj.href = "/publicgetdb/1/" + tag + ".shtml?parmstr=" + str;
		} else {
			alert("至少选择2个产品才可以比较");
			obj.target = "_self";
			obj.href = "#";
			return false;

		}
	} else {
		alert("至少选择2个产品才可以比较");
		obj.target = "_self";
		obj.href = "#";
		return false;

	}
}

function setCookie(name, value) {
	var Days = 1;
	var exp = new Date();
	exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
	document.cookie = name + "=" + escape(value) + ";expires="
			+ exp.toGMTString();
}
function getCookie(name) {
	var arr = document.cookie
			.match(new RegExp("(^| )" + name + "=([^;]*)(;|$)"));
	if (arr != null)
		return unescape(arr[2]);
	return null;
}
function delCookie(name) {
	var exp = new Date();
	exp.setTime(exp.getTime() - 1);
	var cval = getCookie(name);
	if (cval != null)
		document.cookie = name + "=" + cval + ";expires=" + exp.toGMTString();
}
