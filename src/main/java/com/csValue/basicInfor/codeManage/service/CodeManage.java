package com.csValue.basicInfor.codeManage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.Page;

import ssdevframework.core.collection.CData;

import com.csValue.basicInfor.codeManage.dao.CodeDao;

@Component
public class CodeManage {
	@Autowired
	private CodeDao dao;

	@Transactional(readOnly = true)
	public Page<CData> retrieveCodeList(Page<CData> page, CData input) {
		return dao.retrieveCodeList(page, input);
	}

	@Transactional(readOnly = true)
	public CData retrieveCodeDetail(CData input) {
		return dao.retrieveCodeDetail(input);
	}

	@Transactional(readOnly = true)
	public CData retrieveCodeInfo(CData input) {
		return dao.retrieveCodeInfo(input);
	}

	public int updateCode(CData input) {
		return dao.updateCode(input);
	}

	public int createCode(CData input) {
		return dao.createCode(input);
	}
}
