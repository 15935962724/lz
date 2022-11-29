<%@page import="tea.entity.zs.Ctf"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.ui.*,tea.entity.custom.jjh.*" %><%@ page import="java.util.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.node.*" %>
<%
   Http http=new Http(request);
   String nextUrl=http.get("nextUrl");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑志愿者信息</title>
<link href="/res/<%=http.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
<script src="/jsp/custom/jjh/djq.js" type="text/javascript"></script>
<script src="/jsp/zhengshu/jquery-1.9.1.js" type="text/javascript"></script>
<link href="/jsp/custom/jjh/djq.css" rel="stylesheet" type="text/css">

<style type="text/css">
	#btid{color:red}
</style>

<script type="text/javascript">
  function isname(){
	  
	  var is=false;
	  if(form1.name.value==null||form1.name.value==""){
		 $("#cname").html("不能为空!");
		 return is; 
	  }else{
		  is=true;
		  return is;
	  }
  }
function iscreNum(){
	  
	  var is=false;
	  if(form1.creNum.value==null||form1.creNum.value==""){
		 $("#ccreNum").html("不能为空!");
		 return is; 
	  }else{
		  is=true;
		  return is;
	  }
  }
function iscreNumber(){
	  
	  var is=false;
	  if(form1.creNumber.value==null||form1.creNumber.value==""){
		 $("#ccreNumber").html("不能为空!");
		 return is; 
	  }else{
		  is=true;
		  return is;
	  }
}
function iscreName(){
	  
	  var is=false;
	  if(form1.creName.value==null||form1.creName.value==""){
		 $("#ccreName").html("不能为空!");
		 return is; 
	  }else{
		  is=true;
		  return is;
	  }
}
function istime(){
	  
	  var is=false;
	  if(form1.time.value==null||form1.time.value==""){
		 $("#ctime").html("不能为空!");
		 return is; 
	  }else{
		  is=true;
		  return is;
	  }
}
  function istrue(){
	  if(isname()&iscreNum()&iscreNumber()&iscreName()&istime()){
		  form1.submit();
	  }
  }
</script>
</head>
<body>
<h1>证书新建</h1>
<!-- onSubmit="return mt.checkform(this)" -->
<form  name="form1" action="/CtfSeivlet.do"   target="_ajax" method="post"> 
<input type="hidden" name="status" value="add"/>
<input type="hidden" name="nextUrl" value="<%=nextUrl%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="">
   <script type="text/javascript">
    mt.re=function(cc){
	form1.photo.value=document.getElementById("ccc").src=cc;
   };

   </script>
    <td align="right" width="180" nowrap><span id="btid">*</span>姓名:</TD>
    <td nowrap><input type="TEXT" class="edit_input"  name="name" value="" onKeyUp="value=value.replace(/[^\u4E00-\u9FA5]/g,'')"><span id="cname" style="color: red"></span></td>
    <td nowrap align="right">性别:</td>
    <td nowrap align="left"><input type="radio" name="sex" id="sex1" value="0"  checked="checked"><label for="sex1">男</label>
    	<input type="radio" name="sex" id="sex2" value="1"  ><label for="sex2">女</label></td>
    <td width="110" rowspan="5" align="center"><input name="photo" type="hidden" value=""/>
    <img id="ccc" src="../type/bbs/default_bbsphoto/index.jpg" /><br>
<a href="###" onClick="mt.show('/jsp/zhengshu/MemberSetAvatar.jsp?community=<%=http.community%>',2,'修改您的头像',450,277)">上传头像</a><br />
<span class="tix" style="color:#F00;width:110px;display:block;">请尽量使用英文名称的图片上传！</span></td>
  </tr>
  <tr id="">
    <td nowrap align="right" ><span id="btid">*</span>证件号码:</TD>
    <td nowrap><input type="TEXT" class="edit_input"  name="creNum" value="" maxlength="18" onKeyUp="value=value.replace(/[\W]/g,'')"><span id="ccreNum" style="color: red"></span></td>
    <td nowrap align="right" ><span id="btid">*</span>证书编号:</TD>
    <td nowrap><input type="TEXT" class="edit_input"  name="creNumber" value="" maxlength="29" onKeyUp="value=value.replace(/[\W]/g,'')"><span id="ccreNumber" style="color: red"></span></td>
    </tr>
  <tr id="">
    <td nowrap align="right" ><span id="btid">*</span>证书名称:</TD>
    <td nowrap><input type="TEXT" class="edit_input"  name="creName" value="" onKeyUp="value=value.replace(/[^\u4E00-\u9FA5]/g,'')"><span id="ccreName" style="color: red"></span></td>
    <td nowrap align="right" >证书级别:</TD>
    <td nowrap><input type="TEXT" class="edit_input"  name="creLv" value=""></td>
  </tr>
  <tr id="">
    <td nowrap align="right" ><input type="TEXT" class="edit_input"  name="markName1" value="理论知识成绩" size="14" maxlength="20"></TD>
    <td nowrap><input type="TEXT" class="edit_input"  name="mark1" value=""></td>
    <td nowrap align="right" ><input type="TEXT" class="edit_input"  name="markName2" value="专业技能成绩" size="14" maxlength="20"></TD>
    <td nowrap><input type="TEXT" class="edit_input"  name="mark2" value=""></td>
  </tr>
  <tr id="">
    <td nowrap align="right" ><input type="TEXT" class="edit_input"  name="markName3" value="论文评审成绩" size="14" maxlength="20"></TD>
    <td nowrap><input type="TEXT" class="edit_input"  name="mark3" value=""></td>
    <td nowrap align="right"><input type="TEXT" class="edit_input"  name="markName4" value="综合评定成绩" size="14" maxlength="20"></td>
    <td nowrap><input type="TEXT" class="edit_input"  name="mark4" value=""></td>
  </tr>
  <tr id="">
    <td nowrap align="right" ><input type="TEXT" class="edit_input"  name="markName5" value="论文评审成绩" size="14" maxlength="20"></TD>
    <td nowrap><input type="TEXT" class="edit_input"  name="mark5" value=""></td>
    <td nowrap align="right"><input type="TEXT" class="edit_input"  name="markName6" value="综合评定成绩" size="14" maxlength="20"></td>
    <td colspan="2" nowrap><input type="TEXT" class="edit_input"  name="mark6" value=""></td>
  </tr>
  <tr id="">
    <td nowrap align="right">数据上报单位:</TD>
    <td nowrap><input type="TEXT" class="edit_input"  name="danwei" value=""  maxlength="20"></td>
    <td nowrap align="right">评定成绩:</TD>
    <td colspan="2" nowrap><input type="TEXT" class="edit_input"  name="gra" value=""  maxlength="20"></td>
    </tr>
  <tr id="">
    <td nowrap align="right" ><input type="TEXT" class="edit_input"  name="otherName" value="备注" size="14"></TD>
    <td nowrap><input type="TEXT" class="edit_input"  name="other" value=""></td>
    <td nowrap align="right"><span id="btid">*</span>发证时间:</TD>
    <td colspan="2" nowrap>
		<input id="datestime" name="time" size="14"  value=""  style="cursor:pointer" readonly onClick="new Calendar().show('form1.time');"> 
  <img src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer;margin-bottom:-8px;" onclick="new Calendar().show('form1.time');" />
    <span id="ctime" style="color: red"></span>
 	</td>
  </tr>
  
</table>

  
  <span id="submitshow">
  <input id="submit1" class="edit_button" value="保存" onClick="javascript:istrue();" type="button">&nbsp;
  <input name="reset" value="返回" onClick="history.go(-1);" type="button">
</span>

</form>

</body>
</html>
