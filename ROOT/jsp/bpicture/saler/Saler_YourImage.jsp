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
<%@page import="tea.db.*" %>
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
</head>
<body>
<form action="">
</form>
<form action="">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>图片标题</td><td>UCO</td><td>销售</td><td>放大</td><td>点击次数</td><td>点击率</td><td>&nbsp;</td>
</tr>
<%
java.util.Enumeration ee = Baudit.findByCommunity(teasession._strCommunity," and passpage=1 and member="+DbAdapter.cite(teasession._rv.toString()),0,10);
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
  <td><%=nodeobj.getSubject(teasession._nLanguage)%></td>
  <td>&nbsp;</td>
  <td><%=num%></td>
  <td><%=bt.getZoom()%></td>
  <td><%=nodeobj.getClick()%></td>
  <td>
  <%if(nodeobj.getClick()==0)
  {
    out.print("0.00");
  }
  else
  {
    out.println((new BigDecimal(bt.getZoom())).divide(new BigDecimal(nodeobj.getClick()),2,BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(100)));
  }

    %>%</td>
    <td><a href="/jsp/bpicture/saler/EditPicture_copy.jsp?node=<%=nodes%>">编辑</a></td>
  </tr>
  <%
}
%>
</table>
</form>
</body>
</html>

