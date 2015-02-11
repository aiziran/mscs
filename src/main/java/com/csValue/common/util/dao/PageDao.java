package com.csValue.common.util.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Component;
import org.springside.modules.orm.Page;

import ssdevframework.core.collection.CData;

@Component
public class PageDao extends SqlSessionDaoSupport {

	@SuppressWarnings("unchecked")
	public Page<CData> getPageList(String querySql, Page<CData> page, CData query) {

		if (query.getString("selPageRow") == null || "".equals(query.getString("selPageRow")))
			query.setInt("selPageRow", 1);

		if (query.getString("selShowpageNO") == null || "".equals(query.getString("selShowpageNO")))
			query.setInt("selShowpageNO", 10);

		if (query.getString("selPageOrderBy") != null && !"".equals(query.getString("selPageOrderBy")))
			page.setOrderBy(query.getString("selPageOrderBy"));

		if (query.getString("selPageOrder") != null && !"".equals(query.getString("selPageOrder")))
			page.setOrder(query.getString("selPageOrder"));

		page.setPageNo(query.getInt("selPageRow"));
		page.setPageSize(query.getInt("selShowpageNO"));

		int pageId = (page.getPageNo() - 1) * page.getPageSize();
		int limit = page.getPageSize();
		page.setResult(getSqlSession().selectList(querySql, query, new RowBounds(pageId, limit)));
		List pageNum = getSqlSession().selectList(querySql, query, new RowBounds(-100, -100));
		if (pageNum.size() > 0)
			page.setTotalCount(Long.parseLong(((CData) pageNum.get(0)).get("totalCount").toString()));
		else
			page.setTotalCount(0L);
		return page;
	}
}
