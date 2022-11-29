<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.lms.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String key=h.get("lmscert");
int lmscert=key.length()<1?0:Integer.parseInt(MT.dec(key));
LmsCert t=LmsCert.find(lmscert);

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1><%=t.lmscert==0?"添加":"编辑"%>证书管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/LmsCerts.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmscert" value="<%=key%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0" class="alignLeft">
  <tr>
    <th><em>*</em>证书编号：</th>
    <td><input name="code" value="<%=MT.f(t.code)%>" alt="证书编号"/></td>
  </tr>
  <tr>
    <th><em>*</em>证书名称：</th>
    <td><input name="name" value="<%=MT.f(t.name)%>" alt="证书名称" size="30"/></td>
  </tr>
  <tr>
    <th>证书类型：</th>
    <td><select name="type"><%=h.options(LmsCert.LMSCERT_TYPE,t.type)%></select></td>
  </tr>
  <tr>
    <th>证书等级：</th>
    <td><select name="rank"><%=h.options(LmsCert.RANK_TYPE,t.rank)%></select></td>
  </tr>
  <tr>
    <th><em>*</em>申请费用：</th>
    <td><input name="price" value="<%=MT.f(t.price)%>" mask="float" alt="申请费用"/></td>
  </tr>
  <tr>
    <th>证书描述：</th>
    <td><textarea name="content" cols="60" rows="6"><%=MT.f(t.content)%></textarea></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
