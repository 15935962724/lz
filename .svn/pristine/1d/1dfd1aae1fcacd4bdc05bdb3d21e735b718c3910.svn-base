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
<h1><%=t.lmspro==0?"添加":"编辑"%>专业管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form2" action="/LmsPros.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmspro" value="<%=key%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0" class='alignLeft'>
  <tr>
    <th><em>*</em>专业代码：</th>
    <td><input name="code" value="<%=MT.f(t.code)%>" alt="代码" /></td>
  </tr>
  <tr>
    <th><em>*</em>专业名称：</th>
    <td><input name="name" value="<%=MT.f(t.name)%>" alt="名称" size="30"/></td>
  </tr>
  <tr>
    <th>描述：</th>
    <td><textarea name="content" cols="50" rows="5"><%=MT.f(t.content)%></textarea></td>
  </tr>
  <tr>
    <th><em>*</em>毕业学分：</th>
    <td><input name="credit" value="<%=MT.f(t.credit)%>" alt="学分" mask="float"/></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
