package com.csValue.basicInfor.dataManage.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.csValue.common.util.dao.PageDao;
import org.springside.modules.orm.Page;

import ssdevframework.core.collection.CData;

import java.util.ArrayList;



@Component
public class DataDao extends SqlSessionDaoSupport{

	
	@Autowired
	private PageDao pageDao;

	@SuppressWarnings("unchecked")
	public Page<CData> team(Page<CData> page, CData data) {
		return pageDao.getPageList("dataManage.team", page, data);
	}
	
	public int updateTeam(CData data) {
		return this.getSqlSession().update("dataManage.updateTeam", data);
	}

	public int insertTeam(CData data) {
		return this.getSqlSession().insert("dataManage.insertTeam", data);
	}

	public void deleteTeam(CData data) {
		this.getSqlSession().update("dataManage.deleteTeam", data);
	}
	@SuppressWarnings("unchecked")
	public ArrayList<CData> updateTeamDetail(CData input) {
		// TODO Auto-generated method stub
		return (ArrayList<CData>) this.getSqlSession().selectList("dataManage.updateTeamDetail", input);
	}
	
	
	
	@SuppressWarnings("unchecked")
	public Page<CData> classes(Page<CData> page, CData data) {
		return pageDao.getPageList("dataManage.classes", page, data);
	}
	public int updateClasses(CData data) {
		return this.getSqlSession().update("dataManage.updateClasses", data);
	}

	public int insertClasses(CData data) {
		return this.getSqlSession().insert("dataManage.insertClasses", data);
	}

	public void deleteClasses(CData data) {
		this.getSqlSession().update("dataManage.deleteClasses", data);
	}
	@SuppressWarnings("unchecked")
	public ArrayList<CData> updateClassesDetail(CData input) {
		// TODO Auto-generated method stub
		return (ArrayList<CData>) this.getSqlSession().selectList("dataManage.updateClassesDetail", input);
	}
	
	
	
	
	@SuppressWarnings("unchecked")
	public Page<CData> hander(Page<CData> page, CData data) {
		return pageDao.getPageList("dataManage.hander", page, data);
	}
	public int updateHander(CData data) {
		return this.getSqlSession().update("dataManage.updateHander", data);
	}

	public int insertHander(CData data) {
		return this.getSqlSession().insert("dataManage.insertHander", data);
	}

	public void deleteHander(CData data) {
		this.getSqlSession().update("dataManage.deleteHander", data);
	}
	@SuppressWarnings("unchecked")
	public ArrayList<CData> updateHanderDetail(CData input) {
		// TODO Auto-generated method stub
		return (ArrayList<CData>) this.getSqlSession().selectList("dataManage.updateHanderDetail", input);
	}
	
	

	@SuppressWarnings("unchecked")
	public Page<CData> inspector(Page<CData> page, CData data) {
		return pageDao.getPageList("dataManage.inspector", page, data);
	}

	public int updateInspector(CData data) {
		return this.getSqlSession().update("dataManage.updateInspector", data);
	}

	public int insertInspector(CData data) {
		return this.getSqlSession().insert("dataManage.insertInspector", data);
	}

	public void deleteInspector(CData data) {
		this.getSqlSession().update("dataManage.deleteInspector", data);
	}
	@SuppressWarnings("unchecked")
	public ArrayList<CData> updateInspectorDetail(CData input) {
		// TODO Auto-generated method stub
		return (ArrayList<CData>) this.getSqlSession().selectList("dataManage.updateInspectorDetail", input);
	}

	public CData selectupdatateamDetail(CData data) {
		return (CData) this.getSqlSession().selectOne("dataManage.updateTeamDetail", data);
	}
	public CData selectupdataClassesDetail(CData data) {
		return (CData) this.getSqlSession().selectOne("dataManage.updateClassesDetail", data);
	}
	public CData selectupdataHanderDetail(CData data) {
		return (CData) this.getSqlSession().selectOne("dataManage.updateHanderDetail", data);
	}
	public CData selectupdataInspectorDetail(CData data) {
		return (CData) this.getSqlSession().selectOne("dataManage.updateInspectorDetail", data);
	}
	
	@SuppressWarnings("unchecked")
	public Page<CData> handerWorking(Page<CData> page, CData data) {
		return pageDao.getPageList("dataManage.handerWorking", page, data);
	}
	
	public int updateWorkoing(CData data) {
		return this.getSqlSession().update("dataManage.updateWorking", data);
	}

	public int insertWorkoing(CData data) {
		return this.getSqlSession().insert("dataManage.insertWorkoing", data);
	}

	public void deleteWorking(CData data) {
		this.getSqlSession().update("dataManage.deleteWorking", data);
	}
	@SuppressWarnings("unchecked")
	public ArrayList<CData> updateWorkoingDetail(CData input) {
		// TODO Auto-generated method stub
		return (ArrayList<CData>) this.getSqlSession().selectList("dataManage.updateWorkoingDetail", input);
	}

	public CData reupdateWorkoing(CData data) {
		// TODO Auto-generated method stub
		return (CData) this.getSqlSession().selectOne("dataManage.updateWorkoingDetail", data);
	}
	

}
