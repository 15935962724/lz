<%@page contentType="text/html;charset=utf-8" %><%@page import="tea.ui.*" %><%@page import="tea.entity.site.*" %><%request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

int node=Community.find(teasession._strCommunity).getNode();

%><html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <frameset cols="300,*" frameborder="NO" border="0" framespacing="0">
    <frame src="/jsp/access/AccessMemberTree.jsp?community=<%=teasession._strCommunity%>&node=<%=node%>" >
    <frame src="/jsp/access/AccessMembers.jsp?community=<%=teasession._strCommunity%>&node=<%=node%>" name="AccessMemberFrame">
  </frameset><noframes></noframes>
</html>
