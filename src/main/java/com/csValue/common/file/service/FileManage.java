package com.csValue.common.file.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import ssdevframework.core.collection.CData;

import com.csValue.common.file.dao.FileDao;

@Component
public class FileManage {

	@Autowired
	private FileDao fileDao;

	public String getFile(CData data) {
		return fileDao.getFile(data);
	}

}
