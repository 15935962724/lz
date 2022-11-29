<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.weibo.*"%><%

Http h=new Http(request,response);
TeaSession ts = new TeaSession(request);
if (ts._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + h.node);
  return;
}

int wmobile=h.getInt("wmobile");
WMobile t=WMobile.find(wmobile);


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>查看——客户端信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="wmobile" value="<%=wmobile%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>制造商</td>
    <td><%=MT.f(t.manufacturer)%></td>
  </tr>
  <tr>
    <td>型号</td>
    <td><%=MT.f(t.product)%></td>
  </tr>
  <tr>
    <td>固件版本</td>
    <td><%=MT.f(t.version)%></td>
  </tr>
  <tr>
    <td>设备ID</td>
    <td><%=MT.f(t.deviceid)%></td>
  </tr>
  <tr>
    <td>手机号</td>
    <td><%=MT.f(t.number)%></td>
  </tr>
  <tr>
    <td>分辨率</td>
    <td><%=MT.f(t.display)%></td>
  </tr>
  <tr>
    <td>IP地址</td>
    <td><%=MT.f(t.ip)%></td>
  </tr>
  <tr>
    <td>城市/地区</td>
    <td><%=MT.f(t.city)%></td>
  </tr>
  <tr>
    <td>时间</td>
    <td><%=MT.f(t.time,1)%></td>
  </tr>
</table>

<br/>
<input type="button" value="返回" onclick="history.back();"/>
</form>

<script>
</script>
</body>
</html>
