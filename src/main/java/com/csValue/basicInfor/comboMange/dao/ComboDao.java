package com.csValue.basicInfor.comboMange.dao;

import java.util.ArrayList;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Component;

import ssdevframework.core.collection.CData;

import com.csValue.common.login.entity.LoginUserData;

@Component
public class ComboDao extends SqlSessionDaoSupport {

	//医院列表
	@SuppressWarnings("unchecked")
	public ArrayList<CData> retrieveHosList() {
		return (ArrayList<CData>) this.getSqlSession().selectList("comboManage.retrieveHosListALL");
	}

	//供应商列表
	@SuppressWarnings("unchecked")
	public ArrayList<CData> retrieveSupplierList() {
		return (ArrayList<CData>) this.getSqlSession().selectList("comboManage.retrieveSupplierListALL");
	}

	//部门所有列表
	@SuppressWarnings("unchecked")
	public ArrayList<CData> retrieveDeptListALL() {
		return (ArrayList<CData>) this.getSqlSession().selectList("comboManage.retrieveDeptListALL");
	}

	//部门用户别列表
	@SuppressWarnings("unchecked")
	public ArrayList<CData> retrieveDeptList() {
		CData cdata = new CData();
		cdata.setString("userId", LoginUserData.getCurrentUserData().getUserId());
		return (ArrayList<CData>) this.getSqlSession().selectList("comboManage.retrieveDeptList", cdata);
	}

	//职务列表
	@SuppressWarnings("unchecked")
	public ArrayList<CData> retrievePositionList() {
		return (ArrayList<CData>) this.getSqlSession().selectList("comboManage.retrievePositionList");
	}

	//权限列表
	@SuppressWarnings("unchecked")
	public ArrayList<CData> retrieveAuthList() {
		return (ArrayList<CData>) this.getSqlSession().selectList("comboManage.retrieveAuthList");
	}

	@SuppressWarnings("unchecked")
	public ArrayList<CData> handerAuthList() {
		return (ArrayList<CData>) this.getSqlSession().selectList("comboManage.handerAuthList");
	}
	@SuppressWarnings("unchecked")
	public ArrayList<CData> inspectorAuthList() {
		return (ArrayList<CData>) this.getSqlSession().selectList("comboManage.inspectorAuthList");
	}
	
	

	//根据用户的userId 查询其所辖部门列表
	@SuppressWarnings("unchecked")
	public ArrayList<CData> retrieveDeptAuthList(CData cdata) {
		if (cdata.getString("userId") == null)
			cdata.setString("userId", LoginUserData.getCurrentUserData().getUserId());
		return (ArrayList<CData>) this.getSqlSession().selectList("comboManage.retrieveDeptAuthList", cdata);
	}

	//取得所有状态为'Y'的用户列表
	@SuppressWarnings("unchecked")
	public ArrayList<CData> retrieveUserList() {
		return (ArrayList<CData>) this.getSqlSession().selectList("comboManage.retrievePOCreate");
	}

	//代码组列表
	@SuppressWarnings("unchecked")
	public ArrayList<CData> retrieveCodeGroup() {
		return (ArrayList<CData>) this.getSqlSession().selectList("comboManage.retrieveCodeGroup");
	}

	/*
	 * 部门类型列表  by csq	 * 
	 */
	@SuppressWarnings("unchecked")
	public ArrayList<CData> retrieveDeptTypeList() {
		return (ArrayList<CData>) this.getSqlSession().selectList("comboManage.retrieveDeptTypeList");
	}

	/*
	 * 部门类型列表  by csq	 * 
	 */
	@SuppressWarnings("unchecked")
	public ArrayList<CData> retrieveFenKuList() {
		return (ArrayList<CData>) this.getSqlSession().selectList("comboManage.retrieveFenKuList");
	}

	/*
	 * 采购类别列表  by csq	 * 
	 */
	@SuppressWarnings("unchecked")
	public ArrayList<CData> retrievePoTypeList() {
		return (ArrayList<CData>) this.getSqlSession().selectList("comboManage.retrievePoTypeList");
	}

	@SuppressWarnings("unchecked")
	public ArrayList<CData> retrieveSubDeptList(CData cdata) {
		return (ArrayList<CData>) this.getSqlSession().selectList("comboManage.retrieveSubDeptList", cdata);
	}
}
