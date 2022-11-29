<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.util.*"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.netdisk.*"%>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/NetDisk");

String base=request.getParameter("base");
String path=request.getParameter("path");

NetDiskMember obj=NetDiskMember.find(teasession._strCommunity,teasession._rv._strV,path);


%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body>

<h1><%=r.getString(teasession._nLanguage, "文件上传")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=obj.getAncestor(null)%></td>
  </tr>
</table>

<form name="form1" action="/servlet/EditNetDiskMember" method="post" enctype="multipart/form-data">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="act" value="upload">
<input type="hidden" name="base" value="<%=base%>">
<input type="hidden" name="path" value="<%=path%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "FileName")%></td>
    <td><input type="file" name="file" size="40"></td>
  </tr>
  <tr><td>选项:</td><td><input type="checkbox" name="decompression" value="0">自动解压(ZIP或RAR)</td></tr>
</table>
<input type="submit" value="提交">
<input type="button" value="返回" onClick="history.back();">
</form>

</body>
</html>
