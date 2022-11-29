<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.entity.util.*"%><%

Http h=new Http(request,response);


h.node=Node.find(h.node).getFather();

Outside t=Outside.find(h.node,h.language);


%>


<table id="tablecenter" cellspacing="0">
  <tr>
    <td align="right">城市：</td>
    <td><%=Card.find(t.city).toString()%></td>
  </tr>
  <tr>
    <td align="right">详细地址：</td>
    <td><%=MT.f(t.address)%></td>
  </tr>
  <tr>
    <td align="right">网址：</td>
    <td><%=MT.f(t.website)%></td>
  </tr>
  <tr>
    <td align="right">电话：</td>
    <td><%=MT.f(t.tel)%></td>
  </tr>
  <tr>
    <td align="right">QQ：</td>
    <td><%=MT.f(t.qq)%></td>
  </tr>
  <tr>
    <td align="right">乘车路线：</td>
    <td><%=MT.f(t.bus)%></td>
  </tr>
<%
if(MT.f(t.map).length()>0)
{
  out.print("<tr><td colspan='2'><iframe src='/jsp/admin/map/ViewGMap.jsp?node="+MT.f(h.node)+"&point="+t.map+"' frameborder='0' scrolling='no' width='600' height='500'></iframe></td></tr>");
}
%>
</table>
