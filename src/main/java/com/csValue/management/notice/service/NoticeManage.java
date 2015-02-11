package com.csValue.management.notice.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.Page;

import ssdevframework.core.collection.CData;

import com.csValue.management.notice.dao.NoticeDao;

/**
 * 
* @ClassName: NoticeManage
* @Description: 公告管理逻辑层
* @author lixinliang
* @date 2011-5-20 上午10:31:13
*
 */
@Component
@Transactional
public class NoticeManage {

	@Autowired
	private NoticeDao noticeDao;

	/**
	 * 
	 * 分页查询公告
	 * returnType：Page<CData>
	 * 2011-5-20 上午10:34:51
	 */
	public Page<CData> list(Page<CData> page, CData query) {
		return noticeDao.list(page, query);
	}

	/**
	 * 
	 * 查询公告明细
	 * returnType：CData
	 * 2011-5-20 下午06:06:10
	 */
	public CData noticeDetail(String noticeId) {
		return noticeDao.noticeDetail(noticeId);
	}

	/**
	 * 
	 * 保存公告
	 * returnType：String
	 * 2011-5-21 下午11:14:57
	 */
	public void saveNotice(CData data) {
		String noticeId = data.getString("noticeId");
		if (noticeId == null || noticeId.equals("")) {
			noticeDao.addNotice(data);
		} else {
			noticeDao.updateNotice(data);
		}

	}
}
