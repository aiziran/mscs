package com.csValue.basicInfor.useRateManage.web;

import java.util.ArrayList;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;

import ssdevframework.core.collection.CData;
import ssdevframework.core.util.DateUtil;
import ssdevframework.front.action.BaseActionSupport;

import com.csValue.basicInfor.comboMange.service.ComboManage;
import com.csValue.basicInfor.useRateManage.service.UseRateManage;

/**
 * 
 * @ClassName: UseRateAction 
 * @date 2011-5-8 下午02:56:46 
 *
 */
@Namespace("/basicInfor/useRateManage")
@Results({ @Result(name = BaseActionSupport.RELOAD, location = "useRate.action", type = "redirect") })
public class UseRateAction extends BaseActionSupport {

	private static final long serialVersionUID = 4222894011756167212L;

	@Autowired
	private UseRateManage useRateManage;
	
	

	@Autowired
	private ComboManage comboManage;

	private ArrayList<CData> codeGroupList;

	public ArrayList<CData> getCodeGroupList() {
		return codeGroupList;
	}

	public void setCodeGroupList(ArrayList<CData> codeGroupList) {
		this.codeGroupList = codeGroupList;
	}

	private Page<CData> page = new Page<CData>();

	@SuppressWarnings("static-access")
	@Override
	public String list() throws Exception {
		//DateUtil dateUtil = new DateUtil();//该实例是多余的
		String date1 = DateUtil.addDays(DateUtil.getCurrentDateString("yyyy-MM-dd"), -7, "yyyy-MM-dd");
		String date2 = DateUtil.getCurrentDateString("yyyy-MM-dd");
		if (data.get("queryStartDate") == null) {
			data.set("queryStartDate", date1);
		}
		if (data.get("queryEndDate") == null) {
			data.set("queryEndDate", date2);
		}
		setCodeGroupList(comboManage.retrieveDeptList());
		page = useRateManage.retrieveUseRateList(page, data);
		return SUCCESS;
	}

	public Page<CData> getPage() {
		return page;
	}

	public void setPage(Page<CData> page) {
		this.page = page;
	}

}
