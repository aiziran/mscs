package com.csValue.basicInfor.dataManage.web;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFClientAnchor;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFPatriarch;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.Region;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.utils.web.struts2.Struts2Utils;
import ssdevframework.core.collection.CData;
import ssdevframework.front.action.BaseActionSupport;

import com.csValue.basicInfor.dataManage.service.DataManage;

import com.lowagie.text.Cell;


@Namespace("/basicInfor/dataManage")
@Results({ @Result(name = BaseActionSupport.RELOAD, location = "data.action", type = "redirectParams") })
public class DataAction extends BaseActionSupport {
	@Autowired
	private DataManage manage;
	private Page<CData> page = new Page<CData>();
	private List<CData> rdata = new ArrayList<CData>();
	private CData dataInfo;
	public CData getDataInfo() {
		return dataInfo;
	}
	public void setDataInfo(CData dataInfo) {
		this.dataInfo = dataInfo;
	}
	

	@Override
	public String list() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	//排班表
	public String handerWorking() throws Exception {
		page = manage.handerWorking(page, data);
		return "handerworking";
	}
	//排班更新页面
	public String updateWorkoingPage() throws Exception {
		setDataInfo(manage.reupdateWorkoing(data));
		return "updateworking";
	}
	//新增排班 页面
	public String insertWorkoingPage() throws Exception {
		return "insertworking";
	}
	//排班更新保存
	public String updateWorkoing() throws Exception {
		manage.updateWorkoing(data);
		page = manage.handerWorking(page, data);
		return "handerworking";
	}
	//新增排班保存
	public String insertWorkoing() throws Exception {
		manage.insertWorkoing(data);
		page = manage.handerWorking(page, data);
		return "handerworking";
	}
	//删除排班
	public String deleteWorking() throws Exception {
		manage.deleteWorking(data);
		page = manage.handerWorking(page, data);
		return "handerworking";
		
	}
	
	
	
	//班组
	public String team() throws Exception {
		// TODO Auto-generated method stub
		page = manage.team(page, data);
		return "team";
	}
	//班组更新页面
	public String updateTeamPage() throws Exception {
		setDataInfo(manage.reupdataTeam(data));
		return "updateteam";
	}
	//新增班组 页面
	public String insertTeamPage() throws Exception {
		return "insertteam";
	}
	//班组更新保存
	public String updateTeam() throws Exception {
		manage.updateTeam(data);
		page = manage.team(page, data);
		return "team";
	}
	//新增班组 保存
	public String insertTeam() throws Exception {
		manage.insertTeam(data);
		page = manage.team(page, data);
		return "team";
	}
	//删除班组
	public String deleteTeam() throws Exception {
		manage.deleteTeam(data);
		page = manage.team(page, data);
		return "team";
		
	}
   
	//班次
	public String classes() throws Exception {
		// TODO Auto-generated method stub
		page = manage.classes(page, data);
		return "classes";
	}
	//班次
	public String classesdetail() throws Exception {
		// TODO Auto-generated method stub
		page = manage.classes(page, data);
		return "classesdetail";
	}
	
	//班次更新页面
	public String updateClassesPage() throws Exception {
		setDataInfo(manage.selectupdataClassesDetail(data));
		return "updateclasses";
	}
	//新增班次 页面
	public String insertClassesPage() throws Exception {
		return "insertclasses";
	}
	//班次更新保存
	public String updateClasses() throws Exception {
		manage.updateClasses(data);
		page = manage.classes(page, data);
		return "classes";
		
	}
	//新增班次 保存
	public String insertClasses() throws Exception {
		manage.insertClasses(data);
		page = manage.classes(page, data);
		return "classes";
		
	}
	//删除班次
	public String deleteClasses() throws Exception {
		manage.deleteClasses(data);
		page = manage.classes(page, data);
		return "classes";
		
	}
	
	//机手
	public String hander() throws Exception {
		// TODO Auto-generated method stub
		page = manage.hander(page, data);
		return "hander";
	}
	//机手更新页面
	public String updateHanderPage() throws Exception {
		setDataInfo(manage.selectupdataHanderDetail(data));
		return "updatehander";
	}
	//新增机手 页面
	public String insertHanderPage() throws Exception {
		return "inserthander";
	}
	//机手更新保存
	public String updateHander() throws Exception {
		manage.updateHander(data);
		page = manage.hander(page, data);
		return "hander";
	}
	//新增机手 保存
	public String insertHander() throws Exception {
		manage.insertHander(data);
		page = manage.hander(page, data);
		return "hander";
	}
	//删除机手
	public String deleteHander() throws Exception {
		manage.deleteHander(data);
		page = manage.hander(page, data);
		return "hander";
		
	}
	
