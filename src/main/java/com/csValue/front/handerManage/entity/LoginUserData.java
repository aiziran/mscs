package com.csValue.front.handerManage.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springside.modules.utils.web.struts2.Struts2Utils;

public class LoginUserData
  implements Serializable
{
  private static final long serialVersionUID = -6825267645027264858L;
  public static final String USER_DATA_KEY = "userSession";
  private String userId;
  private String authority;
  private List<String> roles;
  private String menuId;
  private List<HashMap> deptRoleList;
  private String userNm;
  private String subDeptId;
  private String loginDeptId;
  private String supplierId;
  private String hospitalId;

  public String getSupplierId()
  {
    return this.supplierId;
  }

  public void setSupplierId(String supplierId) {
    this.supplierId = supplierId;
  }

  public String getHospitalId() {
    return this.hospitalId;
  }

  public void setHospitalId(String hospitalId) {
    this.hospitalId = hospitalId;
  }

  public String getSubDeptId() {
    return this.subDeptId;
  }

  public void setSubDeptId(String subDeptId) {
    this.subDeptId = subDeptId;
  }

  public void addRole(String roleCode) {
    if (this.roles == null) {
      this.roles = new ArrayList();
    }
    this.roles.add(roleCode);
  }

  public boolean hasRole(String targetRole) {
    if (this.roles == null) {
      return false;
    }

    return this.roles.contains(targetRole);
  }

  public static LoginUserData getCurrentUserData() {
    HttpSession session = Struts2Utils.getSession(false);

    if (session == null) {
      return null;
    }
    return (LoginUserData)session.getAttribute("userSession");
  }

  public LoginUserData()
  {
  }

  public LoginUserData(HashMap<String, ?> data) throws Exception
  {
    if (data.containsKey("USERID"))
      setUserId((String)data.get("USERID"));
    if (data.containsKey("AUTHORITY"))
      setAuthority((String)data.get("AUTHORITY"));
    if (data.containsKey("MENUID"))
      setMenuId((String)data.get("MENUID"));
    if (data.containsKey("USERNAME"))
      setUserNm((String)data.get("USERNAME"));
    if (data.containsKey("deptRoleList")) {
      setDeptRoleList((List)data.get("deptRoleList"));
    }
    if (data.containsKey("userRole"))
      setRoles((List)data.get("userRole"));
  }

  public String getUserId()
  {
    return this.userId;
  }

  public void setUserId(String userId) {
    this.userId = userId;
  }

  public String getAuthority() {
    return this.authority;
  }

  public List<HashMap> getDeptRoleList() {
    return this.deptRoleList;
  }

  public void setDeptRoleList(List<HashMap> deptRoleList) {
    this.deptRoleList = deptRoleList;
  }

  public void setAuthority(String authority) {
    this.authority = authority;
  }

  public List getRoles() {
    return this.roles;
  }

  public void setRoles(List roles) {
    this.roles = roles;
  }

  public String getMenuId() {
    return this.menuId;
  }

  public void setMenuId(String menuId) {
    this.menuId = menuId;
  }

  public String getUserNm() {
    return this.userNm;
  }

  public void setUserNm(String userNm) {
    this.userNm = userNm;
  }

  public String getLoginDeptId() {
    return this.loginDeptId;
  }

  public void setLoginDeptId(String loginDeptId) {
    this.loginDeptId = loginDeptId;
  }
}