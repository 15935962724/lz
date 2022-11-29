<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int origin=h.getInt("origin");
ShopOrigin t=ShopOrigin.find(origin);


%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑</h1>

<form name="form1" action="/ShopOrigins.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="origin" value="<%=origin%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>英文标题</td>
    <td><input name="name0" value="<%=MT.f(t.name[0])%>"/></td>
  </tr>
  <tr>
    <td>中文标题</td>
    <td><input name="name1" value="<%=MT.f(t.name[1])%>" alt="中文标题"/></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>form1.name1.focus();</script>
</body>
</html>
