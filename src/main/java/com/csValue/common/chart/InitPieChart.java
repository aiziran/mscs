package com.csValue.common.chart;

import java.util.Date;
import java.util.Map;

import org.jfree.data.general.DefaultPieDataset;

import ssdevframework.core.collection.CMultiData;
import de.laures.cewolf.DatasetProduceException;
import de.laures.cewolf.DatasetProducer;

public class InitPieChart implements DatasetProducer {

	CMultiData result = new CMultiData();

	public String getProducerId() {
		return "1";
	}

	public InitPieChart(CMultiData result) {
		this.result = result;
	}

	public InitPieChart() {

	}

	public boolean hasExpired(Map arg0, Date arg1) {
		return true;
	}

	public Object produceDataset(Map arg0) throws DatasetProduceException {

		DefaultPieDataset defaultpiedataset = new DefaultPieDataset();

		for (int i = 0; i < result.getDataCount("pieNum"); i++) {
			defaultpiedataset.setValue(result.getString("pieName", i), result.getDouble("pieNum", i));
		}

		return defaultpiedataset;
	}
}
