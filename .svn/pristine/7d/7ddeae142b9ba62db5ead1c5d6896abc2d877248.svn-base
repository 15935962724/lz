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
<ul>
<li>网址：<%=MT.f(t.website)%></li>
<li>电话：<%=MT.f(t.tel)%></li>
<li>QQ：<%=MT.f(t.qq)%></li>
<li>乘车路线：<%=MT.f(t.bus)%></li>
<li>详细地址：<%=MT.f(t.address)%></li>
</ul>
