package com.csValue.basicInfor.menu.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import ssdevframework.core.collection.CData;
import ssdevframework.core.collection.CMultiData;
import ssdevframework.core.exception.ServiceException;

import com.csValue.basicInfor.menu.dao.MenuDao;

@Component
@Transactional
public class MenuManage {

	@Autowired
	private MenuDao dao;

	public CMultiData menuList() {
		return dao.menuList();
	}

	public CData menuDetail(CData data) {
		return dao.menuDetail(data);
	}

	public CData createMenu(CData data) {
		return dao.createMenu(data);
	}

	public void createMenuDo(CData data) throws Exception {
		try {
			dao.createMenuDo(data);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new ServiceException("hmis.err.Service.menu.createMenuDo", e);
		}
	}

	public void updateMenuDo(CData data) throws Exception {
		try {
			dao.updateMenuDo(data);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new ServiceException("hmis.err.Service.menu.updateMenuDo", e);
		}
	}

}
