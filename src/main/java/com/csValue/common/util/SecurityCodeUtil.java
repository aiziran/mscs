package com.csValue.common.util;


public class SecurityCodeUtil extends SeedBase {

	/**
	 * Data를 len 길이만큼 Key로 ECB 암호화.
	 * 
	 * @param data 암호화시킬 데이타
	 * @param len 암호화시킬길이
	 * @param key 암호화시킬 키
	 * 
	 * @return byte[] 암호화된 데이타.
	 */
	public byte[] ECBEncrypt(byte[] data, int len, byte[] key) {
		int i, block;
		byte[] dup_key = new byte[SEED_BLOCK_SIZE];
		byte[] m = new byte[SEED_BLOCK_SIZE];
		byte[] c = new byte[SEED_BLOCK_SIZE];
		byte[] pad_data;
		byte[] result;

		// 키를 복사해서 사용.
		System.arraycopy(key, 0, dup_key, 0, SEED_BLOCK_SIZE);

		if (len == 0) {
			return null;
		}

		// 데이터 패딩을 한다.
		pad_data = Padding(data, len);

		// 패딩한 데이터를 16바이트 블럭으로 계산한다.
		block = pad_data.length / SEED_BLOCK_SIZE;
		result = new byte[block * SEED_BLOCK_SIZE];

		// 키값 초기화 및 라운딩
		for (i = 0; i < EncRoundKey.length; i++) {
			EncRoundKey[i] = 0x00;
		}
		SeedEncRoundKey(dup_key);

		// 블럭단위로 암호화
		for (i = 0; i < block; i++) {
			System.arraycopy(pad_data, i * SEED_BLOCK_SIZE, m, 0, SEED_BLOCK_SIZE);
			c = SeedEncrypt(m, EncRoundKey);
			System.arraycopy(c, 0, result, i * SEED_BLOCK_SIZE, SEED_BLOCK_SIZE);
		}

		return result;
	}

	/**
	 * Data를 len 길이만큼 Key로 ECB 복호화.
	 * 
	 * @param data 복호화시킬 데이타
	 * @param len 복호화시킬 길이
	 * @param key 복호화시킬 키
	 * 
	 * @return byte[] 암호화된 데이타.
	 */
	public byte[] ECBDecrypt(byte[] data, int len, byte[] key) {
		int i, block;
		byte[] dup_key = new byte[SEED_BLOCK_SIZE];
		byte[] m = new byte[SEED_BLOCK_SIZE];
		byte[] c = new byte[SEED_BLOCK_SIZE];
		byte[] pad_data;
		byte[] result;

		// 키를 복사해서 사용.
		System.arraycopy(key, 0, dup_key, 0, SEED_BLOCK_SIZE);

		int return_len = 0;
		byte[] return_data;

		// 길이가 0이면 null을 리턴한다.
		if (len == 0) {
			return null;
		}

		// 버퍼 크기화 초기화를 한다.
		result = new byte[len];
		block = len / SEED_BLOCK_SIZE;
		pad_data = new byte[len];
		System.arraycopy(data, 0, pad_data, 0, len);

		// 키 초기화
		for (i = 0; i < EncRoundKey.length; i++) {
			EncRoundKey[i] = 0x00;
		}
		SeedEncRoundKey(dup_key);

		// 블럭단위로 복호화
		for (i = 0; i < block; i++) {
			System.arraycopy(pad_data, i * SEED_BLOCK_SIZE, c, 0, SEED_BLOCK_SIZE);
			m = SeedDecrypt(c, EncRoundKey);
			System.arraycopy(m, 0, result, i * SEED_BLOCK_SIZE, SEED_BLOCK_SIZE);
		}

		return_len = UnPadding(result, len);

		// 필요한 부분만 생성하여 리턴한다.
		return_data = new byte[return_len];
		System.arraycopy(result, 0, return_data, 0, return_len);

		return return_data;
	}

