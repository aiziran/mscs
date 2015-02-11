package com.csValue.exportexcel;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import ssdevframework.core.collection.CData;

public class ReadExcel
{
  private POIFSFileSystem fs;
  private HSSFWorkbook wb;
  private Row row;
  private Sheet sheet;

  public String[] readExcelTitle(String filepath)
    throws IOException
  {
    System.out.println("------读取EXCEL---------");
    InputStream is = new FileInputStream(filepath);
    Workbook hssfWorkbook = null;
    try {
      hssfWorkbook = new XSSFWorkbook(filepath);
      System.out.println("解析2007版本----->");
    }
    catch (Exception ex) {
      hssfWorkbook = new HSSFWorkbook(is);
      System.out.println("解析2003版本----->");
    }

    this.sheet = hssfWorkbook.getSheetAt(0);
    this.row = this.sheet.getRow(0);

    int colNum = this.row.getPhysicalNumberOfCells();
    System.out.println("colNum:" + colNum);
    String[] title = new String[colNum];

    if (colNum == this.row.getLastCellNum()) {
      for (int cellNum = 0; cellNum <= this.row.getLastCellNum(); cellNum++)
      {
        Cell hssfCell = this.row.getCell(cellNum);
        if (hssfCell != null)
        {
          title[cellNum] = getValue(hssfCell);
        }
      }
    }
    return title;
  }

  public List<CData> readXls(String filepath, String[] tmp)
    throws IOException
  {
    List list = new ArrayList();
    InputStream is = new FileInputStream(filepath);
    this.wb = new HSSFWorkbook(is);

    this.sheet = this.wb.getSheetAt(0);
    int rowNum = this.sheet.getLastRowNum();
    this.row = this.sheet.getRow(0);

    for (int Num = 3; Num <= rowNum; Num++) {
      CData content = new CData();

      this.row = this.sheet.getRow(Num);

      int colNum = this.row.getPhysicalNumberOfCells();

      int j = 0;

      if (this.row != null) { if (isBlankRow(this.row));
        while (j < colNum)
        {
          Cell hssfCell = this.row.getCell(j);
          String str1 = "";
          if (hssfCell == null)
            str1 = "";
          else {
            str1 = getValue(hssfCell).trim();
          }
          System.out.println(j + "tmp" + str1);

          content.set(tmp[j], str1);
          j++;
        }

        System.out.println("向List添加值===" + content);
        list.add(content);
      }
    }

    return list;
  }

  private String getValue(Cell hssfCell)
  {
    if (hssfCell.getCellType() == 4)
      return String.valueOf(hssfCell.getBooleanCellValue());
    if (hssfCell.getCellType() == 0)
    {
      Double value = Double.valueOf(hssfCell.getNumericCellValue());
      if (value.doubleValue() == value.longValue()) {
        return String.valueOf(value.longValue());
      }
      return value.toString();
    }
    return String.valueOf(hssfCell.getStringCellValue());
  }

  public static boolean isBlankRow(Row row)
  {
    if (row == null)
      return true;
    boolean result = true;
    for (int i = row.getFirstCellNum(); i < row.getLastCellNum(); i++) {
      Cell cell = row.getCell(i, Row.RETURN_BLANK_AS_NULL);
      String value = "";
      if (cell != null) {
        switch (cell.getCellType()) {
        case 1:
          value = cell.getStringCellValue();
          break;
        case 0:
          value = String.valueOf((int)cell.getNumericCellValue());
          break;
        case 4:
          value = String.valueOf(cell.getBooleanCellValue());
          break;
        case 2:
          value = String.valueOf(cell.getCellFormula());
          break;
        case 3:
        }

        if (!value.trim().equals("")) {
          result = false;
          break;
        }
      }
    }

    return result;
  }
}