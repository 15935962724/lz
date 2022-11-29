<%@page contentType="text/html;charset=UTF-8" %><%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

%>
<html>
<head>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<FRAMESET border=0 frameSpacing=0 rows=* frameBorder=YES cols=200,*>
  <FRAME name=user_list src="/jsp/subscibe/SubscibeList.jsp?node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>" frameBorder="NO" noResize scrolling="yes">
  <FRAME name=send_subscibe src="/jsp/subscibe/JjSendSubscibe.jsp?node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>" noResize scrolling="yes">
</FRAMESET>
</html>

