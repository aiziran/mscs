package com.csValue.common.ireport;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRConstants;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRPdfExporterParameter;
import net.sf.jasperreports.engine.util.FileBufferedOutputStream;
import net.sf.jasperreports.j2ee.servlets.BaseHttpServlet;
import ssdevframework.core.collection.CMultiData;

/**
 * 
 * @ClassName: PdfExportUtil 
 * @Description: TODO
 *		pdf导出工具类，通过调用PdfExportPrepare()输出pdf文件，其中mData中有一个key值为"PDFCONTENTDATA"的CMultiData用来存放pdf数据
 * @author caoshengquan csq39@126.com 
 * @date 2011-5-13 下午11:57:01 
 *
 */
public class PdfExportUtil {
	private static final long serialVersionUID = JRConstants.SERIAL_VERSION_UID;

	public static String PDF_CONTENT = "PDFCONTENTDATA";

	/**
	 * @Description: TODO
	 * 	该工具类的调用方法是 PdfExportUtil.PdfExportPrepare();
	 * 	注意传入的mData的格式以及url的路径。
	 *  pdf导出的页面部分请用弹出页的方式访问路径。
	 *  action中相关方法请returne null;
	 * @param request 当前的请求
	 * @param response 当前的response
	 * @param context 当前请求的上下文环境
	 * @param mData pdf的数据
	 * @param url   jasper文件的相对webcontent的路径
	 * @throws IOException
	 * @throws ServletException     
	 * @throws
	 */
	public static void PdfExportPrepare(HttpServletRequest request, HttpServletResponse response,
			ServletContext context, CMultiData mData, String url) throws IOException, ServletException {

		//		List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
		//
		//		if (url != null && !mData.isEmpty()) {
		//			url = context.getRealPath(url);
		//			for (int i = 0; i < mData.getDataCount(PDF_CONTENT); i++) {
		//				JasperPrint jasperPrint = null;
		//				try {
		//					File reportFile = new File(url);
		//					JasperReport jasperReport = (JasperReport) JRLoader.loadObject(reportFile.getPath());
		//					HashMapDataSource hd = new HashMapDataSource((CMultiData) mData.get(PDF_CONTENT, i));
		//					JRDataSource dataSource = hd.createReportDataSource();
		//
		//					jasperPrint = JasperFillManager.fillReport(jasperReport, new HashMap(), dataSource);
		//				} catch (JRException e) {
		//				}
		//				if (jasperPrint == null) {
		//					throw new ServletException("No JasperPrint documents found on the HTTP session.");
		//				}
		//				jasperPrintList.add(jasperPrint);
		//			}
		//		}
		//
		//		exportPdf(jasperPrintList, request, response);
	}

	protected static void exportPdf(List<JasperPrint> jasperPrintList, HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		Boolean isBuffered = Boolean.valueOf(request.getParameter(BaseHttpServlet.BUFFERED_OUTPUT_REQUEST_PARAMETER));
		if (isBuffered.booleanValue()) {
			FileBufferedOutputStream fbos = new FileBufferedOutputStream();
			JRPdfExporter exporter = new JRPdfExporter();
			exporter.setParameter(JRExporterParameter.JASPER_PRINT_LIST, jasperPrintList);
			exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, fbos);
			exporter.setParameter(JRPdfExporterParameter.IS_CREATING_BATCH_MODE_BOOKMARKS, Boolean.TRUE);
			try {
				exporter.exportReport();
				fbos.close();

				if (fbos.size() > 0) {
					response.setContentType("application/pdf");
					response.setContentLength(fbos.size());
					ServletOutputStream ouputStream = response.getOutputStream();

					try {
						fbos.writeData(ouputStream);
						fbos.dispose();
						ouputStream.flush();
					} finally {
						if (ouputStream != null) {
							try {
								ouputStream.close();
							} catch (IOException ex) {
							}
						}
					}
				}
			} catch (JRException e) {
				throw new ServletException(e);
			} finally {
				fbos.close();
				fbos.dispose();
			}

		} else {
			response.setContentType("application/pdf");

			JRPdfExporter exporter = new JRPdfExporter();
			exporter.setParameter(JRExporterParameter.JASPER_PRINT_LIST, jasperPrintList);

			OutputStream ouputStream = response.getOutputStream();
			exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, ouputStream);

			try {
				exporter.exportReport();
			} catch (JRException e) {
				throw new ServletException(e);
			} finally {
				if (ouputStream != null) {
					try {
						ouputStream.close();
					} catch (IOException ex) {
					}
				}
			}
		}

	}
}
