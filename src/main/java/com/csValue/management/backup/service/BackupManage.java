package com.csValue.management.backup.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Component;

import ssdevframework.core.collection.CData;

import com.csValue.common.util.Config;

@Component
public class BackupManage {
	
	
	private static String expFilePath;// 导出文件路径
	private static String expFilePrefix;// 导出文件前缀
	private static String dbConn;// 数据库连接,如 user/pwd@sid
	private static String otherCommand;// 其他exp命令行条
	
	public int backup(CData input) throws Exception {

		try {
			this.readCFG(); // 从配置文件得到参数
			
			File file = new File(expFilePath);
			if (!file.exists())
				file.mkdir();
			expFilePath = file.toString() + File.separator;
			String fileName = expFilePrefix + this.getNowTime("yyyy-MM-dd") + ".dmp";
			if(input.getString("bakFile") != null && !"".equals(input.getString("bakFile")))
				fileName = input.getString("bakFile");
			
			String command = "EXP " + dbConn + " " + "FILE=" + "\""
					+ expFilePath + fileName + "\" " + otherCommand + " LOG=\""
					+ expFilePath + fileName + ".exp.log\"";
			return this.RunCommand(command);

		} catch (Exception ex) {
			ex.printStackTrace();
			return 1;
		}
	}
//内部类
class StreamThread extends Thread {

		InputStream is;
		String type;

		StreamThread(InputStream is, String type) {
			this.is = is;
			this.type = type;
		}

		public void run() {
			try {
				InputStreamReader isr = new InputStreamReader(is);
				BufferedReader br = new BufferedReader(isr);
				String line = null;
				while ((line = br.readLine()) != null) {
					System.out.println(type + ">" + line);
				}
			} catch (IOException ioe) {
			}
		}
	}

	public void readCFG() {
		expFilePath = Config.getInstance().getNodeText("/root/expFilePath");
		expFilePrefix = Config.getInstance().getNodeText("/root/expFilePrefix");
		dbConn = Config.getInstance().getNodeText("/root/dbConn");
		otherCommand = Config.getInstance().getNodeText("/root/otherCommand");	
	}
	

	public int RunCommand(String command) {
		try {
			Process process = Runtime.getRuntime().exec(command);
			new StreamThread(process.getInputStream(), "INFO").start();
			new StreamThread(process.getErrorStream(), "INFO").start();
			int status = process.waitFor();
			return status;
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return 2;
	}


	// 获取当天时间
	public String getNowTime(String dateformat) {
		Date now = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat(dateformat);// 可以方便地修改日期格式
		String dateStr = dateFormat.format(now);
		return dateStr;
	}
}
