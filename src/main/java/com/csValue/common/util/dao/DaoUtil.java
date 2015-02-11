package com.csValue.common.util.dao;

import java.util.List;

import ssdevframework.core.collection.CData;
import ssdevframework.core.collection.CMultiData;

/**
 * @ClassName: DaoUtil 
 * @Description: 
 *		dao层用到的类型转换工具类
 * @author caoshengquan csq39@126.com 
 * @date 2011-5-1 下午10:28:04 
 *
 */

public class DaoUtil {

	/**
	 * @Description:
	 * 		把list类型的数据转换Cmutildate类型
	 * @param data
	 * @return  CMultiData
	 * @throws
	 */
	public static CMultiData ConvertList2CMulti(List<CData> data) {
		CMultiData mData = new CMultiData();

		for (CData element : data)
			if (element != null)
				mData.addCData(element);

		return mData;
	}

}
