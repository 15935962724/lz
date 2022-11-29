<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);

Node node=Node.find(teasession._nNode);

String s = request.getParameter("community");
if(s==null)
{
  s=node.getCommunity();
}
//tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Callboard");
String member=node.getCreator()._strV;

int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
%>
<html>
<head>
<link href="/res/<%=s%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body >
   <%
   java.util.Enumeration enumer=   Callboard.find(" AND member="+DbAdapter.cite(member),pos,1);
   while(enumer.hasMoreElements())
   {
     int id=((Integer)enumer.nextElement()).intValue();
     Callboard c=  Callboard.find(id);
%>
<h1 align="center"><%=c.getSubject(teasession._nLanguage)%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>
<%=c.getContent(teasession._nLanguage)%><br>
<%=c.getTimeToString()%><br>
  <%   }
   %>
<%=new tea.htmlx.FPNL(teasession._nLanguage, "/jsp/profile/Callboards.jsp?community="+s+"&node=" + teasession._nNode + "&pos=", pos, Callboard.count(" AND member="+DbAdapter.cite(member)),1)%>
</td></tr></table>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

