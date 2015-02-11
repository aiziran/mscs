package com.csValue.basicInfor.materialcodingManage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.Page;

import ssdevframework.core.collection.CData;

import com.csValue.basicInfor.materialcodingManage.dao.MaterialcodingDao;

/**
 * 物料编码系统主界面service
 * @author MeiRuixue
 *
 */
@Component
@Transactional
public class MaterialcodingManage {
	@Autowired
	private MaterialcodingDao materialcodingDao;
	/**
	 * 获取电子元件类型
	 * @param data 
	 * @return
	 */
	public List<CData> selectAllTypes(CData data) {
		return materialcodingDao.selectAllTypes(data);
	}
	/**
	 * 获取元件分类
	 * @param data 
	 * @return
	 */
	public List<CData> selectAllClassify(CData data) {
		return materialcodingDao.selectAllClassify(data);
	}
	/**
	 * 获取元件属性
	 * @param data 
	 * @return
	 */
	public List<CData> selectAllAttr(CData data) {
		return materialcodingDao.selectAllAttr(data);
	}
	/**
	 * 获取元件属性参数
	 * @param data
	 * @return
	 */
	public List<CData> getArguments(CData data) {
		return materialcodingDao.getArguments(data);
	}
	/**
	 * 分页显示
	 * @param page
	 * @param data
	 * @return
	 */
	public Page<CData> selectAllInfo(Page<CData> page, CData data) {
		return materialcodingDao.selectAllInfo(page, data);
	}
	/**
	 * 录入物料信息
	 * @param data
	 * @return
	 */
	public Integer savematerialinfo(CData data) {
		return materialcodingDao.savematerialinfo(data);
	}
	/**
	 * 获取属相相同的物料信息
	 * @param data
	 * @return
	 */
	public List<CData> selectAllInfo(CData data) {
		return materialcodingDao.selectAllInfo(data);
	}
	/**
	 * 删除物料信息
	 * @param data
	 * @return
	 */
	public Integer deleteInfo(CData data) {
		return materialcodingDao.deleteInfo(data);
	}
	/**
	 * 修改物料信息
	 * @param data
	 * @return
	 */
	public Integer updatematerialinfo(CData data) {
		return materialcodingDao.updatematerialinfo(data);
	}
	/**
	 * 物料属性配置页面
	 * @param page
	 * @param data
	 * @return
	 */
	public Page<CData> attrconfig(Page<CData> page, CData data) {
		return materialcodingDao.attrconfig(page, data);
	}
	/**
	 * 元件类型配置
	 * @param page3
	 * @param data
	 * @return
	 */
	public Page<CData> typesconfig(Page<CData> page, CData data) {
		return materialcodingDao.typesconfig(page, data);
	}
	/**
	 * 元件分类配置
	 * @param page
	 * @param data
	 * @return
	 */
	public Page<CData> classifyconfig(Page<CData> page, CData data) {
		return materialcodingDao.classifyconfig(page, data);
	}
	/**
	 * 新增物料属性
	 * @param data
	 * @return
	 */
	public Integer saveattr(CData data) {
		return materialcodingDao.saveattr(data);
	}
	/**
	 * 修改物料属性
	 * @param data
	 * @return
	 */
	public Integer updateattr(CData data) {
		return materialcodingDao.updateattr(data);
	}
	/**
	 * 修改物料属性回显
	 * @param data
	 * @return
	 */
	public List<CData> attrconfig(CData data) {
		return materialcodingDao.attrconfig(data);
	}
	/**
	 * 删除物料属性
	 * @param data
	 * @return
	 */
	public Integer deleteattr(CData data) {
		return materialcodingDao.deleteattr(data);
	}
	/**
	 * 新增元件分类
	 * @param data
	 * @return
	 */
	public Integer saveclassify(CData data) {
		return materialcodingDao.saveclassify(data);
	}
	/**
	 * 修改元件分类
	 * @param data
	 * @return
	 */
	public Integer updateclassify(CData data) {
		return materialcodingDao.updateclassify(data);
	}
	/**
	 * 修改元件分类回显
	 * @param data
	 * @return
	 */
	public List<CData> classifyconfig(CData data) {
		return materialcodingDao.classifyconfig(data);
	}
	/**
	 * 删除元件分类
	 * @param data
	 * @return
	 */
	public Integer deleteclassify(CData data) {
		return materialcodingDao.deleteclassify(data);
	}
	/**
	 * 新增元件类型
	 * @param data
	 * @return
	 */
	public Integer savetypes(CData data) {
		return materialcodingDao.savetypes(data);
	}
	/**
	 * 修改元件类型
	 * @param data
	 * @return
	 */
	public Integer updatetypes(CData data) {
		return materialcodingDao.updatetypes(data);
	}
	/**
	 * 修改元件类型回显
	 * @param data
	 * @return
	 */
	public List<CData> typesconfig(CData data) {
		return materialcodingDao.typesconfig(data);
	}
	/**
	 * 删除元件类型
	 * @param data
	 * @return
	 */
	public Integer deletetypes(CData data) {
		return materialcodingDao.deletetypes(data);
	}
	/**
	 * 获取属相相同的物料信息
	 * @param data
	 * @return
	 */
	public List<CData> selectOneInfo(CData data) {
		return materialcodingDao.selectOneInfo(data);
	}
	/**
	 * 物料属性参数和编码号有重复报警提示
	 * @param data
	 * @return
	 */
	public List<CData> isrepeatattr(CData data) {
		return materialcodingDao.isrepeatattr(data);
	}
	/**
	 * 查看元件类型和元件分类是否有关联
	 * @param data
	 * @return
	 */
	public List<CData> isrelevance(CData data) {
		return materialcodingDao.isrelevance(data);
	}
	/**
	 * 模糊查询获取元件属性
	 * @param data
	 * @return
	 */
	public List<CData> selectAttr(CData data) {
		return materialcodingDao.selectAttr(data);
	}
	/**
	 * 查询cid
	 * @param data
	 * @return
	 */
	public List<CData> findCid(CData data) {
		return materialcodingDao.findCid(data);
	}
	/**
	 * 元件类型和编码号有重复提示
	 * @param data
	 * @return
	 */
	public List<CData> isrepeattypes(CData data) {
		return materialcodingDao.isrepeattypes(data);
	}
	/**
	 * 查看元件分类和物料属性是否有关联
	 * @param data
	 * @return
	 */
	public List<CData> isrelevanceclassify(CData data) {
		return materialcodingDao.isrelevanceclassify(data);
	}
	/**
	 * 元件分类是否重复
	 * @param data
	 * @return
	 */
	public List<CData> isrepeatclassify(CData data) {
		return materialcodingDao.isrepeatclassify(data);
	}
	
}
