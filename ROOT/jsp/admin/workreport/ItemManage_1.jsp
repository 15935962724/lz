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
  tree="about:blank";//index_leftup.jsp?node="+teasession._nNode;
}
%>
<script>
function fchangetitle()
{
  window.document.title=window.m.document.title;
}
window.setInterval("fchangetitle();",1000);
</script>
<html>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<frameset cols="200,*" framespacing="0" frameborder="no" id="frame">
   <frameset id="frame" rows="80,*" framespacing="0" >
     <frame id="hbxg" src="/jsp/admin/workreport/NonceItem.jsp?quanxian=quanxian" name="Itemlist"  noresize />
     <frame id="hbxg" src="/jsp/admin/workreport/Worklogs_11.jsp" name="Worklogs_10" noresize />
  </frameset>

  <frameset rows="80,*" framespacing="0" frameborder="no" bordercolor="#1F55B8" id="frame">
     <frame src="/jsp/admin/workreport/ItemMenu.jsp" noresize="noresize" frameborder="no" name="Itemmenu" />
     <frame src="/jsp/admin/workreport/ViewWorkproject2.jsp" noresize="noresize" frameborder="no" name="VWproject2"/>
  </frameset>
</frameset>
<noframes></noframes>
</html>




