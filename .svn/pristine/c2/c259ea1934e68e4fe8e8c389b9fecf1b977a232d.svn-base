<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.net.*"%><%@ page import="java.util.*"%><%@ page import="java.text.*"%><%@ page import="java.security.*"%><%@ page import="com.capinfo.crypt.*"%><%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%><%@ page import="java.math.*"%><%@ page import="tea.entity.csvclub.alipay.*"%><%@ page import="tea.entity.csvclub.encrypt.*" %><%@ page import="tea.entity.admin.mov.*" %><%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.league.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.util.Calendar" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);

String nexturl=request.getParameter("nexturl");
int leagueshoptype=Integer.parseInt(request.getParameter("leagueshoptype"));
int leagueshopmsg=Integer.parseInt(request.getParameter("leagueshopmsg"));
String subject="",content="";
int state=0;
LeagueShopMsg lsm=LeagueShopMsg.find(leagueshopmsg);
if(lsm!=null)
{
  subject=lsm.getSubject();
  content=lsm.getContent();
  state=lsm.getState();
}
if("POST".equals(request.getMethod()))
{
  String act=request.getParameter("act");
  if("del".equals(act))
  {
    lsm.delete();
  }else
  {
    subject=request.getParameter("subject");
    content=request.getParameter("content");
    state=Integer.parseInt(request.getParameter("state"));
    if(leagueshopmsg<1)
    {
      LeagueShopMsg.create(leagueshoptype,subject,content,state);
    }else
    {
      lsm.set(subject,content,state);
    }
  }
  response.sendRedirect("/jsp/info/Succeed.jsp?community="+teasession._strCommunity+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
  return;
}
LeagueShopType obj=LeagueShopType.find(leagueshoptype);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
</head>

<body onload="form1.subject.focus();">
<h1>添加/编辑 <%=obj.getLstypename()%> 公告</h1>

<form name="form1" action="?" method="POST">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="leagueshoptype" value="<%=leagueshoptype%>"/>
<input type="hidden" name="leagueshopmsg" value="<%=leagueshopmsg%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>

<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
<tr>
  <td align="right">主题:</td>
  <td><input type="text" name="subject" value="<%=subject%>"></td>
</tr>
<tr>
  <td align="right">内容：</td>
  <td><textarea name="content" cols="50" rows="5"><%=content%></textarea></td>
</tr>
<tr>
  <td align="right">位置：</td>
  <td><input name="state" type="radio" value="0" checked="checked" />卡前台 <input name="state" type="radio" value="1" <%if(state==1)out.print(" checked='checked' ");%> />卡后台</td>
</tr>
</table>

<input type="submit" value="提交"/>
<input type="button" value="返回" onclick="history.back()"/>
</form>
</body>
</html>
