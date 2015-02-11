package com.csValue.common.util.module;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springside.modules.orm.PropertyFilter;
import org.springside.modules.utils.web.struts2.Struts2Utils;

public class RequestFilter {

	/**
	 * 
	 * @Description: 
	 * 		用于统一接收查询条件使用，查询条件的字段格式为应该以：
	 * 			"filter_QES_"+字段名
	 * 		如：
	 * 			<input type="text" name="filter_EQS_loginName" value="${param['filter_EQS_loginName']}" size="9"/>
	 * @author caoshengquan csq39@126.com  2011-4-9 上午11:31:22
	 * @param  @param request
	 * @param  @return
	 * @return HashMap<String,String>
	 * @throws
	 */
	public static HashMap<String,String> getQuestFilter(final HttpServletRequest request) {
		HashMap<String,String> map = new HashMap<String,String>();
		List<PropertyFilter> filters = PropertyFilter.buildFromHttpRequest(Struts2Utils.getRequest());
		
		for(PropertyFilter filterMap:filters){			
			try {
				map.put((String)filterMap.getPropertyNames()[0],(String)filterMap.getMatchValue());
			} catch (Exception e) {
				System.out.print("请确认参数是否完整，完整的格式应该为：name=\"filter_QES_\"+字段名");
			}
		}
		return map;
	}
}