	/**
	 * Data를 len 길이만큼 Key로 CBC 암호화한 다음 마지막 블럭을 돌려준다.
	 * 
	 * @param data 암호화시킬 데이타
	 * @param len 암호화시킬 길이
	 * @param key 암호화시킬 키
	 * 
	 * @return byte[] MAC 데이타.
	 */
	public byte[] CBCMAC(byte[] data, int len, byte[] key) {
		int i, block;
		byte[] dup_key = new byte[SEED_BLOCK_SIZE];
		byte[] m = new byte[SEED_BLOCK_SIZE];
		byte[] c = new byte[SEED_BLOCK_SIZE];
		byte[] iv = new byte[SEED_BLOCK_SIZE];
		byte[] pad_data;

		// 키를 복사해서 사용.
		System.arraycopy(key, 0, dup_key, 0, SEED_BLOCK_SIZE);

		if (len == 0) {
			return null;
		}

		// 초기화..
		for (i = 0; i < SEED_BLOCK_SIZE; i++) {
			iv[i] = 0x00;
		}

		// 키 초기화...
		for (i = 0; i < EncRoundKey.length; i++) {
			EncRoundKey[i] = 0x00;
		}
		SeedEncRoundKey(dup_key);

		pad_data = Padding(data, len);
		block = pad_data.length / SEED_BLOCK_SIZE;

		for (i = 0; i < block; i++) {
			System.arraycopy(pad_data, i * SEED_BLOCK_SIZE, m, 0, SEED_BLOCK_SIZE);

			mem_xor(m, iv, SEED_BLOCK_SIZE, 0);

			c = SeedEncrypt(m, EncRoundKey);

			System.arraycopy(c, 0, iv, 0, SEED_BLOCK_SIZE);
		}

		return c;
	}

	/**
	 * Data를 len 길이만큼 Key로 CBC 암호화.
	 * 
	 * @param data 암호화시킬 데이타
	 * 
	 * @return byte[] 암호화된 데이타
	 */
	public byte[] CBCEncrypt(byte[] data) {
		byte[] byteRetKey = { (byte) 0x01, (byte) 0x23, (byte) 0x45, (byte) 0x67, (byte) 0x89, (byte) 0xAB,
				(byte) 0xCD, (byte) 0xEF, (byte) 0x12, (byte) 0x34, (byte) 0x56, (byte) 0x78, (byte) 0X9A, (byte) 0XBC,
				(byte) 0XDE, (byte) 0XF0 };
		return CBCEncrypt(data, data.length, byteRetKey, byteRetKey);
	}

	/**
	 * Data를 len 길이만큼 Key로 CBC 암호화.
	 * 
	 * @param data 암호화시킬 데이타
	 * @param len 암호화시킬길이
	 * @param key 암호화시킬 키
	 * @param iv 초기값
	 * 
	 * @return byte[] 암호화된 데이타
	 */
	public byte[] CBCEncrypt(byte[] data, int len, byte[] key, byte[] iv) {
		int i, block;
		byte[] dup_key = new byte[SEED_BLOCK_SIZE];
		byte[] dup_iv = new byte[SEED_BLOCK_SIZE];
		byte[] m = new byte[SEED_BLOCK_SIZE];
		byte[] c = new byte[SEED_BLOCK_SIZE];
		byte[] pad_data;
		byte[] result;

		// 키를 복사해서 사용.
		System.arraycopy(key, 0, dup_key, 0, SEED_BLOCK_SIZE);
		System.arraycopy(iv, 0, dup_iv, 0, SEED_BLOCK_SIZE);

		if (len == 0) {
			return null;
		}

		// 데이터 패딩을 한다.
		pad_data = Padding(data, len);

		// 패딩한 데이터를 16바이트 블럭으로 계산한다.
		block = pad_data.length / SEED_BLOCK_SIZE;
		result = new byte[block * SEED_BLOCK_SIZE];

		// 키값 초기화 및 라운딩
		for (i = 0; i < EncRoundKey.length; i++) {
			EncRoundKey[i] = 0x00;
		}
		SeedEncRoundKey(dup_key);

		// 블럭단위로 암호화
		for (i = 0; i < block; i++) {
			System.arraycopy(pad_data, i * SEED_BLOCK_SIZE, m, 0, SEED_BLOCK_SIZE);

			mem_xor(m, dup_iv, SEED_BLOCK_SIZE, 0);

			c = SeedEncrypt(m, EncRoundKey);

			System.arraycopy(c, 0, result, i * SEED_BLOCK_SIZE, SEED_BLOCK_SIZE);

			System.arraycopy(c, 0, dup_iv, 0, SEED_BLOCK_SIZE);
		}

		return result;
	}

	/**
	 * Data를 len 길이만큼 Key로 복호화.
	 * 
	 * @param data 복호화시킬 데이타
	 * 
	 * @return byte[] 복화화된 데이타
	 */
	public byte[] CBCDecrypt(byte[] data) {
		//	  UserFunction uf = new UserFunction();
		byte[] byteRetKey = { (byte) 0x01, (byte) 0x23, (byte) 0x45, (byte) 0x67, (byte) 0x89, (byte) 0xAB,
				(byte) 0xCD, (byte) 0xEF, (byte) 0x12, (byte) 0x34, (byte) 0x56, (byte) 0x78, (byte) 0X9A, (byte) 0XBC,
				(byte) 0XDE, (byte) 0XF0 };
		//System.out.println("Decrypt Data : "+uf.ascii2hexstr(data));
		//System.out.println("Before Decrypt : "+uf.ascii2hexstr(byteRetKey));

		return CBCDecrypt(data, data.length, byteRetKey, byteRetKey);

	}

