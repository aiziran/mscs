package com.csValue.management.config.web;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.csValue.common.util.Config;
import com.csValue.management.config.service.ConfigManage;

import ssdevframework.front.action.BaseActionSupport;

/**
 * 
 * @ClassName: ConfigAction 
 * @Description: TODO
 *      系统设置
 * @author houyingchang hougebest@163.com 
 * @date 2011-5-31 下午12:11:58 
 *
 */
@Namespace("/management/config")
@Results({ @Result(name = BaseActionSupport.RELOAD, location = "config.action", type = "redirectParams") })
public class ConfigAction extends BaseActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Autowired
	private ConfigManage manage;
	@Override
	public String list() throws Exception {
		// TODO Auto-generated method stub
		data.set("newFilePath",Config.getInstance().getNodeText("/root/expFilePath"));
		data.set("saftyFactorHigh",Config.getInstance().getNodeText("/root/saftyFactorHigh"));
		data.set("saftyFactorLow",Config.getInstance().getNodeText("/root/saftyFactorLow"));
		data.set("purRuleRoundMethod", Config.getInstance().getNodeText("/root/purRuleRoundMethod"));
		data.set("purPlanRoundMethod", Config.getInstance().getNodeText("/root/purPlanRoundMethod"));
		return SUCCESS;
	}
	
	public String saveConfig()throws Exception{
		manage.saveConfig(data);
		return  BaseActionSupport.RELOAD;
	}

}
