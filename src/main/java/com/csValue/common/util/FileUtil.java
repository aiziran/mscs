package com.csValue.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import ssdevframework.core.collection.CData;
import ssdevframework.core.util.DateUtil;

import com.csValue.common.util.dao.CommonDao;

@Component
public class FileUtil {

	@Autowired
	private CommonDao commonDao;

	public String fileUpload(File upload, String uploadFileName, String dirPath) throws Exception {
		if (uploadFileName == null)
			return "";
		/**
		 * 设置为D盘，之前设置为应用根目录，因系统采用war包方式部署，每次更新需要删除旧系统，
		 * 会导致原有上传的文件丢失。故修改为硬盘根目录
		 * modified  by csq 2011-06-25
		 */
		//String realPath = Struts2Utils.getRequest().getSession().getServletContext().getRealPath("/");
		String realPath = "D:/";

		File dirFile = new File(realPath + "upload/" + dirPath + "/");
		if (!(dirFile.exists()) && !(dirFile.isDirectory())) {
			dirFile.mkdirs();
		}
		String time = DateUtil.getCurrentDateString("yyyyMMdd") + " " + DateUtil.getCurrentDateString("HHmmss");
		realPath = realPath + "upload/" + dirPath + "/" + "[" + time + "] - " + uploadFileName;

		FileOutputStream fos = new FileOutputStream(realPath);
		FileInputStream fis = new FileInputStream(upload);

		byte[] buffer = new byte[1024];
		int len = 0;
		while ((len = fis.read(buffer)) > 0) {
			fos.write(buffer, 0, len);
		}
		fis.close();
		fos.close();
		upload.delete();
		CData data = new CData();
		data.set("fileUrl", realPath);
		data.set("fileNameOrl", uploadFileName);
		data.set("fileName", "[" + time + "] - " + uploadFileName);
		return commonDao.insertFile(data);
	}
	
	public static String toUTF8(String isoString) {
        String utf8String = null;
        if (null != isoString && !isoString.equals("")) {
            try {
                byte[] stringBytesISO = isoString.getBytes("ISO-8859-1");
                utf8String = new String(stringBytesISO, "UTF-8");
            } catch (Exception e) {

                utf8String = isoString;
            }
        } else {
            utf8String = isoString;
        }
        return utf8String;
    }
}
