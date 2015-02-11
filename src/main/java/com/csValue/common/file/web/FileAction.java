package com.csValue.common.file.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import ssdevframework.front.action.BaseActionSupport;

import com.csValue.common.file.service.FileManage;

@Namespace("/file")
@Results({ @Result(name = "download", type = "stream", params = { "inputName", "fileDoc", "contentDisposition",
		"attachment;fileName=\"${downloadFileName}\"", "bufferSize", "4096" }) })
public class FileAction extends BaseActionSupport {

	private static final long serialVersionUID = 1L;
	private String filePath;
	private String fileName;
	@SuppressWarnings("unused")
	private InputStream fileDoc;
	@Autowired
	private FileManage fileManage;

	@Override
	public String list() throws Exception {
		return null;
	}

	public String fileDown() throws Exception {
		setFilePath(fileManage.getFile(data));
		setFileName(filePath.substring(filePath.lastIndexOf("/") + 1));
		return "download";
	}

	public InputStream getFileDoc() throws Exception {
		if ("-1".equals(filePath))
			throw new Exception("文件不存在");
		//return ServletActionContext.getServletContext().getResourceAsStream(filePath);
		return new FileInputStream(new File(filePath));
	}

	public String getDownloadFileName() {

		String downFileName = fileName;
		try {
			downFileName = new String(downFileName.getBytes(), "ISO8859-1");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return downFileName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

}
