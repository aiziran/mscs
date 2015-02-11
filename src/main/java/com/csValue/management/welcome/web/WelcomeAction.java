package com.csValue.management.welcome.web;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.utils.web.struts2.Struts2Utils;

import ssdevframework.core.collection.CData;
import ssdevframework.front.action.BaseActionSupport;

import com.csValue.management.welcome.service.WelcomeManage;

/**
 * 
 * @ClassName: WelcomeAction 
 * @Description: TODO
 *  欢迎界面
 * @author houyingchang hougebest@163.com 
 * @date 2011-5-28 下午11:21:00 
 *
 */
@Namespace("/management/welcome")
public class WelcomeAction extends BaseActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Autowired
	private WelcomeManage manage;

	private CData orderCnt;

	private CData drugCnt;

	private CData endDate;
	private CData emailDate;

	private ArrayList<CData> attentionList;

	private ArrayList<CData> noticeList;
	private ArrayList<CData> emailList;
	private ArrayList<CData> estatenNewsList;
	private ArrayList<CData> estatenLoraList;
	private ArrayList<CData> affairsList;
	private String message;

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public ArrayList<CData> getNoticeList() {
		return noticeList;
	}

	public void setNoticeList(ArrayList<CData> noticeList) {
		this.noticeList = noticeList;
	}

	public ArrayList<CData> getAttentionList() {
		return attentionList;
	}

	public void setAttentionList(ArrayList<CData> attentionList) {
		this.attentionList = attentionList;
	}

	@Override
	public String list() throws Exception {


		return SUCCESS;
	}

	public String noticeDetail() {
		data = manage.retrieveSystemNoticeDetail(data);
		return "notice";
	}

	public CData getOrderCnt() {
		return orderCnt;
	}

	public void setOrderCnt(CData orderCnt) {
		this.orderCnt = orderCnt;
	}

	public CData getDrugCnt() {
		return drugCnt;
	}

	public void setDrugCnt(CData drugCnt) {
		this.drugCnt = drugCnt;
	}

	public CData getEndDate() {
		return endDate;
	}

	public void setEndDate(CData endDate) {
		this.endDate = endDate;
	}

	public CData getEmailDate() {
		return emailDate;
	}

	public void setEmailDate(CData emailDate) {
		this.emailDate = emailDate;
	}

	public WelcomeManage getManage() {
		return manage;
	}

	public void setManage(WelcomeManage manage) {
		this.manage = manage;
	}

	public ArrayList<CData> getEmailList() {
		return emailList;
	}

	public void setEmailList(ArrayList<CData> emailList) {
		this.emailList = emailList;
	}

	public ArrayList<CData> getEstatenNewsList() {
		return estatenNewsList;
	}

	public void setEstatenNewsList(ArrayList<CData> estatenNewsList) {
		this.estatenNewsList = estatenNewsList;
	}

	public ArrayList<CData> getEstatenLoraList() {
		return estatenLoraList;
	}

	public void setEstatenLoraList(ArrayList<CData> estatenLoraList) {
		this.estatenLoraList = estatenLoraList;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public ArrayList<CData> getAffairsList() {
		return affairsList;
	}

	public void setAffairsList(ArrayList<CData> affairsList) {
		this.affairsList = affairsList;
	}

}
