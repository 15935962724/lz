<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}


String nexturl=h.get("nexturl");
LmsPlan lp=LmsPlan.getInstance();

%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/lms/lms.js" type="text/javascript"></script>
<style>
.info{color:#999999}
</style>
</head>
<body>
<h1>导入学员报考</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
</form>

<form name="form2" action="/LmsMemberCourses.do?repository=imp/<%=h.member%>" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)&&mt.show(null,0)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="lmsplan" value="<%=lp.lmsplan%>"/>
<input type="hidden" name="act" value="imp"/>
<input type="hidden" name="path"/>
<input type="hidden" name="ignore" title="考试通过是否重复报考"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <th>考试计划:</th>
    <td><%=lp.name%></td>
  </tr>
  <tr>
    <th><em>*</em>文件:</th>
    <td><input type="file" name="file" onchange="form2.path.value='';" alt="文件" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"/>
        <a href="/Utils.do?act=down&url=/res/lms/template/14080129.xls">下载模板</a></td>
  </tr>
  <tr>
    <th>重复:</th>
    <td><%=h.radios(Lms.IMPORT_TYPE,"type",0)%></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交" onclick="form2.ignore.value=false;"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>
var arr=form2.type;
for(var i=0;i<arr.length;i++)
{
  arr[i].setAttribute("alt","重复");
}
</script>
</body>
</html>
