package com.csValue.common.util;

import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.util.Properties;

import org.apache.poi.hssf.usermodel.HSSFCell;

public class LogAdder {
	public static void main(String[] args) {
		 Properties properties = System.getProperties();
         String encodingStr = properties.getProperty("file.encoding");
         System.out.println(encodingStr);
	}
	 public static void PrintLog(String fileName, String content) {   
		    File f=new File("C://",fileName);
		    if(!f.exists()){
		    	try {
					f.createNewFile();
				} catch (IOException e) {
					e.printStackTrace();
				}
		    }
	        RandomAccessFile randomFile = null;  
	        try {     
	            // 打开一个随机访问文件流，按读写方式     
	            randomFile = new RandomAccessFile("C://"+fileName, "rw");     
	            // 文件长度，字节数     
	            long fileLength = randomFile.length();     
	            // 将写文件指针移到文件尾。     
	            randomFile.seek(fileLength);     
	            randomFile.writeBytes(content);      
	        } catch (IOException e) {     
	            e.printStackTrace();     
	        } finally{  
	            if(randomFile != null){  
	                try {  
	                    randomFile.close();  
	                } catch (IOException e) {  
	                    e.printStackTrace();  
	                }  
	            }  
	        }  
	    }    
	 public static void PrintCSV(RandomAccessFile randomFile,String filePath, String content) {   
		 Properties properties = System.getProperties();
         String encodingStr = properties.getProperty("file.encoding");
	    try{
			 // 文件长度，字节数     
			 long fileLength = randomFile.length();     
			 // 将写文件指针移到文件尾。     
			 randomFile.seek(fileLength);     
			 randomFile.write(content.getBytes(encodingStr));      
		 } catch (IOException e) {     
			 e.printStackTrace(); 
			 System.err.println("写入文件异常");
		 } 
	 }    
}
