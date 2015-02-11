package ssdevframework.front.util;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * for data conversion of chinese column
 * 
 * @author 孔宗(mend@lgcns.com)
 * @version $Revision: 1.4 $ $Date: 2006/03/15 07:52:21 $
 */
public class DataConvProcess {

	//目标数据库信息（gbk编码），视实际情况修改
	static final String TAR_IP = "192.168.0.100";
	static final String TAR_PORT = "1521";
	static final String TAR_SID = "hmis";
	static final String TAR_URL = "jdbc:oracle:thin:@" + TAR_IP + ":" + TAR_PORT + ":" + TAR_SID;
	static final String TAR_USER = "hmis";
	static final String TAR_PASSWORD = "hmis";

	/*
	 * 将ASC编码转换到GBK的数据转换函数，参数为源数据库连接参数(asc编码)
	 */
	static public void convASC2GBK(String ip, String port, String sid, String user, String password) {
		Connection connection = null;
		try {
			// Load the JDBC driver
			String driverName = "oracle.jdbc.driver.OracleDriver";
			Class.forName(driverName);

			//构建目标数据库连接,此连接用户更新转化后数据
			Connection connection1 = DriverManager.getConnection(TAR_URL, TAR_USER, TAR_PASSWORD);
			Statement stmt1 = connection1.createStatement();

			//按照获得的参数建立源数据连接
			String url = "jdbc:oracle:thin:@" + ip + ":" + port + ":" + sid;
			connection = DriverManager.getConnection(url, user, password);
			Statement stmt = connection.createStatement();

			String parama = "管理";
			try {
				byte[] byte_parama = parama.getBytes("GBK");
				parama = new String(byte_parama, "ISO8859_1");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//读取源数据的sql
			String selectSql = "";
			selectSql = "SELECT MENU_CODE,MENU_NAME,MENU_DESC FROM com_menu_m T where MENU_NAME like '%" + parama
					+ "%'";

			System.out.println("select sql : " + selectSql);
			//源数据表
			ResultSet rs = stmt.executeQuery(selectSql);
			int count = 0;

			while (rs.next()) {
				try {
					count++;

					String MENU_CODE = rs.getString("MENU_CODE");

					//获得需要转化的字段
					String convert_MENU_NAME = rs.getString("MENU_NAME");
					String convert_MENU_DESC = rs.getString("MENU_DESC");

					//实际转化
					byte[] bytes_MENU_NAME = convert_MENU_NAME.getBytes("ISO8859_1");
					//convert = new String(bytes, "BIG5");
					convert_MENU_NAME = new String(bytes_MENU_NAME, "GBK");

					byte[] bytes_MENU_DESC = convert_MENU_DESC.getBytes("ISO8859_1");
					//convert = new String(bytes, "BIG5");
					convert_MENU_DESC = new String(bytes_MENU_DESC, "GBK");

					/*
					//构建更新sql
					String sql = "UPDATE ATT_SHIFT_MASTER " + "      SET SHIFT_NM = '" + convert
							+ "'   WHERE SUBSD_CD= " + companyCd + "  AND (SUBSTR(SHIFT_NO,-2)='" + code + "'"
							+ "           OR SUBSTR(SHIFT_NO,-1)='" + code + "')";

					System.out.println("convert sql : " + sql);
					//加入批处理队列
					stmt1.addBatch(sql);
					*/

					System.out.println("row count=" + count + "  MENU_CODE:" + MENU_CODE + ",MENU_NAME:"
							+ convert_MENU_NAME + ",MENU_DESC:" + convert_MENU_DESC);
				} catch (UnsupportedEncodingException e1) {
					e1.printStackTrace();
				}
			}
			/*
			//批处理运行
			int[] result = stmt1.executeBatch();

			//Log结果
			int totalUpdate = 0;
			for (int i = 0; i < result.length; i++) {
				totalUpdate += result[i];
			}
			System.out.println(totalUpdate + " updated of " + count);
			*/

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	/*
	 * 将GBK编码转换到ASC的数据转换函数
	 */
	public static void convGBK2ASC() {

		Connection connection = null;
		try {
			// Load the JDBC driver
			String driverName = "oracle.jdbc.driver.OracleDriver";
			Class.forName(driverName);

			// Create a connection to the conversion database
			String serverName = "localhost";
			String portNumber = "1521";
			String sid = "rsdb";
			String url = "jdbc:oracle:thin:@" + serverName + ":" + portNumber + ":" + sid;
			String username = "hmim";
			String password = "hmim";
			connection = DriverManager.getConnection(url, username, password);

			// Create a connection to the target database
			String serverName1 = "192.168.0.100";
			String portNumber1 = "1521";
			String sid1 = "hmis";
			String url1 = "jdbc:oracle:thin:@" + serverName1 + ":" + portNumber1 + ":" + sid1;
			String username1 = "hmis";
			String password1 = "hmis";
			Connection connection1 = DriverManager.getConnection(url1, username1, password1);
			Statement stmt1 = connection1.createStatement();

			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT MENU_CODE,MENU_NAME,MENU_DESC FROM com_menu_m T");
			int count = 0;

			while (rs.next()) {
				try {
					count++;

					String convert_MENU_NAME = rs.getString("MENU_NAME");
					String convert_MENU_DESC = rs.getString("MENU_DESC");

					String MENU_CODE = rs.getString("MENU_CODE");

					byte[] bytes_MENU_NAME = convert_MENU_NAME.getBytes("GBK");
					convert_MENU_NAME = new String(bytes_MENU_NAME, "ISO8859_1");

					byte[] bytes_MENU_DESC = convert_MENU_DESC.getBytes("GBK");
					convert_MENU_DESC = new String(bytes_MENU_DESC, "ISO8859_1");

					System.out.println("convert_MENU_NAME : " + convert_MENU_NAME);
					System.out.println("convert_MENU_DESC : " + convert_MENU_DESC);

					String sql = "update com_menu_m set menu_name='" + convert_MENU_NAME + "' where menu_code ='"
							+ MENU_CODE + "'";

					stmt1.addBatch(sql);

				} catch (UnsupportedEncodingException e1) {
					e1.printStackTrace();
				}
			}
			int[] result = stmt1.executeBatch();

			int totalUpdate = 0;
			for (int i = 0; i < result.length; i++) {
				totalUpdate += result[i];
			}
			System.out.println(totalUpdate + " updated of " + count);

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	/*
	 * 
	 */
	public static void main(String[] args) throws SQLException {

		//调用实际转换函数
		DataConvProcess.convASC2GBK("192.168.0.100", "1521", "hmis", "hmis", "hmis");

		//DataConvProcess.convGBK2ASC();
	}

}