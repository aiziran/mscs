package com.csValue.common.util;

import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class CreateMd5Key  {

	public static void main(String[] args) {
        try {
	        	Calendar ca=Calendar.getInstance();
	        	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	        	ca.setTime(new Date());
	        	ca.add(Calendar.MONTH, 3);
	        	Date valid=ca.getTime();
	        	String date=sdf.format(valid);
	        	System.out.println("三个月后的有效日期："+date);
	        	String dateString=convertDateToString(date.toString());//根据三个月之后日期转换为字符串等特殊字符
	        	
	            MessageDigest messageDigest =MessageDigest.getInstance("MD5");
	            String code="NJASDICNNASLKJIG";
	            byte[] inputByteArray = code.getBytes();
	            messageDigest.update(inputByteArray);
	            byte[] resultByteArray = messageDigest.digest();
	            String md5=bytesToString(resultByteArray);//取得MD5
	            System.out.println("ipad机器码的MD5值："+bytesToString(resultByteArray));
	            System.out.println("md5加上日期的值"+md5+dateString);
        
            
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	public static String createMd5(String identifier){
		  try {
	        	Calendar ca=Calendar.getInstance();
	        	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	        	ca.setTime(new Date());
	        	ca.add(Calendar.MONTH, 3);
	        	Date valid=ca.getTime();
	        	String date=sdf.format(valid);
	        	System.out.println("三个月后的有效日期："+date);
	        	String dateString=convertDateToString(date.toString());//根据三个月之后日期转换为字符串等特殊字符
	        	
	            MessageDigest messageDigest =MessageDigest.getInstance("MD5");
	            String code="IPad"+identifier;
	            byte[] inputByteArray = code.getBytes();
	            messageDigest.update(inputByteArray);
	            byte[] resultByteArray = messageDigest.digest();
	            String md5=bytesToString(resultByteArray);//取得MD5
	            System.out.println("ipad机器码的MD5值："+bytesToString(resultByteArray));
	            System.out.println("md5加上日期的值"+md5+dateString);
	            return md5+dateString;
          
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
		
		
	}
	   public static String bytesToString(byte[] data) {
	        char hexDigits[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd',
	                'e', 'f'};
	        char[] temp = new char[data.length * 2];
	        for (int i = 0; i < data.length; i++) {
	            byte b = data[i];
	            temp[i * 2] = hexDigits[b >>> 4 & 0x0f];
	            temp[i * 2 + 1] = hexDigits[b & 0x0f];
	        }
	        return new String(temp);

	    }
	   public static  String convertDateToString(String validity){
		   String [] strs=new String[10];
		   String date=validity;
		   if(date.contains("-")){
			   date=date.replace("-", "");
		   }
		   for(int i=0;i<date.length();i++){
			   if(i==date.length()){
					  break;
			   }
			   	strs[i]=date.substring(i, i+1);
		   }
		   StringBuffer sb=new StringBuffer();
		   char [] replaceTo={'g','~','q','@','i','t','$','p','+','m','*'};
		   for(int i=0;i<date.length();i++){
			   if(strs.length==i+1){
				   break;
			   }
			   switch (Integer.parseInt(strs[i])) {
					case 0:
						sb.append(replaceTo[0]);
						break;
					case 1:
						sb.append(replaceTo[1]);
						break;
					case 2:
						sb.append(replaceTo[2]);
						break;
					case 3:
						sb.append(replaceTo[3]);
						break;
					case 4:
						sb.append(replaceTo[4]);
						break;
					case 5:
						sb.append(replaceTo[5]);
						break;
					case 6:
						sb.append(replaceTo[6]);
						break;
					case 7:
						sb.append(replaceTo[7]);
						break;
					case 8:
						sb.append(replaceTo[8]);
						break;
					case 9:
						sb.append(replaceTo[9]);
						break;
					default:
						break;
			}
		   }
		   System.out.println(sb.toString());
		   System.out.println(validity);
		   
		   
		    return sb.toString();
	   }
}
