package com.csValue.common.file.dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Component;

import ssdevframework.core.collection.CData;

@Component
public class FileDao extends SqlSessionDaoSupport {

	public String getFile(CData data) {
		CData file = (CData) this.getSqlSession().selectOne("fileManage.retrieveFilePath", data);
		if (file.isEmpty())
			return "-1";
		else
			return file.getString("filePath");
	}
}
