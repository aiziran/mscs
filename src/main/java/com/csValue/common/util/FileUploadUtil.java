package com.csValue.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

import org.springside.modules.utils.web.struts2.Struts2Utils;

public class FileUploadUtil {
	/**
	 * 
	 * @param filePath file类型文件
	 * @param fileName 文件名称
	 * @param flooderName 上传的文件目录  只需传入 相对文件目录 例如pic/car/ 或pic/
	 * @return 返回刚才传入的相对目录加上文件名  
	 */
	public  static String UploadFile(File filePath,String fileName,String flooderName) {
		String realPath = Struts2Utils.getRequest().getSession().getServletContext().getRealPath("/");
		File dirFile = new File(realPath + flooderName);
		//String time = DateUtil.getCurrentDateString("yyyyMMdd") + DateUtil.getCurrentDateString("HHmmss");
		String relativePath = flooderName + fileName;
		try {
			realPath = realPath + relativePath;
			if (!(dirFile.exists()) && !(dirFile.isDirectory())) {
				dirFile.mkdirs();
			}

			FileOutputStream fos = new FileOutputStream(realPath);
			FileInputStream fis;

			fis = new FileInputStream(filePath);

			byte[] buffer = new byte[1024];
			int len = 0;
			while ((len = fis.read(buffer)) > 0) {
				fos.write(buffer, 0, len);
			}
			fis.close();
			fos.close();
			return relativePath;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return relativePath;
	}
	/**
	 * 取得至项目根目录为止的路径
	 * @return
	 */
	public static String GetRealPath(){
		return 	 Struts2Utils.getRequest().getSession().getServletContext().getRealPath("/");
	}
}
