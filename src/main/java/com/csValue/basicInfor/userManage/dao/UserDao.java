package com.csValue.basicInfor.userManage.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springside.modules.orm.Page;

import ssdevframework.core.collection.CData;

import com.csValue.common.util.dao.PageDao;

@Component
public class UserDao extends SqlSessionDaoSupport {

	@Autowired
	private PageDao pageDao;

	@SuppressWarnings("unchecked")
	public Page<CData> userList(Page<CData> page, CData user) {
		return pageDao.getPageList("userManage.userList", page, user);
	}

	public CData isDeptUsing(CData input) {
		return (CData) this.getSqlSession().selectOne("userManage.isDeptUsing", input);
	}

	public CData retrieveUserDetail(CData input) {
		return (CData) this.getSqlSession().selectOne("userManage.retrieveUserDetail", input);
	}

	public int updateUserDetail(CData input) {
		return this.getSqlSession().update("userManage.updateUserDetail", input);
	}

	public int createUser(CData input) {
		return this.getSqlSession().insert("userManage.createUser", input);
	}

	public int createUserRole(CData input) {
		return this.getSqlSession().insert("userManage.createUserRole", input);
	}

	public int createUserDept(CData input) {
		return this.getSqlSession().insert("userManage.createUserDept", input);
	}

	public int createDeptRole(CData input) {
		return this.getSqlSession().insert("userManage.createDeptRole", input);
	}

	public int deleteUserRole(CData input) {
		return this.getSqlSession().insert("userManage.deleteUserRole", input);
	}

	public int deleteDeptRole(CData input) {
		return this.getSqlSession().insert("userManage.deleteDeptRole", input);
	}

	public String isUserIdUnique(String userId) {
		return (String) this.getSqlSession().selectOne("userManage.isUserIdUnique", userId);
	}
	public void savePhotoLog(CData fileName) {
		 this.getSqlSession().insert("userManage.savePhotoLog", fileName);
	}

	public String checkUserName(CData data) {
		return (String) this.getSqlSession().selectOne("userManage.checkUserName", data);
	}

	/**
	 * sunjiangfan update user password
	 * @param input
	 * @return
	 */
	public int updateUserPwd(CData input) {
		return this.getSqlSession().update("userManage.updateUserPwd", input);
	}

	public int deleteUser(CData data) {
		this.getSqlSession().delete("userManage.deleteUser", data);
		this.getSqlSession().delete("userManage.deleteDeptRole", data);
		this.getSqlSession().delete("userManage.deleteUserRole", data);
		return 1;

	}

	public Page<CData> handerList(Page<CData> page, CData data) {
		// TODO Auto-generated method stub
		return pageDao.getPageList("userManage.handerList", page, data);
	}

	public Page<CData> inspectorList(Page<CData> page, CData data) {
		// TODO Auto-generated method stub
		return pageDao.getPageList("userManage.inspectorList", page, data);
	}
	/**
	 * 查找所有的操作界面的URL
	 * @return
	 */
	public List<CData> findAllURL() {
		return this.getSqlSession().selectList("userManage.findAllURL");
	}

	public CData selectSmallBagId(CData data) {
		return (CData)this.getSqlSession().selectOne("userManage.selectSmallBagId",data);
	}
	
}
