<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community = teasession.getParameter("community");
String nexturl =null;
 int membertype = 0;
 if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0)
 {
    membertype = Integer.parseInt(teasession.getParameter("membertype"));
 }

 MemberType myobj = MemberType.find(membertype);
 RegisterInstall riobj = RegisterInstall.find(membertype);


%>



