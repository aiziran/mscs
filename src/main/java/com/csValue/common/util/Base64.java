/*
 *------------------------------------------------------------------------------
 * 
 * PROJ : Project Based Framework 
 * Copyright 2006-2007 LG CNS All rights reserved
 *------------------------------------------------------------------------------
 *                  변         경         사         항
 *------------------------------------------------------------------------------
 *   DATE       AUTHOR                      DESCRIPTION
 * -----------  ------  ---------------------------------------------------------
 * 2006.10.13   이정석         최초 프로그램 작성
 *----------------------------------------------------------------------------
 */
package com.csValue.common.util;

/**
 * <pre>
 *   바이트 문자열의 BASE64 인코딩과 디코딩을 지원한다.
 * </pre>
 *
 * 
 * @author 이정석, leejs03@lgcns.com<br>
 *         LG CNS TSD S/W Architecture Team<br>
 * @version CVS$Revision: 1.2 $ 최종작성$Date: 2008/08/25 04:00:56 $
 */
public final class Base64 {

	static private final int BASELENGTH = 255;

	static private final int LOOKUPLENGTH = 64;

	static private final int TWENTYFOURBITGROUP = 24;

	static private final int EIGHTBIT = 8;

	static private final int SIXTEENBIT = 16;

	//    static private final int SIXBIT = 6;

	static private final int FOURBYTE = 4;

	static private final int SIGN = -128;

	static private final byte PAD = (byte) '=';

	static private byte[] base64Alphabet = new byte[BASELENGTH];

	static private byte[] lookUpBase64Alphabet = new byte[LOOKUPLENGTH];

	static {
		for (int i = 0; i < BASELENGTH; i++)
			base64Alphabet[i] = -1;

		for (int i = 'Z'; i >= 'A'; i--)
			base64Alphabet[i] = (byte) (i - 'A');

		for (int i = 'z'; i >= 'a'; i--)
			base64Alphabet[i] = (byte) (i - 'a' + 26);

		for (int i = '9'; i >= '0'; i--)
			base64Alphabet[i] = (byte) (i - '0' + 52);

		base64Alphabet['+'] = 62;
		base64Alphabet['/'] = 63;

		for (int i = 0; i <= 25; i++)
			lookUpBase64Alphabet[i] = (byte) ('A' + i);

		for (int i = 26, j = 0; i <= 51; i++, j++)
			lookUpBase64Alphabet[i] = (byte) ('a' + j);

		for (int i = 52, j = 0; i <= 61; i++, j++)
			lookUpBase64Alphabet[i] = (byte) ('0' + j);

		lookUpBase64Alphabet[62] = (byte) '+';
		lookUpBase64Alphabet[63] = (byte) '/';
	}

	/**
	 * 입력된 문자열이 Base64로 인코딩된 데이터인지를 체크한다.
	 * 
	 * @param isValidString String 문자열
	 * 
	 * @return boolean Base 64 여부를 리턴한다.
	 */
	public static boolean isBase64(String isValidString) {
		return isArrayByteBase64(isValidString.getBytes());
	}

	/**
	 * 입력된 byte 정보가 Base64로 인코딩 된정보인지를 체크한다.
	 * 
	 * @param octect byte 데이터
	 * 
	 * @return boolean Base 64 여부를 리턴한다.
	 */
	public static boolean isBase64(byte octect) {
		return (octect == PAD || base64Alphabet[octect] != -1);
	}

	/**
	 * 입력된 byte array 정보가 Base64로 인코딩 된정보인지를 체크한다.
	 * 
	 * @param arrayOctect byte array
	 * 
	 * @return boolean Base 64 여부를 리턴한다.
	 */
	public static boolean isArrayByteBase64(byte[] arrayOctect) {
		int length = arrayOctect.length;
		if (length == 0)
			return true;
		for (int i = 0; i < length; i++) {
			if (!Base64.isBase64(arrayOctect[i]))
				return false;
		}
		return true;
	}

