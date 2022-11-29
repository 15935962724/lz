<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
String right=request.getParameter("right");
if(right==null)
{
  right="/jsp/criterion/dept_user.jsp";
}
%>
<html>
<head>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
  <link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<FRAMESET border=0 frameSpacing=0 rows=* frameBorder=YES cols=200,*>
  <FRAME name=user_list src="/jsp/criterion/user_list.jsp?node=<%=teasession._nNode%>&right=<%=right%>" frameBorder="NO" noResize scrolling="yes">
  <FRAME name=dept_user src="<%=right%>?node=<%=teasession._nNode%>&UnitId=0" noResize scrolling="yes">
</FRAMESET>
</html>

