<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);


Node n=Node.find(h.node);
if(n.getType()!=100)
{
  String[] arr=n.getPath().split("/");
  h.node=Integer.parseInt(arr[arr.length-(n.getType()<2?2:3)]);
  n=Node.find(h.node);
}
Outside t=Outside.find(h.node,h.language);
%>
<div class="nameOfOrg"><a href="/html/outside/<%=h.node%>-1.htm"><%=MT.f(n.getSubject(h.language))%></a></div>
<div class="listOrg">
<div class="list">
<ul>
<%
Enumeration e=Node.find(" AND father="+h.node+" ORDER BY node",0,4);
while(e.hasMoreElements())
{
  int node=((Integer)e.nextElement()).intValue();
  Node ns=Node.find(node);
  out.print("<li>"+ns.getAnchor(h.language)+"</li>");
}
%>
</ul></div>
<div class="right"></div>
</div>

