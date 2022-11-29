<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.ui.TeaSession" %><%@ page import="tea.entity.admin.*" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/fun");


%><!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js"></script>
<script src="/tea/image/ig/ig.js"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script>
if(top.location==self.location)top.location="/jsp/admin/?community=<%=teasession._strCommunity%>";
</script>
</head>
<body id="by">
<div class="minWidth">
<%
String menu = AdminUsrRole.find(teasession._strCommunity, teasession._rv._strV).getAdminfunction(request.getRemoteAddr());

java.util.Enumeration e=AdminFunction.findUrlig(teasession._strCommunity,teasession._rv._strR,request.getRemoteAddr());
while(e.hasMoreElements())
{
  int id=((Integer)e.nextElement()).intValue();
  AdminFunction obj=AdminFunction.find(id);
  String urlig=obj.getUrlig();

  AdminFunction afobj = AdminFunction.find(obj.getFather());
  if(!afobj.isExists())continue;
  out.print("<div id=m_"+id+" class=modbox><h2 class=modtitle>"+obj.getName(teasession._nLanguage)+"</h2><div class=modboxin>");
  if(urlig.startsWith("http://")||urlig.startsWith("/servlet/"))
  {
    out.print("<iframe src="+urlig+" frameborder=0 scrolling=no width=100% height=100% ></iframe>");
  }else
  {
    out.print("<!-- "+id+":"+urlig+" -->");
    %>
      <jsp:include page="<%=urlig%>">
      <jsp:param name="menuid" value="<%=id%>"/>
        <jsp:param name="showcount" value="<%=10%>"/>
          <jsp:param name="community" value="<%=teasession._strCommunity%>"/>
      </jsp:include>
      <%
  }
  out.print("</div></div>");
}
%>

  <!--  <input type=button value=查看源文件 onClick="var ta=document.getElementById('ta'); ta.value='';  ta.value=document.body.innerHTML;">
    <textarea cols="50" rows="8" id=ta ></textarea>-->
</div>
</body>
</html>
