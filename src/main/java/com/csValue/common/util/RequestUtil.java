package com.csValue.common.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.Future;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;

public class RequestUtil {

	public static String sendGet(String url, String param) {
		String strResponse = "";
		try {
			HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();
			connection.setDoOutput(true);
			connection.setRequestMethod("POST");
			connection.setReadTimeout(1000);
			OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream(), "UTF-8");


			out.write(param);

			//connection.connect();
			out.flush();
			out.close();
			String strLine = "";
			
			InputStream in = connection.getInputStream();
			BufferedReader reader = new BufferedReader(new InputStreamReader(in));
			while ((strLine = reader.readLine()) != null) {
				strResponse += strLine + "\n";
			}

		//	System.out.print(strResponse);

		} catch (Exception e) {
		}
		return strResponse;
	}
	public static void main(String[] args) {
	}
	public static void writeErrorLog(String msg){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String now=sdf.format(new Date());
		File f=new File("c:/cdbj.log");
		String str = new String(); //ԭ��txt����
	    String s1 = new String();//���ݸ���

		if(!f.exists()){
			try {
				f.createNewFile();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		try {
			 BufferedReader input = new BufferedReader(new FileReader(f));
             while ((str = input.readLine()) != null) {
                s1 += str + "\r\n";
             }
             input.close();
			BufferedWriter writer=new BufferedWriter(new FileWriter(f));
			writer.write(s1+"\r\n"+now+"\r\n"+msg);
			writer.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	private final static byte[] hex = "0123456789ABCDEF".getBytes(); 
	private static int parse(char c) {  
        if (c >= 'a')  
            return (c - 'a' + 10) & 0x0f;  
        if (c >= 'A')  
            return (c - 'A' + 10) & 0x0f;  
        return (c - '0') & 0x0f;  
    }  
    // ���ֽ����鵽ʮ������ַ�ת��  
    public static String Bytes2HexString(byte[] b) {  
        byte[] buff = new byte[3 * b.length];  
        for (int i = 0; i < b.length; i++) {  
            buff[3 * i] = hex[(b[i] >> 4) & 0x0f];  
            buff[3 * i + 1] = hex[b[i] & 0x0f];  
            buff[3 * i + 2] = 45;  
        }  
        String re = new String(buff);  
        return re.replace("-", " ");  
    }  
    // ��ʮ������ַ��ֽ�����ת��  
    public static byte[] HexString2Bytes(String hexstr) {  
        hexstr = hexstr.replace(" ", "");  
        byte[] b = new byte[hexstr.length() / 2];  
        int j = 0;  
        for (int i = 0; i < b.length; i++) {  
            char c0 = hexstr.charAt(j++);  
            char c1 = hexstr.charAt(j++);  
            b[i] = (byte) ((parse(c0) << 4) | parse(c1));  
        }  
        return b;  
    }
}