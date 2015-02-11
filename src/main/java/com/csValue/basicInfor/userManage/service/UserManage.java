package com.csValue.basicInfor.userManage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.Page;

import ssdevframework.core.collection.CData;
import ssdevframework.core.exception.ServiceException;
import ssdevframework.front.util.CollectionUtility;

import com.csValue.basicInfor.userManage.dao.UserDao;
import com.csValue.common.util.SecurityCodeUtil;

@Component
@Transactional
public class UserManage {

	@Autowired
	private UserDao dao;

	@Transactional(readOnly = true)
	public Page<CData> userList(Page<CData> page, CData user) {
		return dao.userList(page, user);
	}

	@Transactional(readOnly = true)
	public CData retrieveUserDetail(CData input) {
		return dao.retrieveUserDetail(input);
	}

	public CData isDeptUsing(CData data) {
		return dao.isDeptUsing(data);
	}

	@Transactional(readOnly = true)
	public String isUserIdUnique(String userId) {
		return dao.isUserIdUnique(userId);
	}
	public void savePhotoLog(CData fileName) {
		dao.savePhotoLog(fileName);
	}
	public int updateUserDetail(CData input) {
		CData param = CollectionUtility.clone(input);
		if (param.getString("newPwd") != null && !param.getString("newPwd").equals("")) {
			param.setString("password", SecurityCodeUtil.Encode(input.getString("newPwd")));
		}

		try {

			dao.deleteUserRole(param);
			dao.deleteDeptRole(param);

			if (param.getString("authId") != null)
				dao.createUserRole(param);

			dao.updateUserDetail(param);
			if (param.getString("chk") != null) {
				String[] deptIds = param.getString("chk").split(",");
				for (int i = 0; i < deptIds.length; i++) {
					param.setString("chk", deptIds[i]);
					dao.createDeptRole(param);
				}
			} else {
				dao.createUserDept(param);
			}
		} catch (Exception se) {
			throw new ServiceException("hmis.err.Service.userManage.updateUserDetail", se);
		}
		return 1;
	}
	public String checkUserName(CData data) {
		return dao.checkUserName(data);
	}

	/**
	 * update user password
	 * @param input
	 * @return
	 */
	public int updateUserPwd(CData input) {
		CData param = CollectionUtility.clone(input);

		try {
			dao.updateUserPwd(input);

		} catch (Exception se) {
			throw new ServiceException("hmis.err.Service.userManage.updateUserPwd", se);
		}
		return 1;
	}

	public int createUser(CData input) throws ServiceException {
		CData param = CollectionUtility.clone(input);
		param.setString("password", SecurityCodeUtil.Encode(input.getString("password").trim()));
		try {
			dao.createUserRole(param);
			dao.createUser(param);
			if (param.getString("chk") != null) {
				String[] deptIds = param.getString("chk").split(",");
				for (int i = 0; i < deptIds.length; i++) {
					param.setString("chk", deptIds[i]);
					dao.createDeptRole(param);
				}
			} else {
				dao.createUserDept(param);
			}
		} catch (Exception se) {
			throw new ServiceException("hmis.err.Service.userManage.createUser", se);
		}
		return 1;
	}
	public int deleteUser(CData data){
		dao.deleteUser(data);
		return 1;
	}

	public Page<CData> handerList(Page<CData> page, CData data) {
		// TODO Auto-generated method stub
		return dao.handerList(page,data);
	}

	public Page<CData> inspectorList(Page<CData> page, CData data) {
		// TODO Auto-generated method stub
		return dao.inspectorList(page,data);
	}

	/**
	 * 查找所有的操作界面的URL
	 * @return
	 */
	public List<CData> findAllURL() {
		return dao.findAllURL();
	}

	public CData selectSmallBagId(CData data) {
		return dao.selectSmallBagId(data);
	}
	
}
