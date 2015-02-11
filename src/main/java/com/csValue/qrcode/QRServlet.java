package com.csValue.qrcode;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class QRServlet
 */
public class QRServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public QRServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		QrcodeTool qt = new QrcodeTool();
		String args[] = {
				"936,640133,10120111005377,1000000066,7505,注射用拉氧头孢钠,注射用拉氧头孢钠,海南海灵化,瓶,0.25g,184,211.6,10,1840,2116,国药准字H20010108,101101,20101101,20121031,20110526,1",
				this.getServletContext().getRealPath("/") + "gbk5555.png", "gbk" };
		if (args == null || args.length < 2) {
			System.out.println("need two arguments at last!");
			return;
		}
		try {
			BufferedImage bi = qt.createImage(args[0], args.length > 2 ? args[2] : null,
					args.length > 3 ? "true".equals(args[3]) : false);
			qt.writeImge2File(bi, args[1]);
		} catch (Exception ee) {
			ee.printStackTrace();
		}

		PrintWriter out = response.getWriter();
		out.println("success! <br>");
		out.println("<img src='gbk5555.png'>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
			IOException {
		// TODO Auto-generated method stub
	}

}
