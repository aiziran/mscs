package com.csValue.common.util;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springside.modules.utils.web.struts2.Struts2Utils;

import ssdevframework.core.collection.CData;

import com.csValue.common.login.entity.LoginUserData;

public class UserInformationUtil {

	public static String getUserDeptId() {
		String dept_id = new String();
		HttpSession session = Struts2Utils.getSession();
		@SuppressWarnings("rawtypes")
		List<HashMap> deptRoleList = ((LoginUserData) session.getAttribute("userSession")).getDeptRoleList();
		if (deptRoleList != null && deptRoleList.size() > 0) {
			dept_id = (String) deptRoleList.get(0).get("code");
		}
		return dept_id;
	}

	public static CData getUserDeptId(CData data) {
		String dept_id = new String();
		HttpSession session = Struts2Utils.getSession();
		@SuppressWarnings("rawtypes")
		List<HashMap> deptRoleList = ((LoginUserData) session.getAttribute("userSession")).getDeptRoleList();
		if (deptRoleList != null && deptRoleList.size() > 0) {
			dept_id = (String) deptRoleList.get(0).get("code");
		}
		data.setString("dept_id", dept_id);
		return data;
	}
}
