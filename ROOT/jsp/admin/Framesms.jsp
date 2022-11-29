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
  tree="leftupsms.jsp?node="+teasession._nNode;
}
%>
<script type="">
function fchangetitle()
{
  window.document.title=window.MenuFrame.document.title;
}
window.setInterval("fchangetitle();",1000);
</script>
<html>
<frameset id="frame" rows="40,*"  frameborder="NO" border="0" framespacing="0">
  <frame src="headsms.jsp?community=<%=teasession._strCommunity%>&url=<%=java.net.URLEncoder.encode(desktop,"UTF-8")%>" name="topFrame" marginheight="10" scrolling="NO" noresize style="border-bottom: 1 solid #777">
    <frame name="MenuFrame" src="<%=tree%>" style="border-right: 1 solid #777">
    </frameset>
<noframes></noframes>
</html>



