package ssdevframework.front.filedownload;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * <pre>
 * file download 관련 Utility Class
 * </pre>
 * 
 * @since DevOn Framework 3.0
 * @version DevOn Framework 3.0
 * @author Corporate Asset팀, devon@lgcns.com<br>
 *         LG CNS Technical Service Division<br>
 *         작성 : 2008/04/01<br>
 */
public class FileDownload {

	private static final int BUFFER_SIZE = 4096;

	private final HttpServletRequest request;

	private final HttpServletResponse response;

	private String contentType = "application/octect-stream";

	private String encoding = "UTF-8";

	private boolean directOpen = false;

	private String allow = "*";

	private String deny = "";

	/**
	 * FileDownload 생성자
	 * 
	 * @param req - HttpServletRequest
	 * @param res - HttpServletResponse
	 */
	public FileDownload(HttpServletRequest req, HttpServletResponse res) throws Exception {
		this(req, res, "default");
	}

	/**
	 * FileDownload 생성자
	 * 
	 * @param req - HttpServletRequest
	 * @param res - HttpServletResponse
	 * @param directOpen - direct 오픈 여부
	 */
	public FileDownload(HttpServletRequest req, HttpServletResponse res, String spec) throws Exception {
		this.request = req;
		this.response = res;
	}

	/**
	 * 지정한 url로 redirect시킨다.
	 * 
	 * @param url - redirect하고자 하는 url
	 * @exception Exception
	 */
	public void redirectTo(String url) throws Exception {
		try {
			response.sendRedirect(url);
		} catch (IOException e) {
			throw new Exception("IOExcetion occur. Check " + url + " : " + e, e);
		}
	}

	/**
	 * 설정한 파일을 stream을 통해 다운로드한다.
	 * 
	 * @param file - 다운로드하려는 File 객체
	 * @exception Exception
	 */
	public void streamTo(File file) throws Exception {
		streamTo(file, file.getName());
	}

	/**
	 * alias를 파일명으로 설정한 파일을 stream을 통해 다운로드한다.
	 * 
	 * @param file - 다운로드하려는 File 객체
	 * @param alias - 파일명
	 * @exception Exception
	 */
	public void streamTo(File file, String alias) throws Exception {
		FileInputStream fin = null;
		FileChannel fc = null;
		BufferedOutputStream fout = null;

		try {
			if (!file.getCanonicalPath().equals(file.getAbsolutePath())) {
				throw new Exception(
						"File canonical path does not equals to file absolute path. please use canonical path.");
			}

			this.accept(file);

			if (!file.canRead()) {
				throw new Exception("File cannot be read. Check whether " + file.getName() + " can be read.");
			}

			response.reset();

			setHeaders(alias, file.length());

			fin = new FileInputStream(file);
			fc = fin.getChannel();
			fout = new java.io.BufferedOutputStream(response.getOutputStream());

			ByteBuffer buffer = ByteBuffer.allocate(BUFFER_SIZE);
			int length = -1;
			while ((length = fc.read(buffer)) != -1) {
				buffer.flip();
				fout.write(buffer.array(), 0, length);
				buffer.clear();
			}
		} catch (UnsupportedEncodingException uee) {
			throw new Exception("UnsupportedEncoding[ " + this.encoding + "] : " + uee, uee);
		} catch (FileNotFoundException e) {
			throw new Exception("File not found[ " + file.getName() + "] : " + e, e);
		} catch (IOException e) {
			throw new Exception("IOExcetion occur. Check " + file.getName() + " : " + e, e);
		} finally {
			if (fin != null) {
				try {
					fin.close();
				} catch (Exception e) {
					//LLog.devon.write(LLogUtils.toDefaultLogForm(this.getClass().getName(), "streamTo(File file, String alias)",
					//				"Exception Occured while FileInputStream close : " + e));
				}
			}
			if (fc != null) {
				try {
					fc.close();
				} catch (Exception e) {
					//LLog.devon.write(LLogUtils
					//		.toDefaultLogForm(this.getClass().getName(), "streamTo(File file, String alias)",
					//				"Exception Occured while FileInputStream close : " + e));
				}
			}
			if (fout != null) {
				try {
					fout.flush();
					fout.close();
				} catch (Exception e) {
					//LLog.devon.write(LLogUtils.toDefaultLogForm(this.getClass().getName(),
					//		"streamTo(File file, String alias)",
					//		"Exception Occured while BufferedOutputStream close : " + e));
				}
			}
		}
	}

