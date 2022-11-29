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

Community c=Community.find("jiudian");

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
  tree="/jsp/admin/index_leftup.jsp?id=0";//index_leftup.jsp?node="+teasession._nNode;
}
%>
<script>
function fchangetitle()
{
  if(window.m)
  {
    window.document.title=window.m.document.title;
  }
}
window.setInterval("fchangetitle();",1000);
</script>
<html>
<link href="/res/jiudian/cssjs/community.css" rel="stylesheet" type="text/css">
<frameset id="frame" rows="81,34,*"  frameborder="NO" border="0" framespacing="0">
  <frame src="index_head.jsp?community=jiudian&url=<%=java.net.URLEncoder.encode(desktop,"UTF-8")%>" name="topFrame" id="topFrame" marginheight="10" scrolling="NO" noresize >
   <frame name="MenuFrameyu" id="MenuFrameyu" src="/jsp/admin/index_profile.jsp?community=jiudian&showcount=10&igd=0" noresize>
  <frameset id="frame2" cols="200,*,0" rows="*" frameborder="no" border="0" framespacing="0">

    <frameset id="frame3" cols="*" rows="*,220,220" frameborder="no" border="0" framespacing="0">
		<frame id="MenuFrame" name="MenuFrame" src="<%=tree%>" >
		<frame name="MenuFrameyu01"  id="MenuFrameyu01"  src="/jsp/registration/enquirieshotel3.jsp">
		<frame name="MenuFrameyu03" id="MenuFrameyu03" src="/jsp/registration/airticket.jsp">
	  </frameset>


       <frame name="m" id="m_right"  src="<%=url%>">
       <%--<frame id="RightFrame" name="RightFrame" src="<%=url%>">--%>

  <frame src="UntitledFrame-6"></frameset>
</frameset>
<noframes></noframes>
</html>



