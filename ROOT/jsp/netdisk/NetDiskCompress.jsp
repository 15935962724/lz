<%@page contentType="text/html;charset=UTF-8" %>
<%
tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=request.getParameter("community");
if(community==null)
{
  tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
  community=node.getCommunity();
}
int size=tea.entity.admin.NetDiskSize.getSizeByMember(teasession._rv._strV);


%>
<html>
  <head>
    <title>size</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

</head>
	<body >
        总计:<%=((int)((size/1024)*100))/100F%>M<br/>
        <%if(size>0)
        {
                          String prefix="/tea/netdiskmember/";
                java.io.File dir = new java.io.File(application.getRealPath(prefix +teasession._rv._strV));
 int useSize=      tea.entity.admin.NetDiskSize.getUseSize(dir);
          %>
        已用空间:<%=((int)((useSize/1024)*100))/100F%>M<br/>
        可用空间:<%=((int)(((size-useSize)/1024)*100))/100F%>M<br/>
<img height="20" title="已用空间" width="<%=useSize/(size/100F)%>%" style="background-color:#FF0000 "><img title="可用空间" height="20" width="<%=(size-useSize)/(size/100)%>%" style="background-color:#999999">
<%}%>
</body>
</html>

