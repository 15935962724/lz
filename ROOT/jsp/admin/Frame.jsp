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
  desktop=("DefaultDesktop.jsp");
}
if(url==null)
{
  url=desktop;
}
if(tree==null)
{
  tree="leftup.jsp?node="+teasession._nNode;
}
%>
<html>
<script type="">
function fchangetitle()
{
  if(window.m)
  {
    var newt=window.m.document.title;
    if(window.document.title!=newt)
    window.document.title=newt;
  }
}
window.setInterval("fchangetitle();",1000);
</script>
<frameset id="frame" rows="80,*" frameborder="NO" border="0" framespacing="0">
  <frame src="head.jsp?community=<%=teasession._strCommunity%>&url=<%=java.net.URLEncoder.encode(desktop,"UTF-8")%>" name="topFrame" marginheight="10" scrolling="NO" noresize style="border-bottom: 1 solid #777">
  <frameset OnLoad="" id="frame2" cols="250,10px,*" rows="*" frameborder="no" border="0" framespacing="0">
    <frame name="MenuFrame" src="<%=tree%>" style="border-right: 1 solid #777">
    <frame name="MenuFrame2" src="leftup2.jsp?node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>" style="border-right: 0 solid #777">
    <!--
      <frame name="bottomFrame" src="leftdown.htm" bordercolor="#CB9966">
      </frameset>
    -->
    <frame name="m" src="<%=url%>">
  </frameset>
</frameset>
</html>
