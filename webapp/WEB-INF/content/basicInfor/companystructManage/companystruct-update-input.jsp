<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<html>
<head>
	<title>公司组织结构管理</title>
	<%@ include file="/common/header.jsp" %>
	<script type="text/javascript" src="/archive/ckeditor/ckeditor.js"></script>
	<script type="text/javascript"
		src="${ctx }/js/DatePicker/WdatePicker.js">
	</script>
	 <script type="text/javascript" language="javascript">
	//图片上传
     function checkPic() {
         var picPath = document.getElementById("photopath").value;
         var type = picPath.substring(picPath.lastIndexOf(".") + 1, picPath.length).toLowerCase();
         if (type != "jpg" && type != "bmp" && type != "gif" && type != "png") {
             alert("请上传正确的图片格式");
             return false;
         }
         return true;
     }
     //图片预览
     function PreviewImage(divImage, upload, width, height) {
         if (checkPic()) {
             try {
                 var imgPath;      //图片路径

                 var Browser_Agent = navigator.userAgent;
                 //判断浏览器的类型
                 if (Browser_Agent.indexOf("Firefox") != -1) {
                     //火狐浏览器

						//getAsDataURL在Firefox7.0 无法预览本地图片，这里需要修改
                     //imgPath = upload.files[0].getAsDataURL();
                     imgPath = window.URL.createObjectURL(upload.files[0]);
                     document.getElementById(divImage).innerHTML = "<img id='imgPreview' src='" + imgPath + "' width='" + width + "' height='" + height + "'/>";
                 } else {
                     //IE浏览器 ie9 必须在兼容模式下才能显示预览图片
                     var Preview = document.getElementById(divImage);
                     Preview.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = upload.value;
                     Preview.style.width = width;
                     Preview.style.height = height;
                 }
             } catch (e) {
                 alert("请上传正确的图片格式");
             }
         }
         document.getElementById("asd").style.display="none";
     }
    </script>

	

	<script type="text/javascript" language="javascript">
	//保存
	function fncInp(){
		
		if(document.getElementById("inputer").value==""){
			alert("输入人不能为空");
			return false;
		}
		
		if(document.getElementById("inputtime").value==""){
			alert("输入时间不能为空");
			return false;
		}
		
		if (!confirm("是否要添加？")) {
			return;
		}
		actSubmitValidate($('#formformPage'), '<c:url value="/basicInfor/companystructManage/companystruct!save.action"/>');
	}
	//取消当前编辑
	function fncCancel() {
		if (!confirm("是否要取消当前编辑并返回前页面？")) {
			return;
		}
		fncExtraFormCancel('<c:url value="/basicInfor/companystructManage/companystruct.action"/>');
	}
	
	// 固定表头
    function fncFixupListHead(){  
	    var tab = document.getElementById("listTab");
		if(tab) fixupFirstRow(tab);
		
		if (tab.rows.length < 12) {
			if (document.getElementById("resultDiv")) {
				document.getElementById("resultDiv").style.height = "";
			}
		}
  	}
	
	</script>
</head>

<body onload="fncFixupListHead();">
	<div id="Lcontent">
	<SSTag:navigation/>
		<div id="LsearchArea">
			<form id="formformPage" enctype="multipart/form-data" name="formPage" method="post"  class="enterhandler" style="width: 1000px;">
		       <input type="hidden" name="operateModel" value="update" />
		       	<input type="hidden" name="id" id="id" value="${test.id}" /> 
		       <table width="100%" > 
		          <tr>
			          <th nowrap="nowrap"><font color="red">*</font>组织结构图</th>
			          <td>
					    <input type="file" id="photopath" name="photopath" onchange="PreviewImage('Preview',this,120,120);" />
    					<div id="Preview" style="filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale);">
                          <img id="asd" <c:if test="${test.orgchart==null}"> style="display:none;"</c:if> 
						              	  <c:if test="${test.orgchart!=null}"> src="/archive/${test.orgchart }" </c:if>  
						                  width="120" height="120"/>
                        <input type="hidden" name=orgchart value="${test.orgchart }" />
                         </div>
				 	 </td>
		         </tr>
		         <tr>
			          <th  nowrap="nowrap">输入人</th>
			          <td><input  type="text" name="inputer" id="inputer" value="${test.inputer }" /></td>
		         </tr>
		         <tr>
			          <th  nowrap="nowrap"><font color="red">*</font>输入时间</th>
			          <td>
			          		<input type="text" name="inputtime" id="inputtime" value="${test.inputtime }"
								class="Wdate" onclick="WdatePicker()" 
								style="margin-right: 30px;"  readonly/>
					   </td>
		         </tr>
		       </table> 
		       <div><p>组织结构描述</p>
		        <textarea cols="130" id="structdeso" name="structdeso" rows="100">${test.structdeso }
                       
										</textarea>
										<script language="javascript">
											CKEDITOR.replace( 'structdeso',
										{
										fullPage : true,
										extraPlugins : 'docprops',
										filebrowserUploadUrl : '${ctx}/basicInfor/companystructManage/companystruct!savepic.action'
										});
											</script>
										</div>
			</form>
		</div>
			<fieldset>
						<legend>Button</legend>
							<ul class="LbtnArea">
								<li><input type="button" value="提交" onclick="fncInp()"
									 /> <input type="button" value="取消"
									onclick="fncCancel()"  />
								</li>
							</ul>
			</fieldset>
		    <br/>
	   </div>
	
<!-- END content -->
</body>
</html>								