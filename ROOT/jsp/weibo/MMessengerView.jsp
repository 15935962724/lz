<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.weibo.*"%><%

Http h=new Http(request,response);

int mmessenger=h.getInt("mmessenger");
MMessenger t=MMessenger.find(mmessenger);


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>查看——微信消息</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="mmessenger" value="<%=mmessenger%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>类型</td>
    <td><%=MMessenger.MMESSENGER_TYPE[t.type]%></td>
  </tr>
  <tr>
    <td>发送方</td>
    <td><%=MT.f(t.fusername)%></td>
  </tr>
  <tr>
    <td>接收方</td>
    <td><%=MT.f(t.tusername)%></td>
  </tr>
  <tr>
    <td>内容</td>
    <td><%=MT.f(t.content)%></td>
  </tr>
  <tr>
    <td>地理位置纬度</td>
    <td><%=t.x%></td>
  </tr>
  <tr>
    <td>地理位置经度</td>
    <td><%=t.y%></td>
  </tr>
  <tr>
    <td>地图缩放大小</td>
    <td><%=t.scale%></td>
  </tr>
  <tr>
    <td>发送时间</td>
    <td><%=MT.f(t.time,1)%></td>
  </tr>
</table>

<br/>
<input type="button" value="返回" onclick="history.back();"/>
</form>

<script></script>
</body>
</html>
