<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.ui.*"%>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

String nexturl=request.getParameter("nexturl");

Calendar ca=Calendar.getInstance();
ca.add(Calendar.YEAR,1);
Date time=ca.getTime();

Node n=Node.find(teasession._nNode);
if("POST".equals(request.getMethod()))
{
  Date stop=Community.sdf.parse(teasession.getParameter("timeYear")+"-"+teasession.getParameter("timeMonth")+"-"+teasession.getParameter("timeDay"));
  String domain=request.getParameter("domain");
  //
  Community c=Community.find(teasession._strCommunity);
  c.setStopTime(stop);
  //
  //DNS.find(domain).set("/jsp/type/company/windows/?community="+com,root);
  //
  response.sendRedirect(nexturl);
  return;
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body onload="form1.domain.focus();">
<h1><%=r.getString(teasession._nLanguage, "未开通第一站的企业")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="POST" onsubmit="">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
  <input type="hidden" name="nexturl" value="<%=nexturl%>">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>有效期:</td>
      <td><%=new tea.htmlx.TimeSelection("time",time)%></td>
    <tr>
      <td>域名:</td>
      <td><input name="domain" type="text" size="40"></td>
    <tr>
      <td>金额:</td>
      <td><input type="text" name="charges"></td>
    <tr>
      <td></td>
      <td>
        <input type="submit" value="提交">
        <input type="button" value="返回" onClick="history.back()">
      </td>
    </tr>
  </table>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
