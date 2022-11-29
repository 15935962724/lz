<%@page contentType="text/html; charset=UTF-8" %><%@page import="tea.ui.*" %><%@page import="tea.entity.admin.*" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int size=NetDiskSize.getSizeByMember(teasession._strCommunity,teasession._rv._strV);

%><html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

        <style>
		body		{
	text-align: left;
	margin-left: 10px;
	margin-top: 10px;
	margin-right: 10px;
	margin-bottom: 10px;
}
        </style>
</head>
	<body  TEXT="#000000" style="font-size:9pt; " align=left>
        总计:<%=((int)((size/1024D)*100))/100F%>M<br/>
        <%
        if(size>0)
        {
          String prefix="/res/"+teasession._strCommunity+"/netdiskmember/";
          java.io.File dir = new java.io.File(application.getRealPath(prefix +teasession._rv._strV));
          int useSize=NetDiskSize.getUseSize(dir);
          %>
        已用空间:<%=((int)((useSize/1024D)*100))/100F%>M<br/>
        可用空间:<%=((int)(((size-useSize)/1024D)*100))/100F%>M<br/>
<table  border="0" cellpadding="0" cellspacing="0" width="100%"><tr><td style="height:20px;background-color:#FF0000;width:<%=useSize/(size/100F)%>%;" title="已用空间"></td><td style="width:<%=(size-useSize)/(size/100)%>%;background-color:#999999;height:20px;"></td></tr></table>

<%}%>
</body>
</html>

