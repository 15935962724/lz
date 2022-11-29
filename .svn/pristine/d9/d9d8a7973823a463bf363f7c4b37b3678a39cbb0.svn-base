<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.admin.earth.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="java.util.*"%><%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode("/jsp/admin/Frame.jsp?community="+teasession._strCommunity+"&node="+teasession._nNode,"UTF-8"));
  return;
}

StringBuffer sql=new StringBuffer();
String q=request.getParameter("q");
if(q!=null&&(q=q.trim()).length()>0)
{
  sql.append(" AND ( ip LIKE ").append(DbAdapter.cite("%"+q+"%"));
  sql.append(" OR name LIKE ").append(DbAdapter.cite("%"+q+"%"));
  sql.append(")");
}

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
if (top.location == self.location)
{
  top.location="/jsp/admin/earth/?community=<%=teasession._strCommunity%>&node=<%=teasession._nNode%>";
}
</script>
<style>
body
{
text-align: left;
margin-left: 0px;
margin-top: 10px;
margin-right: 0px;
margin-bottom: 10px;
scrollbar-face-color:#fff;
scrollbar-shadow-color:#e1e1e1;
scrollbar-highlight-color:#e1e1e1;
scrollbar-darkshadow-color:#e1e1e1;
scrollbar-track-color:#eee;
scrollbar-arrow-color:#35507a;
}
#aa{background:#fef1f3;border-top:1px #a8a8a8 dotted;padding-left:28px;line-height:20px;padding-top:5px;padding-bottom:5px;}
#aa a{color:#00c;}
#leftuptree0{padding:3px 0px;display:block}
#leftuptree1 a{color:#666}

a:link {
	color: #000000;
	text-decoration: none;
}
a:visited {
	color: #000000;
	text-decoration: none;
}
a:hover {
	color: #000000;
	text-decoration: none;
}
a:active {
	color: #000000;
	text-decoration: none;
}

</style>
</head>
<body TEXT="#000000" style="font-size:9pt;" align=left>
<div style="margin-bottom:8px">
<form action="?">
<input  type="hidden"  name="community" value="<%=teasession._strCommunity%>"/>
<input id="shuruk" type="text" name="q" value="<%if(q!=null)out.print(q);%>"><input id="ann" type="submit" value="GO"/>
</form>
</div>
<%
Enumeration e=EarthIp.find(sql.toString(),0,Integer.MAX_VALUE);
while(e.hasMoreElements())
{
  String ip=(String)e.nextElement();
  Enumeration e2=EarthHost.findByIp(ip);
  if(e2.hasMoreElements())
  {
    EarthIp ei=EarthIp.find(ip);
    out.print("<div style=\"padding-left:10px;font-weight:bolder;font-size:14px;color:#797979;margin-bottom:5px;\"><img src=/res/ROOT/u/0709/070921017.jpg align=absmiddle> ");
    if(ei.getNode()>0)
    out.print("<a href=/servlet/Node?node="+ei.getNode()+"&Language="+teasession._nLanguage+" target=earth_main>");
    out.print(ei.getName()+"</a> ( "+ip+" )<br></div><div id=\"aa\">");

    while(e2.hasMoreElements())
    {
      String host=(String)e2.nextElement();
      EarthHost eh=EarthHost.find(host);

      out.print("<a href=http://"+host+":"+ei.getPort()+"/jsp/admin/earth/EarthDesktop.jsp?community="+teasession._strCommunity+"&ip="+ip+"&host="+host+"&context="+eh.getContext()+" target=earth_main >"+eh.getContext()+" ( "+Communityinfo.countByHost(host)+" )</a><br>");
    }
    out.print("</div><br>");
  }
}
%>

</body>
</html>



