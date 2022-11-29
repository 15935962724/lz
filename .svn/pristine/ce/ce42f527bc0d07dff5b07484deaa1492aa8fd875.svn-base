<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.site.*" %>
<%
String url=request.getParameter("url");
String desktop;
String tree=request.getParameter("tree");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}

Community community_obj=Community.find(teasession._strCommunity);
if(community_obj.getDesktop()!=null&&community_obj.getDesktop().length()>0)
{
  desktop=(community_obj.getDesktop());
}else
{
  desktop=("DefaultDesktop.jsp");
}
if(url==null)
{
  url=desktop;
}
if(tree==null)
{
  tree="Leftup.jsp?node="+teasession._nNode;
}
%>
<html>
<frameset id="frame" rows="80,*"  frameborder="NO" border="0" framespacing="0">
  <frame src="/jsp/admin/earth/EarthHeader.jsp?community=<%=teasession._strCommunity%>&url=<%=java.net.URLEncoder.encode(desktop,"UTF-8")%>" name="topFrame" marginheight="10" scrolling="NO" noresize style="border-bottom: 1 solid #777">
  <frameset OnLoad="" id="frame2" cols="285,*" rows="*" frameborder="no" border="0" framespacing="0">
      <frameset OnLoad="" id="frame2" cols="*" rows="*,162" frameborder="no" border="0" framespacing="0">
	   <frame name="MenuFrame" src="<%=tree%>" style="border-right: 1 solid #777">
       <frame name="BottomFrame" src="LeftupBottom.jsp">
      </frameset>

    <frame name="earth_main" src="<%=url%>">
  </frameset>
</frameset>
</html>
<script>
try
{
  window.setInterval("window.document.title=window.earth_main.document.title;",1000);
}catch(ex)
{}
</script>



