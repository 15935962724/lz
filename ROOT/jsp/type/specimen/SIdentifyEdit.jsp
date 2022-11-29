<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

int identify=h.getInt("identify");
SIdentify t=SIdentify.find(identify);
if(identify<1)
{
  t.node=h.getInt("node");
}

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑——鉴定</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/Specimens.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="identify" value="<%=identify%>"/>
<input type="hidden" name="node" value="<%=t.node%>"/>
<input type="hidden" name="act" value="iedit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">标本：</td>
    <td><%=Node.find(t.node).getAnchor(h.language)%></td>
  </tr>
  <tr>
    <td class="th">鉴定人：</td>
    <td><input name="iperson" value="<%=MT.f(t.iperson)%>"/></td>
  </tr>
  <tr>
    <td class="th">鉴定时间：</td>
    <td><%=h.selects("iyear",t.iyear)%></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
