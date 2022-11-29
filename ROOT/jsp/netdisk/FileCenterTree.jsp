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
  int father=Integer.parseInt(request.getParameter("father"));
  int step=Integer.parseInt(request.getParameter("step"));
  FileCenter fc=FileCenter.find(father);
  out.print(fc.getTreeToHtml(teasession,step));
  return;
}

int filecenter=Integer.parseInt(request.getParameter("filecenter"));

FileCenter fc=FileCenter.find(filecenter);


%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
if (top.location == self.location)
{
  top.location="/jsp/netdisk/?community=<%=teasession._strCommunity%>&node=<%=teasession._nNode%>";
}

function f_open(filecenter)
{
  window.open("/jsp/netdisk/FileCenterSafetys.jsp?community=<%=teasession._strCommunity%>&filecenter="+filecenter,"NetDiskMainFrame");
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
#leftupdiv {white-space:nowrap;}
</style>
</head>
<body>
<div id="leftupdiv">

<img src="/tea/image/other/img-globe.gif" width="16" height="16">
<a href="###" onClick="f_open('<%=filecenter%>');" >根目录</a>

<div><%=fc.getTreeToHtml(teasession,0)%></div>

</div>

</body>
</html>
