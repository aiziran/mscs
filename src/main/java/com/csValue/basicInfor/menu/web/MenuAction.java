package com.csValue.basicInfor.menu.web;

import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.utils.web.struts2.Struts2Utils;

import ssdevframework.core.collection.CData;
import ssdevframework.core.collection.CMultiData;
import ssdevframework.front.action.BaseActionSupport;

import com.csValue.basicInfor.menu.service.MenuManage;
import com.csValue.common.login.entity.LoginUserData;
import com.csValue.common.util.web.AjaxUtil;

/**
 * 
 * @Description: 菜单管理
 * @ClassName: UserAction 
 * @author SSQ 
 * @date 2012-1-9 上午11:42:10 
 */
@Namespace("/basicInfor/menu")
public class MenuAction extends BaseActionSupport {

	private static final long serialVersionUID = 8683878162525847072L;

	private CMultiData menuList;

	private CData menuDetail;

	@Autowired
	private MenuManage manage;

	@Override
	public String list() throws Exception {
		menuList = manage.menuList();
		return SUCCESS;
	}

	/*
	 * 查询菜单
	 */
	public String retrieveMenu() throws Exception {
		if (data.getString("menuId").equals("undefined")) {
			data.setString("menuId", "");
		}
		menuDetail = manage.menuDetail(data);

		Struts2Utils.renderXml(AjaxUtil.convert2FormXml(menuDetail), "encoding:UTF-8");
		return null;
	}

	/*
	 * 新增菜单
	 */
	public String createMenu() throws Exception {
		if (data.getString("menuId").equals("undefined")) {
			data.setString("menuId", "");
		}
		menuDetail = manage.createMenu(data);

		Struts2Utils.renderXml(AjaxUtil.convert2FormXml(menuDetail), "encoding:UTF-8");
		return null;
	}

	/*
	 * 保存新增菜单
	 */
	public String createMenuDo() throws Exception {
		data.setString("createBy", LoginUserData.getCurrentUserData().getUserId());
		try {
			manage.createMenuDo(data);
			addActionMessage("菜单保存成功");
		} catch (Exception e) {
			addActionMessage("菜单保存失败");
		}
		return list();
	}

	/*
	 * 保存更新菜单
	 */
	public String updateMenuDo() throws Exception {
		data.setString("lastUpdatedBy", LoginUserData.getCurrentUserData().getUserId());
		try {
			manage.updateMenuDo(data);
			addActionMessage("菜单更新成功");
		} catch (Exception e) {
			addActionMessage("菜单更新失败");
		}
		return list();
	}

	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub

	}

	public CMultiData getMenuList() {
		return menuList;
	}

	public void setMenuList(CMultiData menuList) {
		this.menuList = menuList;
	}

	public CData getMenuDetail() {
		return menuDetail;
	}

	public void setMenuDetail(CData menuDetail) {
		this.menuDetail = menuDetail;
	}

}
