package com.csValue.common.tree.web;

import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;

import ssdevframework.core.collection.CData;
import ssdevframework.front.action.BaseActionSupport;

import com.csValue.common.tree.service.TreeManage;

@Namespace("/common/tree")
public class DrugTreeAction extends BaseActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6746226372891374839L;

	@Autowired
	private TreeManage treeManage;

	private List<CData> drugTypeTree;

	@Override
	public String list() throws Exception {
		drugTypeTree = treeManage.retrieveDrugTypeTree(data);
		return SUCCESS;
	}

	public String radio() throws Exception {
		drugTypeTree = treeManage.retrieveDrugTypeTree(data);
		return "radio";
	}

	public List<CData> getDrugTypeTree() {
		return drugTypeTree;
	}

	public void setDrugTypeTree(List<CData> drugTypeTree) {
		this.drugTypeTree = drugTypeTree;
	}

}
