package com.csValue.common.util;

import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import org.directwebremoting.ScriptSession;
import org.directwebremoting.proxy.dwr.Util;
import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

public class MessagePush
{
  public void send(String msg)
  {
    WebContext webContext = WebContextFactory.get();
    Temp.setContext(webContext);
    String ip = webContext.getHttpServletRequest().getRemoteAddr().toString();
    String page = "/archive/messageTest.jsp";
    Collection sessions = webContext.getScriptSessionsByPage(page);
    Util util = new Util(sessions);
    util.addFunctionCall("dwrtest", ip + ": " + msg);
  }
  public void onPageLoad(String userId) {
    ScriptSession scriptSession = WebContextFactory.get().getScriptSession();
    scriptSession.setAttribute(userId, userId);
    DwrScriptSessionManagerUtil dwrScriptSessionManagerUtil = new DwrScriptSessionManagerUtil();
    try {
      dwrScriptSessionManagerUtil.init();
    } catch (ServletException e) {
      e.printStackTrace();
    }
  }
}