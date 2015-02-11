package com.csValue.common.chart;

import java.util.Date;
import java.util.Map;

import org.jfree.data.category.DefaultCategoryDataset;

import ssdevframework.core.collection.CMultiData;
import de.laures.cewolf.DatasetProduceException;
import de.laures.cewolf.DatasetProducer;

public class InitVerticalBar implements DatasetProducer {

	//柱图
	CMultiData result = new CMultiData();//

	public InitVerticalBar(CMultiData result) {
		this.result = result;
	}

	public InitVerticalBar() {

	}

	public String getProducerId() {
		return null;
	}

	public boolean hasExpired(Map arg0, Date arg1) {
		return true;
	}

	public Object produceDataset(Map arg0) throws DatasetProduceException {
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		// 往数据集中添加绘制图表所需的数据     
		for (int i = 0; i < result.getDataCount("verType"); i++) {

			dataset.addValue(result.getDouble("verNum", i), result.getString("verName", i),
					result.getString("verType", i));
		}
		return dataset;
	}

}
