package com.csValue.basicInfor.useRateManage.service;


import java.math.BigDecimal;
import java.math.MathContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.Page;

import ssdevframework.core.collection.CData;

import com.csValue.basicInfor.useRateManage.dao.UseRateDao;


@Component
public class UseRateManage {

	@Autowired
	private UseRateDao dao;
	
	@Transactional(readOnly = true)
	public Page<CData> retrieveUseRateList(Page<CData> page,CData input){
		String queryStartDate =(String) input.get("queryStartDate");
		String queryEndDate =(String) input.get("queryEndDate");
		if(queryStartDate==null){
			input.set("queryStartDate", "");
		}
		if(queryEndDate==null){
			input.set("queryEndDate", "");
		}
		page=dao.retrieveUseRateList(page, input);
		for(int i=0;i<page.getResult().size();i++){
			double rankRate = Double.parseDouble(page.getResult().get(i).getString("rank"))/page.getTotalCount()*100;
			page.getResult().get(i).set("rank", String.valueOf(new BigDecimal(rankRate,new MathContext(3)))+"%");
		}
		
		return dao.retrieveUseRateList(page, input);
	}
}
