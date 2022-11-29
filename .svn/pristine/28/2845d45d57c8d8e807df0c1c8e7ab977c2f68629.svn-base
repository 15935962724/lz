<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.node.*" %>

<%@page import="tea.entity.admin.orthonline.*" %>

<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>

<%@page import="java.net.*" %>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r=new Resource("/tea/resource/AdminList");
r.add("/tea/resource/Report");




Node n=Node.find(teasession._nNode);
String path=n.getPath();
if(path==null)
{
  response.setStatus(404);
  return;
}

String member=teasession._rv._strV;




boolean me=true;
StringBuffer sql=new StringBuffer();
  sql.append(" AND vmember=").append(DbAdapter.cite(member));
  sql.append(" AND community=").append(DbAdapter.cite(teasession._strCommunity));
  sql.append(" AND log='down'");
int count=Logs.readcount(sql.toString());

%>
<!--
参数说明:
me: true|false 选填
type:  有:此类型的所有节点(包括孙子节点),无:列出所有子节点
-->
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>


</head>
<body>
<h1> 我最近下载过的资料</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id=tableonetr>
  <td>序号&nbsp;</td>
<%
out.print("<td>标题&nbsp; </td>");
out.print("<td>日期&nbsp;</td>");
out.print("</tr>");

Enumeration e=Logs.read(sql.toString());
if(!e.hasMoreElements())
{
  out.println("<tr><td colspan=30 align=center>暂无记录");
}else
{
  boolean auditing=false;
  for(int x=1;e.hasMoreElements();x++)
  {
    int nodeid=((Integer)e.nextElement()).intValue();
    System.out.println(nodeid);
    Node nobj=Node.find(nodeid);
   
    out.print("<tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; ><td>"+x);
  
  out.print("</td><td id=NodeListsID>&nbsp;");
  out.print(nobj.getAnchor(teasession._nLanguage));
  out.print("</td><td>&nbsp;");

  out.print(nobj.getTimeToString());
   
    out.print("</td></tr>");
    
}
   out.println(" ");
}
out.print("</table>");
%>



</form>

<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
