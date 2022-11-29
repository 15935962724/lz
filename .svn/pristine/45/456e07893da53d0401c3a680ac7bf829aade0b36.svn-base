<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{ 
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int id=0;
if(request.getParameter("id")!=null)
{
  id=Integer.parseInt(request.getParameter("id"));
}else
{
  id=AdminFunction.getRootId(teasession._strCommunity,teasession._nStatus);
}




%>
<html>
<head> 
<title>投稿管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<FRAMESET border=0 frameSpacing=0 rows=* frameBorder=YES cols=200,*>
  <FRAME name="function_funlist" src="/jsp/admin/ContributorsNodeTree2.jsp?node=<%=teasession._nNode %>&id=<%=id %>" frameBorder=NO noResize scrolling=yes>
  <FRAME name="function_fun" src="/jsp/general/ContributorsNodeLists2.jsp?node=<%=teasession._nNode %>" noResize scrolling=yes>
</FRAMESET>
</html> 



