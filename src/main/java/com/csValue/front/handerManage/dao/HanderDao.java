// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) lnc 
// Source File Name:   HanderDao.java

package com.csValue.front.handerManage.dao;

import java.util.*;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Component;
@Component
public class HanderDao extends SqlSessionDaoSupport
{

            public HanderDao()
            {
            }

            public List topMenuList(List roleList)
            {
/*  17*/        HashMap map = new HashMap();
/*  18*/        map.put("authCode", roleList);
/*  19*/        return getSqlSession().selectList("Hander.topMenuList", map);
            }

            public List leftMenuList(HashMap roleList)
            {
/*  23*/        List result = getSqlSession().selectList("Hander.leftMenuLvl1", roleList);
/*  24*/        List md = getSqlSession().selectList("Hander.leftMenuLvl23", roleList);
/*  25*/        int i = 1;
/*  26*/        for(Iterator iterator = md.iterator(); iterator.hasNext();)
                {
/*  26*/            HashMap map = (HashMap)iterator.next();
/*  27*/            roleList.put("topMenuId", map.get("MENUID"));
/*  28*/            List md1 = getSqlSession().selectList("Hander.leftMenuLvl23", roleList);
/*  29*/            map.put("menuSeq", Integer.valueOf(i++));
/*  30*/            result.add(map);
                    HashMap map2;
/*  31*/            for(Iterator iterator1 = md1.iterator(); iterator1.hasNext(); result.add(map2))
/*  31*/                map2 = (HashMap)iterator1.next();

                }

/*  35*/        return result;
            }

            public HashMap login(String userId)
            {
/*  39*/        return (HashMap)getSqlSession().selectOne("Hander.userLogin", userId);
            }

            public List getDeptRole(String userId)
            {
/*  43*/        return getSqlSession().selectList("Hander.getDeptRole", userId);
            }

            public List getUserRole(String userId)
            {
/*  47*/        List roleList = getSqlSession().selectList("Hander.userRoleList", userId);
/*  48*/        List deptRoleList = new ArrayList();
                HashMap role;
/*  49*/        for(Iterator iterator = roleList.iterator(); iterator.hasNext(); deptRoleList.add((String)role.get("AUTHCODE")))
/*  49*/            role = (HashMap)iterator.next();

/*  51*/        return deptRoleList;
            }

            public List getSpecialDrugType()
            {
/*  55*/        return getSqlSession().selectList("Hander.getSpecialDrugType");
            }

            public HashMap getLoginDeptName(String userDepartment)
            {
/*  59*/        return (HashMap)getSqlSession().selectOne("Hander.getLoginDeptName", userDepartment);
            }

            public String selectOutofwarranty()
            {
/*  63*/        return (String)getSqlSession().selectOne("Hander.selectOutofwarranty");
            }

            public String selectExpirationdate()
            {
/*  66*/        return (String)getSqlSession().selectOne("Hander.selectExpirationdate");
            }
}
