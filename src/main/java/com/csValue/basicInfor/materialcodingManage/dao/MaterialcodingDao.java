package com.csValue.basicInfor.materialcodingManage.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springside.modules.orm.Page;

import ssdevframework.core.collection.CData;

import com.csValue.common.util.dao.PageDao;

/**
 * 物料编码系统主界面dao
 * @author MeiRuixue
 *
 */
@Component
public class MaterialcodingDao extends SqlSessionDaoSupport {
	@Autowired
	private PageDao pageDao;
	/**
	 * 获取电子元件类型
	 * @param data 
	 * @return
	 */
	public List<CData> selectAllTypes(CData data) {
		return this.getSqlSession().selectList("materialcodingManage.selectAllTypes", data);
	}
	/**
	 * 获取元件分类
	 * @param data 
	 * @return
	 */
	public List<CData> selectAllClassify(CData data) {
		return this.getSqlSession().selectList("materialcodingManage.selectAllClassify", data);
	}
	/**
	 * 获取元件属性
	 * @param data 
	 * @return
	 */
	public List<CData> selectAllAttr(CData data) {
		return this.getSqlSession().selectList("materialcodingManage.selectAllAttr", data);
	}
	/**
	 * 获取元件属性参数
	 * @param data
	 * @return
	 */
	public List<CData> getArguments(CData data) {
		return this.getSqlSession().selectList("materialcodingManage.getArguments", data);
	}
	/**
	 * 分页显示
	 * @param page
	 * @param data
	 * @return
	 */
	public Page<CData> selectAllInfo(Page<CData> page, CData data) {
		return pageDao.getPageList("materialcodingManage.selectAllInfo", page, data);
	}
	/**
	 * 录入物料信息
	 * @param data
	 * @return
	 */
	public Integer savematerialinfo(CData data) {
		return this.getSqlSession().insert("materialcodingManage.savematerialinfo", data);
	}
	/**
	 * 获取属相相同的物料信息
	 * @param data
	 * @return
	 */
	public List<CData> selectAllInfo(CData data) {
		return this.getSqlSession().selectList("materialcodingManage.selectAllInfo", data);
	}
	/**
	 * 删除物料信息
	 * @param data
	 * @return
	 */
	public Integer deleteInfo(CData data) {
		return this.getSqlSession().delete("materialcodingManage.deleteInfo", data);
	}
	/**
	 * 修改物料信息
	 * @param data
	 * @return
	 */
	public Integer updatematerialinfo(CData data) {
		return this.getSqlSession().update("materialcodingManage.updatematerialinfo", data);
	}
	/**
	 * 物料属性配置页面
	 * @param page
	 * @param data
	 * @return
	 */
	public Page<CData> attrconfig(Page<CData> page, CData data) {
		return pageDao.getPageList("materialcodingManage.attrconfig", page, data);
	}
	/**
	 * 元件类型配置
	 * @param page
	 * @param data
	 * @return
	 */
	public Page<CData> typesconfig(Page<CData> page, CData data) {
		return pageDao.getPageList("materialcodingManage.typesconfig", page, data);
	}
	/**
	 * 元件分类配置
	 * @param page
	 * @param data
	 * @return
	 */
	public Page<CData> classifyconfig(Page<CData> page, CData data) {
		return pageDao.getPageList("materialcodingManage.classifyconfig", page, data);
	}
	/**
	 * 新增物料属性
	 * @param data
	 * @return
	 */
	public Integer saveattr(CData data) {
		return this.getSqlSession().insert("materialcodingManage.saveattr", data);
	}
	/**
	 * 修改物料属性
	 * @param data
	 * @return
	 */
	public Integer updateattr(CData data) {
		return this.getSqlSession().update("materialcodingManage.updateattr", data);
	}
	/**
	 * 修改物料属性回显
	 * @param data
	 * @return
	 */
	public List<CData> attrconfig(CData data) {
		return this.getSqlSession().selectList("materialcodingManage.attrconfig", data);
	}
	/**
	 * 删除物料属性
	 * @param data
	 * @return
	 */
	public Integer deleteattr(CData data) {
		return this.getSqlSession().delete("materialcodingManage.deleteattr", data);
	}
	/**
	 * 新增元件分类
	 * @param data
	 * @return
	 */
	public Integer saveclassify(CData data) {
		return this.getSqlSession().insert("materialcodingManage.saveclassify", data);
	}
	/**
	 * 修改元件分类
	 * @param data
	 * @return
	 */
	public Integer updateclassify(CData data) {
		return this.getSqlSession().update("materialcodingManage.updateclassify", data);
	}
	/**
	 * 修改元件分类回显
	 * @param data
	 * @return
	 */
	public List<CData> classifyconfig(CData data) {
		return this.getSqlSession().selectList("materialcodingManage.classifyconfig", data);
	}
	/**
	 * 删除元件分类
	 * @param data
	 * @return
	 */
	public Integer deleteclassify(CData data) {
		return this.getSqlSession().delete("materialcodingManage.deleteclassify", data);
	}
	/**
	 * 新增元件类型
	 * @param data
	 * @return
	 */
	public Integer savetypes(CData data) {
		return this.getSqlSession().insert("materialcodingManage.savetypes", data);
	}
	/**
	 * 修改元件类型
	 * @param data
	 * @return
	 */
	public Integer updatetypes(CData data) {
		return this.getSqlSession().update("materialcodingManage.updatetypes", data);
	}
	/**
	 * 修改元件类型回显
	 * @param data
	 * @return
	 */
	public List<CData> typesconfig(CData data) {
		return this.getSqlSession().selectList("materialcodingManage.typesconfig", data);
	}
	/**
	 * 删除元件类型
	 * @param data
	 * @return
	 */
	public Integer deletetypes(CData data) {
		return this.getSqlSession().delete("materialcodingManage.deletetypes", data);
	}
	/**
	 * 获取属相相同的物料信息
	 * @param data
	 * @return
	 */
	public List<CData> selectOneInfo(CData data) {
		return this.getSqlSession().selectList("materialcodingManage.selectOneInfo", data);
	}
	/**
	 * 物料属性参数和编码号有重复报警提示
	 * @param data
	 * @return
	 */
	public List<CData> isrepeatattr(CData data) {
		return this.getSqlSession().selectList("materialcodingManage.isrepeatattr", data);
	}
	/**
	 * 查看元件类型和元件分类是否有关联
	 * @param data
	 * @return
	 */
	public List<CData> isrelevance(CData data) {
		return this.getSqlSession().selectList("materialcodingManage.isrelevance", data);
	}
	/**
	 * 模糊查询获取元件属性
	 * @param data
	 * @return
	 */
	public List<CData> selectAttr(CData data) {
		return this.getSqlSession().selectList("materialcodingManage.selectAttr", data);
	}
	/**
	 * 查询cid
	 * @param data
	 * @return
	 */
	public List<CData> findCid(CData data) {
		return this.getSqlSession().selectList("materialcodingManage.findCid", data);
	}
	/**
	 * 元件类型和编码号有重复提示
	 * @param data
	 * @return
	 */
	public List<CData> isrepeattypes(CData data) {
		return this.getSqlSession().selectList("materialcodingManage.isrepeattypes", data);
	}
	/**
	 * 查看元件分类和物料属性是否有关联
	 * @param data
	 * @return
	 */
	public List<CData> isrelevanceclassify(CData data) {
		return this.getSqlSession().selectList("materialcodingManage.isrelevanceclassify", data);
	}
	/**
	 * 元件分类是否重复
	 * @param data
	 * @return
	 */
	public List<CData> isrepeatclassify(CData data) {
		return this.getSqlSession().selectList("materialcodingManage.isrepeatclassify", data);
	}
	
}
