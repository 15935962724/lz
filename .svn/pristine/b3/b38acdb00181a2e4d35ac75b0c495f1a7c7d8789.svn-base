<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*"%>
<%
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
}

int strid=0;
String tmp=request.getParameter("MenuId");
if(tmp!=null)
{
  strid=Integer.parseInt(tmp);
}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN">
<html>
<head>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
</head>
<FRAMESET border=0 frameSpacing=0 rows=* frameBorder=YES cols=200,*>
  <FRAME name=user_list SRC="/jsp/admin/popedom/AreaTree.jsp?community=<%=teasession._strCommunity%>" frameBorder=NO noResize scrolling=yes>
  <FRAME name="right_area" SRC="about:blank" noResize scrolling=yes>
</FRAMESET>
</html>



