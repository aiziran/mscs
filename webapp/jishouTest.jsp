<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>机手打分</title>
</head>
<body>
  <div width="100%" style="margin:0 auto">
  <table>
      <tr>
         <td>日期 </td>
         <td> <input type="text" id="date" size="15"/></td>
         <td>取样时间</td>
         <td><input type="text" id="quyDate" size="13"></td>
         <td>班次</td>
         <td><select id="banci" style="width:55px">
                    <option value=""></option>
                 </select>
         </td>
          <td>班组</td>
          <td><select id="banzu" style="width:55px">
                    <option value=""></option>
                 </select>
         </td>
         <td>机号</td>
         <td><input type="text" id="jihao" value="14" readonly size="8"></td>
         <td>&nbsp;&nbsp;&nbsp;机手</td>
         <td><input type="text" id="jishou" size="13"></td>
         <td>&nbsp;&nbsp;&nbsp;品牌</td>
         <td><select id="pinpai" style="width:75px">
                    <option value=""></option>
                 </select>
         </td>
      </tr>
     
      <tr>
       <td>产品</td>
       <td colspan="3"> <select id="chanpin" style="width:250px">
                    <option value=""></option>
                 </select>
                    订单号         
        </td>
        <td colspan="2"><input type="text" id="chanpinPh" size="13"/> </td>
        <td colspan="2"> 成品代码</td>
         <td colspan="2"><input type="text" id="chengpinDm" size="13"/> </td>
         <td> 膜卷GCAS号</td>
         <td><input type="text" id="gcasMj" size="13"/></td>
         <td>大袋GCAS号</td>
         <td><input type="text" id="gcasDd" size="13"/></td>
      </tr>
  </table>
  
  </div>
  <div>
     机手打分
  <table>
     <tr>
        <td>薄膜刮损 </td>
        <td>
          <select>
              <option value=""></option>
          </select>
        </td>
        <td>外来材料污染</td>
        <td>
          <select>
              <option value=""></option>
          </select>
        </td>
         <td>印刷缺陷</td>
          <td>
          <select>
              <option value=""></option>
          </select>
        </td>
        <td>膜卷GCAS号</td>
          <td>
          <select>
              <option value=""></option>
          </select>
        </td>
         <td>图案位置</td>
          <td>
          <select>
              <option value=""></option>
          </select>
        </td>
     </tr>
     <tr>
        <td>背封不齐 </td>
        <td>
          <select>
              <option value=""></option>
          </select>
        </td>
        <td>封口皱褶</td>
        <td>
          <select>
              <option value=""></option>
          </select>
        </td>
         <td>过封</td>
          <td>
          <select>
              <option value=""></option>
          </select>
        </td>
        <td>提手强度</td>
          <td>
          <select>
              <option value=""></option>
          </select>
        </td>
         <td>提手外观</td>
          <td>
          <select>
              <option value=""></option>
          </select>
        </td>
     </tr>
      <tr>
        <td>小袋漏粉测试 </td>
        <td>
          <select>
              <option value=""></option>
          </select>
        </td>
        <td>生产日期</td>
        <td>
          <select>
              <option value=""></option>
          </select>
        </td>
         <td>排气孔</td>
          <td>
          <select>
              <option value=""></option>
          </select>
        </td>
        <td colspan="4"></td>
       
     </tr>
     <tr>
      <td  colspan="9"></td>
     <td><input type="button" value="新增机手打分">
              <input type="button" value="保存机手打分">
         </td>
       
      
     </tr>
  </table>
  </div>
</body>
</html>