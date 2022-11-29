<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.site.*" %><%@page import="java.util.*" %><%

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

if(request.getParameter("ajax")!=null)
{
  int step=Integer.parseInt(request.getParameter("step"));
  int father=Integer.parseInt(request.getParameter("father"));
  AdminUnit af=AdminUnit.find(father);
  out.print(af.getTreeToHtml(teasession._nLanguage,step));
  return;
}

Resource r = new Resource("/tea/resource/fun");

int root=AdminUnit.getRootId(teasession._strCommunity);

AdminUnit au=AdminUnit.find(root);

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
if (top.location == self.location)
{
  top.location="/jsp/admin/AdminUnitFrame.jsp?community=<%=teasession._strCommunity%>";
}
function f_ex(j,step)
{
  var di=document.all("divid"+j);
  var im=document.all("img"+j);
  if(di.style.display=="")
  {
    di.style.display="none";
    if(im)
    im.src="/tea/image/tree/tree_plus.gif";
  }else
  {
    di.style.display="";
    if(im)
    im.src="/tea/image/tree/tree_minus.gif";

    if(di.innerHTML=="")
    {
      di.innerHTML="　　<img src=/tea/image/public/load.gif>load...";

      sendx("?ajax=ON&community=<%=teasession._strCommunity%>&father="+j+"&step="+(step+1),
      function(data)
      {
        eval("divid"+j).innerHTML=data;
      } );
    }
  }
}

function f_click(j,step)
{
  if(step==0||step)
  {
    f_ex(j,step);
    window.open("/jsp/admin/popedom/AdminUnitView.jsp?community=<%=teasession._strCommunity%>&adminunit="+j,"adminunit_main");
  }else
  {
    window.open("/jsp/user/ProfileView.jsp?community=<%=teasession._strCommunity%>&member="+encodeURIComponent(j),"adminunit_main");
  }
}
</script>
<style>
body
{
text-align: left;
margin-left: 10px;
margin-top: 10px;
margin-right: 10px;
margin-bottom: 10px;
}

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
<body TEXT="#000000" style="font-size:9pt;" align=left id=leftup>

<!--
<img src="/tea/image/other/img-globe.gif" width="16" height="16">
<a href="/jsp/admin/popedom/AdminUnitList.jsp?community=<%=teasession._strCommunity%>" target="adminunit_main"><%=au.getName()%></a>
<br>
-->

<div id="tree">
<%=au.getTreeToHtml(teasession._nLanguage,0)%>
</div>

<%--

Enumeration e=AdminUnit.findByCommunity(teasession._strCommunity," AND father=0");
while(e.hasMoreElements())
{
  int id=((Integer)e.nextElement()).intValue();
  AdminUnit au=AdminUnit.find(id);
  out.print(au.getTreeToHtml(teasession._nLanguage,0));
}

--%>

<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
