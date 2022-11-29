<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.io.*"%><%@ page import="tea.ui.TeaServlet"%><%@ page import="tea.ui.TeaSession"%>
<%
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
 return;
}
%>
<FRAMESET ROWS="80%,*" FRAMEBORDER=YES>
	<FRAME name=frChatRoom SRC="/jsp/type/chat/ChatRoom.jsp?node=<%=teasession._nNode%>" SCROLLING=YES RESIZE>
	<FRAME name=frSendChat SRC="/servlet/SendChat?node=<%=teasession._nNode%>" SCROLLING=AUTO RESIZE> </FRAMESET>
</FRAMESET>

 