<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String key=h.get("lmschapter");
LmsChapter t=LmsChapter.find(key.length()<1?0:Integer.parseInt(MT.dec(key)));

String ckey=h.get("lmscourse");
if(t.lmschapter<1)
{
  t.lmscourse=Integer.parseInt(MT.dec(ckey));
}


%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1><%=t.lmschapter<1?"添加":"编辑"%>章节信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/LmsChapters.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmschapter" value="<%=key%>"/>
<input type="hidden" name="lmscourse" value="<%=ckey%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <th>课程：</th>
    <td><%=LmsCourse.find(t.lmscourse).name%></td>
  </tr>
  <tr>
    <th><em>*</em>标题：</th>
    <td><input name="name" value="<%=MT.f(t.name)%>" alt="标题"/></td>
  </tr>
  <tr>
    <th>描述：</th>
    <td><textarea name="content" cols="50" rows="5"><%=MT.f(t.content)%></textarea></td>
  </tr>
  <tr>
    <th>在线观看：</th>
    <td><input name="vurl" value="<%=MT.f(t.vurl)%>" size="40"/> <span class="info">优酷的视频网址</span></td>
  </tr>
  <tr>
    <th>网络下载：</th>
    <td><input name="durl" value="<%=MT.f(t.durl)%>" size="40"/> <span class="info">百度网盘的视频下载网址</span></td>
  </tr>
<!--
  <tr>
    <th>顺序：</th>
    <td><input name="sequence" value="<%=MT.f(t.sequence)%>"/></td>
  </tr>
-->
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
