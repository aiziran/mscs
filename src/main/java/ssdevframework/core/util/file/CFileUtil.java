package ssdevframework.core.util.file;

/**
 * @(#) LFileUtil.java
 * 
 * Copyright 2008 by LG CNS, Inc.,
 * All rights reserved.
 *
 * Do Not Erase This Comment!!! (이 주석문을 지우지 말것)
 *
 * DevOn Core의 클래스를 실제 프로젝트에 사용하는 경우 DevOn Core 개발담당자에게
 * 프로젝트 정식명칭, 담당자 연락처(Email)등을 mail로 알려야 한다.
 *
 * 소스를 변경하여 사용하는 경우 DevOn Core 개발담당자에게
 * 변경된 소스 전체와 변경된 사항을 알려야 한다.
 * 저작자는 제공된 소스가 유용하다고 판단되는 경우 해당 사항을 반영할 수 있다.
 * 중요한 Idea를 제공하였다고 판단되는 경우 협의하에 저자 List에 반영할 수 있다.
 *
 * (주의!) 원저자의 허락없이 재배포 할 수 없으며
 * LG CNS 외부로의 유출을 하여서는 안 된다.
 */
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.Arrays;
import java.util.regex.Pattern;
import java.util.zip.CRC32;
import java.util.zip.Checksum;

/**
 * @(#) LFileUtil.java
 * 
 * <pre>
 * File을 핸들링할 때 필요한 Utility Function을 제공한다.
 * 
 * 이 클래스는 JDK V1.4이상에서 동작한다.
 * </pre>
 * 
 * @since DevOn Core 3.0
 * @version DevOn Core 3.0
 * @author Corporate Asset팀, devon@lgcns.com<br>
 *         LG CNS Technical Service Division<br>
 *         작성 : 2004/03/11<br>
 */
public final class CFileUtil {

	private final static int BUFFER_SIZE = 4096;

	private final static String NEW_LINE = System.getProperty("line.separator");

	/**
	 * 도스 파일시스템의 seperator(\)를 Java Style (/)로 변경하기 위해 사용되는 정규식 패턴
	 */
	public static final Pattern dosSeperator = Pattern.compile("\\\\");

	/**
	 * 파일 시스템의 Full Path에서 마지막이 /로 끝나는지를 검사하기 위해 사용되는 정규식 패턴
	 */
	public static final Pattern lastSeperator = Pattern.compile("/$");

	/**
	 * Don't let anyone instantiate this class
	 */
	private CFileUtil() {
	}

	/**
	 * 주어진 파일의 fullpath중 path부분을 제외한 filname part만 분리하여 리턴한다.<BR>
	 * (new File(fullpath)).getName()과 동일하나 File 객체를 사용하지 않고 문자열 패턴만으로 분석한다.<BR>
	 * 만약 fullpath에 / 혹은 \가 존재하지 않는 경우라면 "./" 을 리턴할 것이다.
	 * 
	 * @param fullpath - Path와 filename으로 이루어진 파일의 fullpath
	 * @return String fullpath중 filename part
	 */
	public static String getFileNameChop(String fullpath) {
		if (fullpath == null)
			return null;
		fullpath = dosSeperator.matcher(fullpath).replaceAll("/");
		int pos = fullpath.lastIndexOf("/");
		if (pos > -1)
			return fullpath.substring(pos + 1);
		return fullpath;
	}

	/**
	 * 주어진 파일의 fullpath중 filname part를 제외한 path 부분만 분리하여 리턴한다.<BR>
	 * (new File(fullpath)).getParent()와 동일하나 File 객체를 사용하지 않고 문자열 패턴만으로 분석한다.<BR>
	 * 만약 fullpath에 / 혹은 \가 존재하지 않는 경우라면 "./" 을 리턴할 것이다.<BR>
	 * 만약 \이 fullpath에 존재한다면 모두 /로 변경할 것이다.
	 * 
	 * @param fullpath - Path와 filename으로 이루어진 파일의 fullpath
	 * @return String - fullpath중 path
	 */
	public static String getFilePathChop(String fullpath) {
		if (null == fullpath)
			return null;
		fullpath = dosSeperator.matcher(fullpath).replaceAll("/");
		int pos = fullpath.lastIndexOf("/");
		if (pos > -1)
			return fullpath.substring(0, pos + 1);
		else
			return "./";
	}

	/**
	 * 주어진 파일의 fullpath의 맨 마지막에 /가 붙어 있는지를 검사하고 없는경우 /를 붙여서 리턴한다.<BR>
	 * 만약 \이 fullpath에 존재한다면 모두 /로 변경될 것이다.
	 * 
	 * @param fullpath - Path와 filename으로 이루어진 파일의 fullpath
	 * @return String - fullpath의 맨 마지막에 /가 붙어 있는 fullpath
	 */
	public static String getCompleteLeadingSeperator(String fullpath) {
		if (null == fullpath)
			return null;
		fullpath = dosSeperator.matcher(fullpath).replaceAll("/");
		if (!fullpath.endsWith(File.separator) && !fullpath.endsWith("/"))
			fullpath += "/";
		return fullpath;
	}

	/**
	 * 주어진 파일의 fullpath의 맨 마지막에 /가 붙어 있는지를 검사하고 있는 경우 맨 마지막의 /를 제거하여 리턴한다.<BR>
	 * 만약 \이 fullpath에 존재한다면 모두 /로 변경될 것이다.
	 * 
	 * @param fullpath - Path와 filename으로 이루어진 파일의 fullpath
	 * @return String - fullpath의 맨 마지막에 /가 제거된 fullpath
	 */
	public static String getRemoveLeadingSeperator(String fileName) {
		if (null == fileName)
			return null;
		fileName = dosSeperator.matcher(fileName).replaceAll("/");
		fileName = lastSeperator.matcher(fileName).replaceAll("");
		return fileName;
	}

