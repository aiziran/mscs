package com.csValue.common.chart;

import javax.servlet.http.HttpServletRequest;

import ssdevframework.core.collection.CMultiData;

public class ChartUtil {

	public static void setChart(HttpServletRequest req, CMultiData result, String type) {

		if (type.equals("pie")) {//饼图
			InitPieChart categoryData = new InitPieChart(result);
			req.setAttribute("categoryData", categoryData);
		}

		if (type.equals("verticalBar")) {//柱图
			InitVerticalBar categoryData = new InitVerticalBar(result);
			req.setAttribute("categoryData", categoryData);
		}

		if (type.equals("line")) {//线图
			InitPageView categoryData = new InitPageView(result);
			req.setAttribute("categoryData", categoryData);
		}
	}

}
