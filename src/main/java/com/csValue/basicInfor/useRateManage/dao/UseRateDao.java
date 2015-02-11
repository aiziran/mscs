package com.csValue.basicInfor.useRateManage.dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springside.modules.orm.Page;

import ssdevframework.core.collection.CData;

import com.csValue.common.util.dao.PageDao;

@Component
public class UseRateDao extends SqlSessionDaoSupport{

	@Autowired
	private PageDao pageDao;
	
	public Page<CData> retrieveUseRateList(Page<CData> page, CData input) {
		return pageDao.getPageList("useRateManage.retrieveUseRateList", page, input);
	}
}
