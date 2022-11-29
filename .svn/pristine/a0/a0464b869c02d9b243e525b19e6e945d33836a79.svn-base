<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="java.net.*" %>
<%@page import="tea.entity.node.*" %>
<%
  request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/Node?node=14856&language=1");
  return;
}
String member = teasession._rv.toString();
int destine = Integer.parseInt(teasession.getParameter("destine"));
Destine obj = new Destine(destine);
if(destine!=0)
{
   obj.delete();
//   response.sendRedirect("/jsp/registration/myorders.jsp?member="+URLEncoder.encode(member,"UTF-8"));
response.sendRedirect(teasession.getParameter("nexturl"));
}
else
{
  response.sendRedirect("/jsp/info/Succeed.jsp?info="+"您的订单号错误!");
}
%>
