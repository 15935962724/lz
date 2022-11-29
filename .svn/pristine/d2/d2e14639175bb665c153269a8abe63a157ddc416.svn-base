<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.admin.*" %>
<%request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/Node?node=2198284&language=1");
	return;
}

String url=request.getParameter("url");
String tree=request.getParameter("tree");

Community c=Community.find(teasession._strCommunity);
AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
String desktop=c.getDesktop();
if(desktop==null||desktop.length()<1)
{
  desktop=("DefaultDesktop.jsp");
}

String nu = request.getParameter("nu");

if(url==null)
{
  url=desktop;
}

if(tree==null)
{
  if(aur.getRole().contains("358"))
  {
    tree="index_leftup.jsp?id=130506&language=1&node="+teasession._nNode;
  }else if(aur.getRole().length()>5)
  {
    tree="index_leftup.jsp?id=130552&language=1&node="+teasession._nNode;
  }else
  {
    tree="about:blank";//index_leftup.jsp?node="+teasession._nNode;
  }
}
%>
<script>
window.name=null;
function fchangetitle()
{
  if(window.m)
  {
    var newt=window.m.document.title+" <%=c.getName(teasession._nLanguage)%>";
    if(window.document.title!=newt)window.document.title=newt;
  }
}
window.setInterval("fchangetitle();",1000);
</script>
<html>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<frameset id="frame" rows="85,36,*"  frameborder="NO" border="0" framespacing="0">
  <frame src="B_headtop.jsp?community=<%=teasession._strCommunity%>&url=<%=java.net.URLEncoder.encode(desktop,"UTF-8")%>" name="topFrame" id="topFrame" marginheight="10" scrolling="NO" noresize >

  <frame name="MenuFrameyu" id="MenuFrameyu" src="index_profile2.jsp?community=<%=teasession._strCommunity%>&showcount=10&igd=0">

    <frameset id="frame2" cols="200,*,0" rows="*" frameborder="no" border="0" framespacing="0">
     <frameset id="frame3" cols="*" rows="*,90" frameborder="no" border="0" framespacing="0">
       <frame id="MenuFrame" name="MenuFrame" src="<%=tree%>" >
     </frameset>
    <frame name="m" src="<%=url%>">
    <frame id="RightFrame" name="RightFrame" src="about:blank">
  </frameset>
</frameset>
</html>
