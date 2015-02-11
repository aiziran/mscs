package com.csValue.common.login.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.utils.web.struts2.Struts2Utils;

import ssdevframework.core.collection.CData;

import com.csValue.common.login.dao.LoginDao;
import com.csValue.common.login.entity.LoginUserData;
import com.csValue.common.util.SecurityCodeUtil;

@Component
public class LoginManager
{
  private LoginDao dao;

  public LoginDao getDao()
  {
    return this.dao;
  }
  @Autowired
  public void setDao(LoginDao dao) {
    this.dao = dao;
  }
  @Transactional(readOnly=true)
  public List<HashMap> topMenuList(List roleList) {
    return this.dao.topMenuList(roleList);
  }
  @Transactional(readOnly=true)
  public List<HashMap> leftMenuList(HashMap roleList) {
    return this.dao.leftMenuList(roleList);
  }

  public HashMap login(HashMap loginU) throws Exception
  {
    HashMap user = new HashMap();
    String userId = (String)loginU.get("tUserId");
    String userPassword = (String)loginU.get("tUserPassword");
    String userDepartment = null;

    user = this.dao.login(userId);

    if ((user != null) && (user.size() > 0)) {
      String digestedPassword = SecurityCodeUtil.Encode(userPassword);
      if (!digestedPassword.equals(user.get("PASSWORD"))) {
        user = null;
        return user;
      }
      List deptList = this.dao.getDeptRole(userId);

      user.put("deptRoleList", deptList);
      user.put("userRole", this.dao.getUserRole(userId));
      HttpSession session = Struts2Utils.getSession();
      LoginUserData userDate = new LoginUserData(user);
      System.out.println(user);

      session.setAttribute("userSession", userDate);
      session.setAttribute("userID", user.get("userId"));
      session.setAttribute("userName", user.get("userName"));
      session.setAttribute("userRoleId", this.dao.getUserRole(userId).get(0));
      session.setAttribute("dept_id", user.get("deptCd"));
      System.out.println(user);
    } else {
      user = null;
    }

    return user;
  }
  
  /**
   * 获取操作模块的功能菜单
   * @param map
   * @return
   */
  public List<CData> findFunction(Map map) {
	  return this.dao.findFunction(map);
  }

  public String selectOutofwarranty() {
    return this.dao.selectOutofwarranty();
  }
  public String selectExpirationdate() {
    return this.dao.selectExpirationdate();
  }
  /**
   * 获取按钮权限
   * @param cData
   * @return
   */
	public List<CData> getButtonList(CData cData) {
		return dao.getButtonList(cData);
	}
}