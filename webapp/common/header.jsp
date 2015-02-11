<%@ page import="com.opensymphony.xwork2.ActionContext,org.springframework.web.context.WebApplicationContext,org.springframework.web.context.support.WebApplicationContextUtils
                 ,org.apache.ibatis.session.SqlSessionFactory,org.apache.ibatis.session.SqlSession
                 ,org.springside.modules.utils.web.struts2.Struts2Utils
                 ,ssdevframework.core.collection.CData
                 ,ssdevframework.core.collection.CMultiData
                 ,com.csValue.common.util.dao.DaoUtil
                 ,com.csValue.common.login.entity.LoginUserData"%>
<link href="${ctx}/css/pbf.css" rel="stylesheet" type="text/css" charset="utf-8" />
<link href="${ctx}/css/behavior.css" rel="stylesheet" type="text/css" charset="utf-8"/>
<link href="${ctx}/js/validate/jquery.validate.css" rel="stylesheet" type="text/css" charset="utf-8"/>
<script src="${ctx}/js/jquery.js" type="text/javascript"></script>
<script src="${ctx}/js/validate/jquery.validate.js" type="text/javascript"></script>
<script src="${ctx}/js/validate/jquery.metadata.js" type="text/javascript"></script>
<script src="${ctx}/js/validate/messages_cn.js" type="text/javascript"></script>
<script src="${ctx}/js/common.js" type="text/javascript"></script>
<script src="${ctx}/js/table.js" type="text/javascript"></script>
<script> 	
var jsBaseContent = "${ctx}";
    
function fncExtraFormCancel(url){
	var oForm = "<form id='extraFormCancel'  name='extraFormCancel'  action='"+url+"'/>";
 	$(document.body).append(oForm); 		
 	fncAppend("extraFormCancel");
 	$("#extraFormCancel").submit(); 		
}
function fncAppend(formId){
	<%
		ssdevframework.core.collection.CData dataHidden = (ssdevframework.core.collection.CData)request.getAttribute("data");
	 	if(dataHidden!=null)
		for (java.util.Iterator iterator = dataHidden.keySet().iterator(); iterator.hasNext();) {
			String type = (String) iterator.next();
			if(type.startsWith("query")||"selShowpageNO".equals(type)||"selPageRow".equals(type)||"selPageOrderBy".equals(type)||"selPageOrder".equals(type)){
	%>
				oin = "<input type=\"hidden\" id=\"<%=type %>\" name=\"<%=type %>\" value=\"<%=dataHidden.get(type)%>\"/>";
				$("#"+formId).append(oin);
	<%
				}
		} 	      
	%>
} 	
 </script>

 <script type="text/javascript" language="javascript">
var btnRoleM = new Array();
<%
	if(!Struts2Utils.getSession().isNew()){
	    String HHH_menuId = (String) ActionContext.getContext().getSession().get("selectMenuId");	
	    if(HHH_menuId!=null&&!HHH_menuId.equals("")){
		    WebApplicationContext wap = WebApplicationContextUtils.getWebApplicationContext(Struts2Utils.getRequest()
					.getSession().getServletContext());
			SqlSessionFactory sqlSessionFactory = (SqlSessionFactory) wap.getBean("sqlSessionFactory");
			SqlSession session_head = sqlSessionFactory.openSession();
			
			CData input = new CData();
			
			input.set("authIds", LoginUserData.getCurrentUserData().getRoles());
			input.setString("menuId", HHH_menuId);
			CMultiData btnAuthData = new CMultiData();
			try {
				btnAuthData = DaoUtil.ConvertList2CMulti(session_head.selectList("roleManage.retrieveBtnList", input));
			} finally {
				session_head.close();
			}	
			
			for(int i=0;i<btnAuthData.getDataCount("codeId");i++){
	    		if(btnAuthData.getString("codeId",i).equals("save")){
	    			%>
	    			btnRoleM[btnRoleM.length]= "bSave";
	    			btnRoleM[btnRoleM.length]= "bSave2";
	    			<%
	    			continue;
	    		}
	    		if(btnAuthData.getString("codeId",i).equals("add")){
	    			%>
	    			btnRoleM[btnRoleM.length] = "bCreate";
	    			btnRoleM[btnRoleM.length] = "bCreate2";
	    			<%
	    			continue;
	    		}
	    		if(btnAuthData.getString("codeId",i).equals("update")){
	    			%>
	    			btnRoleM[btnRoleM.length] = "bUpdate";
	    			<%
	    			continue;
	    		}
	    		if(btnAuthData.getString("codeId",i).equals("cancel")){
	    			%>
	    			btnRoleM[btnRoleM.length] = "bCancel";
	    			<%
	    			continue;
	    		}
	    		if(btnAuthData.getString("codeId",i).equals("delete")){
	    			%>
	    			btnRoleM[btnRoleM.length] = "bDelete";
	    			<%
	    			continue;
	    		}
	    		if(btnAuthData.getString("codeId",i).equals("request")){
	    			%>
	    			btnRoleM[btnRoleM.length] = "bRequest";
	    			btnRoleM[btnRoleM.length] = "bRequest2";
	    			btnRoleM[btnRoleM.length] = "bRequest3";
	    			<%
	    			continue;
	    		}
	    	}
			
	    }
	}
%>
</script>
<script src="${ctx}/js/btnManage.js" type="text/javascript"></script>
<style type="text/css">
body { 	font-family: Arial, Helvetica, sans-serif, "Arial Black", Gadget, 		sans-serif; }
</style>