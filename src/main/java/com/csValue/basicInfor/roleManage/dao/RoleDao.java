package com.csValue.basicInfor.roleManage.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springside.modules.orm.Page;

import ssdevframework.core.collection.CData;
import ssdevframework.core.collection.CMultiData;

import com.csValue.common.util.dao.DaoUtil;
import com.csValue.common.util.dao.PageDao;

@Component
public class RoleDao extends SqlSessionDaoSupport {

	@Autowired
	private PageDao pageDao;

	public Page<CData> roleList(Page<CData> page, CData data) {
		return pageDao.getPageList("roleManage.roleList", page, data);
	}

	@SuppressWarnings("unchecked")
	public ArrayList<CData> checkDel(CData data) {
		return (ArrayList<CData>) this.getSqlSession().selectList("roleManage.checkDel", data);
	}

	@SuppressWarnings("unchecked")
	public ArrayList<CData> checkRoleName(CData data) {
		return (ArrayList<CData>) this.getSqlSession().selectList("roleManage.checkRoleName", data);
	}

	public int deleteDo(CData input) {
		return this.getSqlSession().delete("roleManage.deleteDo", input);
	}

	public int updateRoleDo(CData input) {
		return this.getSqlSession().update("roleManage.updateRoleDo", input);
	}

	public int createRoleDo(CData input) {
		return this.getSqlSession().insert("roleManage.createRoleDo", input);
	}

	@SuppressWarnings("unchecked")
	public CMultiData retrieveMenuList() {
		return DaoUtil.ConvertList2CMulti((List<CData>) this.getSqlSession().selectList("roleManage.retrieveMenuList"));
	}

	@SuppressWarnings("unchecked")
	public CMultiData retrieveBtnCodeList() {
		return DaoUtil.ConvertList2CMulti((List<CData>) this.getSqlSession().selectList(
				"roleManage.retrieveBtnCodeList"));
	}

	@SuppressWarnings("unchecked")
	public CMultiData retrieveMenu(CData input) {
		return DaoUtil.ConvertList2CMulti((List<CData>) this.getSqlSession().selectList("roleManage.retrieveMenu",
				input));
	}

	@SuppressWarnings("unchecked")
	public CMultiData retrieveBtn(CData input) {
		return DaoUtil.ConvertList2CMulti((List<CData>) this.getSqlSession()
				.selectList("roleManage.retrieveBtn", input));
	}

	public int deleteAuthMenuDo(CData input) {
		return this.getSqlSession().delete("roleManage.deleteAuthMenuDo", input);
	}

	public int deleteAuthBtnDo(CData input) {
		return this.getSqlSession().delete("roleManage.deleteAuthBtnDo", input);
	}

	public int createAuthBtnDo(CData input) {
		return this.getSqlSession().insert("roleManage.createAuthBtnDo", input);
	}

	public int createAuthMenuDo(CData input) {
		return this.getSqlSession().insert("roleManage.createAuthMenuDo", input);
	}

}
