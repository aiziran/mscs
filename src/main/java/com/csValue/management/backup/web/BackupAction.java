package com.csValue.management.backup.web;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.utils.web.struts2.Struts2Utils;

import com.csValue.common.util.Config;
import com.csValue.management.backup.service.BackupManage;

import ssdevframework.front.action.BaseActionSupport;

/**
 * 
 * @ClassName: DbBackupAction 
 * @Description: TODO
 *  系统备份
 * @author houyingchang hougebest@163.com 
 * @date 2011-5-28 下午11:08:45 
 *
 */
@Namespace("/management/backup")
@Results({ @Result(name = BaseActionSupport.RELOAD, location = "backup.action", type = "redirectParams") })
public class BackupAction extends BaseActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Autowired
	private BackupManage manage;
	@Override
	public String list() throws Exception {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddhhmmss");
		data.set("newFile",Config.getInstance().getNodeText("/root/expFilePrefix")+sdf.format(new Date()));
		return SUCCESS;
	}
	
	
	public String backUp() throws Exception{
		if(manage.backup(data)==1){
			data.set("queryMessage",1);	
		}else{
			data.set("queryMessage",2);
		}
		return   BaseActionSupport.RELOAD;
	}
}
