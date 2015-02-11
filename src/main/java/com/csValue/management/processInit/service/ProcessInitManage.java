package com.csValue.management.processInit.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import ssdevframework.core.collection.CData;

import com.csValue.common.login.entity.LoginUserData;
import com.csValue.management.processInit.dao.ProcessInitDao;

@Component
public class ProcessInitManage {
	
	@Autowired
	private ProcessInitDao dao;
	
	private final static String IMPORT_STORAGE_DETAIL_SQLID = "processInit.deleteImportStorageDetailList";
	private final static String IMPORT_STORAGE_MASTER_SQLID = "processInit.deleteImportStorageMasterList";
	
	private final static String EXPORT_STORAGE_DETAIL_SQLID = "processInit.deleteExportStorageDetailList";
	private final static String EXPORT_STORAGE_MASTER_SQLID = "processInit.deleteExportStorageMasterList";
	
	private final static String PURCHASE_STORAGE_DETAIL_SQLID = "processInit.deletePurchaseStorageDetailList";
	private final static String PURCHASE_STORAGE_MASTER_SQLID = "processInit.deletePurchaseStorageMasterList";
	
	private final static String ONCE_MONTH_LOG_SQLID = "processInit.createOnceMonthLog";
	
	private final static String IMPORT_MASTER_HISTORY = "processInit.createImportMasterHistory";
	private final static String IMPORT_DETAIL_HISTORY = "processInit.createImportDetailHistory";
	private final static String EXPORT_MASTER_HISTORY = "processInit.createExportMasterHistory";
	private final static String EXPORT_DETAIL_HISTORY = "processInit.createExportDetailHistory";
	private final static String PURCHASE_MASTER_HISTORY = "processInit.createPurchaseMasterHistory";
	private final static String PURCHASE_DETAIL_HISTORY = "processInit.createPurchaseDetailHistory";
	
	private final static String IMPORT_MAX_MIN_DATE = "processInit.retrieveImportMaxMinDate";
	private final static String EXPORT_MAX_MIN_DATE = "processInit.retrieveExportMaxMinDate";
	private final static String PURCHAS_MAX_MIN_DATE = "processInit.retrievePurchasMaxMinDate";

