package com.csValue.common.util.dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Component;

import ssdevframework.core.collection.CData;

@Component
public class CommonDao extends SqlSessionDaoSupport {

	public String insertFile(CData data) {
		CData fileid = (CData) this.getSqlSession().selectOne("utilManage.retrieveFileId");
		data.set("fileId", fileid.getString("fileId"));
		this.getSqlSession().update("utilManage.insertFile", data);
		return fileid.getString("fileId");
	}
}
