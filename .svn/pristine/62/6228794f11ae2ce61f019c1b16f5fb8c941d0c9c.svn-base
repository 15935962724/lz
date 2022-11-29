


<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.resource.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.*" %>
<%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
    //out.print("<script>window.open('/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode("/jsp/admin/Frame.jsp?community="+teasession._strCommunity+"&node="+teasession._nNode,"UTF-8")+"','_top');</script>");
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

int root=Integer.parseInt(request.getParameter("id"));//AdminFunction.getRootId(teasession._strCommunity);
AdminFunction af=AdminFunction.find(root);
%>
<html>
  <head>
    <title>leftup</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></script>
<script>
if (top.location == self.location)
{
  top.location="/jsp/admin/?community=<%=teasession._strCommunity%>&node=<%=teasession._nNode%>&tree="+encodeURIComponent(self.location);
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
        eval("divid"+j).innerHTML=data;
      } );
    }
  }
}
function f_open(obj)
{
  var ss=document.getElementsByTagName("A");//SPAN
  for(var i=0;i<ss.length;i++)
  {
    ss[i].id=null;
  }
  obj.id="CurrentlyPage";
}
function f_load()
{
  var a0=document.all('a0');
  if(a0)
  {
    if(a0.length<3)
    {
      var i=a0.length;
      while(i>0)
      {
        eval(a0[--i].href);
      }
    }
  }
}
</script>
<style>
body
{
text-align:left;
margin-bottom: 10px;
}

#leftuptree0{padding:3px 0px;display:block}
#leftuptree1 a{color:#666}

a:link {
	color: #000;
	text-decoration: none;
}
a:visited {
	color:#000;
	text-decoration: none;
}
a:hover {
	color:#E67243;
	text-decoration: none;
}
a:active {
	color:#E67243;
	text-decoration: none;
}

#img129988,#img129991,#img129960,#img129993,#img129994,#img130025,#img130027,#img130028,#img130026{display:none;}
</style>
</head>
<body id="leftup" onLoad="f_load()">
<!--
<%=r.getString(teasession._nLanguage,"CurrentUsers")%>:<%=teasession._rv%><br/>

<br>
-->
<div id="tuob">
<%=af.getName(teasession._nLanguage)%></div><br>


<div id="zuob"><%=af.getTreeToHtml(teasession,0,request.getHeader("referer")!=null)%></div>



</body>
</html>