	/**
	 * 지정된 file이 allow 및 deny에 적합한 이름형식인지를 검사한다.
	 * 
	 * @param file - 저장 정책을 적용할 file 객체
	 * @throws Exception
	 */
	private void accept(File file) throws Exception {

	}

	private void setHeaders(String filename, long filelength) throws UnsupportedEncodingException {
		response.setContentType(getContentType(filename));
		String sUserAgent = request.getHeader("User-Agent");

		if (sUserAgent.indexOf("MSIE 5.5") != -1) {
			response.setHeader("Content-Disposition", "filename=\"" + this.encoding + "\""
					+ encodeURLEncoding(filename) + "\";");
		} else {

			boolean isFirefox = (sUserAgent.toLowerCase().indexOf("firefox") != -1) ? true : false;
			if (this.isDirectOpen()) {
				if (isFirefox) {
					response.setHeader("Content-Disposition", "inline; filename=" + "\"=?" + this.encoding + "?Q?"
							+ encodeQuotedPrintable(filename) + "?=\";");
				} else {
					response.setHeader("Content-Disposition", "inline; filename="
							+ encodeURLEncoding(filename).replaceAll("\\+", "_") + ";");
				}
			} else {
				if (isFirefox) {
					response.setHeader("Content-Disposition", "attachment; filename=" + "\"=?" + this.encoding + "?Q?"
							+ encodeQuotedPrintable(filename) + "?=\";");
				} else {
					response.setHeader("Content-Disposition", "attachment; filename=\""
							+ encodeURLEncoding(filename).replaceAll("\\+", " ") + "\"");
				}
			}
		}

		//response.setHeader("Content-Length", new ClassUtils(filelength).cString());
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");
	}

	private String getContentType(String filename) throws UnsupportedEncodingException {

		this.contentType += "; charset=" + this.encoding;

		if (filename.toLowerCase().lastIndexOf("gif") != -1 || filename.toLowerCase().lastIndexOf("jpg") != -1
				|| filename.toLowerCase().lastIndexOf("bmp") != -1 || filename.toLowerCase().lastIndexOf("png") != -1) {
			this.contentType = "image/gif";
			this.contentType += "; charset=" + this.encoding;
		}
		return this.contentType;
	}

	private String encodeQuotedPrintable(String p_sStr) throws UnsupportedEncodingException {
		String sUrlEncodingStr = URLEncoder.encode(p_sStr, this.encoding);
		sUrlEncodingStr = sUrlEncodingStr.replaceAll("\\+", "_");
		sUrlEncodingStr = sUrlEncodingStr.replaceAll("%", "=");

		return sUrlEncodingStr;
	}

	private String encodeURLEncoding(String p_sStr) throws UnsupportedEncodingException {
		String filename = p_sStr;
		try {
			filename = java.net.URLEncoder.encode(filename, "utf-8");//this.encoding
			filename = filename.replaceAll("\\+", "%20");
		} catch (UnsupportedEncodingException e) {
			//LLog.devon.write(LLogUtils.toDefaultLogForm(this.getClass().getName(), "encodeURLEncoding(String p_sStr)",
			//		"Exception Occured while file name encoding : " + e));

		}
		return filename;
	}

	/**
	 * encoding type을 설정한다.
	 * 
	 * @param encoding - String
	 */
	public void setEncoding(String encoding) {
		this.encoding = encoding;
	}

	/**
	 * direct open 여부를 반환한다.
	 * 
	 * @return boolean - direct open 여부
	 */
	public boolean isDirectOpen() {
		return directOpen;
	}

	/**
	 * direct open 여부를 설정한다.
	 * 
	 * @param directOpen - boolean
	 */
	public void setDirectOpen(boolean directOpen) {
		this.directOpen = directOpen;
	}

}
