<%@page contentType="text/html;charset=utf-8" %><%@page import="tea.ui.*" %><%request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

String base=request.getParameter("path");
if(base==null)
{
  base="";
}else if(base.endsWith("/"))
{
  base=base.substring(0,base.length()-1);
}
base=java.net.URLEncoder.encode(base,"UTF-8");

%><html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <frameset cols="200,*" frameborder="NO" border="0" framespacing="0">
    <frameset rows="*,300" frameborder="NO" border="0" framespacing="0">
      <frame src="/jsp/netdisk/Tree.jsp?community=<%=teasession._strCommunity%>&base=<%=base%>" >
        <frame src="/jsp/netdisk/Search.jsp?community=<%=teasession._strCommunity%>&base=<%=base%>" >
    </frameset>
    <frame src="/jsp/netdisk/NetDisks.jsp?community=<%=teasession._strCommunity%>&base=<%=base%>" name="NetDiskMainFrame">
  </frameset>

</html>
