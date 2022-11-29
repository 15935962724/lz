<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.util.*" %>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.TeaSession" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

String act = teasession.getParameter("act");
if("counting".equals(act))
{
  Node nobj = Node.find(teasession._nNode);//Click
  nobj.click();
  System.out.println(nobj.getClick());
  return;
}
%>
