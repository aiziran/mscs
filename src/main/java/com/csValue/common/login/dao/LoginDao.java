package com.csValue.common.login.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Component;

import ssdevframework.core.collection.CData;

@Component
public class LoginDao extends SqlSessionDaoSupport
{
	/**
	   * 获取操作模块的功能菜单
	   * @param map
	   * @return
	   */
	  public List<CData> findFunction(Map map) {
		  return this.getSqlSession().selectList("Login.findFunction", map);
	  }
  public List<HashMap> topMenuList(List roleList)
  {
    HashMap map = new HashMap();
    map.put("authCode", roleList);
    return getSqlSession().selectList("Login.topMenuList", map);
  }

  public List<HashMap> leftMenuList(HashMap roleList) {
    List result = getSqlSession().selectList("Login.leftMenuLvl1", roleList);
    List<HashMap> md = getSqlSession().selectList("Login.leftMenuLvl23", roleList);
    int i = 1;
    for (HashMap map : md) {
      roleList.put("topMenuId", map.get("MENUID"));
      List<HashMap> md1 = getSqlSession().selectList("Login.leftMenuLvl23", roleList);
      map.put("menuSeq", Integer.valueOf(i++));
      result.add(map);
      for (HashMap map2 : md1) {
        result.add(map2);
      }
    }
    return result;
  }

  public HashMap login(String userId) {
    return (HashMap)getSqlSession().selectOne("Login.userLogin", userId);
  }

  public List<HashMap> getDeptRole(String userId) {
    return getSqlSession().selectList("Login.getDeptRole", userId);
  }

  public List<String> getUserRole(String userId) {
    List<HashMap> roleList = getSqlSession().selectList("Login.userRoleList", userId);
    List deptRoleList = new ArrayList();
    for (HashMap role : roleList)
      deptRoleList.add((String)role.get("AUTHCODE"));
    return deptRoleList;
  }

  public List<HashMap> getSpecialDrugType() {
    return getSqlSession().selectList("Login.getSpecialDrugType");
  }

  public HashMap getLoginDeptName(String userDepartment) {
    return (HashMap)getSqlSession().selectOne("Login.getLoginDeptName", userDepartment);
  }

  public String selectOutofwarranty() {
    return (String)getSqlSession().selectOne("Login.selectOutofwarranty");
  }
  public String selectExpirationdate() {
    return (String)getSqlSession().selectOne("Login.selectExpirationdate");
  }
  /**
   * 获取按钮权限
   * @param cData
   * @return
   */
	public List<CData> getButtonList(CData cData) {
		return this.getSqlSession().selectList("Login.getButtonList", cData);
	}
}