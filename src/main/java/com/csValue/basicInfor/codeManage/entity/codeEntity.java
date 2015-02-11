package com.csValue.basicInfor.codeManage.entity;

import javax.persistence.Entity;

import com.csValue.common.util.IdEntity;


@Entity
public class codeEntity extends IdEntity{
	private String codeId;
	private String codeGroup;
	private String useFlag;
	private String codeOrder;
	private String createDate;
	private String cteateUser;
	private String updateDate;
	private String updateUser;
	private String codeValue1;
	private String codeValue2;
	private String codeDesc;
	public String getCodeId() {
		return codeId;
	}
	public void setCodeId(String codeId) {
		this.codeId = codeId;
	}
	public String getCodeGroup() {
		return codeGroup;
	}
	public void setCodeGroup(String codeGroup) {
		this.codeGroup = codeGroup;
	}
	public String getUseFlag() {
		return useFlag;
	}
	public void setUseFlag(String useFlag) {
		this.useFlag = useFlag;
	}
	public String getCodeOrder() {
		return codeOrder;
	}
	public void setCodeOrder(String codeOrder) {
		this.codeOrder = codeOrder;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCteateUser() {
		return cteateUser;
	}
	public void setCteateUser(String cteateUser) {
		this.cteateUser = cteateUser;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getUpdateUser() {
		return updateUser;
	}
	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}
	public String getCodeValue1() {
		return codeValue1;
	}
	public void setCodeValue1(String codeValue1) {
		this.codeValue1 = codeValue1;
	}
	public String getCodeValue2() {
		return codeValue2;
	}
	public void setCodeValue2(String codeValue2) {
		this.codeValue2 = codeValue2;
	}
	public String getCodeDesc() {
		return codeDesc;
	}
	public void setCodeDesc(String codeDesc) {
		this.codeDesc = codeDesc;
	}
	

}
