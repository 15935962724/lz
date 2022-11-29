<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form id="form1" name="form1" method="post" action="/CtfSeivlet.do?status=add">

   <table width="470" border="1">
  <tr>
    <td width="90">姓名：</td>
    <td width="174"><input type="text" name="name" id="sex" maxlength="10" onkeyup="value=value.replace(/[^\u4E00-\u9FA5]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\u4E00-\u9FA5]/g,''))"
    /></td>
  </tr>
  <tr >
    <td>性别：</td>
    <td><input type="radio" name="sex" id="sex" value="男" checked="checked"/>男
    <input type="radio" name="sex" id="sex" value="女"/>女</td>
  </tr>
  <tr>
    <td>证件号码：</td>
    <td><input type="text" name="creNum" id="creNum" maxlength="18" onkeyup="value=value.replace(/[\W]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"
    ></td>
    
  </tr>
   <tr>
    <td>证书编号：</td>
    <td><input type="text" name="creNumber" id="creNumber" maxlength="29" onkeyup="value=value.replace(/[\W]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"
    ></td>
    
  </tr>
  <tr>
    <td>证书名称：</td>
    <td><input type="text" name="creName" id="creName" onkeyup="value=value.replace(/[^\u4E00-\u9FA5]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\u4E00-\u9FA5]/g,''))"
    ></td>
    
  </tr>
  <tr>
    <td>证书级别：</td>
    <td><input type="text" name="creLv" id="creLv" ></td>
    
  </tr>
  <tr>
    <td>成绩1：</td>
    <td><input type="text" name="markName1" id="markName1" maxlength="20"><input type="text" name="mark1" id="mark1" ></td>
    
  </tr>
  <tr>
    <td>成绩2：</td>
    <td><input type="text" name="markName2" id="markName2" maxlength="20"><input type="text" name="mark2" id="mark2" ></td>
    
  </tr>
  <tr>
    <td>成绩3：</td>
    <td><input type="text" name="markName3" id="markName3" maxlength="20"><input type="text" name="mark3" id="mark3" ></td>
    
  </tr>
  <tr>
    <td>成绩4：</td>
    <td><input type="text" name="markName4" id="markName4" maxlength="20"><input type="text" name="mark4" id="mark4" ></td>
    
  </tr>
  <tr>
    <td>数据上报单位：</td>
    <td><input type="text" name="danwei" id="creLv" maxlength="20"></td>
    
  </tr>
  <tr>
    <td>评定成绩：</td>
    <td><input type="text" name="gra" id="creLv" maxlength="20"></td>
    
  </tr>
  <tr>
    <td>发证时间：</td>
    <td><input id="datestime" name="vtime" size="7"  value=""  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.vtime');"> 
  <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.vtime');" /></td>
    
  </tr>
  <tr>
    <td>照片：</td>
    <td><input type="text" name="creLv" id="creLv" ></td>
    
  </tr>
  <tr>
    <td colspan="2"><input type="submit" name="Submit" value="提交" /></td>
  </tr>
  
</table>

</form>
</body>
</html>