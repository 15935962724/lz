<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.pm.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int newsline=h.getInt("newsline");
Newsline t=Newsline.find(newsline);


%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>实时新闻 <%=newsline<1?"添加":"编辑"%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/Newslines.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="newsline" value="<%=newsline%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>分类</td>
    <td><select name="type" alt="分类"><%=h.options(Newsline.NEWSLINE_TYPE,t.type)%></select></td>
  </tr>
  <tr>
    <td>内容</td>
    <td><textarea name="content" cols="60" rows="6" alt="内容"><%=MT.f(t.content)%></textarea></td>
  </tr>
  <tr>
    <td>图片</td>
    <td><input name="picture" type="file"/>
    <%
    if(t.attch>0)out.print("<a href="+Attch.find(t.attch).path+">查看</a>");
    %>
    </td>
  </tr>
  <tr>
    <td>网址</td>
    <td><input name="url" value="<%=MT.f(t.url)%>" size="40"/></td>
  </tr>
  <tr>
    <td>时间</td>
    <td><%=new tea.htmlx.TimeSelection("time",t.time,true,true)%></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
