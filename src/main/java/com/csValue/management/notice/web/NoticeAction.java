package com.csValue.management.notice.web;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.utils.web.struts2.Struts2Utils;

import ssdevframework.core.collection.CData;
import ssdevframework.core.util.DateUtil;
import ssdevframework.front.action.BaseActionSupport;

import com.csValue.common.login.entity.LoginUserData;
import com.csValue.common.util.web.AjaxUtil;
import com.csValue.management.notice.service.NoticeManage;

/**
 * 
* @ClassName: NoticeAction
* @Description: 公告管理
* @author lixinliang
* @date 2011-5-20 上午10:22:16
*
 */
@Namespace("/management/notice")
@Results({ @Result(name = BaseActionSupport.RELOAD, location = "notice.action", type = "redirectParams") })
public class NoticeAction extends BaseActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8357822450793273122L;

	@Autowired
	private NoticeManage noticeManage;

	private Page<CData> page = new Page<CData>();

	private CData noticeDetail = new CData();

	@Override
	public String list() throws Exception {
		String curDate = DateUtil.getDBdate();//当前日期
		String startDate = DateUtil.getDBdateAddedDay(-7);//查询条件的默认开始日期
		String endDate = DateUtil.getDBdateAddedDay(7);//新增时，默认的结束日期
		if (data.get("queryEndDate") == null)
			data.set("queryEndDate", curDate);
		if (data.get("queryStartDate") == null)
			data.set("queryStartDate", startDate);

		data.set("curDate", curDate);
		data.set("endDate", endDate);

		LoginUserData user = (LoginUserData) (Struts2Utils.getSession().getAttribute(LoginUserData.USER_DATA_KEY));
		data.set("userId", user.getUserId());

		page = noticeManage.list(page, data);
		if (page.getResult() != null && page.getResult().size() > 0) {
			noticeDetail = page.getResult().get(0);
		}

		return SUCCESS;
	}

	/**
	 * 
	 * 异步查询公告明细
	 * returnType：String
	 * 2011-5-20 下午06:11:20
	 */
	public String noticeDetail() {
		CData noticeDetail = noticeManage.noticeDetail(data.getString("noticeId"));
		Struts2Utils.renderXml(AjaxUtil.convert2FormXml(noticeDetail), "encoding:UTF-8");
		return null;
	}

	/**
	 * 
	 * 保存公告
	 * returnType：String
	 * 2011-5-21 下午11:14:20
	 */
	public String saveNotice() {
		LoginUserData user = (LoginUserData) (Struts2Utils.getSession().getAttribute(LoginUserData.USER_DATA_KEY));
		data.set("userId", user.getUserId());
		noticeManage.saveNotice(data);
		return BaseActionSupport.RELOAD;
	}

	public Page<CData> getPage() {
		return page;
	}

	public void setPage(Page<CData> page) {
		this.page = page;
	}

	public CData getNoticeDetail() {
		return noticeDetail;
	}

	public void setNoticeDetail(CData noticeDetail) {
		this.noticeDetail = noticeDetail;
	}

}
