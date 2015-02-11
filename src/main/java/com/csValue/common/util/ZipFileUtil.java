package com.csValue.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.List;

import net.sf.json.JSONArray;

import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;
import org.apache.tools.zip.ZipOutputStream;

public class ZipFileUtil {
	/**
	 * 压缩某个文件夹下所有文件
	 * @param file
	 * @param zipFile
	 * @throws Exception
	 */
	public static void zip(File file, File zipFile) throws Exception {
		File path = new File(zipFile.getPath().replace(zipFile.getName(), ""));
		System.out.println(path);
		if (!path.exists()) {
			path.mkdirs();
		}
		ZipOutputStream output = null;
		try {
			output = new ZipOutputStream(new FileOutputStream(zipFile));
			output.setEncoding("GBK");
			// 顶层目录开始
			zipFile(output, file, "", zipFile.getName().replace(".zip", ""));
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			// 关闭流
			if (output != null) {
				output.flush();
				output.close();
			}
		}
	}

	/**
	 * 压缩指定文件
	 * @param srcfile
	 * @param zipfile
	 */
	public static void ZipFiles(List<File> srcfile, java.io.File zipfile) {
		byte[] buf = new byte[1024];
		try {
			File path = new File(zipfile.getPath().replace(zipfile.getName(), ""));
			System.out.println(path);
			if (!path.exists()) {
				path.mkdirs();
			}
			// Create the ZIP file
			ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipfile));
			out.setEncoding("GBK");
			// Compress the files
			for (int i = 0; i < srcfile.size(); i++) {
				FileInputStream in = new FileInputStream(srcfile.get(i));
				// Add ZIP entry to output stream.
				out.putNextEntry(new ZipEntry(srcfile.get(i).getName()));

				// Transfer bytes from the file to the ZIP file
				int len;
				while ((len = in.read(buf)) > 0) {
					out.write(buf, 0, len);
				}
				// Complete the entry
				out.closeEntry();
				in.close();
			}
			// Complete the ZIP file
			out.close();
			System.out.println("压缩完成.");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private static void zipFile(ZipOutputStream output, File file, String basePath, String projectname)
			throws IOException {
		System.out.println(basePath + "+++++++++++++++++");
		FileInputStream input = null;
		try {
			// 文件为目录
			if (file.isDirectory()) {
				// 得到当前目录里面的文件列表
				File list[] = file.listFiles();

				basePath = basePath + (basePath.length() == 0 ? "" : "/") + file.getName();
				System.out.println(basePath + "__________________");

				// 循环递归压缩每个文件
				for (File f : list)
					zipFile(output, f, basePath, projectname);

			} else {
				// 压缩文件
				basePath = (basePath.length() == 0 ? "" : basePath + "/") + file.getName();
				System.out.println(basePath);
				//这里的操作是 使压缩后的zip文件不包含工程根目录
				//basePath = basePath.replace(projectname + "/", "");
				output.putNextEntry(new ZipEntry(basePath));
				input = new FileInputStream(file);
				int readLen = 0;
				byte[] buffer = new byte[1024 * 8];
				while ((readLen = input.read(buffer, 0, 1024 * 8)) != -1)
					output.write(buffer, 0, readLen);

			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			// 关闭流
			if (input != null)
				input.close();
		}
	}

	public static void unZip(File file, String dest, boolean deleteFile) throws Exception {
		if (!file.exists()) {
			throw new Exception("解压文件不存在!");
		}
		if (new File(dest).exists() == false) {
			new File(dest).mkdirs();
		}else{
			new File(dest).deleteOnExit();
			new File(dest).mkdirs();
		}
		ZipFile zipFile = new ZipFile(file, "GBK");
		Enumeration e = zipFile.getEntries();
		while (e.hasMoreElements()) {
			ZipEntry zipEntry = (ZipEntry) e.nextElement();
			if (zipEntry.isDirectory()) {
				String name = zipEntry.getName();
				name = name.substring(0, name.length() - 1);
				File f = new File(dest + name);
				f.mkdirs();
			} else {
				File f = new File(dest + zipEntry.getName());
				f.getParentFile().mkdirs();
				f.createNewFile();
				InputStream is = zipFile.getInputStream(zipEntry);
				FileOutputStream fos = new FileOutputStream(f);

				int length = 0;
				byte[] b = new byte[1024];
				while ((length = is.read(b, 0, 1024)) != -1) {
					fos.write(b, 0, length);
				}
				is.close();
				fos.close();
			}
		}
		if (zipFile != null) {
			zipFile.close();
		}

		if (deleteFile) {
			file.deleteOnExit();
		}
	}
	public static void unZip(File file, String dest, boolean deleteFile,JSONArray jsonarray) throws Exception {
		if (!file.exists()) {
			throw new Exception("解压文件不存在!");
		}
		if (new File(dest).exists() == false) {
			new File(dest).mkdirs();
		}else{
			new File(dest).deleteOnExit();
			new File(dest).mkdirs();
		}
		ZipFile zipFile = new ZipFile(file, "GBK");
		Enumeration e = zipFile.getEntries();
		while (e.hasMoreElements()) {
			ZipEntry zipEntry = (ZipEntry) e.nextElement();
			if (zipEntry.isDirectory()) {
				String name = zipEntry.getName();
				name = name.substring(0, name.length() - 1);
				File f = new File(dest + name);
				f.mkdirs();
			} else {
				boolean flag=true;
				for(int i=0;i<jsonarray.size();i++){
					String filepath=dest+jsonarray.getJSONObject(i).getString("filepath");
					String zipFilePath=dest + zipEntry.getName();
					if(filepath.equals(zipFilePath)){
						flag=false;
						break;
					}
				}
				if(flag){
					File f = new File(dest + zipEntry.getName());
					f.getParentFile().mkdirs();
					f.createNewFile();
					InputStream is = zipFile.getInputStream(zipEntry);
					FileOutputStream fos = new FileOutputStream(f);
					int length = 0;
					byte[] b = new byte[1024];
					while ((length = is.read(b, 0, 1024)) != -1) {
						fos.write(b, 0, length);
					}
					is.close();
					fos.close();
				}
			}
		}
		if (zipFile != null) {
			zipFile.close();
		}
		
		if (deleteFile) {
			file.deleteOnExit();
		}
	}
}
