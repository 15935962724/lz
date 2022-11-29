<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %><%@page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@ page import="tea.entity.cio.*" %><%@ page import="tea.ui.TeaSession" %>
<%
String type = request.getParameter("type");
String ciopart = request.getParameter("ciopart");
String nexturl = request.getParameter("nexturl");
int icp=-1;
if(ciopart != null){
  icp=Integer.parseInt(ciopart);
}
CioPart cp = CioPart.find(icp);
if(type.equals("bd"))
{
  cp.setBd(true);
}else
{
  cp.setVip(true);
}
response.sendRedirect(nexturl);

%>
