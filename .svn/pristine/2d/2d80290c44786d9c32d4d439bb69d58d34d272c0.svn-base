<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.sub.*"%><%@page import="tea.entity.stat.*"%>
<%@page import="tea.ui.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

Profile p=null;

String key=h.get("member");
int member=key.length()<1?0:Integer.parseInt(MT.dec(key));
if(member>0)p=Profile.find(member);

String username=h.get("username");
if(username!=null)p=Profile.find(username);




%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>会员详细信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<table id="tablecenter" cellspacing="0">
<tr>
  <td>用户名：</td>
  <td><%=p.getMember()%></td>
</tr>
<tr>
  <td>姓名：</td>
  <td><%=p.getName(h.language)%></td>
</tr>
<tr>
  <td>性别：</td>
  <td><%=p.isSex()?"男":"女"%></td>
</tr>
<tr>
  <td>手机号：</td>
  <td><%=p.getMobile()%></td>
</tr>
<tr>
  <td>电话：</td>
  <td><%=p.getTelephone(h.language)%></td>
</tr>
<tr>
  <td>电子邮箱：</td>
  <td><a href="mailto:<%=p.getEmail()%>"><%=p.getEmail()%></a></td>
</tr>
</table>

<h2>登录相关</h2>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>注册时间：</td>
  <td><%=MT.f(p.getTime(),1)%></td>
</tr>
<tr>
  <td>上次登录时间：</td>
  <td><%=MT.f(p.ltime[0],1)%></td>
</tr>
<tr>
  <td>登录IP：</td>
  <td>
  <%
  String tmp=MT.f(p.lip[0]);
  if(tmp.length()>0)
  {
    out.print(tmp+"　"+Ip.findByIp(tmp));
  }
  %></td>
</tr>
<tr>
  <td>登录次数：</td>
  <td><%=p.getLogint()%></td>
</tr>
</table>
<input type="button" value="返回" onclick="history.back()"/>


</body>
</html>
