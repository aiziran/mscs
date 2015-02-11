package com.csValue.common.tree.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Component;

import ssdevframework.core.collection.CData;

@Component
public class TreeDao extends SqlSessionDaoSupport {

	@SuppressWarnings("unchecked")
	public List<CData> retrieveDrugTypeTree(CData input) {
		return (List<CData>) this.getSqlSession().selectList("treeManage.retrieveDrugTypeTree", input);
	}
}
