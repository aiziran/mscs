package com.csValue.common.util;

import java.io.RandomAccessFile;
import java.util.ArrayList;
import java.util.List;

public class ReplaceXmlUtil {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		ReplaceXmlUtil rx=new ReplaceXmlUtil();
		try {
			
			rx.replace("","contacttell","linktel");
			//rx.replace("","fax","chuanzhen");
		} catch (Exception e) {
			e.printStackTrace();
		}
		//D:\demo\ssdev\workspace\car\bin\mapper\front
		//rx.replace("frontappointdetailMapper.xml");
	}
	public void replace(String fileName,String replaceContent,String targetString) throws Exception{
		RandomAccessFile f=new RandomAccessFile("d:/frontclientinfoMapper.xml","rw");   
		String line = f.readLine();
		String t;
		
		/**
		 * 1. 读取一行
		 * 2. 替换关键词
		 *    2.1 将“关键词”， 替换成 ($),
		 *    2.2 替换关键词,为目标关键词
		 *    2.3 将"关键词", 替换回来
		 * 3. 替换当前行
		 *    如果替换之后的行，长度大于原行，则trim后，替换
		 *    否则，直接替换，补全空格
		 */
		while(line != null)
		{
			t = line;
			if(line.indexOf(replaceContent)>-1&&!line.contains("if"))
			{
				long i = f.getFilePointer();
				f.seek(i-line.length());
				if(line.contains("#{"+replaceContent+"}")){
					line = line.replace("#{"+replaceContent+"}", "UPDATEWORLD");
					line = line.replace(replaceContent, targetString);
					line = line.replace("UPDATEWORLD", "#{"+replaceContent+"}");
				}else{
					line = line.replaceAll("\""+replaceContent+"\"", "STRTOREPLACE");
					line = line.replaceAll(replaceContent, targetString);
					line = line.replaceAll("STRTOREPLACE", "\""+replaceContent+"\"");
				}
				System.out.println(line);
				if(line.length()> t.length())
				{
					int gap = line.length()- t.length();
					line = line.substring(gap);
				}
				else if(line.length()<t.length())
				{
					int gap = t.length()- line.length();
					for(int m=0;m<gap;m++)
						line = line + " ";
				}
				line=line+",";
				byte [] cs = line.getBytes();
				f.write(cs, 0, cs.length-1);
				f.writeBytes("\r\n");
				//f.seek(i);
				
//				t=line;
//				long i = f.getFilePointer();
//				int len = line.length();
//
//				
//					if(line.indexOf(replaceContent)==-1){
//						break;
//					}
//					String strt=null;
//					if(line.indexOf(replaceContent)>-1)
//					{
//						if(line.indexOf(replaceContent) != line.indexOf("\""+replaceContent+"\"")-1)//遇到引号中的替换关键词
//						{
//							strt=line.substring(0,line.indexOf(replaceContent)+replaceContent.length() +2);
//						}
//					}
//					if(!strt.contains("\"")&&!strt.contains("#")){
//						//如果目标字符串长度小于原字符串，补全空格
//						strt=strt.replace(replaceContent,targetString);
//						temp.append(strt);   
//						int spaceCount = replaceContent.length() - targetString.length() ;
//						if(spaceCount>0)
//						{
//							for(int j=0;j<spaceCount;j++){
//								temp.append(" ");
//							}
//						}
//					}else{
//						otherStr.append(strt);
//					}
//					
//					line=line.substring(line.indexOf(replaceContent)+replaceContent.length());
//	
//
//				temp=temp.append(otherStr);
//				temp.delete(0, 2);
//				
//				byte [] cs = temp.toString().getBytes();
//
//				f.seek(i-t.length());
//				f.write(cs, 0, cs.length);
//				f.seek(i);
//			}
//			temp.delete(0, temp.length());
//			otherStr.delete(0,otherStr.length());
			}
			line = f.readLine();
		}
           f.close( );
	} 

}
