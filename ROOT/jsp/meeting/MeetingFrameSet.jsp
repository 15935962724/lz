<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<html>
<FRAMESET ROWS=*,150 BORDER=1 FRAMEBORDER=YES>
	<FRAME name=frMeeting SRC="/servlet/Meeting" SCROLLING=YES RESIZE>
	<FRAME SRC="/servlet/SendToMeeting?To=<%=request.getParameter("To")%>" SCROLLING=YES RESIZE>
</FRAMESET>
</html>








