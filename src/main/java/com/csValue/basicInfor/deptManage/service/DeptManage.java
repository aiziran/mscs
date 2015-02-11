package com.csValue.basicInfor.deptManage.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.Page;

import ssdevframework.core.collection.CData;

import com.csValue.basicInfor.deptManage.dao.DeptDao;

@Component
@Transactional
public class DeptManage {

	@Autowired
	private DeptDao deptDao;

	@Transactional(readOnly = true)
	public Page<CData> deptList(Page<CData> page, CData dept) {
		return deptDao.deptList(page, dept);
	}

	@Transactional(readOnly = true)
	public CData retrieveUserDetail(CData input) {
		return deptDao.retrieveDeptDetail(input);
	}

	@Transactional(readOnly = true)
	public ArrayList<CData> retrieveDeptTypeList() {
		return deptDao.retrieveDeptTypeList();
	}

	public void saveDept(CData input) {
		deptDao.createDept(input);
	}

	public void deleteDo(CData data) {
		deptDao.deleteDeptDo(data);
	}

	public void updateDept(CData input) {
		ArrayList<CData> list = deptDao.updateDeptDetail(input);
		if (list.size() > 0) {
			deptDao.updateDeptDetailDo(input);
		}
	}

	public void deleteDept(CData input) {
		ArrayList<CData> list = deptDao.deleteDept(input);
		if (list.size() == 0) {
			deptDao.deleteDeptDo(input);
		}
	}
}
