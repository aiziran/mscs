package com.csValue.basicInfor.userManage.web;

import java.util.ArrayList;

import java.util.List;


import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.utils.web.struts2.Struts2Utils;

import ssdevframework.core.collection.CData;
import ssdevframework.front.action.BaseActionSupport;

import com.csValue.basicInfor.comboMange.service.ComboManage;
import com.csValue.basicInfor.userManage.service.UserManage;
import com.csValue.common.login.entity.LoginUserData;
import com.csValue.common.util.dao.DaoUtil;
import com.csValue.common.util.web.AjaxUtil;

/**
 * 
 * @Description: 用户管理
 * @ClassName: UserAction 
 * @author caoshengquan csq39@126.com 
 * @date 2011-4-9 上午11:42:10 
 */
/**
@Results({ @Result(name = BaseActionSupport.RELOAD, location = "user.action", params = { "selShowpageNO",
		"%{data.selShowpageNO}", "selPageRow", "%{data.selPageRow}", "selPageOrderBy", "%{data.selPageOrderBy}",
		"selPageOrder", "%{data.selPageOrder}", "queryUserId", "%{data.queryUserId}", "queryUserName",
		"%{data.queryUserName}", "queryDepartment", "%{data.queryDepartment}", "queryRoleName", "%{data.queryRoleName}" }, type = "redirect") })*/
@Namespace("/basicInfor/userManage")
@Results({ @Result(name = BaseActionSupport.RELOAD, location = "user.action", type = "redirectParams") })
public class UserAction extends BaseActionSupport {

	private static final long serialVersionUID = 8683878162525847072L;

	@Autowired
	private UserManage userManage;

	@Autowired
	private ComboManage comboManage;
	
	private String authId;
	private ArrayList<CData> codeDeptList;

	private ArrayList<CData> codeAuthList;

	private ArrayList<CData> hosList;

	private ArrayList<CData> suppList;
	
	private List<CData> allURL;

	public List<CData> getAllURL() {
		return allURL;
	}

	public void setAllURL(List<CData> allURL) {
		this.allURL = allURL;
	}

	public String getAuthId() {
		return authId;
	}

	public void setAuthId(String authId) {
		this.authId = authId;
	}

	public ArrayList<CData> getHosList() {
		return hosList;
	}

	public void setHosList(ArrayList<CData> hosList) {
		this.hosList = hosList;
	}

	public ArrayList<CData> getSuppList() {
		return suppList;
	}

	public void setSuppList(ArrayList<CData> suppList) {
		this.suppList = suppList;
	}

	private ArrayList<CData> codeGroupList;

	private ArrayList<CData> positionList;

	private List<CData> subDeptList = new ArrayList<CData>();

	private CData userInfo;

	private Page<CData> page = new Page<CData>();

	public String createInput() throws Exception {
		codeDeptList = comboManage.retrieveDeptAuthList(new CData());
		codeGroupList = comboManage.retrieveDeptListALL();
		codeAuthList = comboManage.retrieveAuthList();
		allURL = userManage.findAllURL();
		return CREATE_INPUT;
	}
	
	public String updateInput() throws Exception {
		data.setString("userId", data.getString("detailUserId"));
		codeDeptList = comboManage.retrieveDeptAuthList(data);
		codeGroupList = comboManage.retrieveDeptListALL();
		codeAuthList = comboManage.retrieveAuthList();
		userInfo = userManage.retrieveUserDetail(data);
		if(userInfo!=null) {
			this.authId=userInfo.get("code").toString();
		}
		allURL = userManage.findAllURL();
		return UPDATE_INPUT;
	}
	

	@Override
	public String list() throws Exception {
		codeGroupList = comboManage.retrieveDeptListALL();
		page = userManage.userList(page, data);
		return SUCCESS;
	}
	//机手信息
	public String hander() throws Exception {
		codeGroupList = comboManage.retrieveDeptListALL();
		page = userManage.handerList(page, data);
		return "hander";
	}
	public String handerDetail() throws Exception {
		codeGroupList = comboManage.retrieveDeptListALL();
		page = userManage.handerList(page, data);
		return "handerdetail";
	}
	//机手新增页面
	@SuppressWarnings("unchecked")
	public String createHander() throws Exception {
			codeDeptList = comboManage.retrieveDeptAuthList(new CData());
			codeGroupList = comboManage.retrieveDeptListALL();
			codeAuthList=comboManage.handerAuthList();
		     return "createhander";
	}
	
