<%@page contentType="text/html;charset=UTF-8"%><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.*" %><%@page import="java.util.*"%><%@page import="java.net.*"%><%@page import="tea.entity.site.*" %>
<%request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}


%>

<html>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">


<frameset  id="frame" cols="*,250"  frameborder="NO" border="0" framespacing="0" >
    <frame  name="RightFrame"   src="/jsp/type/venues/left_seat.jsp?node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>"  title="mainFrame" />
    <frame  name="MenuFrameyu" src="/jsp/type/venues/right_seat.jsp?node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>" scrolling="No" noresize="noresize" title="leftFrame" />
</frameset>
</html>


