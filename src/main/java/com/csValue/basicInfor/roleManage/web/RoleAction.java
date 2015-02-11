package com.csValue.basicInfor.roleManage.web;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.utils.web.struts2.Struts2Utils;

import ssdevframework.core.collection.CData;
import ssdevframework.core.collection.CMultiData;
import ssdevframework.front.action.BaseActionSupport;

import com.csValue.basicInfor.roleManage.service.RoleManage;
import com.csValue.common.login.entity.LoginUserData;
import com.csValue.common.util.web.AjaxUtil;

/**
 * 
 * @ClassName: RoleAction 
 * @Description: TODO
 *		用户权限管理
 * @author SSQ 
 * @date 2011-12-28 下午04:25:43 
 *
 */

@Namespace("/basicInfor/roleManage")
@Results({ @Result(name = BaseActionSupport.RELOAD, location = "role.action", type = "redirectParams") })
public class RoleAction extends BaseActionSupport {

	private static final long serialVersionUID = -3644286428991424144L;

	@Autowired
	private RoleManage manage;

	private Page<CData> page = new Page<CData>();

	private CMultiData menuList = new CMultiData();

	private CMultiData btnCodeList = new CMultiData();

	@Override
	public String list() throws Exception {
		page = manage.roleList(page, data);
		return SUCCESS;
	}

	/*
	 * 删除时，检测关联关系， 存在则不允许删除
	 */
	public String checkDel() throws Exception {
		if (manage.checkDel(data)) {
			Struts2Utils.renderText("ok", "encoding:UTF-8");
		} else {
			Struts2Utils.renderText("当前角色存在关联关系，请先删除关联关系", "encoding:UTF-8");
		}
		return null;
	}

	/*
	 * 保存时，检测roleName是否重复，允许则进行保存操作
	 */
	public String checkRoleName() throws Exception {
		data.put("userId", LoginUserData.getCurrentUserData().getUserId());
		if (manage.checkRoleName(data)) {
			Struts2Utils.renderText("ok", "encoding:UTF-8");
		} else {
			Struts2Utils.renderText("当前角色名称重复，请确认", "encoding:UTF-8");
		}
		return null;
	}

	public String deleteDo() throws Exception {
		manage.deleteDo(data);
		return BaseActionSupport.RELOAD;
	}

	public String config() throws Exception {
		menuList = manage.retrieveMenuList();
		btnCodeList = manage.retrieveBtnCodeList();
		return "config";
	}

	/*
	 * 	菜单权限配置 start
	 */

	public String retrieveMenuBtn() throws Exception {
		CMultiData result = manage.retrieveMenuBtn(data);
		Struts2Utils.renderXml(AjaxUtil.convert2MultidataXml(result), "encoding:UTF-8");
		return null;
	}

	/*
	 * 保存权限
	 */
	@SuppressWarnings("unchecked")
	public String saveAuthMenuDo() throws Exception {
		String userId = LoginUserData.getCurrentUserData().getUserId();
		data.put("userId", userId);
		data.remove("codeId");
		CMultiData saveData = new CMultiData();
		for (int i = 0; i < mdata.getDataCount("chkCodeId"); i++) {
			saveData.add("userId", userId);
			saveData.add("menuId", data.getString("menuId"));
			saveData.add("authCode", data.getString("authCode"));
			saveData.add("useFlag", data.getString("useFlag"));
			saveData.add("codeId", mdata.getString("chkCodeId", i));
		}
		if (saveData.getDataCount() == 0)
			saveData.addCData((CData) data.clone());
		manage.createAuthMenuBtnDo(saveData);
		Struts2Utils.renderText("ok", "encoding:UTF-8");
		return null;
	}

	/*
	 * 	菜单权限配置 end
	 */

	public Page<CData> getPage() {
		return page;
	}

	public void setPage(Page<CData> page) {
		this.page = page;
	}

	public CMultiData getMenuList() {
		return menuList;
	}

	public void setMenuList(CMultiData menuList) {
		this.menuList = menuList;
	}

	public CMultiData getBtnCodeList() {
		return btnCodeList;
	}

	public void setBtnCodeList(CMultiData btnCodeList) {
		this.btnCodeList = btnCodeList;
	}

}
