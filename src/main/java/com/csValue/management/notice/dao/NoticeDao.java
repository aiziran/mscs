package com.csValue.management.notice.dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springside.modules.orm.Page;

import ssdevframework.core.collection.CData;

import com.csValue.common.util.dao.PageDao;

/**
 * 
* @ClassName: NoticeDao
* @Description: 公告管理 数据操作层
* @author lixinliang
* @date 2011-5-20 上午10:32:13
*
 */
@Component
public class NoticeDao extends SqlSessionDaoSupport {

	@Autowired
	private PageDao pageDao;

	/**
	 * 
	 * 分页查询公告
	 * returnType：Page<CData>
	 * 2011-5-20 上午10:35:18
	 */
	public Page<CData> list(Page<CData> page, CData query) {
		return pageDao.getPageList("notice.retrieveNoticeBoardList", page, query);
	}

	/**
	 * 
	 * 查询打个公告
	 * returnType：CData
	 * 2011-5-20 下午06:05:30
	 */
	public CData noticeDetail(String noticeId) {
		return (CData) this.getSqlSession().selectOne("notice.retrieveNoticeBoardDetai", noticeId);
	}

	/**
	 * 
	 * 添加公告
	 * returnType：void
	 * 2011-5-21 下午11:18:11
	 */
	public int addNotice(CData data) {
		return this.getSqlSession().insert("notice.insertNoticeBoardDetail", data);
	}

	/**
	 * 
	 * 修改公告
	 * returnType：void
	 * 2011-5-21 下午11:18:18
	 */
	public int updateNotice(CData data) {
		return this.getSqlSession().update("notice.updateNoticeBoardDetail", data);
	}
}
