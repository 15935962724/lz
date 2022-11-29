<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.netdisk.*" %>
<%

TeaSession teasession = new tea.ui.TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

if(request.getParameter("ajax")!=null)
{
  String father=request.getParameter("father");
  int step=Integer.parseInt(request.getParameter("step"));
  NetDiskMember obj=NetDiskMember.find(teasession._strCommunity,teasession._rv._strV,father);
  out.print(obj.getTreeToHtml(step));
  return;
}

String base=request.getParameter("base");

NetDiskMember obj=NetDiskMember.find(teasession._strCommunity,teasession._rv._strV,base+"/");



base=java.net.URLEncoder.encode(base,"UTF-8");

%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
if (top.location == self.location)
{
  top.location="/jsp/netdisk/?community=<%=teasession._strCommunity%>&node=<%=teasession._nNode%>&base=<%=base%>";
}

function f_open(path)
{
  window.open("/jsp/netdisk/NetDiskMember.jsp?community=<%=teasession._strCommunity%>&base=<%=base%>&path="+path,"NetDiskMainFrame");
}

function f_ex(j,step)
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
margin-left: 10px;
margin-top: 10px;
margin-right: 10px;
margin-bottom: 10px;
}
</style>
</head>
<body>

<img src="/tea/image/other/img-globe.gif" width="16" height="16">
<a href="###" onclick="f_open('/');" >根目录</a>

<div><%=obj.getTreeToHtml(0)%></div>

</body>
</html>
