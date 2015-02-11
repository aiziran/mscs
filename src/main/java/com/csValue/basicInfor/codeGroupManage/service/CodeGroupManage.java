package com.csValue.basicInfor.codeGroupManage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.Page;

import ssdevframework.core.collection.CData;

import com.csValue.basicInfor.codeGroupManage.dao.CodeGroupDao;

@Component
@Transactional
public class CodeGroupManage {
	@Autowired
	private CodeGroupDao dao;

	@Transactional(readOnly = true)
	public Page<CData> retrieveCodeGroupList(Page<CData> page, CData input) {
		return dao.retrieveCodeGroupList(page, input);
	}

	public CData retrieveGroupCodeDetail(CData input) {
		return dao.retrieveGroupCodeDetail(input);
	}

	public int createCodeGroup(CData input) {
		return dao.createCodeGroup(input);
	}

	public int updateCodeGroup(CData input) {
		return dao.updateGroupCodeDo(input);
	}

	// 返回1时是CodeGroupID重复，返回2时是CodeGroup name重复,返回0时是CodeGroup不重复,
	public String checkCodeGroup(CData input) {
		if ("create".equals(input.getString("mode"))) {
			if (input.getString("codeGroup") != null) {
				List<CData> codeList = dao.retrieveGroupCode(input);
				if (codeList.size() > 0)
					return "1";
			}
			if (input.getString("codeGroupName") != null) {
				List<CData> codeList = dao.retrieveGroupCodeName(input);
				if (codeList.size() > 0)
					return "2";
			}
		}
		if ("update".equals(input.getString("mode"))) {
			if (input.getString("codeGroupName") != null) {
				List<CData> codeList = dao.retrieveGroupCodeName(input);
				if (codeList.size() > 0)
					return "2";
			}
		}
		return "0";
	}

}
