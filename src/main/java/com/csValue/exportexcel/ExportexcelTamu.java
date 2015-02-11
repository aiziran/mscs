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

public class ExportexcelTamu
{
  public static String salesprotocol(HSSFSheet sheet,HSSFWorkbook workbook,String[] day, String[] dayname, String excelTop, List<CData> rdata)
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
    int g = 3;
    for (int i = 0; i < rdata.size(); i++) {
      if ((i == 0) || (i % 4 == 0)) {
        if ((i != 0) && (i % 4 == 0)) {
          g++;
        }
        if(((CData)rdata.get(i)).getString("pinpai")!=null){
        	row = sheet.createRow(g);
        	row.createCell((short)0).setCellValue("品牌：" + ((CData)rdata.get(i)).getString("pinpai"));
        }
      }
      g++;
      row = sheet.createRow((short)g);
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
    String[] day = { "类别/评级", "G4", "G3", "G2", "G1", "小计" };
    String[] dayname = { "pinpaiValue", "G4", "G3", "G2", "G1", "小计" };
    String excelTop = "TAMU 结果分析（2013.11）";
    String excelBottom = "TAMU汇总表";
    String excelName = "TAMU汇总表.xls";
    List rdata = new ArrayList();
    for (int i = 0; i < 15; i++) {
      CData data = new CData();
      data.set("pinpai", "碧浪");
      data.set("pinpaiValue", "包装外观");
      data.set("G4", "2013");
      data.set("G3", "2014");
      data.set("G2", "2013");
      data.set("G1", "2014");
      data.set("小计", "2013");
      rdata.add(data);
    }
    try
    {
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }
}