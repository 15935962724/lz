<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="java.util.*" %>
<%@page import="rath.msnm.entity.*" %>
<%@page import="rath.msnm.*" %>
<%@page import="tea.ui.*" %>
<%
request.setCharacterEncoding("UTF-8");
String community=request.getParameter("community");
String name=request.getParameter("name");

%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="refresh" content="10" />
</head>

<body>
<h1>客服列表</h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<%
Msntemp m=Msntemp.find(name);
Iterator iterator =m.msn.getBuddyGroup().getForwardList().iterator();
while(iterator.hasNext())
{
  MsnFriend friend = (MsnFriend) iterator.next();
  String s=friend.getLoginName();
  String f=friend.getFriendlyName();
  if (UserStatus.OFFLINE.equals(friend.getStatus()))
  {
    out.print("<tr><td>"+f+" [离线]");
  }else
  {
    out.print("<tr><td><a href=/jsp/msn/SendMsnMessage.jsp?name="+name+"&service="+s+"&community="+community+" target=msnsend >"+f+"</a> [在线]");
  }
}
%>
</table>
<a target=""></a>
<div id="head6"><img height="6" src="about:blank" alt=""></div><br>
</body>
</html>
