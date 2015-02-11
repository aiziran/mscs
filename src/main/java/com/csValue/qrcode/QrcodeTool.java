package com.csValue.qrcode;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;

import javax.imageio.ImageIO;

public class QrcodeTool {

	/**
	 * 图像大小。
	 */
	private static final int[] IMAGE_SIZE = { 80, 100, 120, 150, 200, 240, 300, 400, 500, 600, 800, 1000 };

	/**
	 * 生成一个二维码
	 * @param contect 内容
	 * @param encoding 内容以何种编码输出
	 * @param convert2Base64 内容是否先编码为base64后，再生成二维码
	 * @return
	 * @throws Exception
	 */
	public static BufferedImage createImage(String contect, String encoding, boolean convert2Base64) throws Exception {

		Qrcode qrcode = new Qrcode();
		qrcode.setQrcodeErrorCorrect('M');
		qrcode.setQrcodeEncodeMode('B');
		//qrcode.setQrcodeVersion(0);

		if (encoding == null || encoding.length() == 0) {
			encoding = "UTF8";
		}

		if (convert2Base64) {
			contect = Base64.encodeStrUrlSafe(contect, encoding);
			System.out.println(contect);
		}

		byte[] d = contect.getBytes(encoding);

		boolean[][] b = qrcode.calQrcode(d);

		int n = b.length > b[0].length ? b.length : b[0].length;
		int imageSize = 0;

		for (int i = 0; i < IMAGE_SIZE.length; i++) {
			if (2 * n < IMAGE_SIZE[i]) {
				imageSize = IMAGE_SIZE[i];
				break;
			}
		}

		BufferedImage bi = new BufferedImage(imageSize, imageSize, BufferedImage.TYPE_INT_RGB);

		// createGraphics  
		Graphics2D g = bi.createGraphics();

		// set background  
		g.setBackground(Color.WHITE);
		g.clearRect(0, 0, imageSize, imageSize);

		g.setColor(Color.BLACK);

		for (int i = 0; i < b.length; i++) {

			for (int j = 0; j < b.length; j++) {
				if (b[j][i]) {
					g.fillRect(j * 2 + 1, i * 2 + 1, 2, 2);
				}
			}
		}

		g.dispose();
		bi.flush();
		return bi;
	}

	public static void writeImge2File(BufferedImage bi, String filePath) throws Exception {
		File f = new File(filePath);

		ImageIO.write(bi, "png", f);

	}

	//936,640133,10120111005377,1000000066,7505,注射用拉氧头孢钠,注射用拉氧头孢钠,海南海灵化,瓶,0.25g,184,211.6,10,1840,2116,国药准字H20010108,101101,20101101,20121031,20110526,1 d:/gbk5555.png gbk
	public static void main(String[] args) {

		if (args == null || args.length < 2) {
			System.out.println("need two arguments at last!");
			return;
		}
		try {
			BufferedImage bi = createImage(args[0], args.length > 2 ? args[2] : null,
					args.length > 3 ? "true".equals(args[3]) : false);
			writeImge2File(bi, args[1]);
		} catch (Exception ee) {
			ee.printStackTrace();
		}
	}
}