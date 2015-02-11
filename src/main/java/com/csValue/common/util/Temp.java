package com.csValue.common.util;

import uk.ltd.getahead.dwr.WebContext;

public class Temp {
	public static WebContext context;

	public static WebContext getContext() {
		return context;
	}

	public static void setContext(WebContext context) {
		Temp.context = context;
	}
	
}
