<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="java.util.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.math.BigDecimal" %>
<%@page import="java.math.BigDecimal" %>
<%@page import="java.io.*" %>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
TeaSession teasession =new TeaSession(request);
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
if(teasession._rv==null)
{
  response.sendRedirect("/jsp/user/StartLogin.jsp?nexturl="+request.getRequestURI());
}
%>
<html>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
  <script> if(parent.lantk) { document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; } </script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Expires" CONTENT="0"/>
  <title>显示所有图片</title>
  <style>
  #table005{width:95%;margin-top:15px;}
  #table005 td{background:#eee;padding:6px;}
  </style>
</head>
<body style="margin:0;">
<div id="wai">
<div id="li_biao"><a href="http://bp.redcome.com" target="_top">首页</a>&nbsp;>&nbsp;管理中心&nbsp;>&nbsp;所有B-picture</div>
<H1>所有B-picture</H1>
<form action="">
</form>
<form action="">
<table border="0" cellpadding="0" cellspacing="2" id="table005">
<tr>
<td align="center">图片标题</td>
<td align="center">UCO</td>
<td align="center">销售</td>
<td align="center">放大</td>
<td align="center">点击次数</td>
<td align="center">点击率</td>
</tr>
<%
java.util.Enumeration ee = Baudit.findByCommunity(teasession._strCommunity," and passpage=1",0,10);
if(!ee.hasMoreElements())
{

}
for (int i=0;ee.hasMoreElements();i++)
{
  int nodes = Integer.parseInt(String.valueOf(ee.nextElement()));
  Baudit bt=Baudit.find(nodes);
  Picture picobj = Picture.find(nodes);
  Node nodeobj = Node.find(nodes);
    int num=Bimage.countAll(teasession._strCommunity," and picsalestype=1 and node="+nodes);
  %>
  <tr>
  <td align="center"><%=nodeobj.getSubject(teasession._nLanguage)%></td>
  <td align="center"></td>
  <td align="center"><%=num%></td>
  <td align="center"><%=bt.getZoom()%></td>
  <td align="center"><%=nodeobj.getClick()%></td>
   <td align="center">
  <%if(nodeobj.getClick()==0)
  {
    out.print("0.00");
  }
  else
  {

    out.println((new BigDecimal(bt.getZoom())).divide(new BigDecimal(nodeobj.getClick()),2,BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(100)));
  }

    %>%</td>
  </tr>
  <%
}
%>
</table>
</form>
</div>
</body>
</html>
</body>
</html>
