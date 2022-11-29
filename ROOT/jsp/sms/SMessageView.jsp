<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);

TeaSession ts=new TeaSession(request);
if(ts._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + h.node+"&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString()));
  return;
}




int smessage=h.getInt("smessage");
SMessage t=SMessage.find(smessage);

String[] mobiles=t.mobile.split("[|]");
String[] states=t.state.split("[|]");

%><html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>查看——短信发送</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>详细</h2>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>发送人：</td><td><%=Profile.find(t.member).getMember()%></td>
</tr>
<tr>
  <td>接收人：</td><td><%=t.getToName(true)%></td>
</tr>
<tr>
  <td>发送时间：</td><td><%=MT.f(t.time,1)%></td>
</tr>
<tr>
  <td colspan="2"><%=MT.f(t.content)%></td>
</tr>
</table>

<h2>状态</h2>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>手机号</td>
  <td>状态</td>
</tr>
<%
for(int i=1;i<mobiles.length;i++)
{
  out.print("<tr><td>"+mobiles[i]);
  out.print("<td>"+SMessage.get(Integer.parseInt(states[i])));
}
%>
</table>

<input class="but" type="button" value="返回" onclick="history.back();"/>

</body>
</html>
