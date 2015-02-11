package com.csValue.basicInfor.dataManage.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.Page;

import com.csValue.basicInfor.dataManage.dao.DataDao;


import ssdevframework.core.collection.CData;

@Component
@Transactional
public class DataManage {
	@Autowired
	private DataDao dao;

	
	
	
	@Transactional(readOnly = true)
	public Page<CData> team(Page<CData> page, CData dept) {
		return dao.team(page, dept);
	}
	
	public void insertTeam(CData input) {
		dao.insertTeam(input);
	}
	public void deleteTeam(CData data) {
		// TODO Auto-generated method stub
		 dao.deleteTeam(data);
	}

	public void updateTeam(CData input) {
		ArrayList<CData> list = dao.updateTeamDetail(input);
		if (list.size() > 0) {
			dao.updateTeam(input);
		}
	}
	

	@Transactional(readOnly = true)
	public Page<CData> classes(Page<CData> page, CData data) {
		// TODO Auto-generated method stub
		return dao.classes(page,data);
	}
	public void insertClasses(CData input) {
		dao.insertClasses(input);
	}
	public void deleteClasses(CData data) {
		// TODO Auto-generated method stub
		 dao.deleteClasses(data);
	}

	public void updateClasses(CData input) {
		ArrayList<CData> list = dao.updateClassesDetail(input);
		if (list.size() > 0) {
			dao.updateClasses(input);
		}
	}
	
	
	
	@Transactional(readOnly = true)
	public Page<CData> hander(Page<CData> page, CData data) {
		// TODO Auto-generated method stub
		return dao.hander(page,data);
	}
	public void insertHander(CData input) {
		dao.insertHander(input);
	}
	public void deleteHander(CData data) {
		// TODO Auto-generated method stub
		 dao.deleteHander(data);
	}

	public void updateHander(CData input) {
		ArrayList<CData> list = dao.updateHanderDetail(input);
		if (list.size() > 0) {
			dao.updateHander(input);
		}
	}
	
	
	
	
	@Transactional(readOnly = true)
	public Page<CData> inspector(Page<CData> page, CData data) {
		// TODO Auto-generated method stub
		return dao.inspector(page,data);
	}
	public void insertInspector(CData input) {
		dao.insertInspector(input);
	}
	public void deleteInspector(CData data) {
		// TODO Auto-generated method stub
		 dao.deleteInspector(data);
	}

	public void updateInspector(CData input) {
		ArrayList<CData> list = dao.updateInspectorDetail(input);
		if (list.size() > 0) {
			dao.updateInspector(input);
		}
	}

	public CData reupdataTeam(CData data) {
		// TODO Auto-generated method stub
		return dao.selectupdatateamDetail(data);
	}
	
	public CData selectupdataClassesDetail(CData data) {
		// TODO Auto-generated method stub
		return dao.selectupdataClassesDetail(data);
	}
	public CData selectupdataHanderDetail(CData data) {
		// TODO Auto-generated method stub
		return dao.selectupdataHanderDetail(data);
	}
	public CData selectupdataInspectorDetail(CData data) {
		// TODO Auto-generated method stub
		return dao.selectupdataInspectorDetail(data);
	}

	//排班表增删查该
	
	@Transactional(readOnly = true)
	public Page<CData> handerWorking(Page<CData> page, CData dept) {
		return dao.handerWorking(page, dept);
	} 
	public void updateWorkoing(CData data) {
		
		ArrayList<CData> list = dao.updateWorkoingDetail(data);
		if (list.size() > 0) {
			dao.updateWorkoing(data);
		}
	}

	public void insertWorkoing(CData data) {
		dao.insertWorkoing(data);
		
	}

	public void deleteWorking(CData data) {
		 dao.deleteWorking(data);
		
	}

	public CData reupdateWorkoing(CData data) {
		return dao.reupdateWorkoing(data);
	}
	
	
}
