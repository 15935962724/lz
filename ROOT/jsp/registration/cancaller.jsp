<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="tea.ui.TeaSession" %><!--导入Teasession的包-->
<%@ page import="tea.entity.site.*" %><!--导入Community的包-->
<%@page import="tea.entity.node.*" %><!--导入node的包-->
<%@page import="tea.resource.*" %>
<%@page import="tea.db.*" %>
<%@ page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
DbAdapter db = new DbAdapter();

if(teasession._rv==null)
{
  response.sendRedirect("/servlet/Node?node=14856&language=1");
  return ;
}
String member = teasession.getParameter("member");

tea.entity.node.Caller.uptype(member);
response.sendRedirect("/jsp/registration/callertype.jsp");
%>
