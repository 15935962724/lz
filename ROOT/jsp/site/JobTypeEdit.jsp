<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.site.*"%><%

Http h=new Http(request,response);

int jobtype=h.getInt("jobtype");
JobType t=JobType.find(jobtype);

if("POST".equals(request.getMethod()))
{
  String act=h.get("act");
  String nexturl=h.get("nexturl");
  if("del".equals(act))
  {
    t.delete();
  }else if("edit".equals(act))
  {
    t.name=h.get("name");
    t.state=h.getInt("state");
    t.sequence=h.getInt("sequence");
    t.time=h.getDate("time");
    t.set();
  }
  out.print("<script>parent.mt.show('数据操作成功！',1,'"+nexturl+"');</script>");
  return;
}

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="jobtype" value="<%=jobtype%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>名称</td>
    <td><input name="name" value="<%=MT.f(t.name)%>"/></td>
  </tr>
  <tr>
    <td>状态</td>
    <td><%=h.radios(JobType.STATE_TYPE,"state",t.state)%></td>
  </tr>
  <tr>
    <td>顺序</td>
    <td><input name="sequence" value="<%=MT.f(t.sequence)%>"/></td>
  </tr>
  <tr>
    <td>时间</td>
    <td><%=h.selects("time",t.time)%></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
