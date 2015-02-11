package ssdevframework.front.taglib.render.combolist;

import ssdevframework.front.taglib.CTag;
import ssdevframework.front.taglib.CTagException;

public class CComboListSelectedCodeTag extends CTag {

	private static final long serialVersionUID = 2779278815103906114L;

	public CComboListSelectedCodeTag() {
		super();
	}

	public int doEndTag() throws CTagException {
		CComboListTag parent = (CComboListTag) findAncestorWithClass(this, CComboListTag.class);

		String code = bodyContent.getString().trim();
		if (code != null)
			parent.setSelectedCode(code);

		return SKIP_BODY;
	}
}
