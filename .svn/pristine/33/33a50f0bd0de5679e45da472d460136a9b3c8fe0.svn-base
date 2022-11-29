<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="java.util.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.site.*" %><%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode("/jsp/admin/?community="+teasession._strCommunity+"&node="+teasession._nNode,"UTF-8"));
    return;
}

if(request.getParameter("ajax")!=null)
{
  int step=Integer.parseInt(request.getParameter("step"));
  int father=Integer.parseInt(request.getParameter("father"));
  boolean isNode=Boolean.parseBoolean(request.getParameter("isNode"));
  if(isNode)
  {
    out.print(Node.find(father).getTreeToHtml(teasession._nLanguage,0));
  }else
  {
    AdminFunction af=AdminFunction.find(father);
    if(af.getType()==2)
    {
      father=Integer.parseInt(af.getUrl(teasession._nLanguage));
      out.print(Node.find(father).getTreeToHtml(teasession._nLanguage,0));
    }else
    out.print(af.getTreeToHtml(teasession,step,true));
  }
  return;
}
 
Resource r = new Resource("/tea/resource/fun");

Community c=Community.find(teasession._strCommunity);
String desktop=c.getDesktop();
//
boolean def=(desktop==null||desktop.length()<1)||request.getHeader("referer")!=null;
int root=Integer.parseInt(request.getParameter("id"));//AdminFunction.getRootId(teasession._strCommunity);
AdminFunction af=AdminFunction.find(root);

%><!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
if(top.location == self.location)
{
  top.location="/jsp/admin/?community=<%=teasession._strCommunity%>&node=<%=teasession._nNode%>&tree="+encodeURIComponent(self.location);
}
function f_click(j,step)
{
  var divid=$("divid"+j),imgid=$("img"+j),isNode=false;
  if(!divid)
  {
    divid=$("ntd_"+j);
    imgid=$("nti_"+j);
    isNode=true;
  }
  if(divid.style.display=="")
  {
    divid.style.display="none";
    imgid.src="/tea/image/tree/tree_plus.gif";
  }else
  {
    divid.style.display="";
    imgid.src="/tea/image/tree/tree_minus.gif";
    if(divid.innerHTML=="")
    {
      divid.innerHTML="　　<img src=/tea/image/public/load.gif>load...";
      sendx("?ajax=ON&community=<%=teasession._strCommunity%>&father="+j+"&step="+(step+1)+"&isNode="+isNode,
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
  var i=h.indexOf("<script>")+8;
  if(i>10)
  {
    var j=h.indexOf("</"+"script>",i);
    eval(h.substring(i,j));
  }
} 
function nt_ex(i,j){f_click(i,j);}
function nt_open(i){window.open('/jsp/general/NodeLists.jsp?node='+i,'m');}
</script>
<style>
body
{
text-align: left;

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
.nt_step{margin-left:10px;}
</style>
</head>
<body id="leftupmember">
<div id="leftupdiv2">
<div id="leftup_bottom">
<!--
<%=r.getString(teasession._nLanguage,"CurrentUsers")%>:<%=teasession._rv%><br/>

<br>
-->
<span class="title"><img src="/tea/image/other/img-globe.gif" width="16" height="16">
<%=af.getName(teasession._nLanguage)%></span>

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
</div>
</body>
</html>