	//机手更新页面
	public String updateHander() throws Exception {
		data.setString("userId", data.getString("detailUserId"));
		codeDeptList = comboManage.retrieveDeptAuthList(data);
		codeGroupList = comboManage.retrieveDeptListALL();
		codeAuthList=comboManage.handerAuthList();
		userInfo = userManage.retrieveUserDetail(data);
		this.authId=userInfo.get("code").toString();
		return "updatehander";
	}
   //机手新增或更改保存
	public String savehander() throws Exception {
		data.setString("createBy", LoginUserData.getCurrentUserData().getUserId());

		if ("create".equals(data.getString("operateModel"))) {
			userManage.createUser(data);
		} else if ("update".equals(data.getString("operateModel"))) {
			userManage.updateUserDetail(data);
		}
		codeGroupList = comboManage.retrieveDeptListALL();
		page = userManage.handerList(page, data);
		return "hander";
	}
	//机手删除
	public String deleteHander(){
		userManage.deleteUser(data);
		codeGroupList = comboManage.retrieveDeptListALL();
		page = userManage.handerList(page, data);
		return "hander";
	}
	
	
	//质检员信息
	public String inspector() throws Exception {
		codeGroupList = comboManage.retrieveDeptListALL();
		page = userManage.inspectorList(page, data);
		return "inspector";
	}
	//质检员新增页面

	public String createInspector() throws Exception {
			codeDeptList = comboManage.retrieveDeptAuthList(new CData());
			codeGroupList = comboManage.retrieveDeptListALL();
			codeAuthList=comboManage.inspectorAuthList();
		     return "createinspector";
	}
	
	//质检员更新页面
	public String updateInspector() throws Exception {
		data.setString("userId", data.getString("detailUserId"));
		codeDeptList = comboManage.retrieveDeptAuthList(data);
		codeGroupList = comboManage.retrieveDeptListALL();
		codeAuthList=comboManage.inspectorAuthList();
		
		userInfo = userManage.retrieveUserDetail(data);
		this.authId=userInfo.get("code").toString();
		return "updateinspector";
	}
   //质检员新增或更改保存
	public String saveInspector() throws Exception {
		data.setString("createBy", LoginUserData.getCurrentUserData().getUserId());

		if ("create".equals(data.getString("operateModel"))) {
			userManage.createUser(data);
		} else if ("update".equals(data.getString("operateModel"))) {
			userManage.updateUserDetail(data);
		}
		codeGroupList = comboManage.retrieveDeptListALL();
		page = userManage.inspectorList(page, data);
		return "inspector";
	}
	//质检员删除
	public String deleteInspector(){
		userManage.deleteUser(data);
		codeGroupList = comboManage.retrieveDeptListALL();
		page = userManage.inspectorList(page, data);
		return "inspector";
	}
	
	
	@Override
	public String save() throws Exception {
		data.setString("createBy", LoginUserData.getCurrentUserData().getUserId());
		
		if ("create".equals(data.getString("operateModel"))) {
			userManage.createUser(data);
		} else if ("update".equals(data.getString("operateModel"))) {
			userManage.updateUserDetail(data);
		}
		return BaseActionSupport.RELOAD;
	}
	
	public String checkUserName(){
		if ("0".equals(userManage.checkUserName(data))) {
			Struts2Utils.renderText("true");
		} else {
			Struts2Utils.renderText("false");
		}
		//因为直接输出内容而不经过jsp,因此返回null.
		return null;
	}


	public String deleteuser(){
		userManage.deleteUser(data);
		return BaseActionSupport.RELOAD;
	}
	
	public Page<CData> getPage() {
		return page;
	}

	public void setPage(Page<CData> page) {
		this.page = page;
	}

	public UserManage getUserManage() {
		return userManage;
	}

	@Autowired
	public void setUserManage(UserManage userManage) {
		this.userManage = userManage;
	}

	public ArrayList<CData> getCodeDeptList() {
		return codeDeptList;
	}

	public void setCodeDeptList(ArrayList<CData> codeDeptList) {
		this.codeDeptList = codeDeptList;
	}

	public ArrayList<CData> getCodeAuthList() {
		return codeAuthList;
	}

	public void setCodeAuthList(ArrayList<CData> codeAuthList) {
		this.codeAuthList = codeAuthList;
	}

	public ArrayList<CData> getCodeGroupList() {
		return codeGroupList;
	}

	public void setCodeGroupList(ArrayList<CData> codeGroupList) {
		this.codeGroupList = codeGroupList;
	}

	public ArrayList<CData> getPositionList() {
		return positionList;
	}

	public void setPositionList(ArrayList<CData> positionList) {
		this.positionList = positionList;
	}

	public CData getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(CData userInfo) {
		this.userInfo = userInfo;
	}

	public String checkUserId() {
		HttpServletRequest request = Struts2Utils.getRequest();
		String userId = request.getParameter("userId");
		if (userManage.isUserIdUnique(userId).equals("0")) {
			Struts2Utils.renderText("true");
		} else {
			Struts2Utils.renderText("false");
		}
		//因为直接输出内容而不经过jsp,因此返回null.
		return null;
	}

	public void setSubDeptList(List<CData> subDeptList) {
		this.subDeptList = subDeptList;
	}

	public List<CData> getSubDeptList() {
		return subDeptList;
	}

	public String retriveSubDeptList() {
		Struts2Utils.renderXml(
				AjaxUtil.convert2MultidataXml2(DaoUtil.ConvertList2CMulti(comboManage.retrieveSubDeptList(data))),
				"encoding:UTF-8");
		return null;
	}
	
}
