package com.csValue.basicInfor.codeManage.dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springside.modules.orm.Page;

import ssdevframework.core.collection.CData;

import com.csValue.common.util.dao.PageDao;

@Component
public class CodeDao extends SqlSessionDaoSupport {
	@Autowired
	private PageDao pageDao;

	//代码检索清单
	@SuppressWarnings("unchecked")
	public Page<CData> retrieveCodeList(Page<CData> page, CData codeId) {
		return pageDao.getPageList("codeManage.retrieveCodeList", page, codeId);
	}

	//代码详细检索
	@SuppressWarnings("unchecked")
	public CData retrieveCodeDetail(CData input) {
		return (CData) this.getSqlSession().selectOne("codeManage.retrieveCodeDetail", input);
	}

	//检索代码信息
	@SuppressWarnings("unchecked")
	public CData retrieveCodeInfo(CData input) {
		return (CData) this.getSqlSession().selectOne("codeManage.retrieveCodeInfo", input);
	}

	//新建代码
	public int createCode(CData input) {
		return this.getSqlSession().insert("codeManage.createCode", input);
	}

	//更新代码
	public int updateCode(CData input) {
		return this.getSqlSession().insert("codeManage.updateCode", input);
	}
}
