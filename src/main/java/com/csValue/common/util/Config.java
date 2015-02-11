package com.csValue.common.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

public class Config {

	public static Config conf = null;

	public String confFile = null;
	public String confPath = null;

	public static Config getInstance() {
		//if (conf == null)
		conf = new Config();
		return conf;
	}

	Config() {
		confPath = this.getClass().getResource("/").getPath(); //..WEB-INF/classes/

		confFile = confPath + "conf.xml";

	}

	public String getConfPath() {
		return this.confPath;
	}

	public String getNodeText(String nodePath) {
		Document document = null;
		try {
			SAXReader saxReader = new SAXReader();
			document = saxReader.read(new File(confFile));
		} catch (DocumentException e) {
			System.out.println(e.getMessage());
		}
		return document.selectSingleNode(nodePath).getText();
	}

	public void setNodeText(String nodePath, String txt) {
		try {
			SAXReader saxReader = new SAXReader();
			Document document = saxReader.read(new File(confFile));
			document.selectSingleNode(nodePath).setText(txt);

			OutputFormat format = OutputFormat.createPrettyPrint();
			FileOutputStream fos = new FileOutputStream(confFile);
			XMLWriter output = new XMLWriter(fos, format);
			output.write(document);
			output.close();
		} catch (DocumentException e) {
			System.out.println(e.getMessage());
		} catch (IOException e) {
			System.out.println(e.getMessage());
		}
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println(Config.getInstance().getNodeText("/root/expFilePath"));
		//		String sPath = System.getProperty("java.home");
		/*System.out.println("java.version = " + System.getProperty("java.version"));
		System.out.println("java.vendor = " + System.getProperty("java.vendor"));
		System.out.println("java.vendor.url = " + System.getProperty("java.vendor.url"));
		System.out.println("java.home = " + System.getProperty("java.home"));
		System.out.println("====================================");

		System.out.println("java.vm.specification.version = " + System.getProperty("java.vm.specification.version"));
		System.out.println("java.vm.specification.vendor = " + System.getProperty("java.vm.specification.vendor"));
		System.out.println("java.vm.specification.name = " + System.getProperty("java.vm.specification.name"));
		System.out.println("java.vm.version = " + System.getProperty("java.vm.version"));
		System.out.println("====================================");

		System.out.println("java.vm.vendor = " + System.getProperty("java.vm.vendor"));
		System.out.println("java.vm.name = " + System.getProperty("java.vm.name"));
		System.out.println("java.specification.version = " + System.getProperty("java.specification.version"));
		System.out.println("java.specification.vendor = " + System.getProperty("java.specification.vendor"));
		System.out.println("====================================");

		System.out.println("java.specification.name = " + System.getProperty("java.specification.name"));
		System.out.println("java.class.version = " + System.getProperty("java.class.version"));
		System.out.println("java.class.path = " + System.getProperty("java.class.path"));
		System.out.println("java.library.path = " + System.getProperty("java.library.path"));
		System.out.println("====================================");

		System.out.println("java.io.tmpdir = " + System.getProperty("java.io.tmpdir"));
		System.out.println("java.compiler  = " + System.getProperty("java.compiler"));
		System.out.println("java.ext.dirs  = " + System.getProperty("java.ext.dirs"));
		System.out.println("os.name   = " + System.getProperty("os.name"));
		System.out.println("====================================");

		System.out.println("os.arch = " + System.getProperty("os.arch"));
		System.out.println("os.version = " + System.getProperty("os.version"));
		System.out.println("file.separator = " + System.getProperty("file.separator"));
		System.out.println("path.separator = " + System.getProperty("path.separator"));
		System.out.println("====================================");

		System.out.println("line.separator = " + System.getProperty("line.separator"));
		System.out.println("user.name = " + System.getProperty("user.name"));
		System.out.println("user.home = " + System.getProperty("user.home"));
		System.out.println("user.dir = " + System.getProperty("user.dir"));
		System.out.println("====================================");
		System.out.println(Thread.currentThread().getContextClassLoader().getResource(""));

		System.out.println(Thread.currentThread().getContextClassLoader().getResource(""));
		System.out.println(Config.class.getClassLoader().getResource(""));
		System.out.println(ClassLoader.getSystemResource(""));
		System.out.println(Config.class.getResource(""));
		System.out.println(Config.class.getResource("/")); //Class文件所在路径
		System.out.println(new File("/").getAbsolutePath());
		System.out.println(System.getProperty("java.io.tmpdir"));*/

	}

}
