package com.csValue.basicInfor.userManage.web;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.utils.web.struts2.Struts2Utils;

import ssdevframework.core.collection.CData;
import ssdevframework.front.action.BaseActionSupport;

import com.csValue.basicInfor.userManage.service.UserManage;
import com.csValue.common.login.entity.LoginUserData;
import com.csValue.common.util.SecurityCodeUtil;

/**
 * 
 * @Description: 用户管理
 * @ClassName: UserPwdAction 
 * @author SSQ 
 * @date 2011-12-15 上午11:42:10 
 */

@Namespace("/basicInfor/userManage")
public class UserPwdAction extends BaseActionSupport {

	private static final long serialVersionUID = 8683878162525847072L;

	@Autowired
	private UserManage userManage;

	private CData userInfo;

	private ServletRequest request;

	public String updateInput() throws Exception {
		data.setString("userId", data.getString("detailUserId"));

		userInfo = userManage.retrieveUserDetail(data);
		return UPDATE_INPUT;
	}

	@Override
	public String list() throws Exception {

		return SUCCESS;
	}

	public UserManage getUserManage() {
		return userManage;
	}

	@Autowired
	public void setUserManage(UserManage userManage) {
		this.userManage = userManage;
	}

	public CData getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(CData userInfo) {
		this.userInfo = userInfo;
	}

	/*
	 * 检查原密码是否正确
	 */
	public String checkPwd() {
		HttpServletRequest request = Struts2Utils.getRequest();
		CData input = new CData();
		try {
			String userId = LoginUserData.getCurrentUserData().getUserId();
			input.setString("detailUserId", userId);
			CData result = userManage.retrieveUserDetail(input);

			String origpwd = SecurityCodeUtil.Encode(request.getParameter("origpwd"));
			if (origpwd.equals(result.get("password"))) {
				//	System.out.println("原密码正确");
			} else {
				Struts2Utils.renderText("false");
			}
		} catch (Exception e) {
			Struts2Utils.renderText("sessionout");
		}

		//因为直接输出内容而不经过jsp,因此返回null.
		return null;
	}

	public String updatePwd() throws Exception {

		String userId = LoginUserData.getCurrentUserData().getUserId();

		CData input = new CData();
		input.setString("detailUserId", userId);
		CData result = userManage.retrieveUserDetail(input);

		String origpwd = SecurityCodeUtil.Encode(data.getString("origPwd"));

		if (origpwd.equals(result.get("password"))) {
			data.setString("userId", userId);
			data.setString("createBy", userId);
			data.setString("password", SecurityCodeUtil.Encode(data.getString("newPwd")));
			userManage.updateUserPwd(data);
			addActionMessage("修改成功!");
		} else {
			addActionMessage("原密码错误!");

		}

		return SUCCESS;
	}
}
