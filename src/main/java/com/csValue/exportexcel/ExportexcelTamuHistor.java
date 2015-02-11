package com.csValue.exportexcel;

import java.io.OutputStream;
import java.io.PrintStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.Region;
import org.springside.modules.utils.web.struts2.Struts2Utils;
import ssdevframework.core.collection.CData;

public class ExportexcelTamuHistor
{
  public static String salesprotocol(String[] day, String[] dayname, List<CData> rdata, String[] day1, String[] dayname1, List<CData> zhijianDate)
    throws Exception
  {
    HSSFWorkbook workbook = new HSSFWorkbook();
    HSSFSheet sheet = workbook.createSheet();
    HSSFSheet sheet1 = workbook.createSheet();
    workbook.setSheetName(0, "小袋TAMU原始数据");
    workbook.setSheetName(1, "大袋TAMU原始数据");

    HSSFCellStyle style = workbook.createCellStyle();
    style.setVerticalAlignment((short)1);
    style.setAlignment((short)2);

    HSSFCellStyle style1 = workbook.createCellStyle();
    style1.setVerticalAlignment((short)1);
    style1.setAlignment((short)2);

    HSSFCellStyle style2 = workbook.createCellStyle();
    style2.setVerticalAlignment((short)1);
    style2.setAlignment((short)2);

    sheet.addMergedRegion(new Region(0, (short)0, 0, (short)11));
    sheet.addMergedRegion(new Region(1, (short)0, 1, (short)11));
    HSSFRow row = sheet.createRow(0);

    HSSFFont font = workbook.createFont();
    font.setFontName("黑体");
    font.setFontHeightInPoints((short)16);
    font.setBoldweight((short)700);
    style.setFont(font);
    HSSFCell cell = row.createCell((short)0);
    int weekDay = Calendar.getInstance().get(7);

    cell.setCellValue("小袋TAMU原始数据");
    cell.setCellStyle(style);
    row = sheet.createRow(1);
    cell = row.createCell((short)0);

    HSSFFont font1 = workbook.createFont();
    font1.setBoldweight((short)700);

    row = sheet.createRow(2);
    for (int i = 0; i < day.length; i++) {
      cell = row.createCell((short)i);
      cell.setCellType(1);
      cell.setCellValue(day[i]);
      style2.setFont(font1);
      cell.setCellStyle(style2);
    }
    for (int i = 0; i < rdata.size(); i++) {
      row = sheet.createRow((short)(i + 3));
      for (int j = 0; j < dayname.length; j++) {
        fun(cell, i, j, dayname[j], row, style1, rdata);
      }

    }

    style = workbook.createCellStyle();
    style.setVerticalAlignment((short)1);
    style.setAlignment((short)2);

    style1 = workbook.createCellStyle();
    style1.setVerticalAlignment((short)1);
    style1.setAlignment((short)2);

    style2 = workbook.createCellStyle();
    style2.setVerticalAlignment((short)1);
    style2.setAlignment((short)2);

    sheet1.addMergedRegion(new Region(0, (short)0, 0, (short)11));
    sheet1.addMergedRegion(new Region(1, (short)0, 1, (short)11));
    HSSFRow row1 = sheet1.createRow(0);

    font = workbook.createFont();
    font.setFontName("黑体");
    font.setFontHeightInPoints((short)16);
    font.setBoldweight((short)700);
    style.setFont(font);
    HSSFCell cell1 = row1.createCell((short)0);
    weekDay = Calendar.getInstance().get(7);

    cell1.setCellValue("大袋TAMU原始数据");
    cell1.setCellStyle(style);
    row1 = sheet1.createRow(1);
    cell1 = row1.createCell((short)0);

    font1 = workbook.createFont();
    font1.setBoldweight((short)700);

    row1 = sheet1.createRow(2);
    for (int i = 0; i < day1.length; i++) {
      cell1 = row1.createCell((short)i);
      cell1.setCellType(1);
      cell1.setCellValue(day1[i]);
      style2.setFont(font1);
      cell1.setCellStyle(style2);
    }
    for (int i = 0; i < zhijianDate.size(); i++) {
      row1 = sheet1.createRow((short)(i + 3));
      for (int j = 0; j < dayname1.length; j++) {
        fun(cell1, i, j, dayname1[j], row1, style1, zhijianDate);
      }
    }
    try
    {
      System.out.println("TAMU原始数据.xls");
      HttpServletResponse resp = Struts2Utils.getResponse();
      resp.setCharacterEncoding("UTF-8");
      resp.setContentType("text/html;charset=utf-8");
      resp.setContentType("application/x-download");
      resp.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode("TAMU原始数据.xls", "UTF-8"));
      OutputStream out = resp.getOutputStream();

      workbook.write(out);
      out.close();
      return "yes";
    } catch (Exception e) {
      e.printStackTrace();
    }

