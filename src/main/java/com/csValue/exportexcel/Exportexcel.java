package com.csValue.exportexcel;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintStream;
import java.io.RandomAccessFile;
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

import com.csValue.common.util.LogAdder;

import ssdevframework.core.collection.CData;

public class Exportexcel
{
  public static String salesprotocol(String[] day, String[] dayname, String excelTop, String excelBottom, String excelName, List<CData> rdata)
    throws Exception
  {
    HSSFWorkbook workbook = new HSSFWorkbook();
    HSSFSheet sheet = workbook.createSheet();
    workbook.setSheetName(0, excelBottom);

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

    cell.setCellValue(excelTop);
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
    try
    {
      System.out.println(excelName);
      HttpServletResponse resp = Struts2Utils.getResponse();
      resp.setCharacterEncoding("UTF-8");
      resp.setContentType("text/html;charset=utf-8");
      resp.setContentType("application/x-download");
      resp.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(excelName, "UTF-8"));
      OutputStream out = resp.getOutputStream();

      workbook.write(out);
      out.close();
      return "yes";
    } catch (Exception e) {
      e.printStackTrace();
    }

    return null;
  }
  public static void exportCSV(File f,RandomAccessFile raf,String filePath,String[] day, String[] dayname, String excelTop, String excelName, List<CData> rdata,boolean downloadFlag,int count)
  throws Exception
  {
	  
	  if(count==0){
		  String tmp=" ";
		  for (int i = 0; i < dayname.length; i++) {
			  tmp=tmp+day[i]+",";
		  }
		  LogAdder.PrintCSV(raf, filePath, tmp+"\r\n");
	  }  
	  for (CData d : rdata) {
			String tmp="";
			for (int i = 0; i < dayname.length; i++) {
				tmp=tmp+d.getString(dayname[i])+(i==dayname.length-1?"\r\n":",");
			}
			LogAdder.PrintCSV(raf, filePath, tmp);
	  }
	  if(downloadFlag){
		  try
		  {
			  HttpServletResponse resp = Struts2Utils.getResponse();
			  resp.setCharacterEncoding("UTF-8");
			  resp.setContentType("text/html;charset=utf-8");
			  resp.setContentType("application/x-download");
			  resp.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(excelName, "UTF-8"));
			  OutputStream out = resp.getOutputStream();
			  FileInputStream fis=new FileInputStream(f);
			  
			  byte[] b=new byte[4096];
			  int c = 0;
			  while ((c = fis.read(b)) > 0) {
			       out.write(b, 0, c);
			   }
			  out.close();
			  f.delete();
		  } catch (Exception e) {
			  e.printStackTrace();
		  }finally{
			  if(raf != null){  
					 try {  
						 raf.close();  
					 } catch (IOException ee) {  
						 ee.printStackTrace();  
					 }  
			  }  
			  f.delete();
		  }
	  }
  }
  public static String salesprotocol(HSSFWorkbook workbook,HSSFSheet sheet, String[] day, String[] dayname, String excelTop, List<CData> rdata)
  throws Exception
  {
	  
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
	  
	  cell.setCellValue(excelTop);
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
	  
	  return null;
  }

  public static void fun(HSSFCell cell, int k, int j, String str, HSSFRow row, HSSFCellStyle style, List<CData> list) {
    cell = row.createCell((short)j);
    cell.setCellType(1);
    if ((str.equals("StartDateTime")) || (str.equals("EndDateTime"))) {
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
      String cellvale = String.valueOf(((CData)list.get(k)).get(str));
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
    try {
      salesprotocol(day, dayname, excelTop, excelBottom, excelName, rdata);
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }
}