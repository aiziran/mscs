package com.csValue.common.interceptor;

import org.springside.modules.utils.web.struts2.Struts2Utils;

import com.csValue.common.login.entity.LoginUserData;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class MenuIdInterceptor extends AbstractInterceptor {

	/**
	 * 
	 */
	private static final long serialVersionUID = -71709725633904390L;

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {

		String actionName = invocation.getProxy().getActionName();
		String namespaceName = invocation.getProxy().getNamespace();
		if(namespaceName.indexOf("/front/")>-1)
		{
			return invocation.invoke();
		}
		
		if (!"login".equals(actionName) && !"pda".equals(actionName)) {
			try {
				String id = LoginUserData.getCurrentUserData().getUserId();
				//System.out.println("id = " + id);
			} catch (Exception e) {
				return "sessionFaild";
			}
		}

		String selectMenuId = Struts2Utils.getRequest().getParameter("selectMenuId");

		if (selectMenuId != null && selectMenuId.length() != 0) {
			ActionContext.getContext().getSession().put("selectMenuId", selectMenuId);
		}
		return invocation.invoke();
	}
}
