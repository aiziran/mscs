package com.csValue.common.tree.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import ssdevframework.core.collection.CData;

import com.csValue.common.tree.dao.TreeDao;

@Component
public class TreeManage {

	@Autowired
	private TreeDao treeDao;

	public List<CData> retrieveDrugTypeTree(CData input) {
		return treeDao.retrieveDrugTypeTree(input);
	}
}
