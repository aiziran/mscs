package com.csValue.common.popup.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.utils.web.struts2.Struts2Utils;

import ssdevframework.core.collection.CData;
import ssdevframework.front.action.BaseActionSupport;

import com.csValue.common.popup.service.PopupManage;

@Namespace("/common/popup")
public class PopupAction extends BaseActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7099709125331989286L;
	private String checkedid;
	private String checkednames;
	@Autowired
	private PopupManage popupManage;
	private Page<CData> page = new Page<CData>();
	private String archivesid;
	private String cabinetid;
	private String participantses;
	private String rlid;
	private String names;
	private String lid;
	private CData datanames = new CData();
	private String username;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public CData getDatanames() {
		return datanames;
	}

	public void setDatanames(CData datanames) {
		this.datanames = datanames;
	}

	public String getNames() {
		return names;
	}

	public void setNames(String names) {
		this.names = names;
	}

	public Page<CData> getPage() {
		return page;
	}

	public String getLid() {
		return lid;
	}

	public void setLid(String lid) {
		this.lid = lid;
	}

	@Override
	public String list() throws Exception {
		return null;
	}

	public String cartype() {
		HttpSession session=Struts2Utils.getSession();
		data.set("approver", session.getAttribute("userID"));
		page = popupManage.retrieveCartypeListPopup(page, data);
		return "cartype";
	}

	public String retrieveGridListPopup() {
		page = popupManage.retrieveGridListPopup(page, data);
		return "grid";
	}

	/**
	 * 获取档案室列表
	 * **/
	public String archives() {
		page = popupManage.retrieveArchivesListPopup(page, data);
		return "archives";
	}

	/**
	 * 获取档案室列表柜子列表
	 * **/
	public String cabinet() {
		System.out.println(archivesid + "adfasfasf");
		data.set("archivesid", archivesid);
		page = popupManage.retrieveCabinetListPopup(page, data);
		return "cabinet";
	}

	public String grid() {
		System.out.println(archivesid + "adfasfasf");
		System.out.println(cabinetid + "cabinetid");
		data.set("archivesid", archivesid);
		data.set("cabinetid", cabinetid);
		page = popupManage.retrieveGridListPopup(page, data);
		return "grid";
	}

	/**
	 * 获取用户列表(单个用户)
	 * **/
	public String userOne() {
		page = popupManage.retrieveUserListPopup(page, data);
		return "userOne";
	}

	/**
	 * 获取用户列表(多个用户)
	 * **/
	public String user() {

		page = popupManage.retrieveUserListPopup(page, data);

		return "user";
	}

	/**
	 * 获取部门
	 * **/
	public String dept() {
		page = popupManage.retrieveDeptListPopup(page, data);
		return "dept";
	}

	public String getRlid() {
		return rlid;
	}

	public void setRlid(String rlid) {
		this.rlid = rlid;
	}

	public String getArchivesid() {
		return archivesid;
	}

	public void setArchivesid(String archivesid) {
		this.archivesid = archivesid;
	}

	public String getParticipantses() {
		return participantses;
	}

	public void setParticipantses(String participantses) {
		this.participantses = participantses;
	}

	/**
	 * 获取发送人
	 * **/
	public String sendto() {
		page = popupManage.sendto(page, data);
		return "sendto";
	}

	public String getCabinetid() {
		return cabinetid;
	}

	public void setCabinetid(String cabinetid) {
		this.cabinetid = cabinetid;
	}

	public String myDept() {
		page = popupManage.retrieveDeptPopup(page, data);
		return "dept";
	}

	public String myType() {
		page = popupManage.retrieveTypePopup(page, data);
		return "type";
	}

	public String getCheckedid() {
		return checkedid;
	}

	public void setCheckedid(String checkedid) {
		this.checkedid = checkedid;
	}

	public String getCheckednames() {
		return checkednames;
	}

	public void setCheckednames(String checkednames) {
		this.checkednames = checkednames;
	}

	public String loan() {
		System.out.println(checkedid);
		System.out.println(checkednames.replace(",", ";"));
		checkednames = checkednames.replace(",", ";");
		List<CData> result = new ArrayList<CData>();
		CData data = new CData();
		data.set("ids", checkedid);
		data.set("names", checkednames);
		result.add(data);
		page.setResult(result);
		return "loan";
	}

	//续借
	public String rlend() {
		String[] ids = rlid.trim().split(";");
		String names = "";
		for (int i = 0; i < ids.length; i++) {
			data.set("aid", ids[i]);
			names += popupManage.selectArchiveName(data) + ";";
		}
		datanames.set("names", names);
		return "rlend";
	}

	//借出
	public String doLend() {
		return "dolend";
	}

	//归还
	public String returnAr() {
		data.set("rlid", rlid);
		username = popupManage.selectUser(data);
		return "returnAr";
	}

	public String lend() {
		System.out.println(data);
		page = popupManage.lendDetail(page, data);
		return "lend";
	}

	public String lendcheck() {
		page = popupManage.lendcheck(page, data);
		return "lendcheck";
	}

	//借出记录
	public String loanNotes() {
		page = popupManage.loanNotesListPopup(page, data);
		return "notesloan";
	}

	//打印记录
	public String printNotes() {
		page = popupManage.printNotesListPopup(page, data);
		return "notesprint";
	}

	//导出PDF记录
	public String exportNotes() {
		page = popupManage.exportNotesListPopup(page, data);
		return "notesexport";
	}

	//合同类型
	public String contractType() {
		page = popupManage.contractType(page, data);
		return "contract";
	}

	//副总编号
	public String selectDeputy() {
		page = popupManage.selectDeputy(page, data);
		return "deputy";
	}

	public String officesupplyname() {
		page = popupManage.officesupplyname(page, data);
		return "officesupply";
	} //销售合同查询

	public String salecontractList() {
		page = popupManage.salecontractList(page, data);
		System.out.println(page);
		return "salecontract";
	}
}
