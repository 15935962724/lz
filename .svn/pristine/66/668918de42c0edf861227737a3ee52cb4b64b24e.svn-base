<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.weixin.*"%><%

Http h=new Http(request,response);

int wxredgrab=h.getInt("wxredgrab");
WxRedGrab t=WxRedGrab.find(wxredgrab);

if("POST".equals(request.getMethod()))
{
  String act=h.get("act");
  String nexturl=h.get("nexturl");
  if("del".equals(act))
  {
    t.delete();
  }else if("edit".equals(act))
  {
    t.wxuser=h.getInt("wxuser");
    t.wxred=h.getInt("wxred");
    t.money=h.getFloat("money");
    t.time=h.getDate("time");
    t.set();
  }
  out.print("<script>parent.mt.show('数据操作成功！',1,'"+nexturl+"');</script>");
  return;
}

%>
<!DOCTYPE html>
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
<input type="hidden" name="wxredgrab" value="<%=wxredgrab%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>用户</td>
    <td><input name="wxuser" value="<%=MT.f(t.wxuser)%>"/></td>
  </tr>
  <tr>
    <td>红包</td>
    <td><input name="wxred" value="<%=MT.f(t.wxred)%>"/></td>
  </tr>
  <tr>
    <td>金额</td>
    <td><input name="money" value="<%=MT.f(t.money)%>"/></td>
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
