package ssdevframework.front.action;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ssdevframework.core.collection.CData;
import ssdevframework.core.collection.CMultiData;
import ssdevframework.front.util.CollectionUtility;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Preparable;

/**
 * Struts2中典型CRUD Action的抽象基类.
 * 
 * 主要定义了对Preparable,ModelDriven接口的使用,以及CRUD函数和返回值的命名.
 *
 * @param <T> BaseActionSupport所管理的对象类型.
 * 
 * @author calvin
 */
@Results({ @Result(name = "line", location = "/common/chart/page.jsp"),
		@Result(name = "pie", location = "/common/chart/pie.jsp"),
		@Result(name = "verticalBar", location = "/common/chart/vertical.jsp"),
		@Result(name = "excelList", location = "/common/chart/exportExcel.jsp") })
public abstract class BaseActionSupport extends ActionSupport implements Preparable {

	private static final long serialVersionUID = -1653204626115064950L;
	//protected LoginUserData loginUser;

	/** 进行增删改操作后,以redirect方式重新打开action默认页的result名.*/
	public static final String RELOAD = "reload";
	public static final String CREATE_INPUT = "create-input";
	public static final String UPDATE_INPUT = "update-input";

	/*
	 * 订单编辑
	 */
	public static final String POEDIT = "poEditByTemp";
	/*
	 * excel返回
	 */
	public static final String EXCEL = "excelList";
	/*
	 * 饼图
	 */
	public static final String IMGPIE = "pie";
	/*
	 * 线图
	 */
	public static final String IMGLINE = "line";
	/*
	 * 柱图
	 */
	public static final String IMGVER = "verticalBar";

	private String fileHideUploadFlag;
	//重新封装Request请求数据
	protected CData data = CollectionUtility.getData();
	protected CMultiData mdata = CollectionUtility.getMultiData();

	protected Logger logger = LoggerFactory.getLogger(getClass());

	/**
	 * Action函数, 默认的action函数, 默认调用list()函数.
	 */
	@Override
	public String execute() throws Exception {
		return list();
	}

	//-- CRUD Action函数 --//
	/**
	 * Action函数,显示Entity列表界面.
	 * 建议return SUCCESS.
	 */
	public abstract String list() throws Exception;

	/**
	 * Action函数,显示新增或修改Entity界面.
	 * 建议return INPUT.
	 */

	public String input() throws Exception {
		return INPUT;
	}

	/**
	 * Action函数,新增或修改Entity. 
	 * 建议return RELOAD.
	 */
	public String save() throws Exception {
		return RELOAD;
	}

	/**
	 * Action函数,删除Entity.
	 * 建议return RELOAD.
	 */
	public String delete() throws Exception {
		return RELOAD;
	}

	//-- Preparable函数 --//
	/**
	 * 实现空的prepare()函数,屏蔽了所有Action函数都会执行的公共的二次绑定.
	 */
	public void prepare() throws Exception {
	}

	public CData getData() {
		return data;
	}

	public CMultiData getMdata() {
		return mdata;
	}

	/**
	 * 定义在input()前执行二次绑定.
	 */
	public void prepareInput() throws Exception {
		prepareModel();
	}

	/**
	 * 定义在save()前执行二次绑定.
	 */
	public void prepareSave() throws Exception {
		prepareModel();
	}

	/**
	 * 等同于prepare()的内部函数,供prepardMethodName()函数调用. 
	 */
	protected void prepareModel() throws Exception {
	}

	public String getFileHideUploadFlag() {
		return fileHideUploadFlag;
	}

	/*
	 * 多文件上传时，获取表单数据，需要在页面增加一个隐藏的input，name属性为：fileHideUploadFlag
	 */
	public void setFileHideUploadFlag(String fileHideUploadFlag) {
		this.fileHideUploadFlag = fileHideUploadFlag;
		mdata = CollectionUtility.getMultiData();
		data = CollectionUtility.getData();
	}

	protected String saveUploadFile(File upload) {
		//计算路径
		SimpleDateFormat sdf = new SimpleDateFormat("/yyyy/MM/dd/");
		String basePath = ServletActionContext.getServletContext().getRealPath("/WEB-IFN/upload_files");
		String subPath = sdf.format(new Date());
		String path = basePath + subPath + UUID.randomUUID().toString();//使用UUID解决重名问题

		//如果文件夹不存在就创建
		File dir = new File(basePath + subPath);
		if (!dir.exists()) {
			dir.mkdirs();
		}

		//移动文件
		File dest = new File(path);
		upload.renameTo(dest);
		return path;
	}

}
