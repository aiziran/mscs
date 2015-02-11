package com.csValue.basicInfor.materialcodingManage.web;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.utils.web.struts2.Struts2Utils;

import ssdevframework.core.collection.CData;
import ssdevframework.front.action.BaseActionSupport;

import com.csValue.basicInfor.materialcodingManage.service.MaterialcodingManage;
import com.csValue.exportexcel.Exportexcel;
/**
 * 物料编码系统主界面action
 * @author MeiRuixue
 *
 */
@Namespace("/basicInfor/materialcodingManage")
@Results({ @Result(name = BaseActionSupport.RELOAD, location = "materialcoding.action", type = "redirectParams") })
public class MaterialcodingAction extends BaseActionSupport {
	@Autowired
	private MaterialcodingManage materialcodingManage;
	/**
	 * 分页显示
	 */
	private Page<CData> page = new Page();
	
	private List<CData> export;
	
	public MaterialcodingManage getMaterialcodingManage() {
		return materialcodingManage;
	}
	public void setMaterialcodingManage(MaterialcodingManage materialcodingManage) {
		this.materialcodingManage = materialcodingManage;
	}
	public Page<CData> getPage() {
		return page;
	}
	public void setPage(Page<CData> page) {
		this.page = page;
	}
	
	public List<CData> getExport() {
		return export;
	}
	public void setExport(List<CData> export) {
		this.export = export;
	}
	/**
	 * 物料编码
	 */
	@Override
	public String list() throws Exception {
		//分页显示
		this.page = materialcodingManage.selectAllInfo(page, this.data);
		return SUCCESS;
	}
	/**
	 * 物料编码查询界面
	 */
	public String search() {
		//分页显示
		this.page = materialcodingManage.selectAllInfo(page, this.data);
		return "search";
	}
	/**
	 * 物料编码数据导出
	 */
	public void export() {
		export = materialcodingManage.selectAllInfo(this.data);
		String[] day = {"编码", "元件类型","元件分类","SMT/THT", "第一属性名称", "第一属性参数", "第二属性名称", "第二属性参数", "原厂物料码", "数量", 
		        "产品信息", "制造商", "单位","备注"};
		String[] dayname = {"codednum", "componenttypes","componentclassify","smttht", "attrname", "arguments", "attrname2", "arguments2", "productname", "counts", "productinfo", 
		        "manufacturer", "units", "remark"};
		String excelName = "materialcoding" + new SimpleDateFormat("yyyy-MM-dd").format(new Date()) + ".xls";
		try {
			Exportexcel.salesprotocol(day, dayname, "物料编码数据", "物料编码数据", excelName, export);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 获取元件属性
	 * @return
	 */
	public String selectAllAttr() {
		List<CData> list = materialcodingManage.selectAllAttr(data);
		JSONArray json = JSONArray.fromObject(list);
		try {
			Struts2Utils.getResponse().getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 模糊查询获取元件属性
	 * @return
	 */
	public String selectAttr() {
		List<CData> list = materialcodingManage.selectAttr(data);
		JSONArray json = JSONArray.fromObject(list);
		try {
			Struts2Utils.getResponse().getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 获取元件分类
	 * @return
	 */
	public String selectAllClassify() {
		/*List<CData> typesList = materialcodingManage.selectAllTypes(data);
		if(typesList!=null && typesList.size()>0) {
			data.put("typesid", typesList.get(0).getString("id"));
		}*/
		List<CData> list = materialcodingManage.selectAllClassify(data);
		JSONArray json = JSONArray.fromObject(list);
		try {
			Struts2Utils.getResponse().getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 获取元件类型
	 * @return
	 */
	public String selectAllTypes() {
		List<CData> list = materialcodingManage.selectAllTypes(data);
		JSONArray json = JSONArray.fromObject(list);
		try {
			Struts2Utils.getResponse().getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 物料属性是否重复公共
	 * @return
	 */
	public List<CData> isRepeatPublic(CData data) {
		StringBuilder codednum = new StringBuilder("");
		//元件类型
		List<CData> typeList = materialcodingManage.selectAllTypes(data);
		if(typeList!=null && typeList.size()>0) {
			codednum.append(typeList.get(0).getString("codednum"));
		}
		//元件分类
		List<CData> ccList = materialcodingManage.selectAllClassify(data);
		if(ccList!=null && ccList.size()>0) {
			codednum.append(ccList.get(0).getString("codednum"));
		}
		//SMT/THT
		codednum.append(data.getString("smttht"));
		//获取元件第一属性编码
		CData cData = new CData();
		cData.put("componentclassifycodednum", data.getString("componentclassify"));
		cData.put("attrname", data.getString("attrname"));
		cData.put("arguments", data.getString("arguments"));
		List<CData> list = materialcodingManage.getArguments(cData);
		if(list!=null && list.size()>0) {
			codednum.append(list.get(0).getString("codednum"));
		}
		//获取元件第二属性编码
		cData.put("attrname", data.getString("attrname2"));
		cData.put("arguments", data.getString("arguments2"));
		List<CData> list2 = materialcodingManage.getArguments(cData);
		if(list2!=null && list2.size()>0) {
			codednum.append(list2.get(0).getString("codednum"));
		}
		boolean flag = false;
		List<CData> jsonList = new ArrayList<CData>();
		CData cData2 = new CData();
		//获取属性相同的物料信息
		CData cData4 = new CData();
		cData4.put("codednum", codednum.toString());
		List<CData> sameCodeList = materialcodingManage.selectOneInfo(cData4);
		String status = data.getString("status");
		//新增
		if(status!=null && status.equals("save")) {
			//如果有相同的编码就+1
			if(sameCodeList!=null && sameCodeList.size()>0) {
				CData cData3 = sameCodeList.get(0);
				String num = cData3.getString("codednum");
				if(num!=null && num.length()>0) {
					String parse = Integer.parseInt(num.substring(num.length()-4)) + 1 + "";
					for (int i = parse.length(); i < 4; i++) {
						parse = "0" + parse;
					}
					codednum.append(parse);
				}
				flag = true;
				cData3.put("codednum2", codednum.toString());
				jsonList.add(cData3);
			//没有相同
			} else {
				codednum.append("0001");
			}
		} else if(status.equals("update")) {
			//修改
			CData updateCData = new CData();
			updateCData.put("id", data.getString("id"));
			List<CData> updateList = materialcodingManage.selectOneInfo(updateCData);
			if(updateList!=null && updateList.size()>0) {
				String num = updateList.get(0).getString("codednum");
				if(num!=null && num.length()>0) {
					String substring = num.substring(0, num.length()-4);
					//没有更改物料编码
					if(codednum.toString().equals(substring)) {
						String parse = Integer.parseInt(num.substring(num.length()-4)) + "";
						for (int i = parse.length(); i < 4; i++) {
							parse = "0" + parse;
						}
						codednum.append(parse);
					//更改物料编码
					} else {
						//如果有相同的编码就+1
						if(sameCodeList!=null && sameCodeList.size()>0) {
							CData cData3 = sameCodeList.get(0);
							String num2 = cData3.getString("codednum");
							if(num2!=null && num2.length()>0) {
								String parse = Integer.parseInt(num2.substring(num2.length()-4)) + 1 + "";
								for (int i = parse.length(); i < 4; i++) {
									parse = "0" + parse;
								}
								codednum.append(parse);
							}
							flag = true;
							cData3.put("codednum2", codednum.toString());
							jsonList.add(cData3);
						//没有相同
						} else {
							codednum.append("0001");
						}
					}
				}
			}
		}
		cData2.put("codednum", codednum.toString());
		cData2.put("flag", flag);
		jsonList.add(0, cData2);
		return jsonList;
	}
	/**
	 * 物料属性是否重复
	 * @return
	 */
	public String isrepeat() {
		List<CData> repeatPublic = isRepeatPublic(data);
		JSONArray json = JSONArray.fromObject(repeatPublic);
		try {
			Struts2Utils.getResponse().getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 录入/修改物料信息
	 * @return
	 */
	public String savematerialinfo() {
		List<CData> repeatPublic = isRepeatPublic(data);
		String codednum = repeatPublic.get(0).getString("codednum");
		
		CData cData = new CData();
		//插入时间
		this.data.put("inserttime", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		this.data.set("codednum", codednum.toString());
		if(codednum.length()==12) {
			String status = data.getString("status");
			if(status!=null && status.equals("save")) {
				//保存物料信息
				Integer num = materialcodingManage.savematerialinfo(data);
				if(num>0) {
					cData.put("msg", "保存成功");
				} else {
					cData.put("msg", "保存失败");
				}
			} else if(status.equals("update")) {
				Integer num = 0;
				//修改物料信息
				try {
					num = materialcodingManage.updatematerialinfo(data);
					cData.put("msg", "修改成功");
				} catch (Exception e) {
					e.printStackTrace();
					cData.put("msg", "修改失败");
				}
			}
		}
		JSONArray json = JSONArray.fromObject(cData);
		try {
			Struts2Utils.getResponse().getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return RELOAD;
	}
	/**
	 * 获取元件属性参数
	 * @return
	 */
	public String getArguments() {
		List<CData> list = materialcodingManage.getArguments(data);
		JSONArray json = JSONArray.fromObject(list);
		try {
			Struts2Utils.getResponse().getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 获取元件属性参数
	 * @return
	 */
	public String infoEcho() {
		List<CData> list = materialcodingManage.selectAllInfo(data);
		JSONArray json = JSONArray.fromObject(list);
		try {
			Struts2Utils.getResponse().getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 删除物料信息
	 * @return
	 */
	public String deleteInfo() {
		Integer num = materialcodingManage.deleteInfo(data);
		return RELOAD;
	}
	/**
	 * 物料属性配置页面
	 * @return
	 */
	public String attrconfig() {
		page = materialcodingManage.attrconfig(page, this.data);
		return "attrconfig";
	}
	/**
	 * 新增/修改物料属性
	 * @return
	 */
	public String saveattr() {
		String status = data.getString("status");
		String whichattr = data.getString("whichattr");
		String attrSql = "";
		if(whichattr!=null && whichattr.equals("1")) {
			attrSql = "attrname";
		} else if(whichattr!=null && whichattr.equals("2")) {
			attrSql = "attrname2";
		}
		data.put("attrSql", "AND "+attrSql+"='"+data.getString("attrname")+"'");
		//查询cid
		List<CData> list = materialcodingManage.findCid(data);
		if(list!=null && list.size()>0) {
			String cid = list.get(0).getString("cid");
			data.put("cid", cid);
		}
		if(status!=null && status.equals("save")) {
			Integer num = materialcodingManage.saveattr(data);
		} else if(status.equals("update")) {
			Integer num = materialcodingManage.updateattr(data);
		}
		try {
			Struts2Utils.getResponse().sendRedirect("materialcoding!attrconfig.action");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 修改物料属性回显
	 * @return
	 */
	public String attrEcho() {
		List<CData> list = materialcodingManage.attrconfig(data);
		JSONArray json = JSONArray.fromObject(list);
		try {
			Struts2Utils.getResponse().getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 删除物料属性
	 * @return
	 */
	public String deleteattr() {
		Integer num = materialcodingManage.deleteattr(data);
		try {
			Struts2Utils.getResponse().sendRedirect("materialcoding!attrconfig.action");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 物料属性参数和编码号有重复报警提示
	 * @return
	 */
	public String isrepeatattr() {
		List<CData> list = materialcodingManage.isrepeatattr(data);
		JSONArray json = JSONArray.fromObject(list);
		try {
			Struts2Utils.getResponse().getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 元件类型和编码号有重复提示
	 * @return
	 */
	public String isrepeattypes() {
		List<CData> list = materialcodingManage.isrepeattypes(data);
		JSONArray json = JSONArray.fromObject(list);
		try {
			Struts2Utils.getResponse().getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 元件分类是否重复
	 * @return
	 */
	public String isrepeatclassify() {
		List<CData> list = materialcodingManage.isrepeatclassify(data);
		JSONArray json = JSONArray.fromObject(list);
		try {
			Struts2Utils.getResponse().getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 元件类型配置
	 * @return
	 */
	public String typesconfig() {
		page = materialcodingManage.typesconfig(page, this.data);
		return "typesconfig";
	}
	/**
	 * 新增/修改元件类型
	 * @return
	 */
	public String savetypes() {
		String status = data.getString("status");
		if(status!=null && status.equals("save")) {
			Integer num = materialcodingManage.savetypes(data);
		} else if(status.equals("update")) {
			Integer num = materialcodingManage.updatetypes(data);
		}
		this.data.remove("id");
		try {
			Struts2Utils.getResponse().sendRedirect("materialcoding!typesconfig.action");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 修改元件类型回显
	 * @return
	 */
	public String typesEcho() {
		List<CData> list = materialcodingManage.typesconfig(data);
		JSONArray json = JSONArray.fromObject(list);
		try {
			Struts2Utils.getResponse().getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 删除元件类型
	 * @return
	 */
	public String deletetypes() {
		CData cData = new CData();
		//查看元件类型和元件分类是否有关联
		List<CData> list = materialcodingManage.isrelevance(data);
		if(list!=null && list.size()>0) {
			cData.put("flag", false);
		} else {
			Integer num = materialcodingManage.deletetypes(data);
			if(num>0) {
				cData.put("flag", true);
			} else {
				cData.put("flag", false);
			}
		}
		JSONArray json = JSONArray.fromObject(cData);
		try {
			Struts2Utils.getResponse().getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 元件分类配置
	 * @return
	 */
	public String classifyconfig() {
		page = materialcodingManage.classifyconfig(page, this.data);
		return "classifyconfig";
	}
	/**
	 * 新增/修改元件分类
	 * @return
	 */
	public String saveclassify() {
		CData cData = new CData();
		cData.put("componenttypes3", data.getString("componenttypes"));
		List<CData> typesconfig = materialcodingManage.typesconfig(cData);
		if(typesconfig!=null && typesconfig.size()>0) {
			data.put("typesid", typesconfig.get(0).getString("id"));
		}
		String status = data.getString("status");
		if(status!=null && status.equals("save")) {
			Integer num = materialcodingManage.saveclassify(data);
		} else if(status.equals("update")) {
			Integer num = materialcodingManage.updateclassify(data);
		}
		try {
			Struts2Utils.getResponse().sendRedirect("materialcoding!classifyconfig.action");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 修改元件分类回显
	 * @return
	 */
	public String classifyEcho() {
		List<CData> list = materialcodingManage.classifyconfig(data);
		JSONArray json = JSONArray.fromObject(list);
		try {
			Struts2Utils.getResponse().getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 删除元件分类
	 * @return
	 */
	public String deleteclassify() {
		CData cData = new CData();
		//查看元件分类和物料属性是否有关联
		List<CData> list = materialcodingManage.isrelevanceclassify(data);
		if(list!=null && list.size()>0) {
			cData.put("flag", false);
		} else {
			Integer num = materialcodingManage.deleteclassify(data);
			if(num>0) {
				cData.put("flag", true);
			} else {
				cData.put("flag", false);
			}
		}
		JSONArray json = JSONArray.fromObject(cData);
		try {
			Struts2Utils.getResponse().getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