	/**
	 * 입력된 byte array를 BASE64 인코딩 수행한다.
	 * 
	 * @param binaryData 입력 byte
	 * 
	 * @return byte[] 인코딩 결과 byte array
	 */
	public static byte[] encode(byte[] binaryData) {
		if (binaryData == null || binaryData.length == 0)
			return new byte[0];
		int lengthDataBits = binaryData.length * EIGHTBIT;
		int fewerThan24bits = lengthDataBits % TWENTYFOURBITGROUP;
		int numberTriplets = lengthDataBits / TWENTYFOURBITGROUP;
		byte encodedData[] = null;

		if (fewerThan24bits != 0) {
			encodedData = new byte[(numberTriplets + 1) * 4];
		} else {
			encodedData = new byte[numberTriplets * 4];
		}

		byte k = 0, l = 0, b1 = 0, b2 = 0, b3 = 0;

		int encodedIndex = 0;
		int dataIndex = 0;
		int i = 0;

		for (i = 0; i < numberTriplets; i++) {
			dataIndex = i * 3;
			b1 = binaryData[dataIndex];
			b2 = binaryData[dataIndex + 1];
			b3 = binaryData[dataIndex + 2];

			l = (byte) (b2 & 0x0f);
			k = (byte) (b1 & 0x03);

			encodedIndex = i * 4;
			byte val1 = ((b1 & SIGN) == 0) ? (byte) (b1 >> 2) : (byte) ((b1) >> 2 ^ 0xc0);
			byte val2 = ((b2 & SIGN) == 0) ? (byte) (b2 >> 4) : (byte) ((b2) >> 4 ^ 0xf0);
			byte val3 = ((b3 & SIGN) == 0) ? (byte) (b3 >> 6) : (byte) ((b3) >> 6 ^ 0xfc);

			encodedData[encodedIndex] = lookUpBase64Alphabet[val1];
			encodedData[encodedIndex + 1] = lookUpBase64Alphabet[val2 | (k << 4)];
			encodedData[encodedIndex + 2] = lookUpBase64Alphabet[(l << 2) | val3];
			encodedData[encodedIndex + 3] = lookUpBase64Alphabet[b3 & 0x3f];
		}

		dataIndex = i * 3;
		encodedIndex = i * 4;
		if (fewerThan24bits == EIGHTBIT) {
			b1 = binaryData[dataIndex];
			k = (byte) (b1 & 0x03);
			byte val1 = ((b1 & SIGN) == 0) ? (byte) (b1 >> 2) : (byte) ((b1) >> 2 ^ 0xc0);
			encodedData[encodedIndex] = lookUpBase64Alphabet[val1];
			encodedData[encodedIndex + 1] = lookUpBase64Alphabet[k << 4];
			encodedData[encodedIndex + 2] = PAD;
			encodedData[encodedIndex + 3] = PAD;
		} else if (fewerThan24bits == SIXTEENBIT) {
			b1 = binaryData[dataIndex];
			b2 = binaryData[dataIndex + 1];
			l = (byte) (b2 & 0x0f);
			k = (byte) (b1 & 0x03);

			byte val1 = ((b1 & SIGN) == 0) ? (byte) (b1 >> 2) : (byte) ((b1) >> 2 ^ 0xc0);
			byte val2 = ((b2 & SIGN) == 0) ? (byte) (b2 >> 4) : (byte) ((b2) >> 4 ^ 0xf0);

			encodedData[encodedIndex] = lookUpBase64Alphabet[val1];
			encodedData[encodedIndex + 1] = lookUpBase64Alphabet[val2 | (k << 4)];
			encodedData[encodedIndex + 2] = lookUpBase64Alphabet[l << 2];
			encodedData[encodedIndex + 3] = PAD;
		}
		return encodedData;
	}

	/**
	 * 입력된 byte array를 BASE64 디코딩 수행한다.
	 * 
	 * @param base64Data base64로 인코딩된 byte[]
	 * 
	 * @return byte[] 디코딩 결과 byte array
	 */
	public static byte[] decode(byte[] base64Data) {
		if (base64Data == null || base64Data.length == 0)
			return new byte[0];

		int numberQuadruple = base64Data.length / FOURBYTE;
		byte decodedData[] = null;
		byte b1 = 0, b2 = 0, b3 = 0, b4 = 0, marker0 = 0, marker1 = 0;

		int encodedIndex = 0;
		int dataIndex = 0;
		{
			int lastData = base64Data.length;
			while (base64Data[lastData - 1] == PAD) {
				if (--lastData == 0)
					return new byte[0];
			}
			decodedData = new byte[lastData - numberQuadruple];
		}

		for (int i = 0; i < numberQuadruple; i++) {
			dataIndex = i * 4;
			marker0 = base64Data[dataIndex + 2];
			marker1 = base64Data[dataIndex + 3];

			b1 = base64Alphabet[base64Data[dataIndex]];
			b2 = base64Alphabet[base64Data[dataIndex + 1]];

			if (marker0 != PAD && marker1 != PAD) {
				b3 = base64Alphabet[marker0];
				b4 = base64Alphabet[marker1];

				decodedData[encodedIndex] = (byte) (b1 << 2 | b2 >> 4);
				decodedData[encodedIndex + 1] = (byte) (((b2 & 0xf) << 4) | ((b3 >> 2) & 0xf));
				decodedData[encodedIndex + 2] = (byte) (b3 << 6 | b4);
			} else if (marker0 == PAD) {
				decodedData[encodedIndex] = (byte) (b1 << 2 | b2 >> 4);
			} else if (marker1 == PAD) {
				b3 = base64Alphabet[marker0];

				decodedData[encodedIndex] = (byte) (b1 << 2 | b2 >> 4);
				decodedData[encodedIndex + 1] = (byte) (((b2 & 0xf) << 4) | ((b3 >> 2) & 0xf));
			}
			encodedIndex += 3;
		}
		return decodedData;
	}

	public static void main(String[] args) {

	}
}
