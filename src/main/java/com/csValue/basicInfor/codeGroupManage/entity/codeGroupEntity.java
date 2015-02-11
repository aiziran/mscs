package com.csValue.basicInfor.codeGroupManage.entity;

import javax.persistence.Entity;

import com.csValue.common.util.IdEntity;

@Entity
public class codeGroupEntity extends IdEntity {

	private String codeGroup;
	private String codeGroupName;
	private String useFlag;
	private String createDate;
	private String updateData;
	private String createUser;
	private String updataUser;
	private String codeGroupDesc;

	public String getCodeGroup() {
		return codeGroup;
	}

	public void setCodeGroup(String codeGroup) {
		this.codeGroup = codeGroup;
	}

	public String getCodeGroupName() {
		return codeGroupName;
	}

	public void setCodeGroupName(String codeGroupName) {
		this.codeGroupName = codeGroupName;
	}

	public String getUseFlag() {
		return useFlag;
	}

	public void setUseFlag(String useFlag) {
		this.useFlag = useFlag;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getUpdateData() {
		return updateData;
	}

	public void setUpdateData(String updateData) {
		this.updateData = updateData;
	}

	public String getCreateUser() {
		return createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public String getUpdataUser() {
		return updataUser;
	}

	public void setUpdataUser(String updataUser) {
		this.updataUser = updataUser;
	}

	public String getCodeGroupDesc() {
		return codeGroupDesc;
	}

	public void setCodeGroupDesc(String codeGroupDesc) {
		this.codeGroupDesc = codeGroupDesc;
	}

}
