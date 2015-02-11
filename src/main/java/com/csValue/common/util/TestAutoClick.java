package com.csValue.common.util;

import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Timer;
import java.util.TimerTask;

public class TestAutoClick {

	/**
	 * @param args
	 */
	static int temp=0;
	static int endTime=6000*1000;
	//http://user.qzone.qq.com/2512327818/blog/1328939685
	static String url="http://bbs.taobao.com/catalog/thread/510527-276276402.htm?spm=a210m.7475144.1998166562.54.PJauc3";
	static	Thread t1=new Thread(new Runnable() {
		public void run() {
			TestAutoClick.startClick("thread1:弟");
		}
	});
	static Thread t2=new Thread(new Runnable() {
		public void run() {
			TestAutoClick.startClick("thread2:弟");
		}
	});
	static Thread t3=new Thread(new Runnable() {
		public void run() {
			TestAutoClick.startClick("thread3:弟");
		}
	});
	static Thread t4=new Thread(new Runnable() {
		public void run() {
			TestAutoClick.startClick("thread4:弟");
		}
	});
	static Thread t5=new Thread(new Runnable() {
		public void run() {
			TestAutoClick.startClick("thread5:弟");
		}
	});
	public static void main(String[] args) {
			t1.start();
			t2.start();
			t3.start();
			t4.start();
			t5.start();
		    Timer timer = new Timer();  
		    timer.schedule( new TimerTask() {   
		    	public void run() {   
			    		t1.stop();
						t2.stop();
						t3.stop();
						t4.stop();
						t5.stop();
						System.out.println("共刷了"+temp+"次点击...");
		    		}   
		    		}, endTime); 
	}
	public static Runnable  startClick(String log){
		//根据qq空间精简版页面刷某日志点击  http://qz.qq.com/ 如该空间进行锁定则刷不成功
		//http://qz.qq.com/382267044/blog?uin=382267044&vin=978934130&blogid=1347751251
		while(true){
			temp=temp++;
			System.out.println(log+temp++);
			URL getUrl;
			try {
				getUrl = new URL(url);
			HttpURLConnection connection =(HttpURLConnection) getUrl.openConnection();
			System.out.println(connection.getURL());
			System.out.println(connection.getResponseCode());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
