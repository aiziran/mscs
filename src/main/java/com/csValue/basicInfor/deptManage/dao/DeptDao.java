/**
 * 
 */
package com.csValue.basicInfor.deptManage.dao;

import java.util.ArrayList;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springside.modules.orm.Page;

import ssdevframework.core.collection.CData;

import com.csValue.common.util.dao.PageDao;

/**
 * @author wangbaoping
 * 
 */
@Component
public class DeptDao extends SqlSessionDaoSupport {

	@Autowired
	private PageDao pageDao;

	@SuppressWarnings("unchecked")
	public Page<CData> deptList(Page<CData> page, CData dept) {
		return pageDao.getPageList("deptManage.retrieveDeptList", page, dept);
	}

	public CData retrieveDeptDetail(CData input) {
		return (CData) this.getSqlSession().selectOne("deptManage.updateDept", input);
	}

	@SuppressWarnings("unchecked")
	public ArrayList<CData> updateDeptDetail(CData input) {
		return (ArrayList<CData>) this.getSqlSession().selectList("deptManage.updateDept", input);
	}

	public int updateDeptDetailDo(CData input) {
		return this.getSqlSession().update("deptManage.updateDeptDo", input);
	}

	public int createDept(CData input) {
		return this.getSqlSession().insert("deptManage.createDeptDo", input);
	}

	@SuppressWarnings("unchecked")
	public ArrayList<CData> deleteDept(CData input) {
		return (ArrayList<CData>) this.getSqlSession().selectList("deptManage.deleteDept", input);

	}

	public void deleteDeptDo(CData input) {
		this.getSqlSession().update("deptManage.deleteDeptDo", input);
	}

	@SuppressWarnings("unchecked")
	public ArrayList<CData> retrieveDeptTypeList() {
		return (ArrayList<CData>) this.getSqlSession().selectList("deptManage.retrieveDeptTypeList");
	}

}