	/**
	 * Data를 len 길이만큼 Key로 복호화.
	 * 
	 * @param data 복호화시킬 데이타
	 * @param len 복호화시킬길이
	 * @param key 복호화시킬 키
	 * @param iv 초기값
	 * 
	 * @return byte[] 복화화된 데이타
	 */
	public byte[] CBCDecrypt(byte[] data, int len, byte[] key, byte[] iv) {
		int i, block;
		byte[] dup_key = new byte[SEED_BLOCK_SIZE];
		byte[] dup_iv = new byte[SEED_BLOCK_SIZE];
		byte[] m = new byte[SEED_BLOCK_SIZE];
		byte[] c = new byte[SEED_BLOCK_SIZE];
		byte[] pad_data;
		byte[] result;
		//		UserFunction uf = new UserFunction();

		// 키를 복사해서 사용.
		//System.out.println("before copy Decrypt : "+uf.ascii2hexstr(key));
		System.arraycopy(key, 0, dup_key, 0, SEED_BLOCK_SIZE);
		System.arraycopy(iv, 0, dup_iv, 0, SEED_BLOCK_SIZE);
		//System.out.println("after copy Decrypt : "+uf.ascii2hexstr(key));

		int return_len = 0;
		byte[] return_data;

		// 길이가 0이면 null을 리턴한다.
		if (len == 0) {
			return null;
		}

		// 버퍼 크기화 초기화를 한다.
		result = new byte[len];
		block = len / SEED_BLOCK_SIZE;
		pad_data = new byte[len];
		System.arraycopy(data, 0, pad_data, 0, len);

		// 키 초기화
		for (i = 0; i < EncRoundKey.length; i++) {
			EncRoundKey[i] = 0x00;
		}
		SeedEncRoundKey(dup_key);

		// 블럭단위로 복호화
		for (i = 0; i < block; i++) {
			System.arraycopy(pad_data, i * SEED_BLOCK_SIZE, c, 0, SEED_BLOCK_SIZE);
			m = SeedDecrypt(c, EncRoundKey);
			mem_xor(m, dup_iv, SEED_BLOCK_SIZE, 0);
			System.arraycopy(m, 0, result, i * SEED_BLOCK_SIZE, SEED_BLOCK_SIZE);
			//System.out.println("Decrypt for("+i+") : "+new String(result));
			System.arraycopy(c, 0, dup_iv, 0, SEED_BLOCK_SIZE);
		}

		return_len = UnPadding(result, len);

		// 필요한 부분만 생성하여 리턴한다.
		return_data = new byte[return_len];
		System.arraycopy(result, 0, return_data, 0, return_len);

		//System.out.println("Decrypt dup_key : "+uf.ascii2hexstr(dup_key));
		//System.out.println("Decrypt dup_iv : "+uf.ascii2hexstr(dup_iv));

		return return_data;
	}

	public byte[] base64Encode(byte[] raw) {
		return Base64.encode(raw);
	}

	public byte[] base64Decode(byte[] raw) {
		return Base64.decode(raw);
	}

	public static void main(String[] args) {
		SecurityCodeUtil iseed = new SecurityCodeUtil();
		String aa = "sitedev1";

		byte[] enc_data = iseed.CBCEncrypt(aa.getBytes());
		System.out.println("ENC String : " + new String(enc_data));

		byte[] base = Base64.encode(enc_data);
		System.out.println("BASE64 : " + new String(base));

		byte[] result = Base64.decode(base);
		System.out.println("BASE64 Decode : " + new String(result));

		byte[] dec_data = iseed.CBCDecrypt(result);

		System.out.println("Dec String : " + new String(dec_data));
	}

	/**
	 * base64로 변환한 데이터 반환
	 * 
	 * @param data
	 * @return
	 * @throws LException
	 */
	public static String Encode(String input) {
		SecurityCodeUtil su = new SecurityCodeUtil();
		byte[] encResult = su.CBCEncrypt(input.getBytes());
		byte[] base64enc = su.base64Encode(encResult);
		return new String(base64enc);
	}

	public static String Decode(String input) {
		SecurityCodeUtil su = new SecurityCodeUtil();
		byte[] base64dec = su.base64Decode(input.getBytes());
		byte[] decResult = su.CBCDecrypt(base64dec);
		return new String(decResult);
	}
}
