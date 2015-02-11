package com.csValue.exportexcel;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.ServletActionContext;
import org.springside.modules.utils.web.struts2.Struts2Utils;

import ssdevframework.core.collection.CData;

public class ExportexcleTamuCollect {

	  public static void Export( List<CData> rdata,int jihao,String banzu,HSSFSheet worksheet) throws Exception
	  {//TAMUTemplete.xls
		  for (CData d : rdata) {
			  int insertRow=getRowByJihao(jihao);
			  int insertCol=getCellByBanzu(banzu,d.getString("leibie"));
			  
			  insertCellValue(Integer.parseInt(d.getString("g4")),insertRow,insertCol,worksheet);//T
			  insertCellValue(Integer.parseInt(d.getString("g3")),insertRow,insertCol+1,worksheet);//A
			  insertCellValue(Integer.parseInt(d.getString("g2")),insertRow+1,insertCol,worksheet);//M
			  insertCellValue(Integer.parseInt(d.getString("g1")),insertRow+1,insertCol+1,worksheet);//U
			
		  }
	  }
	  public static void RestartCount(HSSFWorkbook workbook) throws Exception
	  {//TAMUTemplete.xls
		  for(int k=0;k<33;k++){
			  HSSFSheet worksheet=workbook.getSheetAt(k);
			  int lastRow= worksheet.getLastRowNum();
			  int fristRow= worksheet.getFirstRowNum();
			  for (int i = fristRow; i < lastRow; i++) {
				  HSSFRow row=worksheet.getRow(i);
				  int lastCol=row.getLastCellNum();
				  int fristCol=row.getFirstCellNum();
				  for (int j = fristCol; j <lastCol; j++) {
					  HSSFCell cell=row.getCell(j);
					  try {
						  switch (cell.getCellType()) {
						  case HSSFCell.CELL_TYPE_FORMULA://公式
							  cell.setCellFormula(cell.getCellFormula()); 
							  break;
						  default:
						  }
						  
					  } catch (Exception e) {
						 // System.out.println(k+"___"+i+"___"+j+"___");
					  }
				  }
			  }
		  }
	  }
	  /**
	   * row计算从0开始
	   * @param jihao
	   * @return
	   */
	  public static int getRowByJihao(int jihao){
		  int row=0;
		  if(jihao==1){
			  row=12;
		  }else{
			  if(jihao<=13){//由于excle 13机器之后少了一行 则需要结果减2
				  row=(((jihao-1)*4)+13)-1;
			  }else{
				  row=(((jihao-1)*4)+13)-2;
			  }
		  }
		  return row;
	  }
	  /**
	   * cell计算从0开始   
	   * @param jihao
	   * @return
	   */
	  public static int getCellByBanzu(String banzu,String type){
		  int cell=0;
		  if(banzu.equals("早班")){
			  cell=4;
		  }else if (banzu.equals("中班")){
			  cell=21;
		  }else if (banzu.equals("夜班")){
			  cell=38;
		  }
		  
		  if(type.equals("漏粉")){
			  cell=cell+4;
		  }else if(type.equals("包装完全")){
			  cell=cell+8;
		  }else if(type.equals("客户外包装")){
			  cell=cell+12;
		  }
		  return cell;
	  }
	  public static void insertCellValue(int value,int rowNum,int cellNum,HSSFSheet sheet){
		  HSSFRow row=sheet.getRow(rowNum);
		  HSSFCell cell=row.getCell(cellNum);
		  
		  cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
		  cell.setCellValue(value);
	  }
}
