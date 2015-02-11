package com.csValue.common.chart;

import java.awt.Font;
import java.util.Map;

import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PiePlot;

import de.laures.cewolf.ChartPostProcessor;

public class PieProcessor implements ChartPostProcessor {
	public void processChart(Object chart, Map params) { //这个接口就这一个方法
		PiePlot plot = (PiePlot) ((JFreeChart) chart).getPlot();
		plot.setLabelFont(new Font("宋体", Font.PLAIN, 12));//label
		((JFreeChart) chart).getLegend().setItemFont(new Font("宋体", Font.PLAIN, 12));//底部
		((JFreeChart) chart).getTitle().setFont(new Font("宋体", Font.PLAIN, 12));//title
	}

}
