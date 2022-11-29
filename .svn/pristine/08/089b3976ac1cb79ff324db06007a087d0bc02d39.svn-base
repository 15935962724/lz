<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%> 
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
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
String community=teasession._strCommunity;

int ids = 0;
if(teasession.getParameter("id")!=null)
{
	ids = Integer.parseInt(teasession.getParameter("id"));
}

if(ids>0){
	int id = Integer.parseInt(teasession.getParameter("id"));
	String sortname = teasession.getParameter("sortname");
	Sort obj = Sort.find(id);
	obj.set(sortname);
	response.sendRedirect("/jsp/admin/books/sort.jsp");
	return;
}
if(ids==0){
	String sortname = teasession.getParameter("sortname");
	Sort.create(community,teasession._rv,sortname);
	response.sendRedirect("/jsp/admin/books/sort.jsp");
	return;
}



%>





