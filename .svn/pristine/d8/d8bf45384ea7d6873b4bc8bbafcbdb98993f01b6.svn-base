<%@page contentType="text/html;charset=utf-8" %><%@page import="tea.ui.*" %><%@page import="tea.entity.netdisk.*"%><%request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}

int root=FileCenter.getRootId(teasession._strCommunity);
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<frameset cols="200,*" frameborder="NO" border="0" framespacing="0">
  <frame src="/jsp/netdisk/FileCenterTree.jsp?community=<%=teasession._strCommunity%>&filecenter=<%=root%>" name="leftFrame" style=" border-right:solid thin #CCCCCC">
  <frame src="/jsp/netdisk/FileCenterSafetys.jsp?community=<%=teasession._strCommunity%>&filecenter=<%=root%>" name="NetDiskMainFrame">
</frameset><noframes></noframes>
</html>
