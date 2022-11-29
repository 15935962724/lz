<%@page contentType="text/html;charset=UTF-8" %> <%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);

tea.entity.node.Node node=  tea.entity.node.Node.find(teasession._nNode);

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
<h1>公告栏</h1>
  <div id="head6"><img height="6" src="about:blank"></div>
   <%
   java.util.Enumeration enumer=   tea.entity.member.Callboard.find("",pos,1);
   while(enumer.hasMoreElements())
   {
     int id=((Integer)enumer.nextElement()).intValue();
     tea.entity.member.Callboard c=  tea.entity.member.Callboard.find(id);
     if(c.getSubject(teasession._nLanguage)!=null){
%>
<h2><%=c.getSubject(teasession._nLanguage)%></h2>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>发布者:<%=c.getMember()%>
<tr><td>发布日期:<%=c.getTimeToString()%>
<tr><td>
<%=c.getContent(teasession._nLanguage).replaceAll("\r\n","<br/>")%>
  <%
  }
    }
   %>
</td></tr></table>
<%=new tea.htmlx.FPNL(teasession._nLanguage, "/jsp/criterion/Callboards.jsp?community="+s+"&node=" + teasession._nNode + "&pos=", pos, tea.entity.member.Callboard.count(""),1)%>

<input type="button" value="添加" onclick="window.open('/jsp/profile/EditCallboard.jsp?community=<%=s%>&node=<%=teasession._nNode%>','_self');"/>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


