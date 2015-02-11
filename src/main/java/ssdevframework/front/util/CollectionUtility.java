package ssdevframework.front.util;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import org.apache.struts2.ServletActionContext;
import org.springside.modules.utils.web.struts2.Struts2Utils;

import ssdevframework.core.collection.CData;
import ssdevframework.core.collection.CMultiData;

import com.opensymphony.xwork2.ActionContext;

public class CollectionUtility {

	private CollectionUtility() {
	}

	public static CData getData() {
		CData data = new CData("REQUEST_DATA");
		Map<String, Object> map = ActionContext.getContext().getParameters();
		Struts2Utils.getRequest();
		ServletActionContext.getRequest();
		for (Iterator<String> iterator = map.keySet().iterator(); iterator.hasNext();) {
			String params = iterator.next();
			if (map.get(params) instanceof String[]) {
				String[] value = (String[]) map.get(params);
				if (value.length == 1) {
					data.set(params, value[0]);
				} else {
					StringBuffer sb = new StringBuffer();
					for (int i = 0; i < value.length; i++) {
						sb.append(value[i] + ",");
					}
					sb.substring(0, sb.length() - 1);
					data.set(params, sb.toString());
				}
			}
		}
		return data;
	}

	public static CMultiData getMultiData() {
		CMultiData multiData = new CMultiData("REQUEST_LMultiData");
		Map<String, Object> map = ActionContext.getContext().getParameters();
		for (Iterator<String> iterator = map.keySet().iterator(); iterator.hasNext();) {
			String key = iterator.next();
			if (map.get(key) instanceof String[]) {
				String[] values = (String[]) map.get(key);
				ArrayList<String> list = new ArrayList<String>();
				for (int i = 0; i < values.length; i++) {
					list.add(values[i]);
				}
				multiData.put(key, list);
			}
		}
		return multiData;
	}

	public static CData clone(CData data) {
		CData newData = new CData(data.getName());

		CData src = data;
		CData target = newData;

		Set set = src.keySet();
		Iterator e = set.iterator();

		while (e.hasNext()) {
			String key = (String) e.next();
			Object value = src.get(key);
			target.set(key, value);
		}
		return newData;
	}
}
