<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.ui.*" %><%@page import="tea.entity.site.*" %><%

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
String _strH=request.getParameter("height");
if(_strH==null)
	_strH="60";
Community obj=Community.find(teasession._strCommunity);
%>
<script type="">
function fchangetitle()
{
  window.document.title=window.ContentFrame.document.title;
}

window.setInterval("fchangetitle();",1000);
</script>
<html>
<frameset id="frame" rows="<%=_strH%>,*"  frameborder="NO" border="0" framespacing="0">
  <frame src="/servlet/Node?node=<%=obj.getDynamicdesktop()%>" name="topFrame" marginheight="10" scrolling="NO" noresize >
  <frame name="ContentFrame" src="/jsp/admin/DynamicDesktop.jsp?node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>" >
</frameset>
<noframes></noframes>
</html>



