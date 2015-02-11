/*

 * Translated default messages for the jQuery validation plugin.
 * Locale: CN
 */
jQuery.extend(jQuery.validator.messages, {
	required : "必填项",
	remote : "请修正该项",
	email : "请输入正确格式的电子邮件",
	url : "请输入合法的网址",
	date : "请输入合法的日期",
	dateISO : "请输入合法的日期 (ISO).",
	number : "请输入合法的数字",
	digits : "只能输入整数",
	age:"请输入年龄",
	card : "请输入身份证号码",
	creditcard : "请输入合法的信用卡号",
	equalTo : "请再次输入相同的值",
	accept : "请输入拥有合法后缀名的字符串",
	maxlength : jQuery.validator.format("请输入一个长度最多是 {0} 的字符串"),
	minlength : jQuery.validator.format("请输入一个长度最少是 {0} 的字符串"),
	rangelength : jQuery.validator.format("请输入一个长度介于 {0} 和 {1} 之间的字符串"),
	range : jQuery.validator.format("请输入一个介于 {0} 和 {1} 之间的值"),
	max : jQuery.validator.format("请输入一个最大为 {0} 的值"),
	min : jQuery.validator.format("请输入一个最小为 {0} 的值"),
	phone : "电话号码格式错误",
	mobile : "手机号码格式错误",
	userid : "用户ID只能是数字、字母和下划线",
	pwd : "用户密码只能是数字、字母和下划线"
});
$.metadata.setType("attr", "validate");

// pwd验证
jQuery.validator.addMethod("pwd", function(value, element) {
	var length = value.length;
	var pwd = /^\w+$/;
	return this.optional(element) || (pwd.test(value));
}, "用户密码只能是数字、字母和下划线");

// 用户ID验证
jQuery.validator.addMethod("userid", function(value, element) {
	var length = value.length;
	var userId = /^\w+$/;
	return this.optional(element) || (userId.test(value));
}, "用户ID只能是数字、字母和下划线");
// 手机号码验证
jQuery.validator.addMethod("mobile", function(value, element) {
	var length = value.length;
	// var mobile = /^(13[0-9]|15[0-9]|18[0-9])\d{8}$/;
	var mobile = /^(1)\d{10}$/;
	return this.optional(element) || (length == 11 && mobile.test(value));
}, "手机号码格式错误");

// 身份证号码验证
jQuery.validator.addMethod("card", function(value, element) {
	var length = value.length;
	var card = /^\d{18}|\d{15}$/;
	return this.optional(element) || (length <= 18 && card.test(value));

}, "身份证验证不正确，身份证长度应该是15到18位之间");

// 年龄输入验证
jQuery.validator.addMethod("age", function(value, element) {
	var length = value.length;
	var age = /^^\-?[0-9]+$/;
	return this.optional(element) || (length <= 3 && card.test(value));
	
}, "年龄不得超过150，不得小于10");

// 固话电话号码验证
jQuery.validator.addMethod("phone", function(value, element) {
	// var tel = /^(0[0-9]{2,3}\-)?([2-9][0-9]{5,6,7})+(\-[0-9]{1,4})?$/;
	// var tel =
	// /^(0[0-9]{2,3}\-)?([0-9][0-9][0-9][0-9]{5,6,7,8})+(\-[0-9]{1,4})?$/;
	var tel = /^[0-9\-]*$/;
	return this.optional(element) || (tel.test(value));
}, "电话号码格式错误");

// 手机或固话号码验证
jQuery.validator.addMethod("phone_mobile", function(value, element) {
	// var tel =
	// /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\d{8}$/;
	var tel = /^(1)\d{10}$|^[0-9\-]*$/;
	return this.optional(element) || (tel.test(value));
}, "手机或固话号码格式错误");
