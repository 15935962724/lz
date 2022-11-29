<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.site.*" %>
<%request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

String url=request.getParameter("url");
String tree=request.getParameter("tree");

Community c=Community.find(teasession._strCommunity);

String desktop=c.getDesktop();
if(desktop==null||desktop.length()<1)
{
  desktop="/jsp/admin/DefaultDesktop.jsp";
}
if(url==null)
{
  url=desktop;
}
if(tree==null)
{
  tree="about:blank";//index_leftup.jsp?node="+teasession._nNode;
}
%>
<script>
/*
function fchangetitle()
{
  if(window.m)
  {
    window.document.title=window.m.document.title;
  }
}
window.setInterval("fchangetitle();",1000);*/
</script>
<html>
<TITLE>企企网企业管理中心</TITLE>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<frameset id="frame" rows="80,*,100"  frameborder="NO" border="0" framespacing="0">

  <frame src="index_head.jsp?community=<%=teasession._strCommunity%>&url=<%=java.net.URLEncoder.encode(desktop,"UTF-8")%>" name="topFrame" id="topFrame" marginheight="10" scrolling="NO" noresize >

  <frameset id="frame2" cols="180,*,165" frameborder="no" border="0" framespacing="0">
    <frame id="MenuFrame" name="MenuFrame" src="<%=tree%>" >
    <frame name="m" src="<%=url%>">
    <frame id="RightFrame" name="RightFrame" src="/jsp/site/HelpLists2.jsp">
  </frameset>
  <frame id="BottomFrame" name="BottomFrame" src="/jsp/netkoo/bottom.html">
</frameset>

</html>



