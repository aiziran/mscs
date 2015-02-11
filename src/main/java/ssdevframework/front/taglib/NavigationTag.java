package ssdevframework.front.taglib;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspTagException;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springside.modules.utils.web.struts2.Struts2Utils;

import ssdevframework.core.collection.CData;
import ssdevframework.core.collection.CMultiData;

import com.csValue.common.util.dao.DaoUtil;
import com.opensymphony.xwork2.ActionContext;

public class NavigationTag extends CTag {
	private static final long serialVersionUID = 1L;

	private String menuId = null;

	public NavigationTag() {
		super();
	}

	public void release() {
		super.release();
	}

	public int doEndTag() throws JspTagException {
		try {
			HttpServletRequest req = (HttpServletRequest) pageContext.getRequest();

			String selectMenuId = req.getParameter("selectMenuId");

			if (selectMenuId == null || selectMenuId.length() == 0)
				selectMenuId = (String) ActionContext.getContext().getSession().get("selectMenuId");

			CData input = new CData();
			input.setString("selectMenuId", selectMenuId);

			WebApplicationContext wap = WebApplicationContextUtils.getWebApplicationContext(Struts2Utils.getRequest()
					.getSession().getServletContext());
			SqlSessionFactory sqlSessionFactory = (SqlSessionFactory) wap.getBean("sqlSessionFactory");
			SqlSession session = sqlSessionFactory.openSession();

			CMultiData result;
			try {
				result = DaoUtil.ConvertList2CMulti(session.selectList("menu.retrieveMenuNavigation", input));
			} finally {
				session.close();
			}

			int rowSize = result.getDataCount("menuId");
			if (rowSize == 0) {
				this.printBlankString();
			}

			StringBuffer navStr = new StringBuffer();
			navStr.append("<div id=\"LpageTitleArea\">");
			navStr.append("<h1>");
			navStr.append(result.getString("menuName", rowSize - 1));
			navStr.append("</h1><div>");
			for (int inx = 0; inx < rowSize; inx++) {
				if (inx == 0) {
					navStr.append("<a href=\"#\">");
					navStr.append("Home");
					navStr.append("</a> &gt; ");
				} else if (inx == rowSize - 1) {
					navStr.append("<a href=\"");
					navStr.append(req.getContextPath());
					navStr.append(result.getString("menuAppl", inx));
					navStr.append("?selectMenuId=");
					navStr.append(result.getString("menuId", inx));
					navStr.append("\"  id=\"Lhere\">");
					navStr.append(result.getString("menuName", inx));
					navStr.append("</a>");
				} else {
					navStr.append("<a href=\"#\">");
					navStr.append(result.getString("menuName", inx));
					navStr.append("</a> &gt; ");
				}
			}
			navStr.append("</div></div>");

			this.printTagString(navStr.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return EVAL_PAGE;
	}

	public void setMenuId(String aMenuId) {
		this.menuId = aMenuId;
	}

	public String getMenuId() {
		return menuId;
	}

}
