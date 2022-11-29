<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.Item" %><%@ page import="tea.entity.criterion.Egqb" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");


%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN">
<html>
<head>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
</head>
<FRAMESET  border=0 frameSpacing=0 rows=* frameBorder=YES cols=200,*>
  <FRAME name="producer_list" src="/jsp/producer/ProducerList.jsp?node=<%=teasession._nNode%>&community=<%=community%>&editproducer=ON" frameBorder=NO noResize scrolling=yes>
  <FRAME name="producer_edit" src="" noResize scrolling=yes>
</FRAMESET>
</html>

