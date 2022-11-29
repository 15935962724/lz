<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms"/>
<%
  request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
  Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
  String vertify = sms.password();
  Community community = Community.find(teasession._strCommunity);

  String nexturl = request.getParameter("nexturl");
  int destine = 0;
  if(request.getParameter("destine")!=null && request.getParameter("destine").length()>0)
     destine = Integer.parseInt(request.getParameter("destine"));
  Destine d = Destine.find(destine);
 // Node n = Node.find(d.getNode());
  //Profile p = Profile.find(d.getMember());
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="bodynone">
<div id="jspbefore" style="display:none"><%=community.getJspBefore(teasession._nLanguage)%></div>
<div id="tablebgnone" class="register">
  <h1>订单审批意见</h1>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td><%=d.getIdea() %></td>
</tr>
</table>
<input type="button" value="关闭"  onClick="javascript:window.close();">
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
</html>
