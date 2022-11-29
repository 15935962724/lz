<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.io.*"%>
<%@ page import="tea.ui.*"%>
<%
TeaSession teasession = new TeaSession(request);
String name=request.getParameter("name");
String service=request.getParameter("service");
%>
<html>
<FRAMESET cols="150,*"  BORDER="1" FRAMEBORDER="YES">
  <FRAME name="msnonline" SRC="/jsp/msn/MsnOnlinelist.jsp?name=<%=name%>&service=<%=service%>&community=<%=teasession._strCommunity%>" SCROLLING="YES" >
  <FRAMESET ROWS=*,150 BORDER="1" FRAMEBORDER="YES">
    <FRAME name="msnhistory" SRC="/jsp/msn/HistoryMsnMessage.jsp?name=<%=name%>&service=<%=service%>&community=<%=teasession._strCommunity%>" SCROLLING="YES" />
      <FRAME name="msnsend" SRC="/jsp/msn/SendMsnMessage.jsp?name=<%=name%>&service=<%=service%>&community=<%=teasession._strCommunity%>" SCROLLING="AUTO"  />
  </FRAMESET>
</FRAMESET>
</html>

