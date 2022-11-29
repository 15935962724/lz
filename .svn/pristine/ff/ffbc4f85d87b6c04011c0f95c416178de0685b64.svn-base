<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.net.*"%><%@ page import="java.util.*"%><%@ page import="java.text.*"%><%@ page import="java.security.*"%><%@ page import="com.capinfo.crypt.*"%><%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%><%@ page import="java.math.*"%><%@ page import="tea.entity.csvclub.alipay.*"%><%@ page import="tea.entity.csvclub.encrypt.*" %><%@ page import="tea.entity.admin.mov.*" %><%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.league.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.util.Calendar" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);

int leagueshoptype=Integer.parseInt(request.getParameter("leagueshoptype"));
LeagueShopType obj=LeagueShopType.find(leagueshoptype);
String bgstyle=obj.getBgStyle(),fgstyle=obj.getFgStyle();
if("POST".equals(request.getMethod()))
{
  bgstyle=request.getParameter("bgstyle");
  fgstyle=request.getParameter("fgstyle");
  obj.set(bgstyle,fgstyle);
  response.sendRedirect("/jsp/info/Succeed.jsp?community="+teasession._strCommunity);
  return;
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
</head>

<body>

<form action="?" method="POST">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="leagueshoptype" value="<%=leagueshoptype%>"/>
<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
<tr>
  <td height="30" nowrap="nowrap" align="right">卡管理样式:</td>
  <td><textarea name="bgstyle" cols="50" rows="5"><%if(bgstyle!=null)out.print(bgstyle.replaceAll("<","&lt;"));%></textarea></td>
</tr>
<tr>
  <td height="30" nowrap="nowrap" align="right">卡前台样式：</td>
  <td><textarea name="fgstyle" cols="50" rows="5"><%if(fgstyle!=null)out.print(fgstyle.replaceAll("<","&lt;"));%></textarea></td>
</tr>
</table>
<input type="submit" value="提交"/>
<input type="button" value="返回" onclick="history.back()"/>
</form>
</body>
</html>
