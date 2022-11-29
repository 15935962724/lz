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

%>
<html>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<frameset cols="200,*" framespacing="0" frameborder="no" id="frame">
   <frameset id="frame" rows="80,*" framespacing="0" >
     <frame id="hbxg" src="/jsp/admin/workreport/NonceItem.jsp" name="Itemlist"  noresize  >
     <frame id="hbxg" src="/jsp/admin/workreport/Worklogs_10.jsp" noresize="noresize"  name="Worklogs_10"/>
  </frameset>
  <frameset rows="80,*" framespacing="0" frameborder="no" bordercolor="#1F55B8" id="frame">
     <frame src="/jsp/admin/workreport/ItemMenu.jsp" noresize="noresize" frameborder="no" name="Itemmenu" />
     <frame src="/jsp/admin/workreport/ViewWorkproject2.jsp" noresize="noresize" frameborder="no" name="VWproject2"/>
  </frameset>
</frameset>
<noframes></noframes>
</html>