	//质检员
	public String inspector() throws Exception {
		// TODO Auto-generated method stub
		page = manage.inspector(page, data);
		return "inspector";
	}
	
	//质检员更新页面
	public String updateInspectorPage() throws Exception {
		setDataInfo(manage.selectupdataInspectorDetail(data));
		return "updateinspector";
	}
	//新增质检员 页面
	public String insertInspectorPage() throws Exception {
		return "insertinspector";
	}
	//质检员更新保存
	public String updateInspector() throws Exception {
		manage.updateInspector(data);
		page = manage.hander(page, data);
		return "hander";
	}
	//新增质检员 保存
	public String insertInspector() throws Exception {
		manage.insertInspector(data);
		page = manage.hander(page, data);
		return "hander";
	}
	//删除质检员
	public String deletInspector() throws Exception {
		manage.deleteInspector(data);
		page = manage.hander(page, data);
		return "hander";
		
	}
	
	
	
	
	
	public static void main(String[] args) {
		double averagevalue=301.25;
		String guigexx="391";
		double biaozhuncha=2.19;
		double NORMSDISTInput=(averagevalue- Double.parseDouble(guigexx))/biaozhuncha;
		double[] NORMSDISTTable={0.5,0.504,0.508,0.512,0.516,0.5199,0.5239,0.5279,0.5319,0.5359,
    			0.5398,0.5438,0.5478,0.5517,0.5557,0.5596,0.5636,0.5675,0.5714,0.5753,
    			0.5793,0.5832,0.5871,0.591,0.5948,0.5987,0.6026,0.6064,0.6103,0.6141,
    			0.6179,0.6217,0.6255,0.6293,0.6331,0.6368,0.6406,0.6443,0.648,0.6517,
    			0.6554,0.6591,0.6628,0.6664,0.67,0.6736,0.6772,0.6808,0.6844,0.6879,
    			0.6915,0.695,0.6985,0.7019,0.7054,0.7088,0.7123,0.7157,0.719,0.7224,
    			0.7257,0.7291,0.7324,0.7357,0.7389,0.7422,0.7454,0.7486,0.7517,0.7549,
    			0.758,0.7611,0.7642,0.7673,0.7703,0.7734,0.7764,0.7794,0.7823,0.7852,
    			0.7881,0.791,0.7939,0.7967,0.7995,0.8023,0.8051,0.8078,0.8106,0.8133,
    			0.8159,0.8186,0.8212,0.8238,0.8264,0.8289,0.8315,0.834,0.8365,0.8389,
    			0.8413,0.8438,0.8461,0.8485,0.8508,0.8531,0.8554,0.8577,0.8599,0.8621,
    			0.8643,0.8665,0.8686,0.8708,0.8729,0.8749,0.877,0.879,0.881,0.883,
    			0.8849,0.8869,0.8888,0.8907,0.8925,0.8944,0.8962,0.898,0.8997,0.9015,
    			0.9032,0.9049,0.9066,0.9082,0.9099,0.9115,0.9131,0.9147,0.9162,0.9177,
    			0.9192,0.9207,0.9222,0.9236,0.9251,0.9265,0.9278,0.9292,0.9306,0.9319,
    			0.9332,0.9345,0.9357,0.937,0.9382,0.9394,0.9406,0.9418,0.943,0.9441,
    			0.9452,0.9463,0.9474,0.9484,0.9495,0.9505,0.9515,0.9525,0.9535,0.9545,
    			0.9554,0.9564,0.9573,0.9582,0.9591,0.9599,0.9608,0.9616,0.9625,0.9633,
    			0.9641,0.9648,0.9656,0.9664,0.9671,0.9678,0.9686,0.9693,0.97,0.9706,
    			0.9713,0.9719,0.9726,0.9732,0.9738,0.9744,0.975,0.9756,0.9762,0.9767,
    			0.9772,0.9778,0.9783,0.9788,0.9793,0.9798,0.9803,0.9808,0.9812,0.9817,
    			0.9821,0.9826,0.983,0.9834,0.9838,0.9842,0.9846,0.985,0.9854,0.9857,
    			0.9861,0.9864,0.9868,0.9871,0.9874,0.9878,0.9881,0.9884,0.9887,0.989,
    			0.9893,0.9896,0.9898,0.9901,0.9904,0.9906,0.9909,0.9911,0.9913,0.9916,
    			0.9918,0.992,0.9922,0.9925,0.9927,0.9929,0.9931,0.9932,0.9934,0.9936,
    			0.9938,0.994,0.9941,0.9943,0.9945,0.9946,0.9948,0.9949,0.9951,0.9952,
    			0.9953,0.9955,0.9956,0.9957,0.9959,0.996,0.9961,0.9962,0.9963,0.9964,
    			0.9965,0.9966,0.9967,0.9968,0.9969,0.997,0.9971,0.9972,0.9973,0.9974,
    			0.9974,0.9975,0.9976,0.9977,0.9977,0.9978,0.9979,0.9979,0.998,0.9981,
    			0.9981,0.9982,0.9982,0.9983,0.9984,0.9984,0.9985,0.9985,0.9986,0.9986,
    			0.9987,0.999,0.9993,0.9995,0.9997,0.9998,0.9998,0.9999,0.9999,1.0,
    			0.999032,0.999065,0.999096,0.999126,0.999155,0.999184,0.999211,0.999238,0.999264,0.999289,
    			0.999313,0.999336,0.999359,0.999381,0.999402,0.999423,0.999443,0.999462,0.999481,0.999499,
    			0.999517,0.999534,0.999550,0.999566,0.999581,0.999596,0.999610,0.999624,0.999638,0.999660,
    			0.999663,0.999675,0.999687,0.999698,0.999709,0.999720,0.999730,0.999740,0.999749,0.999760,
    			0.999767,0.999776,0.999784,0.999792,0.999800,0.999807,0.999815,0.999822,0.999828,0.999885,
    			0.999841,0.999847,0.999853,0.999858,0.999864,0.999869,0.999874,0.999879,0.999883,0.999880,
    			0.999892,0.999896,0.999900,0.999904,0.999908,0.999912,0.999915,0.999918,0.999922,0.999926,
    			0.999928,0.999931,0.999933,0.999936,0.999938,0.999941,0.999943,0.999946,0.999948,0.999950,
    			0.999952,0.999954,0.999956,0.999958,0.999959,0.999961,0.999963,0.999964,0.999966,0.999967,
    			0.999968,0.999970,0.999971,0.999972,0.999973,0.999974,0.999975,0.999976,0.999977,0.999978,
    			0.999979,0.999980,0.999981,0.999982,0.999983,0.999983,0.999984,0.999985,0.999985,0.999986,
    			0.999987,0.999987,0.999988,0.999988,0.999989,0.999989,0.999990,0.999990,0.999991,0.999991,
    			0.999991,0.999992,0.999992,0.999930,0.999993,0.999993,0.999993,0.999994,0.999994,0.999994,
    			0.999995,0.999995,0.999995,0.999995,0.999996,0.999996,0.999996,1.000000,0.999996,0.999996,
    			0.999997,0.999997,0.999997,0.999997,0.999997,0.999997,0.999997,0.999998,0.999998,0.999998,
    			0.999998,0.999998,0.999998,0.999998,0.999998,0.999998,0.999998,0.999998,0.999999,0.999999,
    			0.999999,0.999999,0.999999,0.999999,0.999999,0.999999,0.999999,0.999999,0.999999,0.999999,
    			0.999999,0.999999,0.999999,0.999999,0.999999,0.999999,0.999999,0.999999,0.999999,0.999999,
    			1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000};
    
    	double NORMSDISTOutput;
    	if(NORMSDISTInput < 0.0)
    	{
    		NORMSDISTOutput = 0.5;
    	}
    	else if( NORMSDISTInput > 4.98){
    		NORMSDISTOutput=1.0;
    	}
    	else
    	{
    		double StartValue = NORMSDISTTable[(int)(NORMSDISTInput*100)];
    		double EndValue = NORMSDISTTable[(int)(NORMSDISTInput*100)+1];
    		NORMSDISTOutput = StartValue + (EndValue - StartValue)/0.01*(NORMSDISTInput - (double)(int)(NORMSDISTInput * 100)/100.0);
    	}
    	double quexianlv0=(1.0-NORMSDISTOutput)*1000000;
    	int quexianlv=(int)Math.round(quexianlv0);
    	System.out.println(quexianlv);
	}
	
	
	
	
	
	
	
	
	public List<CData> getRdata() {
		return rdata;
	}

	public void setRdata(List<CData> rdata) {
		this.rdata = rdata;
	}
	
	
	public Page<CData> getPage() {
		return page;
	}

	public void setPage(Page<CData> page) {
		this.page = page;
	}
	
	

}
