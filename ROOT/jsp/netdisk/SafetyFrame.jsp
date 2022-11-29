<%@page contentType="text/html;charset=utf-8" %><%@page import="tea.ui.*" %><%request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}

%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<frameset cols="200,*" frameborder="NO" border="0" framespacing="0">
  <frame src="/jsp/netdisk/NetDiskTree3.jsp?community=<%=teasession._strCommunity%>" name="leftFrame" scrolling="no" style=" border-right:solid thin #CCCCCC">
  <frame src="/jsp/netdisk/Safetys.jsp?community=<%=teasession._strCommunity%>&path=/" name="NetDiskMainFrame">
</frameset>
</html>