	public List<CData>  getOnceMonthProcessDate(){
		return dao.getOnceMonthProcessDate();
	}
	public CData processImportSto(CData input) throws Exception{
		input.set("createBy",  LoginUserData.getCurrentUserData().getUserId());
		String startTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
		CData result = new CData();
		// 需要处理的入库业务数据保存到入库历史表中
		int importDetailCnt = createCommonDao(IMPORT_DETAIL_HISTORY, input);
		int importMasterCnt = createCommonDao(IMPORT_MASTER_HISTORY, input);
		// 业务处理的数据条数
		result.set("importMasterCnt", importMasterCnt);
		result.set("importDetailCnt", importDetailCnt);
		
		// 查询被处理入库数据的最小日期和最大日期
		CData importMaxMinDate = retrieveSingleRecord(IMPORT_MAX_MIN_DATE, null);
		System.out.println(importMaxMinDate);
		if(importMaxMinDate!=null){
			input.setString("minProcessDate", importMaxMinDate.getString("minProcessDate"));
			input.setString("maxProcessDate", importMaxMinDate.getString("maxProcessDate"));
		}else{
			input.setString("minProcessDate", "");
			input.setString("maxProcessDate","");
		}
		
		// 处理入库明细表的数据
		int importDetailCount = deleteCommonDao(IMPORT_STORAGE_DETAIL_SQLID, null);
		if(importDetailCount != 0) {
			input.setString("tableName", "tb_drug_import_detail");
			input.setInt("deleteRowCount", importDetailCount);
			createCommonDao(ONCE_MONTH_LOG_SQLID, input);
		}
		// 处理入库主表的数据
		int importMasterCount = deleteCommonDao(IMPORT_STORAGE_MASTER_SQLID, null);
		if(importMasterCount != 0) {
			input.setString("tableName", "tb_drug_import_master");
			input.setInt("deleteRowCount", importMasterCount);
			createCommonDao(ONCE_MONTH_LOG_SQLID, input);
		}
		
		// 需要处理的出库业务数据保存到出库历史表中
		int exportDetailCnt = createCommonDao(EXPORT_DETAIL_HISTORY, input);
		int exportMasterCnt = createCommonDao(EXPORT_MASTER_HISTORY, input);
		// 业务处理的数据条数
		result.set("exportMasterCnt", exportMasterCnt);
		result.set("exportDetailCnt", exportDetailCnt);
		
		// 查询被处理出库数据的最小日期和最大日期
		CData exportMaxMinDate = retrieveSingleRecord(EXPORT_MAX_MIN_DATE, null);
		if(exportMaxMinDate!=null){
			input.setString("minProcessDate", exportMaxMinDate.getString("minProcessDate"));
			input.setString("maxProcessDate", exportMaxMinDate.getString("maxProcessDate"));
		}else{
			input.setString("minProcessDate", "");
			input.setString("maxProcessDate", "");
		}
		
		// 处理出库明细表的数据
		int exportDetailCount = deleteCommonDao(EXPORT_STORAGE_DETAIL_SQLID, null);
		if(exportDetailCount != 0) {
			input.setString("tableName", "tb_drug_export_detail");
			input.setInt("deleteRowCount", exportDetailCount);
			createCommonDao(ONCE_MONTH_LOG_SQLID, input);
		}
		
		// 处理出库主表的数据
		int exportMasterCount = deleteCommonDao(EXPORT_STORAGE_MASTER_SQLID, null);
		if(exportMasterCount != 0) {
			input.setString("tableName", "tb_drug_export_master");
			input.setInt("deleteRowCount", exportMasterCount);
			createCommonDao(ONCE_MONTH_LOG_SQLID, input);
		}
		
		// 需要处理的采购业务数据保存到采购历史表中
		int purchaseDetailCnt = createCommonDao(PURCHASE_DETAIL_HISTORY, input);
		int purchaseMasterCnt = createCommonDao(PURCHASE_MASTER_HISTORY, input);
		// 业务处理的数据条数
		result.set("purchaseMasterCnt", purchaseMasterCnt);
		result.set("purchaseDetailCnt", purchaseDetailCnt);
		
		// 查询被处理采购数据的最小日期和最大日期
		CData purchaseMaxMinDate = retrieveSingleRecord(PURCHAS_MAX_MIN_DATE, null);
		if(purchaseMaxMinDate!=null){
			input.setString("minProcessDate", purchaseMaxMinDate.getString("minProcessDate"));
			input.setString("maxProcessDate", purchaseMaxMinDate.getString("maxProcessDate"));
		}else{
			input.setString("minProcessDate", "");
			input.setString("maxProcessDate", "");
		}
		// 处理采购明细表的数据
		int purchaseDetailCount = deleteCommonDao(PURCHASE_STORAGE_DETAIL_SQLID, null);
		if(purchaseDetailCount != 0) {
			input.setString("tableName", "tb_purchas_detail");
			input.setInt("deleteRowCount", purchaseDetailCount);
			createCommonDao(ONCE_MONTH_LOG_SQLID, input);
		}
		// 处理采购主表的数据
		int purchaseMasterCount = deleteCommonDao(PURCHASE_STORAGE_MASTER_SQLID, null);
		if(purchaseMasterCount != 0) {
			input.setString("tableName", "tb_purchas_master");
			input.setInt("deleteRowCount", purchaseMasterCount);
			createCommonDao(ONCE_MONTH_LOG_SQLID, input);
		}
		String endTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
		if(!result.isEmpty()) {
			result.set("importMst", "入库主表处理结束，处理条数"+ (result.getString("importMasterCnt")!=null?result.getString("importMasterCnt"):"0"));
			result.set("importDtl", "入库明细表处理结束，处理条数"+(result.getString("importDetailCnt")!=null?result.getString("importDetailCnt"):"0"));
			result.set("exportMst", "出库主表处理结束，处理条数"+(result.getString("exportMasterCnt")!=null?result.getString("exportMasterCnt"):"0"));
			result.set("exportDtl", "出库明细表处理结束，处理条数"+(result.getString("exportDetailCnt")!=null?result.getString("exportDetailCnt"):"0"));
			result.set("purchasMst", "采购主表处理结束，处理条数"+(result.getString("purchaseMasterCnt")!=null?result.getString("purchaseMasterCnt"):"0"));
			result.set("purchasDtl", "采购明细表处理结束，处理条数"+(result.getString("purchaseDetailCnt")!=null?result.getString("purchaseDetailCnt"):"0"));
			result.set("startTime", "处理开始时间: " + startTime);
			result.set("endTime", "处理结束时间: " + endTime);
		} else {
			input.set("errMsg", "月次备份失败！");
		}
		return result;
	}
	/**
	 * 插入指定的记录
	 * 
	 * @param sqlID
	 * @param lData
	 * @return
	 * @throws LException
	 */
	public int createCommonDao(String sqlID, CData data) throws Exception {
			int createCount = 0;
			createCount = dao.createCommonDao(sqlID,data);
		return createCount;
    }
	
	/**
	 * 查询一条记录
	 * 
	 * @param sqlID
	 * @param lData
	 * @return
	 * @throws LException
	 */
	public CData retrieveSingleRecord(String sqlID, CData data) throws Exception {
			return dao.executeQueryForSingle(sqlID, data);
    }
	/**
	 * 删除指定的记录
	 * 
	 * @param sqlID
	 * @param lData
	 * @return
	 * @throws LException
	 */
	public int deleteCommonDao(String sqlID, CData data) throws Exception {
			int delCount = 0;
			delCount = dao.deleteCommonDao(sqlID, data);
			return delCount;
    }
}
