package ssdevframework.core.util;

/**
 * @(#) LClassUtils.java
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

import java.io.File;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.net.URL;
import java.net.URLClassLoader;

/**
 * 클래스(Class)와 관련된 Utility Class
 * 
 * @since DevOn Core 3.0
 * @version DevOn Core 3.0
 * @author Corporate Asset팀, devon@lgcns.com<br>
 *         LG CNS Technical Service Division<br>
 *         작성 : 2008/04/01<br>
 */
public class ClassUtils {

	/**
	 * 클래스 로더를 반환한다. 단, 파라미터로 주어진 <code>path</code>가 유효하면 URLClassLoader를
	 * 반환한다.
	 * 
	 * @param path
	 * @return ClassLoader -
	 */
	public static ClassLoader getClassLoader(String path) {
		try {
			File file = new File(path);
			URL url = file.toURL();
			return new URLClassLoader(new URL[] { url }, Thread.currentThread().getContextClassLoader());
		} catch (Exception e) {
			return Thread.currentThread().getContextClassLoader();
		}
	}

	/**
	 * 클래스의 instance를 return한다.
	 * 
	 * @param name - 클래스 name
	 * @return Object
	 * @throws Exception
	 */
	public static Object getInstance(String name) throws Exception {
		ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
		Object instance = null;
		try {
			Class classInstance = classLoader.loadClass(name.trim());
			instance = classInstance.newInstance();
		} catch (ClassNotFoundException e) {
			throw new Exception("COR_UTL_001", e);
		} catch (IllegalAccessException e) {
			throw new Exception("COR_UTL_002", e);
		} catch (InstantiationException e) {
			throw new Exception("COR_UTL_003", e);
		}
		return instance;
	}

	/**
	 * 클래스의 instance를 return한다.
	 * 
	 * @param name
	 * @param classParam
	 * @param params
	 * @return Object
	 * @throws Exception
	 */
	public static Object getInstance(String name, Class[] classParam, Object[] params) throws Exception {
		ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
		Object instance = null;
		try {
			Class classInstance = classLoader.loadClass(name.trim());
			Constructor classConstructor = classInstance.getConstructor(classParam);
			instance = classConstructor.newInstance(params);
		} catch (ClassNotFoundException e) {
			throw new Exception("COR_UTL_001", e);
		} catch (IllegalAccessException e) {
			throw new Exception("COR_UTL_002", e);
		} catch (InstantiationException e) {
			throw new Exception("COR_UTL_003", e);
		} catch (NoSuchMethodException e) {
			throw new Exception("COR_UTL_004", e);
		} catch (InvocationTargetException e) {
			throw new Exception("COR_UTL_005", e);
		}

		return instance;
	}

}
