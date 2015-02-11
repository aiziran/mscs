package com.csValue.front.handerManage.web;

import com.csValue.basicInfor.comboMange.service.ComboManage;
import com.csValue.front.handerManage.service.HanderManager;
import com.opensymphony.xwork2.ActionSupport;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.http.HttpSession;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.utils.web.struts2.Struts2Utils;
import ssdevframework.core.collection.CData;

@Namespace("/front/handerManage")
@Results({@org.apache.struts2.convention.annotation.Result(name="jishou", location="/WEB-INF/content/jishou.jsp"), @org.apache.struts2.convention.annotation.Result(name="reload", location="hander.action", type="redirectParams")})
public class HanderAction extends ActionSupport
{
  private static final long serialVersionUID = 1L;
  private String j_username;
  private String message;
  private String j_password;
  private String j_department;
  private ArrayList<CData> deptList;
  private HanderManager handerManager;
  private CData data;

  @Autowired
  private ComboManage comboManage;

  public HanderManager getHanderManager()
  {
    return this.handerManager;
  }

  public void setHanderManager(HanderManager handerManager) {
    this.handerManager = handerManager;
  }

  public CData getData()
  {
    return this.data;
  }

  public void setData(CData data) {
    this.data = data;
  }

  public String execute()
    throws Exception
  {
    this.deptList = this.comboManage.retrieveDeptListALL();
    return "success";
  }

  public String hander() throws Exception
  {
    System.out.println("用户登录");
    HashMap loginU = new HashMap();
    loginU.put("tUserId", getJ_username());
    loginU.put("tUserPassword", getJ_password());
    loginU.put("tUserDepartment", getJ_department());
    HashMap user = this.handerManager.login(loginU);
    System.out.println(user);
    if (user == null) {
      addActionMessage("用户名或者密码错误，请确认后再输入");
      this.deptList = this.comboManage.retrieveDeptListALL();
      return "success";
    }

    HttpSession session = Struts2Utils.getSession();
    String roleid = (String) user.get("userRole");
    String id = roleid.substring(1, 8);
    session.setAttribute("username", getJ_username());
    session.setAttribute("roleId", id);

    return "jishou";
  }

  public String loginOut()
    throws Exception
  {
    HttpSession session = Struts2Utils.getSession();
    session.removeAttribute("userSession");
    session.invalidate();
    this.deptList = this.comboManage.retrieveDeptListALL();

    return "success";
  }

  public String goToMvnForum() throws Exception
  {
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
}