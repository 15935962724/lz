<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.member.*" %>
<%@include file="/jsp/Header.jsp"%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="refresh" content="60">
</head>

<body>
<h1><%=r.getString(teasession._nLanguage, "在线会员")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td scope="col">姓名</TD>
    <td scope="col">呼叫</TD>
    <td scope="col">E-Mail</TD>
  </tr>
  <%
java.util.Enumeration enumer=OnlineList.findByCommunity(teasession._strCommunity,"");int count=0;
while(enumer.hasMoreElements())
{
  count++;
  String member=(String)enumer.nextElement();
  Profile profile=Profile.find(member);
  OnlineList online=OnlineList.find(member);
%>
<tr>
  <td><%=profile.getFirstName(teasession._nLanguage)%> <%=profile.getLastName(teasession._nLanguage)%></td>
  <td><A href="/servlet/Call?Receiver=<%=member%>" TARGET="_blank"><img SRC="/tea/image/Call.gif"></A></td>
  <td><a href="/jsp/message/NewMessage.jsp?URI=/servlet/NewMessage"><%=profile.getEmail()%></A></td>
</tr>
<%}%>在线人数:<%=count%>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

