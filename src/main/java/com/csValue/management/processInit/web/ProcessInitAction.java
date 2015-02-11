package com.csValue.management.processInit.web;

import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;

import com.csValue.management.processInit.service.ProcessInitManage;

import ssdevframework.front.action.BaseActionSupport;

/**
 * 
 * @ClassName: processInitAction 
 * @Description: TODO
 *     业务数据处理
 * @author houyingchang hougebest@163.com 
 * @date 2011-5-28 上午09:40:08 
 *
 */
@Namespace("/management/processInit")
public class ProcessInitAction extends BaseActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Autowired
	private ProcessInitManage manage;

	@SuppressWarnings("unchecked")
	private List historyLog;
	@Override
	public String list() throws Exception {
		historyLog =manage.getOnceMonthProcessDate();
		return SUCCESS;
	}
	@SuppressWarnings("unchecked")
	public List getHistoryLog() {
		return historyLog;
	}
	@SuppressWarnings("unchecked")
	public void setHistoryLog(List historyLog) {
		this.historyLog = historyLog;
	}
	
	public String processImportSto() throws Exception{
		data=manage.processImportSto(data);
		return "select";
	}

}
