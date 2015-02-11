package com.csValue.common.popup.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springside.modules.orm.Page;

import ssdevframework.core.collection.CData;

import com.csValue.common.popup.dao.PopupDao;

@Component
public class PopupManage {

	@Autowired
	private PopupDao popupDao;

	public Page<CData> retrieveCartypeListPopup(Page<CData> page, CData input) {
		return popupDao.retrieveCartypeListPopup(page, input);
	}

	public Page<CData> retrieveArchivesListPopup(Page<CData> page, CData input) {
		return popupDao.retrieveArchivesListPopup(page, input);
	}

	public Page<CData> lendDetail(Page<CData> page, CData input) {
		return popupDao.lendDetail(page, input);
	}

	public Page<CData> retrieveGridListPopup(Page<CData> page, CData input) {
		return popupDao.retrieveGridListPopup(page, input);
	}

	public Page<CData> retrieveCabinetListPopup(Page<CData> page, CData input) {
		return popupDao.retrieveCabinetListPopup(page, input);
	}

	public Page<CData> retrieveUserListPopup(Page<CData> page, CData input) {
		return popupDao.retrieveUserListPopup(page, input);
	}

	public Page<CData> retrieveDeptListPopup(Page<CData> page, CData input) {
		return popupDao.retrieveDeptListPopup(page, input);
	}

	public Page<CData> retrieveDeptPopup(Page<CData> page, CData input) {
		return popupDao.retrieveDeptPopup(page, input);
	}

	public Page<CData> sendto(Page<CData> page, CData data) {
		return popupDao.sendto(page, data);
	}

	public Page<CData> retrieveTypePopup(Page<CData> page, CData input) {
		return popupDao.retrieveTypeListPopup(page, input);
	}

	public Page<CData> loanNotesListPopup(Page<CData> page, CData input) {
		return popupDao.loanNotesListPopup(page, input);
	}

	public Page<CData> printNotesListPopup(Page<CData> page, CData input) {
		return popupDao.printNotesListPopup(page, input);
	}

	public Page<CData> exportNotesListPopup(Page<CData> page, CData data) {
		return popupDao.exportNotesListPopup(page, data);
	}

	public Page<CData> lendcheck(Page<CData> page, CData data) {
		return popupDao.lendcheck(page, data);
	}

	public Page<CData> contractType(Page<CData> page, CData data) {
		return popupDao.contractType(page, data);
	}

	public Page<CData> selectDeputy(Page<CData> page, CData data) {
		return popupDao.selectDeputy(page, data);
	}

	public String selectArchiveName(CData data) {
		// TODO Auto-generated method stub
		return popupDao.selectArchiveName(data);
	}

	public String selectUser(CData data) {
		return popupDao.selectUser(data);
	}
	
	public Page<CData> salecontractList(Page<CData> page, CData input) {
		return popupDao.salecontractList(page, input);
	}

	public Page<CData> officesupplyname(Page<CData> page, CData data) {
		return popupDao.officesupplyname(page, data);
	}

}
