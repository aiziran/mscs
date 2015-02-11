package com.csValue.basicInfor.codeGroupManage.web;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springside.modules.orm.Page;
import org.springside.modules.utils.web.struts2.Struts2Utils;

import ssdevframework.core.collection.CData;
import ssdevframework.front.action.BaseActionSupport;

import com.csValue.basicInfor.codeGroupManage.service.CodeGroupManage;
import com.csValue.common.login.entity.LoginUserData;

/**
 * 
 * @Description: 代码组信息处理！
 * @ClassName: CodeGroupAction
 * @author SCQ	
 * @date 2012-1-03 		上午09:42:10
 */
@Namespace("/basicInfor/codeGroupManage")
@Results({ @Result(name = BaseActionSupport.RELOAD, location = "code-group.action", type = "redirectParams") })
@Component
public class CodeGroupAction extends BaseActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8813205241510884580L;

	private Page<CData> page = new Page<CData>();

	@Autowired
	private CodeGroupManage codeGroupManage;

	private CData codeGroupInfo;

	@Override
	public String list() throws Exception {
		page = codeGroupManage.retrieveCodeGroupList(page, data);
		return SUCCESS;
	}

	@Override
	public String save() throws Exception {

		data.setString("userId", LoginUserData.getCurrentUserData().getUserId());

		if ("create".equals(data.getString("mode"))) {
			//insert
			codeGroupManage.createCodeGroup(data);
		} else if ("update".equals(data.getString("mode"))) {
			//update
			codeGroupManage.updateCodeGroup(data);
		}

		return RELOAD;

	}

	public String updateInput() throws Exception {
		codeGroupInfo = codeGroupManage.retrieveGroupCodeDetail(data);
		return INPUT;
	}

	public String createInput() throws Exception {
		return INPUT;
	}

	public String checkCodeGroup() {
		Struts2Utils.renderText(codeGroupManage.checkCodeGroup(data));
		return null;
	}

	public CData getCodeGroupInfo() {
		return codeGroupInfo;
	}

	public void setCodeGroupInfo(CData codeGroupInfo) {
		this.codeGroupInfo = codeGroupInfo;
	}

	public Page<CData> getPage() {
		return page;
	}

	public void setPage(Page<CData> page) {
		this.page = page;
	}

}