	/**
	 * 주어진 size를 크기에 따라 Kb, Mb 형태의 읽기 좋은 String으로 변경하여 리턴한다.<BR>
	 * 변경되는 형태는 아래와 같을 것이다. <BR>
	 * 0 ~ 1024 : #,###.00 byte <BR>
	 * 1024 ~ 1048576 : #,###.00 Kb <BR>
	 * 1048576 ~ 1073741824 : #,###.00 Mb <BR>
	 * 
	 * @param size - 변환하기를 원하는 size
	 * @return String - size 값이 Kb, Mb로 변경된 문자
	 */
	public static String getFilesizeString(long size) {
		String tail = "";
		if (1024 > size) {
			tail = "byte";
		} else if (1048576 > size) {
			size = size / 1024;
			tail = "Kb";
		} else if (1073741824 > size) {
			size = size / 1024;
			tail = "Mb";
		} else if (1099511627776.0 > size) {
			size = (long) (size / 1073741824.0);
			tail = "Gb";
		}
		return new DecimalFormat("#,###.00").format(size) + tail;
	}

	/**
	 * 파일의 확장자를 return 한다.
	 * 
	 * @param filename - String
	 * @return String - 확장자
	 */
	public static String getExtension(String filename) {
		int index = filename.lastIndexOf(".");
		String ext = index == -1 ? "" : filename.substring(index + 1);
		return ext;
	}

	/**
	 * 확장자를 제외한 파일명을 return 한다.
	 * 
	 * @param filename - String
	 * @return String
	 */
	public static String getWithoutExtension(String filename) {
		int index = filename.lastIndexOf(".");
		String name = index == -1 ? filename : filename.substring(0, index);
		return name;
	}

	/**
	 * 파일의 CRC32값을 return 한다.
	 * 
	 * @param file - File
	 * @return long
	 * @throws IOException
	 */
	public static long getCRC32Value(File file) throws IOException {
		Checksum crc = new CRC32();
		BufferedInputStream in = null;
		try {
			in = new BufferedInputStream(new FileInputStream(file));
			byte buffer[] = new byte[BUFFER_SIZE];
			int length = 0;

			while ((length = in.read(buffer)) >= 0) {
				crc.update(buffer, 0, length);
			}

		} finally {
			try {
				in.close();
			} catch (IOException ex) {
			}
		}
		return crc.getValue();
	}

	/**
	 * flush를 수행한다.
	 * 
	 * @param file - File
	 * @return boolean
	 */
	public static boolean touch(File file) {
		FileOutputStream fo = null;
		try {
			fo = new FileOutputStream(file);

		} catch (Exception e) {
			return false;
		} finally {
			if (fo != null) {
				try {
					fo.flush();
				} catch (Exception e) {
				}
				try {
					fo.close();
				} catch (Exception e) {
				}
			}
		}
		return true;
	}

	/**
	 * 두 파일의 바이너리값을 비교한다.
	 * 
	 * @param source - File
	 * @param target - File
	 * @return boolean - 일치 여부
	 * @throws FileNotFoundException - 해당 파일이 존재하지 않을 때 발생
	 */
	public static boolean compareBinary(File source, File target) throws FileNotFoundException {
		if (source.length() != target.length()) {
			return false;
		}
		InputStream in1 = new BufferedInputStream(new FileInputStream(source));
		InputStream in2 = new BufferedInputStream(new FileInputStream(target));
		try {
			byte[] buffer1 = new byte[BUFFER_SIZE];
			byte[] buffer2 = new byte[BUFFER_SIZE];
			int read1 = -1;
			int read2 = -1;
			while ((read1 = in1.read(buffer1)) >= 0 && (read2 = in2.read(buffer2)) >= 0) {
				if (read1 != read2 || !Arrays.equals(buffer1, buffer2)) {
					return false;
				}
			}
		} catch (IOException e) {
			return false;
		} finally {
			try {
				in1.close();
			} catch (IOException ex) {
			}
			try {
				in2.close();
			} catch (IOException ex) {
			}
		}
		return true;
	}

	/**
	 * 빈 파일 여부를 체크한다.
	 * 
	 * @param file - File
	 * @return boolean
	 */
	public static boolean isEmpty(File file) {
		if (file.isDirectory()) {
			String[] files = file.list();
			return files == null || files.length == 0;
		} else {
			return file.length() == 0;
		}
	}

	/**
	 * 빈 폴더 여부를 체크한다.
	 * 
	 * @param file - File
	 * @return boolean
	 */
	public static boolean isEmptyDirectory(File file) {
		if (!file.isDirectory())
			return false;
		String[] files = file.list();
		return files == null || files.length == 0;
	}

	/**
	 * 파일의 내용을 String으로 return 한다.
	 * 
	 * @param fileName - String
	 */
	public static String readFile(String fileName) {
		String retStr = "";
		File f = new File(fileName);
		try {
			BufferedReader br = new BufferedReader(new FileReader(f));
			StringBuffer buff = new StringBuffer();
			String line = br.readLine();
			while (line != null) {
				buff.append(line + NEW_LINE);
				line = br.readLine();
			}
			retStr = buff.toString();
			br.close();
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		return retStr;
	}

	/**
	 * 파일의 내용을 저장한다.
	 * 
	 * @param fileName - String
	 * @param content - String
	 */
	public static void saveFile(String fileName, String content) {
		File f = new File(fileName);
		try {
			BufferedWriter bw = new BufferedWriter(new FileWriter(f));
			bw.write(content);
			bw.close();
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
	}

}
