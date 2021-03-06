package com.csValue.common.chart;

import java.awt.Font;
import java.util.Map;

import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.CategoryLabelPositions;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.renderer.category.LineAndShapeRenderer;

import de.laures.cewolf.ChartPostProcessor;

public class pageProcessor implements ChartPostProcessor {
	public void processChart(Object chart, Map params) { //这个接口就这一个方法
		CategoryPlot plot = (CategoryPlot) ((JFreeChart) chart).getCategoryPlot();
		NumberAxis numberaxis = (NumberAxis) plot.getRangeAxis();
		CategoryAxis domainAxis = plot.getDomainAxis();

		domainAxis.setTickLabelFont(new Font("宋体", Font.PLAIN, 11));

		domainAxis.setLabelFont(new Font("宋体", Font.PLAIN, 12));

		numberaxis.setTickLabelFont(new Font("宋体", Font.PLAIN, 12));

		numberaxis.setLabelFont(new Font("宋体", Font.PLAIN, 12));
		numberaxis.setAutoRangeIncludesZero(true);
		numberaxis.setAutoRangeStickyZero(true);
		domainAxis.setCategoryLabelPositions(CategoryLabelPositions.createUpRotationLabelPositions(0.4));
		((JFreeChart) chart).getLegend().setItemFont(new Font("宋体", Font.PLAIN, 12));//底部
		((JFreeChart) chart).getTitle().setFont(new Font("宋体", Font.PLAIN, 12));//title

		LineAndShapeRenderer lineandshaperenderer = (LineAndShapeRenderer) plot.getRenderer();

		lineandshaperenderer.setBaseLinesVisible(true); // series 点（即数据点）间有连线可见    

	}

}
