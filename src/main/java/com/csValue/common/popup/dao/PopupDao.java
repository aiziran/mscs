package com.csValue.common.popup.dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springside.modules.orm.Page;

import ssdevframework.core.collection.CData;

import com.csValue.common.util.dao.PageDao;

@Component
public class PopupDao extends SqlSessionDaoSupport {

	@Autowired
	private PageDao pageDao;

	public Page<CData> retrieveCartypeListPopup(Page<CData> page, CData input) {
		return pageDao.getPageList("popupManage.retrieveCartypeListPopup", page, input);
	}

	public Page<CData> retrieveArchivesListPopup(Page<CData> page, CData input) {
		return pageDao.getPageList("popupManage.retrieveArchivesListPopup", page, input);
	}

	public Page<CData> lendDetail(Page<CData> page, CData input) {
		return pageDao.getPageList("popupManage.lendDetail", page, input);
	}

	public Page<CData> retrieveCabinetListPopup(Page<CData> page, CData input) {
		return pageDao.getPageList("popupManage.retrieveCabinetListPopup", page, input);
	}

	public Page<CData> retrieveGridListPopup(Page<CData> page, CData input) {
		return pageDao.getPageList("popupManage.retrieveGridListPopup", page, input);
	}

	public Page<CData> retrieveUserListPopup(Page<CData> page, CData input) {
		return pageDao.getPageList("popupManage.retrieveUserListPopup", page, input);
	}

	public Page<CData> retrieveDeptListPopup(Page<CData> page, CData input) {
		return pageDao.getPageList("popupManage.retrieveDeptListPopup", page, input);
	}

	public Page<CData> retrieveDeptPopup(Page<CData> page, CData input) {
		return pageDao.getPageList("popupManage.retrieveDeptPopup", page, input);
	}

	public Page<CData> sendto(Page<CData> page, CData data) {
		return pageDao.getPageList("popupManage.sendto", page, data);
	}

	public Page<CData> retrieveTypeListPopup(Page<CData> page, CData input) {
		return pageDao.getPageList("popupManage.retrieveTypeListPopup", page, input);
	}

	public Page<CData> loanNotesListPopup(Page<CData> page, CData input) {
		return pageDao.getPageList("popupManage.loanNotesListPopup", page, input);
	}

	public Page<CData> printNotesListPopup(Page<CData> page, CData input) {
		return pageDao.getPageList("popupManage.printNotesListPopup", page, input);
	}

	public Page<CData> exportNotesListPopup(Page<CData> page, CData input) {
		return pageDao.getPageList("popupManage.exportNotesListPopup", page, input);
	}

	public Page<CData> lendcheck(Page<CData> page, CData data) {
		return pageDao.getPageList("popupManage.lendcheck", page, data);
	}

	public Page<CData> contractType(Page<CData> page, CData data) {
		return pageDao.getPageList("popupManage.contractType", page, data);
	}

	public Page<CData> selectDeputy(Page<CData> page, CData data) {
		return pageDao.getPageList("popupManage.selectDeputy", page, data);
	}

	public String selectArchiveName(CData data) {
		// TODO Auto-generated method stub
		return (String) this.getSqlSession().selectOne("popupManage.selectArchiveName", data);
	}

	public String selectUser(CData data) {
		return (String) this.getSqlSession().selectOne("popupManage.selectUser", data);
	}
	
	public Page<CData> salecontractList(Page<CData> page, CData data) {
		return pageDao.getPageList("popupManage.salecontractList", page, data);
	}
	public Page<CData> officesupplyname(Page<CData> page, CData data) {
		return pageDao.getPageList("popupManage.officesupplyname", page, data);
	}

}
