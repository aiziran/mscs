package com.csValue.common.chart;

import java.io.Serializable;
import java.util.Date;
import java.util.Map;

import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;

import ssdevframework.core.collection.CMultiData;
import de.laures.cewolf.DatasetProduceException;
import de.laures.cewolf.DatasetProducer;
import de.laures.cewolf.links.CategoryItemLinkGenerator;
import de.laures.cewolf.tooltips.CategoryToolTipGenerator;

public class InitPageView implements DatasetProducer, CategoryToolTipGenerator, CategoryItemLinkGenerator, Serializable {

	CMultiData result = new CMultiData();

	public InitPageView(CMultiData result) {
		this.result = result;
	}

	public InitPageView() {

	}

	public boolean hasExpired(Map params, Date since) {
		return true;
	}

	public String generateToolTip(CategoryDataset arg0, int series, int arg2) {
		return result.getString("pageName", series);
	}

	public String generateLink(Object arg0, int series, Object arg2) {
		return result.getString("pageName", series);
	}

	/**  
	 * Returns a unique ID for this DatasetProducer  
	 */
	public String getProducerId() {
		return "PageView";
	}

	/**  
	 * Produces some random data.  
	 */
	public Object produceDataset(Map params) throws DatasetProduceException {
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		for (int series = 0; series < result.getDataCount("pageName"); series++) {
			dataset.addValue(result.getDouble("pageNum", series), result.getString("pageName", series),
					result.getString("pageType", series));
		}
		return dataset;
	}

}
