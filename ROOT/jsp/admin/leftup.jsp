<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.admin.*" %><%

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
  AdminFunction af=AdminFunction.find(father);
  out.print(af.getTreeToHtml(teasession,step,false));
  return;
}

Resource r = new Resource("/tea/resource/fun");

int root=AdminFunction.getRootId(teasession._strCommunity,teasession._nStatus);

AdminFunction af=AdminFunction.find(root);

%>
<!doctype html>
<html>
  <head>
    <title>leftup</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
if (top.location == self.location)
{
  top.location="/jsp/admin/Frame.jsp?community=<%=teasession._strCommunity%>&node=<%=teasession._nNode%>";
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
      } );
    }
  }
}
</script>
<style>
body
{
text-align: left;
margin:10px

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
<%=r.getString(teasession._nLanguage,"CurrentUsers")%>:<%=teasession._rv%><br/>
<font FACE='宋体'>
<br>

<img src="/tea/image/other/img-globe.gif" width="16" height="16">
<%=af.getName(teasession._nLanguage)%><br>

<div><%=af.getTreeToHtml(teasession,0,false)%></div>

</font>

<script>
var a0=document.all('a0');
if(a0&&a0.length<3)
{
  var i=a0.length;
  while(i>0)
  {
    eval(a0[--i].href);
  }
}
</script>

<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
