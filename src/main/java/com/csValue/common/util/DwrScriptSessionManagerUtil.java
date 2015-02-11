package com.csValue.common.util;

import java.io.PrintStream;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;
import org.directwebremoting.Container;
import org.directwebremoting.ScriptSession;
import org.directwebremoting.ServerContext;
import org.directwebremoting.ServerContextFactory;
import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.event.ScriptSessionEvent;
import org.directwebremoting.event.ScriptSessionListener;
import org.directwebremoting.extend.ScriptSessionManager;
import org.directwebremoting.servlet.DwrServlet;

public class DwrScriptSessionManagerUtil extends DwrServlet {
	private static final long serialVersionUID = -7504612622407420071L;

	public void init() throws ServletException {
		Container container = ServerContextFactory.get().getContainer();

		ScriptSessionManager manager = (ScriptSessionManager) container.getBean(ScriptSessionManager.class);
		ScriptSessionListener listener = new ScriptSessionListener() {
			public void sessionCreated(ScriptSessionEvent ev) {
				HttpSession session = WebContextFactory.get().getSession();
				String lineno = (String) session.getAttribute("jihao");
				ev.getSession().setAttribute("lineno", lineno);
			}

			public void sessionDestroyed(ScriptSessionEvent ev) {
			}
		};
		manager.addScriptSessionListener(listener);
	}
}
