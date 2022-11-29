<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.resource.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
    response.sendRedirect("/servlet/Node?node=2198284&language=1");
    return;
}

if(request.getParameter("ajax")!=null)
{
  int step=Integer.parseInt(request.getParameter("step"));
  int father=Integer.parseInt(request.getParameter("father"));
  AdminFunction af=AdminFunction.find(father);
  out.print(af.getTreeToHtml(teasession,step,true));
  return;
}

Resource r = new Resource("/tea/resource/fun");

Community c=Community.find(teasession._strCommunity);
String desktop=c.getDesktop();
//
boolean def=(desktop==null||desktop.length()<1)||request.getHeader("referer")!=null;
int root=Integer.parseInt(request.getParameter("id"));//AdminFunction.getRootId(teasession._strCommunity);
AdminFunction af=AdminFunction.find(root);

%><html>
  <head>
    <title>leftup</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
if (top.location == self.location)
{
  top.location="/jsp/bpicture/?community=<%=teasession._strCommunity%>&node=<%=teasession._nNode%>&tree="+encodeURIComponent(self.location);
}
function f_click(j,step)
{
  var divid=document.all("divid"+j);
  if(divid.style.display=="")
  {
    divid.style.display="none";
    document.all("img"+j).src="/tea/image/tree/tree_plus.gif";
  }else
  {
    divid.style.display="";
    document.all("img"+j).src="/tea/image/tree/tree_minus.gif";
    if(divid.innerHTML=="")
    {
      divid.innerHTML="　　<img src=/tea/image/public/load.gif>load...";
      sendx("?ajax=ON&community=<%=teasession._strCommunity%>&father="+j+"&step="+(step+1),
      function(data)
      {
        divid.innerHTML=data;
        f_open(divid);
      } );
    }else
    {
      f_open(divid);
    }
  }
}
function f_open(obj)
{
  var h=obj.innerHTML;
  var i=h.indexOf("<SCRIPT>")+8;
  if(i>10)
  {
    var j=h.indexOf("</"+"SCRIPT>",i);
    eval(h.substring(i,j));
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
#leftupdiv {white-space:nowrap;}

</style>
</head>
<body id="leftup">
<div id="leftupdiv">
<div id="lzj_san"> </div>
<div id="leftupdiv2">
<!--
<%=r.getString(teasession._nLanguage,"CurrentUsers")%>:<%=teasession._rv%><br/>

<br>
-->
<img src="/tea/image/other/img-globe.gif" width="16" height="16">
<%=af.getName(teasession._nLanguage)%><br>

<div><%=af.getTreeToHtml(teasession,0,def)%></div>

<script>
//var a0=document.all('a0');
//if(a0)
//{
//  if(a0.length)
//  {
//
//  }
//  if(a0.length<3)
//  {
//    var i=a0.length;
//    while(i>0)
//    {
//      eval(a0[--i].href);
//    }
//  }
//}
</script>

<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</div>
<div id="lzj_xia"> </div>
</div>
</body>
</html>
