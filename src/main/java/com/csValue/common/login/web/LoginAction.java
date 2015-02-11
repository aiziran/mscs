package com.csValue.common.login.web;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.utils.web.struts2.Struts2Utils;

import ssdevframework.core.collection.CData;

import com.csValue.basicInfor.comboMange.service.ComboManage;
import com.csValue.common.login.entity.LoginUserData;
import com.csValue.common.login.service.LoginManager;
import com.opensymphony.xwork2.ActionSupport;

@Namespace("/login")
@Results({@org.apache.struts2.convention.annotation.Result(name="behand", location="/WEB-INF/content/behand.jsp"), @org.apache.struts2.convention.annotation.Result(name="jishou", location="/WEB-INF/content/jishou.jsp"), @org.apache.struts2.convention.annotation.Result(name="zhijian", location="/WEB-INF/content/zhijian.jsp"), @org.apache.struts2.convention.annotation.Result(name="success", location="/WEB-INF/content/login.jsp"), @org.apache.struts2.convention.annotation.Result(name="loginSuccess", location="/WEB-INF/content/main/main.jsp"), @org.apache.struts2.convention.annotation.Result(name="tiaozhuan", location="/WEB-INF/content/main/tiaozhuan.jsp"), @org.apache.struts2.convention.annotation.Result(name="mvnForum", location="/WEB-INF/content/common/login/mvnForum.jsp")})
public class LoginAction extends ActionSupport
{
  private static final long serialVersionUID = 1L;
  private String j_username;
  private String message;
  private String j_password;
  private String j_department;
  private ArrayList<CData> deptList;
  private LoginManager loginManager;
  private CData data;
  private String topMenuId;
  private String topMenuName;

  @Autowired
  private ComboManage comboManage;

  public CData getData()
  {
    return this.data;
  }

  public void setData(CData data) {
    this.data = data;
  }

  public LoginManager getLoginManager()
  {
    return this.loginManager;
  }
  @Autowired
  public void setLoginManager(LoginManager loginManager) {
    this.loginManager = loginManager;
  }

  public String execute() throws Exception
  {
    this.deptList = this.comboManage.retrieveDeptListALL();
    return "success";
  }

  public String login() throws Exception
  {
    System.out.println("用户登录");
    HashMap loginU = new HashMap();
    loginU.put("tUserId", getJ_username());
    loginU.put("tUserPassword", getJ_password());
    loginU.put("tUserDepartment", getJ_department());
    HashMap user = this.loginManager.login(loginU);
    Struts2Utils.getSession().removeAttribute("jihao");
    if (user == null) {
      addActionMessage("用户名或者密码错误，请确认后再输入");
      this.deptList = this.comboManage.retrieveDeptListALL();
      return "success";
    }

    HttpSession session = Struts2Utils.getSession();
    String roleid = user.get("userRole").toString();
    String id = roleid.substring(1, 8);
    session.setAttribute("roleId", id);
    session.setAttribute("username", getJ_username());
    session.setAttribute("userChianName", user.get("userName"));
    session.setAttribute("username", getJ_username());
    session.setAttribute("password", getJ_password());
    //获取按钮权限
    CData cData = new CData();
    cData.put("rid", id);
    List<CData> list = loginManager.getButtonList(cData);
	session.setAttribute("buttonlist", list);
  //获取操作模块的功能菜单
    String userListStr = (String) user.get("urllist");
    if(userListStr != null && userListStr.trim().length()>0) {
    	userListStr = userListStr.substring(0, userListStr.length()-1);
    	String[] split = userListStr.split(",");
    	Map map = new HashMap();
    	map.put("id", split);
    	List<CData> findFunctionList = loginManager.findFunction(map);
    	if(findFunctionList!=null && findFunctionList.size()>0) {
    		session.setAttribute("functionList", findFunctionList);
    	}
    }
    
    if (id.equals("1000078"))
    {
      return "tiaozhuan";
    }

    if (id.equals("1000079"))
    {
      return "tiaozhuan";
    }

    if (id.equals("1000080"))
    {
      return "tiaozhuan";
    }

    return "tiaozhuan";
  }

  public String home()
    throws Exception
  {
    HttpSession session = Struts2Utils.getSession();
    if (LoginUserData.getCurrentUserData() == null) {
      this.deptList = this.comboManage.retrieveDeptListALL();
      return "success";
    }
    return "loginSuccess";
  }

  public String loginOut() throws Exception {
    HttpSession session = Struts2Utils.getSession();
    session.removeAttribute("userSession");
    session.invalidate();
    this.deptList = this.comboManage.retrieveDeptListALL();

    return "success";
  }

  public String tiaozhuan()
  {
    try
    {
      String str = new String(Struts2Utils.getRequest().getParameter("topMenuName").trim().getBytes("ISO-8859-1"), "UTF-8");
      Struts2Utils.getSession().setAttribute("topMenuId", Struts2Utils.getRequest().getParameter("topMenuId"));
      Struts2Utils.getSession().setAttribute("topMenuName", str);

      System.out.println(this.topMenuId + "==============>>>" + this.topMenuName);
    }
    catch (UnsupportedEncodingException e) {
      e.printStackTrace();
    }

    return "loginSuccess";
  }

  public String goToMvnForum() throws Exception {
    return "mvnForum";
  }

  public String getJ_username()
  {
    return this.j_username;
  }

  public void setJ_username(String j_username) {
    this.j_username = j_username;
  }

  public String getJ_password() {
    return this.j_password;
  }

  public void setJ_password(String j_password) {
    this.j_password = j_password;
  }

  public ArrayList<CData> getDeptList() {
    return this.deptList;
  }

  public void setDeptList(ArrayList<CData> deptList) {
    this.deptList = deptList;
  }

  public String getJ_department() {
    return this.j_department;
  }

  public void setJ_department(String j_department) {
    this.j_department = j_department;
  }

  public String getMessage() {
    return this.message;
  }

  public void setMessage(String message) {
    this.message = message;
  }
  public String getTopMenuId() {
    return this.topMenuId;
  }

  public void setTopMenuId(String topMenuId) {
    this.topMenuId = topMenuId;
  }

  public String getTopMenuName() {
    return this.topMenuName;
  }

  public void setTopMenuName(String topMenuName) {
    this.topMenuName = topMenuName;
  }
}