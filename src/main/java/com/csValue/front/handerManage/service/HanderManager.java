// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) lnc 
// Source File Name:   HanderManager.java

package com.csValue.front.handerManage.service;

import com.csValue.common.login.entity.LoginUserData;
import com.csValue.common.util.SecurityCodeUtil;
import com.csValue.front.handerManage.dao.HanderDao;
import java.io.PrintStream;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.utils.web.struts2.Struts2Utils;
@Component
@Transactional
public class HanderManager
{

            public HanderManager()
            {
            }

            public HanderDao getDao()
            {
/*  29*/        return dao;
            }

            public void setDao(HanderDao dao)
            {
/*  34*/        this.dao = dao;
            }

            public List topMenuList(List roleList)
            {
/*  39*/        return dao.topMenuList(roleList);
            }

            public List leftMenuList(HashMap roleList)
            {
/*  44*/        return dao.leftMenuList(roleList);
            }

            public HashMap login(HashMap loginU)
                throws Exception
            {
/*  49*/        HashMap user = new HashMap();
/*  50*/        String userId = (String)loginU.get("tUserId");
/*  51*/        String userPassword = (String)loginU.get("tUserPassword");
/*  52*/        String userDepartment = null;
/*  54*/        user = dao.login(userId);
/*  56*/        if(user != null && user.size() > 0)
                {
/*  57*/            String digestedPassword = SecurityCodeUtil.Encode(userPassword);
/*  58*/            if(!digestedPassword.equals(user.get("PASSWORD")))
                    {
/*  59*/                user = null;
/*  60*/                return user;
                    }
/*  62*/            List deptList = dao.getDeptRole(userId);
/*  64*/            user.put("deptRoleList", deptList);
/*  65*/            user.put("userRole", dao.getUserRole(userId));
/*  66*/            HttpSession session = Struts2Utils.getSession();
/*  67*/            LoginUserData userDate = new LoginUserData(user);
/*  68*/            System.out.println(user);
/*  70*/            session.setAttribute("userSession", userDate);
/*  71*/            session.setAttribute("userID", user.get("userId"));
/*  72*/            session.setAttribute("userName", user.get("userName"));
/*  73*/            session.setAttribute("userRoleId", dao.getUserRole(userId).get(0));
/*  74*/            session.setAttribute("dept_id", user.get("deptCd"));
/*  75*/            System.out.println(user);
                } else
                {
/*  77*/            user = null;
                }
/*  80*/        return user;
            }

            public String selectOutofwarranty()
            {
/*  84*/        return dao.selectOutofwarranty();
            }

            public String selectExpirationdate()
            {
/*  87*/        return dao.selectExpirationdate();
            }

            private HanderDao dao;
}
