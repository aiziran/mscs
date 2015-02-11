package com.csValue.basicInfor.menu.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Component;

import ssdevframework.core.collection.CData;
import ssdevframework.core.collection.CMultiData;

import com.csValue.common.util.dao.DaoUtil;

@Component
public class MenuDao extends SqlSessionDaoSupport {

	@SuppressWarnings("unchecked")
	public CMultiData menuList() {
		return DaoUtil.ConvertList2CMulti((List<CData>) this.getSqlSession().selectList("menu.menurList"));
	}

	public CData menuDetail(CData data) {
		return (CData) this.getSqlSession().selectOne("menu.menuDetail", data);
	}

	public CData createMenu(CData data) {
		CData c = (CData) this.getSqlSession().selectOne("menu.createMenu", data);
		return c;
	}

	public void createMenuDo(CData data) {
		CData cid = (CData) this.getSqlSession().selectOne("menu.createMenuId");
		String menuId = cid.get("menuId").toString();
		data.put("menuId", menuId);
		this.getSqlSession().update("menu.createMenuDo", data);
	}

	public void updateMenuDo(CData data) {
		this.getSqlSession().update("menu.updateMenuDo", data);
	}

	public CMultiData retrieveMenuNavigation() {
		CMultiData c = DaoUtil.ConvertList2CMulti((List<CData>) this.getSqlSession().selectList(
				"menu.retrieveMenuNavigation"));
		System.out.println("===========" + c.getName() + "::");
		return c;
	}
}
