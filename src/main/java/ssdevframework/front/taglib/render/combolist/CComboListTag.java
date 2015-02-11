package ssdevframework.front.taglib.render.combolist;

import java.util.ArrayList;

import javax.servlet.jsp.JspTagException;

import ssdevframework.core.collection.CData;
import ssdevframework.front.taglib.CTag;

public class CComboListTag extends CTag {
	private static final long serialVersionUID = 1L;

	private ArrayList<CData> mData = null;

	private String mdataKey = null;

	private String selectedCode = null;

	/**
	 * LComboListTag 생성자
	 */
	public CComboListTag() {
		super();
	}

	/**
	 * release
	 */
	public void release() {
		super.release();
	}

	/**
	 * do after body
	 * 
	 * @return int - EVAL_PAGE
	 */
	public int doAfterBody() throws JspTagException {

		mData = (ArrayList<CData>) pageContext.getAttribute(getValue());
		int rowSize = mData.size();
		if (rowSize == 0) {
			this.printBlankString();
		}

		StringBuffer optionString = new StringBuffer();
		for (int inx = 0; inx < rowSize; inx++) {
			CData data = (CData) mData.get(inx);
			String code = data.getString("code");
			String value = data.getString("value");
			if (code.equals(selectedCode)) {
				optionString.append("<option value=\"" + code + "\" selected>");
			} else {
				optionString.append("<option value=\"" + code + "\">");
			}
			optionString.append(value);
			optionString.append("</option>\n");
		}

		this.printTagBody(optionString.toString());
		return SKIP_BODY;
	}

	/**
	 * do end tag
	 * 
	 * @return int - EVAL_PAGE
	 * @throws JspTagException
	 */
	public int doEndTag() throws JspTagException {
		this.release();
		return EVAL_PAGE;
	}

	/**
	 * value setter
	 * 
	 * @param value - LMultiData
	 */
	public void setValue(String value) {
		this.mdataKey = value;
	}

	/**
	 * value getter
	 * 
	 * @return LMultiData
	 */
	public String getValue() {
		return mdataKey;
	}

	/**
	 * selectedCode getter
	 * 
	 * @return String - selectedCode
	 */
	public String getSelectedCode() {
		return selectedCode;
	}

	/**
	 * selectedCode setter
	 * 
	 * @param selectedCode - String
	 */
	public void setSelectedCode(String selectedCode) {
		this.selectedCode = selectedCode;
	}
}
