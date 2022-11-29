<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String key=h.get("lmspro");
int lmspro=key.length()<1?0:Integer.parseInt(MT.dec(key));
LmsPro t=LmsPro.find(lmspro);


%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>查看专业管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form2">

<table id="tablecenter" cellspacing="0" class='alignLeft'>
  <tr>
    <th>专业代码：</th>
    <td><%=MT.f(t.code)%></td>
  </tr>
  <tr>
    <th>专业名称：</th>
    <td><%=MT.f(t.name)%></td>
  </tr>
  <tr>
    <th>描述：</th>
    <td><%=MT.f(t.content).replaceAll("\r\n","<br/>")%></td>
  </tr>
  <tr>
    <th>毕业学分：</th>
    <td><%=MT.f(t.credit)%></td>
  </tr>
</table>

<br/>
<input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
