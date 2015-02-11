package com.csValue.management.welcome.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import ssdevframework.core.collection.CData;

import com.csValue.management.welcome.dao.WelcomeDao;

@Component
public class WelcomeManage {

	@Autowired
	private WelcomeDao dao;

	public List<CData> retrieveSystemNoticeList() throws Exception {
		return dao.retrieveSystemNoticeList();
	}

	public CData retrieveNotApprovedOrderCnt() {
		//input.set("userId", LoginUserData.getCurrentUserData().getUserId());
		CData data = new CData();
		if (dao.retrieveNotApprovedOrderCnt() == null) {
			data.set("orderCnt", "0");
			return data;
		} else
			return dao.retrieveNotApprovedOrderCnt();
	}

	public CData retrieveNotMaintenanceDrugCnt() {
		CData data = new CData();
		if (dao.retrieveNotMaintenanceDrugCnt() == null) {
			data.set("drugCnt", "0");
			return data;
		} else
			return dao.retrieveNotMaintenanceDrugCnt();
	}

	public CData getLastImportDate() {
		CData data = new CData();
		if (dao.getLastImportDate() == null) {
			data.set("endDate", "");
			return data;
		} else
			return dao.getLastImportDate();
	}

	public CData retrieveSystemNoticeDetail(CData data) {
		if (dao.retrieveSystemNoticeDetail(data).size() > 0)
			return dao.retrieveSystemNoticeDetail(data).get(0);
		else
			return null;
	}

	public ArrayList<CData> selectNotice() {
		return dao.selectNotice();
	}
	public ArrayList<CData> selectEmailList(CData data) {
		return dao.selectEmailList(data);
	}
	public ArrayList<CData> selectEstatenList(CData data) {
		return dao.selectEstatenList(data);
	}
	public ArrayList<CData> selectAffairsList(CData data) {
		
		return dao.selectAffairsList(data);
	}

	public ArrayList<CData> selectAttention(String user_id) {
		return dao.selectAttention(user_id);
	}

}
