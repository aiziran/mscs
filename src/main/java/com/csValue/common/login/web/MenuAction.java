package com.csValue.common.login.web;

import java.util.HashMap;
import java.util.List;

import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.csValue.common.login.entity.LoginUserData;
import com.csValue.common.login.service.LoginManager;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("unchecked")
@Results({ @Result(name = "success", location = "/WEB-INF/content/main/TopMenu.jsp"),
		@Result(name = "leftMenu", location = "/WEB-INF/content/main/menu-leftMenu.jsp") })
public class MenuAction extends ActionSupport {

	private static final long serialVersionUID = -3454048507936759984L;

	private LoginManager loginManager;

	private List<HashMap> map;
	private String message;
	private String carinfoCount;
	private String archiveCount;

	private String topMenuId;

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public List<HashMap> getMap() {
		return map;
	}

	public void setMap(List<HashMap> map) {
		this.map = map;
	}

	public String getTopMenuId() {
		return topMenuId;
	}

	public void setTopMenuId(String topMenuId) {
		this.topMenuId = topMenuId;
	}

	public LoginManager getLoginManager() {
		return loginManager;
	}

	@Autowired
	public void setLoginManager(LoginManager loginManager) {
		this.loginManager = loginManager;
	}

	@Override
	public String execute() throws Exception {
		this.map = loginManager.topMenuList(LoginUserData.getCurrentUserData().getRoles());
		return SUCCESS;
	}

	/**
	 * ��˵�
	 * @author csq
	 * @return
	 * @throws Exception
	 */
	public String leftMenuList() throws Exception {
		List roleList = LoginUserData.getCurrentUserData().getRoles();
		HashMap roleMap = new HashMap();
		roleMap.put("authCode", roleList);
		roleMap.put("topMenuId", topMenuId);
		this.map = loginManager.leftMenuList(roleMap);
		HashMap temp = new HashMap();
		for (HashMap menu : map) {
			if (temp.size() != 0)
				temp.put("nextLV", menu.get("MENULVL"));
			else {
				temp.put("nextLV", "");
			}
			temp = menu;
		}
		if (temp.size() != 0)
			temp.put("nextLV", "");
		return "leftMenu";
	}

	public String getCarinfoCount() {
		return carinfoCount;
	}

	public void setCarinfoCount(String carinfoCount) {
		this.carinfoCount = carinfoCount;
	}

	public String getArchiveCount() {
		return archiveCount;
	}

	public void setArchiveCount(String archiveCount) {
		this.archiveCount = archiveCount;
	}
	
	
}
