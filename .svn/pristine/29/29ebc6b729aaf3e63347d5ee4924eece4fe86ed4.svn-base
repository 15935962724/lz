<%@page import="tea.entity.zs.Ctf"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.ui.*,tea.entity.custom.jjh.*" %><%@ page import="java.util.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.node.*" %>
<%
Http http=new Http(request);
String nextUrl=http.get("nextUrl");
int cid=http.getInt("cid");
Ctf c=null;
int id=0;
if(cid!=0){
	c=Ctf.getCtf(cid);
	id=c.getId();
}
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
<h1>证书查询</h1>
<!-- onSubmit="return mt.checkform(this)" -->
<form  name="form1" action="/CtfSeivlet.do"   target="_ajax" method="post"> 
<input type="hidden" name="status" value="edit"/>
<input type="hidden" name="id" value="<%=id%>"/>
<input type="hidden" name="nextUrl" value="<%=nextUrl%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="">
   <script type="text/javascript">
    mt.re=function(cc){
	form1.photo.value=document.getElementById("ccc").src=cc;
   };

   </script>
    <td align="right" width="180" nowrap>姓名:</TD>
    <td nowrap><%=MT.f(c.getName()) %><span id="cname" style="color: red"></span></td>
    <td nowrap align="right">性别:</td>
    <td nowrap align="left"><%=c.getSex()==0?"男":"女"%>
    	</td>
    <td width="110" rowspan="5" align="center">
    <img id="ccc" src="<%=MT.f(c.getPhoto())==""?"../type/bbs/default_bbsphoto/index.jpg":MT.f(c.getPhoto()) %>" />
</td>
  </tr>
  <tr id="">
    <td nowrap align="right" >证件号码:</TD>
    <td nowrap><%=c.getCreNum() %><span id="ccreNum" style="color: red"></span></td>
    <td nowrap align="right" >证书编号:</TD>
    <td nowrap><%=c.getCreNumber() %><span id="ccreNumber" style="color: red"></span></td>
    </tr>
  <tr id="">
    <td nowrap align="right" >证书名称:</TD>
    <td nowrap><%=c.getCreName() %><span id="ccreName" style="color: red"></span></td>
    <td nowrap align="right" >证书级别:</TD>
    <td nowrap><%=c.getCreLv() %></td>
  </tr>
  <tr id="">
    <td nowrap align="right" ><%=c.getMarkName1() %></TD>
    <td nowrap><%=c.getMark1() %></td>
    <td nowrap align="right" ><%=c.getMarkName2() %></TD>
    <td nowrap><%=c.getMark2() %></td>
  </tr>
  <tr id="">
    <td nowrap align="right" ><%=c.getMarkName3() %></TD>
    <td nowrap><%=c.getMark3() %></td>
    <td nowrap align="right"><%=c.getMarkName4() %></td>
    <td nowrap><%=c.getMark4() %></td>
  </tr>
  <tr id="">
    <td nowrap align="right" ><%=c.getMarkName5() %></TD>
    <td nowrap><%=c.getMark5() %></td>
    <td nowrap align="right"><%=c.getMarkName6() %></td>
    <td colspan="2" nowrap><%=c.getMark6() %></td>
  </tr>
  <tr id="">
    <td nowrap align="right">数据上报单位:</TD>
    <td nowrap><%=c.getDanwei() %></td>
    <td nowrap align="right">评定成绩:</TD>
    <td colspan="2" nowrap><%=c.getGra() %></td>
    </tr>
  <tr id="">
    <td nowrap align="right" ><%=c.getOtherName() %></TD>
    <td nowrap><%=c.getOther() %></td>
    <td nowrap align="right">发证时间:</TD>
    <td colspan="2" nowrap>
		<%=MT.f(c.getTime()) %>
 	</td>
  </tr>
  
</table>

  
  <span id="submitshow">
  
  <input name="reset" value="返回" onClick="history.go(-1);" type="button">
</span>

</form>

</body>
</html>

