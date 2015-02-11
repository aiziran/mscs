/**
 * 
 */
package com.csValue.basicInfor.deptManage.web;

import java.util.ArrayList;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;

import ssdevframework.core.collection.CData;
import ssdevframework.front.action.BaseActionSupport;

import com.csValue.basicInfor.comboMange.service.ComboManage;
import com.csValue.basicInfor.deptManage.service.DeptManage;
import com.csValue.basicInfor.userManage.service.UserManage;
import com.csValue.common.login.entity.LoginUserData;

/**
 * 
 * @Description: 部门管理
 * @ClassName: DeptAction
 * @author SSQ
 * @date 2012-1-3 上午11:42:10
 */
@Namespace("/basicInfor/deptManage")
@Results({ @Result(name = BaseActionSupport.RELOAD, location = "dept.action", type = "redirectParams") })
public class DeptAction extends BaseActionSupport {

	@Autowired
	private DeptManage deptManage;

	@Autowired
	private UserManage userManage;

	private ArrayList<CData> deptTypeList;
	private CData deptInfo;
	private String username;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	private Page<CData> page = new Page<CData>();

	@Autowired
	private ComboManage comboManage;

	public String createInput() throws Exception {
		setDeptTypeList(comboManage.retrieveDeptTypeList());
		return CREATE_INPUT;
	}

	public String updateInput() throws Exception {
		setDeptTypeList(comboManage.retrieveDeptTypeList());
		setDeptInfo(deptManage.retrieveUserDetail(data));
		return UPDATE_INPUT;
	}

	@Override
	public String list() throws Exception {
		setDeptTypeList(comboManage.retrieveDeptTypeList());
		page = deptManage.deptList(page, data);
		return SUCCESS;
	}

	@Override
	public String save() throws Exception {
		data.setString("createBy", LoginUserData.getCurrentUserData().getUserId());

		if ("create".equals(data.getString("operateModel"))) {
			deptManage.saveDept(data);
		} else if ("update".equals(data.getString("operateModel"))) {
			deptManage.updateDept(data);
		}
		return BaseActionSupport.RELOAD;
	}

	public String deleteDo() throws Exception {
		data.setString("createBy", LoginUserData.getCurrentUserData().getUserId());

		/**
		 * 检查数据权限有没有被用户引用 deptId
		 */
		CData result = userManage.isDeptUsing(data);
		if (!result.getString("cnt").equals("0")) {
			addActionMessage("此数据权限被用户引用，不能删除！");

			return "error";
		} else {
			deptManage.deleteDo(data);
			return BaseActionSupport.RELOAD;
		}
	}

	public DeptManage getDeptManage() {
		return deptManage;
	}

	public void setDeptManage(DeptManage deptManage) {
		this.deptManage = deptManage;
	}

	public CData getDeptInfo() {
		return deptInfo;
	}

	public void setDeptInfo(CData deptInfo) {
		this.deptInfo = deptInfo;
	}

	public Page<CData> getPage() {
		return page;
	}

	public void setPage(Page<CData> page) {
		this.page = page;
	}

	public ArrayList<CData> getDeptTypeList() {
		return deptTypeList;
	}

	public void setDeptTypeList(ArrayList<CData> deptTypeList) {
		this.deptTypeList = deptTypeList;
	}

}
