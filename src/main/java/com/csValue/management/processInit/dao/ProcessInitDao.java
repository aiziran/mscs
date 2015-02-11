package com.csValue.management.processInit.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Component;

import ssdevframework.core.collection.CData;

@Component
public class ProcessInitDao extends SqlSessionDaoSupport{
	
	
	public List<CData>  getOnceMonthProcessDate(){
		return this.getSqlSession().selectList("processInit.retrieveLogHistory");
	}
	public CData executeQueryForSingle(String sqlId,CData input){
		return (CData)this.getSqlSession().selectList(sqlId, input).get(0);
	}
	public int deleteCommonDao(String sqlID, CData data) throws Exception {
		return this.getSqlSession().delete(sqlID, data);
	}
	public int createCommonDao(String sqlID, CData data){
		return this.getSqlSession().insert(sqlID, data);
	}
}
