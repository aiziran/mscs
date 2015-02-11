package com.csValue.basicInfor.roleManage.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.Page;

import ssdevframework.core.collection.CData;
import ssdevframework.core.collection.CMultiData;

import com.csValue.basicInfor.roleManage.dao.RoleDao;

@Component
@Transactional
public class RoleManage {

	@Autowired
	private RoleDao dao;

	public Page<CData> roleList(Page<CData> page, CData data) {
		return dao.roleList(page, data);
	}

	/**
	 * 检测roleId是否存在关联关系
	 * @Description: TODO
	 * @param data
	 * @return   true：可以删除，false：存在关联关系，不能删除   
	 * @throws
	 */
	public boolean checkDel(CData data) {
		ArrayList<CData> mData = dao.checkDel(data);
		return mData.size() == 0 ? true : false;
	}

	/**
	 * 先检测当前角色名是否重复，不重复则执行保存操作，否则直接反回false
	 * @Description: TODO
	 * @param data
	 * @return     
	 * @throws
	 */
	public boolean checkRoleName(CData data) {
		ArrayList<CData> mData = dao.checkRoleName(data);

		if (mData.size() > 0)
			return false;

		if (data.get("roleId").equals("--")) {//新增
			dao.createRoleDo(data);
		} else {//更新
			dao.updateRoleDo(data);
		}

		return true;
	}

	public int deleteDo(CData data) {
		return dao.deleteDo(data);
	}

	public CMultiData retrieveMenuList() {
		return dao.retrieveMenuList();
	}

	public CMultiData retrieveBtnCodeList() {
		return dao.retrieveBtnCodeList();
	}

	/**
	 * 查询菜单权限，分为按钮权限和菜单是否可用2种。
	 * 其中按钮权限有都中，菜单是否可用用useFlag表示
	 * @Description: TODO
	 * @param data
	 * @return     
	 * @throws
	 */
	public CMultiData retrieveMenuBtn(CData data) {
		CMultiData btnRole = new CMultiData();
		btnRole = dao.retrieveBtn(data);
		CMultiData menuRole = dao.retrieveMenu(data);
		btnRole.addString("useFlag", menuRole.isEmpty() ? "N" : "Y");

		return btnRole;
	}

	public boolean createAuthMenuBtnDo(CMultiData data) {
		try {
			dao.deleteAuthBtnDo(data.getCData(0));
			dao.deleteAuthMenuDo(data.getCData(0));
			if (data.getCData(0).getString("useFlag").equals("Y"))
				dao.createAuthMenuDo(data.getCData(0));
			for (int i = 0; i < data.getDataCount("codeId"); i++) {
				dao.createAuthBtnDo(data.getCData(i));
			}
		} catch (Exception e) {
			//	throw new ServiceException("hmis.err.Service.RoleManage.createAuthMenuBtnDo", e);
			return false;
		}

		return true;
	}

}
