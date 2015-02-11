package com.csValue.management.config.service;

import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import ssdevframework.core.collection.CData;

import com.csValue.common.util.Config;

@Component
@Transactional
public class ConfigManage {
	
	public void saveConfig(CData input){
		Config.getInstance().setNodeText("/root/expFilePath",
				input.getString("expFilePath"));
	//	Config.getInstance().setNodeText("/root/drugManualPath",
	//			input.getString("drugManualPath"));
	//	Config.getInstance().setNodeText("/root/drugCertPath",
	//			input.getString("drugCertPath"));
	//	Config.getInstance().setNodeText("/root/drugCheckReportPath",
	//			input.getString("drugCheckReportPath"));
	//	Config.getInstance().setNodeText("/root/drugPackagePicPath",
	//			input.getString("drugPackagePicPath"));
		Config.getInstance().setNodeText("/root/purRuleRoundMethod",
				input.getString("purRuleRoundMethod"));
		Config.getInstance().setNodeText("/root/purPlanRoundMethod",
				input.getString("purPlanRoundMethod"));
		Config.getInstance().setNodeText("/root/saftyFactorHigh",
				input.getString("saftyFactorHigh"));
		Config.getInstance().setNodeText("/root/saftyFactorLow",
				input.getString("saftyFactorLow"));
		}
}
