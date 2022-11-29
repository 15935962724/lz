<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.node.*"%>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
if(teasession._rv._strR==null)
{
response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
return;
}
int node = Integer.parseInt(request.getParameter("node"));
int language = Integer.parseInt( teasession.getParameter("language"));
String nexturl = teasession.getParameter("nexturl");
String father = teasession.getParameter("fnode");
try{
Node no = Node.find(node);
no.delete(teasession._nLanguage);
new Hostel(node).delete();
}catch(Exception ex)
{
System.out.println(ex.toString());
}
response.sendRedirect(nexturl+"?father="+nexturl);
%>
