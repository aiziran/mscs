package com.csValue.basicInfor.codeGroupManage.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springside.modules.orm.Page;

import ssdevframework.core.collection.CData;

import com.csValue.common.util.dao.PageDao;

@Component
public class CodeGroupDao extends SqlSessionDaoSupport {

	@Autowired
	private PageDao pageDao;

	public Page<CData> retrieveCodeGroupList(Page<CData> page, CData input) {
		return pageDao.getPageList("codeGroupManage.retrieveCodeGroupList", page, input);
//
	}

	public CData retrieveGroupCodeDetail(CData input) {
		return (CData) this.getSqlSession().selectOne("codeGroupManage.retrieveGroupCodeDetail", input);
	}

	public int updateGroupCodeDo(CData input) {
		return this.getSqlSession().update("codeGroupManage.updateGroupCodeDo", input);
	}

	public CData retrieveCodeGroup(CData input) {
		return (CData) this.getSqlSession().selectOne("codeGroupManage.retrieveCodeGroup", input);
	}

	@SuppressWarnings("unchecked")
	public List<CData> retrieveGroupCode(CData input) {
		return this.getSqlSession().selectList("codeGroupManage.retrieveGroupCode", input);
	}

	@SuppressWarnings("unchecked")
	public List<CData> retrieveGroupCodeName(CData input) {
		return this.getSqlSession().selectList("codeGroupManage.retrieveGroupCodeName", input);
	}

	public int createCodeGroup(CData input) {
		return this.getSqlSession().insert("codeGroupManage.createCodeGroup", input);
	}

	public int deleteCodeGroup(CData input) {
		return this.getSqlSession().delete("codeGroupManage.deleteCodeGroup", input);
	}

}
