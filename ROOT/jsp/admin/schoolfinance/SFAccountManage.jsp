<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.*" %>
<%
TeaSession teasession=new TeaSession(request);

%>
<html>
<head>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
</head>
<FRAMESET border=0 frameSpacing=0 rows=* frameBorder=YES cols=200,*>
  <FRAME name=user_list src="/jsp/admin/schoolfinance/SFAccountMenu.jsp?community=<%=teasession._strCommunity%>" frameBorder=NO noResize scrolling=yes>
  <FRAME name="t" src="/jsp/admin/schoolfinance/EditSFAccount.jsp?community=<%=teasession._strCommunity%>&id=0" noResize scrolling=yes>
</FRAMESET>
</html>



