package com.csValue.management.welcome.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Component;

import ssdevframework.core.collection.CData;

@Component
public class WelcomeDao extends SqlSessionDaoSupport {

	public List<CData> retrieveSystemNoticeList() throws Exception {
		return this.getSqlSession().selectList("welcome.retrieveSystemNoticeList");
	}

	public CData retrieveNotApprovedOrderCnt() {
		if (this.getSqlSession().selectList("welcome.retrieveNotApprovedOrderCnt").size() > 0)
			return (CData) this.getSqlSession().selectList("welcome.retrieveNotApprovedOrderCnt").get(0);
		else
			return null;
	}

	public CData retrieveNotMaintenanceDrugCnt() {
		if (this.getSqlSession().selectList("welcome.retrieveNotMaintenanceDrugCnt").size() > 0)
			return (CData) this.getSqlSession().selectList("welcome.retrieveNotMaintenanceDrugCnt").get(0);
		else
			return null;
	}

	public CData getLastImportDate() {
		if (this.getSqlSession().selectList("welcome.retrieveLastImportDate").size() > 0)
			return (CData) this.getSqlSession().selectList("welcome.retrieveLastImportDate").get(0);
		else
			return null;
	}

	public List<CData> retrieveSystemNoticeDetail(CData data) {
		return this.getSqlSession().selectList("welcome.retrieveSystemNoticeDetail", data);
	}

	public ArrayList<CData> selectNotice() {
		return (ArrayList<CData>) this.getSqlSession().selectList("welcome.selectNotice");
	}
	public ArrayList<CData> selectEmailList(CData data) {
		return (ArrayList<CData>) this.getSqlSession().selectList("welcome.selectEmailList",data);
	}
	public ArrayList<CData> selectEstatenList(CData data) {
		return (ArrayList<CData>) this.getSqlSession().selectList("welcome.selectEstatenList",data);
	}
	public ArrayList<CData> selectAffairsList(CData data) {
		return (ArrayList<CData>) this.getSqlSession().selectList("welcome.selectAffairsList",data);
	}

	public ArrayList<CData> selectAttention(String user_id) {
		return (ArrayList<CData>) this.getSqlSession().selectList("welcome.selectAttention", user_id);
	}

}
