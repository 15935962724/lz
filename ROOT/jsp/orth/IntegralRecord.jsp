<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.node.*" %>

<%@page import="tea.entity.admin.orthonline.*" %>
<%@page import="tea.entity.integral.*" %>
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
int pos=0,size=30;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}
int count=IntegralRecord.count(member);

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
<h1> 我的积分记录</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id=tableonetr>
  <td>序号</td>
<%
out.print("<td>时间</td>");
out.print("<td>积分</td>");
out.print("<td>原因</td>");

out.print("</tr>");
Enumeration e=IntegralRecord.find(teasession._rv._strV,pos,size);
if(!e.hasMoreElements())
{
  out.println("<tr><td colspan=30 align=center>暂无记录");
}else
{
  boolean auditing=false;
  for(int x=pos+1;e.hasMoreElements();x++)
  {
    int rid=((Integer)e.nextElement()).intValue();
   
   IntegralRecord record=IntegralRecord.find(rid);
   
    out.print("<tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; ><td>"+x);
  
  out.print("<td id=NodeListsID>&nbsp;");
  out.print(record.getTime().toLocaleString());
  out.print("</td>");
  out.print("<td>&nbsp;");
  out.print(record.getIntegral());
  out.print("</td>");
  out.print("<td>&nbsp;");
  out.print(IntegralRecord.MODIFY_TYPE[record.getReason()]);
  out.print("</td>");
   out.print( "</tr>");
    
}
   
}
 out.println("<tr><td colspan='30' align='right'>"+new tea.htmlx.FPNL(teasession._nLanguage,"/jsp/orth/IntegralRecord.jsp?pos=",pos,count,size));
out.print("</td>");
   out.print( "</tr>");
out.print("</table>");
%>



</form>

<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
