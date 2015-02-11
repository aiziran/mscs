package com.csValue.basicInfor.comboMange.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import ssdevframework.core.collection.CData;

import com.csValue.basicInfor.comboMange.dao.ComboDao;
import com.csValue.common.login.entity.LoginUserData;

/**
 * 
 * @author SSQ
 *
 * CsValue项目所有下拉框信息操作
 */
@Component
public class ComboManage {
	@Autowired
	private ComboDao combodao;
	//部门列表
	public ArrayList<CData> retrieveDeptListALL() {
		return combodao.retrieveDeptListALL();
	}

	//部门用户别列表
	@SuppressWarnings("unchecked")
	public ArrayList<CData> retrieveDeptList() {
		ArrayList<CData> list = new ArrayList<CData>();
		if ("999999".equals(LoginUserData.getCurrentUserData().getLoginDeptId())) {//
			CData headData = new CData();
			headData.put("code", "");
			headData.put("value", "全部");
			list.add(headData);
			list.addAll(combodao.retrieveDeptList());
		} else {
			CData headData = new CData();
			headData.put("code", LoginUserData.getCurrentUserData().getLoginDeptId());
			list.add(headData);
		}
		return list;
	}

	public ArrayList<CData> retrieveHosList() {
		return combodao.retrieveHosList();
	}

	public ArrayList<CData> retrieveSupplierList() {
		return combodao.retrieveSupplierList();
	}

	//权限列表
	public ArrayList<CData> retrieveAuthList() {
		return combodao.retrieveAuthList();
	}
	public ArrayList<CData> handerAuthList() {
		return combodao.handerAuthList();
	}
	public ArrayList<CData> inspectorAuthList() {
		return combodao.inspectorAuthList();
	}
	
	

	//根据用户的userId 查询其所辖部门列表
	public ArrayList<CData> retrieveDeptAuthList(CData cdata) {
		return combodao.retrieveDeptAuthList(cdata);
	}

	//取得所有状态为'Y'的用户列表
	public ArrayList<CData> retrieveUserList() {
		return combodao.retrieveUserList();
	}

	//代码组列表
	public ArrayList<CData> retrieveCodeGroup() {
		return combodao.retrieveCodeGroup();
	}

	/*
	 * 部门类型列表  by csq	 * 
	 */
	public ArrayList<CData> retrieveDeptTypeList() {
		return combodao.retrieveDeptTypeList();
	}

	/*
	 * 部门类型列表  by csq	 * 
	 */
	public ArrayList<CData> retrieveSubDeptList(CData cdata) {
		return combodao.retrieveSubDeptList(cdata);
	}

}
