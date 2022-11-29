<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int father=h.getInt("father");

String key=h.get("lmsplan");
int lmsplan=key.length()<1?0:Integer.parseInt(MT.dec(key));
LmsPlan t=LmsPlan.find(lmsplan<1?father:lmsplan);


%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
<style>
.date{width:130px}
</style>
</head>
<body>
<h1><%=t.lmsplan<1?"添加":"编辑"%>考试计划</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/LmsPlans.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmsplan" value="<%=key%>"/>
<input type="hidden" name="father" value="<%=father%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<!--
省份：<span class="info">注：如查未选省份则默认为全国统一报考时间，如果某省的报名时间特殊，需单独对该省进行报考时间设置。</span>
-->
<table id="tablecenter" cellspacing="0" class="alignLeft">
<%
if(father<1&&t.father<1)
{
%>
  <tr>
    <th><em>*</em>标题名称</th>
    <td><input name="name" value="<%=MT.f(t.name)%>" alt="标题名称"/></td>
    <th></th>
    <td></td>
  </tr>
<%
}else
{
%>
  <tr>
    <th><em>*</em>省份</th>
    <td><script>mt.city("city",null,null,"<%=t.city%>");form1.city.setAttribute('alt','省份');</script></td>
    <th></th>
    <td></td>
  </tr>
<%
}
%>
  <tr>
    <th>机考报考开始时间</th>
    <td><input name="starttime" value="<%=MT.f(t.starttime,1)%>" onclick="mt.date(this,true)" readonly="readonly" class="date"/></td>
    <th>机考报考结束时间</th>
    <td><input name="endtime" value="<%=MT.f(t.endtime,1)%>" onclick="mt.date(this,true)" readonly="readonly" class="date"/></td>
  </tr>
  <tr>
    <th>实践环节报考开始时间</th>
    <td><input name="pstarttime" value="<%=MT.f(t.pstarttime,1)%>" onclick="mt.date(this,true)" readonly="readonly" class="date"/></td>
    <th>实践环节报考结束时间</th>
    <td><input name="pendtime" value="<%=MT.f(t.pendtime,1)%>" onclick="mt.date(this,true)" readonly="readonly" class="date"/></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>
mt.focus();
</script>
</body>
</html>