    return null;
  }
  public static String salesprotocol(HSSFWorkbook workbook ,String[] day, String[] dayname, List<CData> rdata, String[] day1, String[] dayname1, List<CData> zhijianDate)
  throws Exception
  {
	  HSSFSheet sheet = workbook.createSheet();
	  HSSFSheet sheet1 = workbook.createSheet();
	  workbook.setSheetName(1, "TAMU小袋原始数据");
	  workbook.setSheetName(2, "TAMU大袋原始数据");
	  
	  HSSFCellStyle style = workbook.createCellStyle();
	  style.setVerticalAlignment((short)1);
	  style.setAlignment((short)2);
	  
	  HSSFCellStyle style1 = workbook.createCellStyle();
	  style1.setVerticalAlignment((short)1);
	  style1.setAlignment((short)2);
	  
	  HSSFCellStyle style2 = workbook.createCellStyle();
	  style2.setVerticalAlignment((short)1);
	  style2.setAlignment((short)2);
	  
	  sheet.addMergedRegion(new Region(0, (short)0, 0, (short)11));
	  sheet.addMergedRegion(new Region(1, (short)0, 1, (short)11));
	  HSSFRow row = sheet.createRow(0);
	  
	  HSSFFont font = workbook.createFont();
	  font.setFontName("黑体");
	  font.setFontHeightInPoints((short)16);
	  font.setBoldweight((short)700);
	  style.setFont(font);
	  HSSFCell cell = row.createCell((short)0);
	  int weekDay = Calendar.getInstance().get(7);
	  
	  cell.setCellValue("TAMU小袋原始数据");
	  cell.setCellStyle(style);
	  row = sheet.createRow(1);
	  cell = row.createCell((short)0);
	  
	  HSSFFont font1 = workbook.createFont();
	  font1.setBoldweight((short)700);
	  
	  row = sheet.createRow(2);
	  for (int i = 0; i < day.length; i++) {
		  cell = row.createCell((short)i);
		  cell.setCellType(1);
		  cell.setCellValue(day[i]);
		  style2.setFont(font1);
		  cell.setCellStyle(style2);
	  }
	  for (int i = 0; i < rdata.size(); i++) {
		  row = sheet.createRow((short)(i + 3));
		  for (int j = 0; j < dayname.length; j++) {
			  fun(cell, i, j, dayname[j], row, style1, rdata);
		  }
		  
	  }
	  
	  style = workbook.createCellStyle();
	  style.setVerticalAlignment((short)1);
	  style.setAlignment((short)2);
	  
	  style1 = workbook.createCellStyle();
	  style1.setVerticalAlignment((short)1);
	  style1.setAlignment((short)2);
	  
	  style2 = workbook.createCellStyle();
	  style2.setVerticalAlignment((short)1);
	  style2.setAlignment((short)2);
	  
	  sheet1.addMergedRegion(new Region(0, (short)0, 0, (short)11));
	  sheet1.addMergedRegion(new Region(1, (short)0, 1, (short)11));
	  HSSFRow row1 = sheet1.createRow(0);
	  
	  font = workbook.createFont();
	  font.setFontName("黑体");
	  font.setFontHeightInPoints((short)16);
	  font.setBoldweight((short)700);
	  style.setFont(font);
	  HSSFCell cell1 = row1.createCell((short)0);
	  weekDay = Calendar.getInstance().get(7);
	  
	  cell1.setCellValue("TAMU大袋原始数据");
	  cell1.setCellStyle(style);
	  row1 = sheet1.createRow(1);
	  cell1 = row1.createCell((short)0);
	  
	  font1 = workbook.createFont();
	  font1.setBoldweight((short)700);
	  
	  row1 = sheet1.createRow(2);
	  for (int i = 0; i < day1.length; i++) {
		  cell1 = row1.createCell((short)i);
		  cell1.setCellType(1);
		  cell1.setCellValue(day1[i]);
		  style2.setFont(font1);
		  cell1.setCellStyle(style2);
	  }
	  for (int i = 0; i < zhijianDate.size(); i++) {
		  row1 = sheet1.createRow((short)(i + 3));
		  for (int j = 0; j < dayname1.length; j++) {
			  fun(cell1, i, j, dayname1[j], row1, style1, zhijianDate);
		  }
	  }
	  return null;
  }

  public static void fun(HSSFCell cell, int k, int j, String str, HSSFRow row, HSSFCellStyle style, List<CData> list) {
    cell = row.createCell((short)j);
    cell.setCellType(1);
    if ((str.equals("StartDateTime")) || (str.equals("EndDateTime")) || (str.equals("xuanzeTime")) || (str.equals("quyangTime"))) {
      SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      String mm = df.format(((CData)list.get(k)).get(str));
      cell.setCellValue(mm);
    } else if ((str.equals("weight")) && (str.contains("g"))) {
      String str1 = ((CData)list.get(k)).getString(str);
      if ((str1 != null) && (!str1.equals(""))) {
        String[] weight = str1.split("g");
        cell.setCellValue(Double.parseDouble(weight[0]));
      }
    } else {
      String cellvale = (String) ((CData)list.get(k)).get(str);
      if ((cellvale == null) || (cellvale.equals("null"))) {
        cellvale = "";
      }
      cell.setCellValue(cellvale);
    }

    cell.setCellType(1);
    cell.setCellStyle(style);
  }

  public static void main(String[] args) {
    String[] day = { "机器号", "产品", "开始时间", "结束时间" };
    String[] dayname = { "lineNo", "productor", "startDtateTime", "enddatetime" };
    String excelTop = "测试";
    String excelBottom = "";
    String excelName = "test";
    List rdata = new ArrayList();
    CData data = new CData();
    data.set("lineNo", "1号机器号");
    data.set("productor", "洗衣粉");
    data.set("startDtateTime", "2013");
    data.set("enddatetime", "2014");
    rdata.add(data);
  }
}