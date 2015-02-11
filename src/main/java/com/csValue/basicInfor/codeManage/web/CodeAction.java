package com.csValue.basicInfor.codeManage.web;

import java.util.ArrayList;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.utils.web.struts2.Struts2Utils;

import ssdevframework.core.collection.CData;
import ssdevframework.front.action.BaseActionSupport;

import com.csValue.basicInfor.codeManage.service.CodeManage;
import com.csValue.basicInfor.comboMange.service.ComboManage;
import com.csValue.common.login.entity.LoginUserData;

/**
 * 
 * @Description: 代码组信息处理！
 * @ClassName: CodeGroupAction
 * @author SCQ	
 * @date 2012-1-03 		上午09:42:10
 */
@Namespace("/basicInfor/codeManage")
@Results({ @Result(name = BaseActionSupport.RELOAD, location = "code.action", type = "redirectParams") })
public class CodeAction extends BaseActionSupport {

	private Page<CData> page = new Page<CData>();

	@Autowired
	private CodeManage codeManage;
	@Autowired
	private ComboManage comboManage;

	ArrayList<CData> codeGroupList = new ArrayList<CData>();

	private CData codeInfo = new CData();

	@Override
	public String list() throws Exception {
		codeGroupList = comboManage.retrieveCodeGroup();
		page = codeManage.retrieveCodeList(page, data);
		return SUCCESS;
	}

	public String createInput() throws Exception {
		codeGroupList = comboManage.retrieveCodeGroup();
		return INPUT;
	}

	public String updateInput() throws Exception {
		codeGroupList = comboManage.retrieveCodeGroup();
		codeInfo = codeManage.retrieveCodeDetail(data);
		return INPUT;
	}

	public String checkCodeId() throws Exception {
		if (codeManage.retrieveCodeInfo(data) == null) {
			Struts2Utils.renderText("true");
		} else {
			Struts2Utils.renderText("false");
		}
		return null;
	}

	@Override
	public String save() throws Exception {
		data.setString("userId", LoginUserData.getCurrentUserData().getUserId());

		if ("create".equals(data.getString("mode"))) {
			codeManage.createCode(data);
		} else if ("update".equals(data.getString("mode"))) {
			codeManage.updateCode(data);
		}
		return BaseActionSupport.RELOAD;
	}

	public Page<CData> getPage() {
		return page;
	}

	public void setPage(Page<CData> page) {
		this.page = page;
	}

	public CData getCodeInfo() {
		return codeInfo;
	}

	public ArrayList<CData> getCodeGroupList() {
		return codeGroupList;
	}

	public void setCodeGroupList(ArrayList<CData> codeGroupList) {
		this.codeGroupList = codeGroupList;
	}
}
