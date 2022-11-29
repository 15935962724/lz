<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.util.*"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
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


String nexturl=request.getParameter("nexturl");
String base=request.getParameter("base");
String path=request.getParameter("path");

NetDiskMember obj=NetDiskMember.find(teasession._strCommunity,teasession._rv._strV,path);
File f=new File(application.getRealPath(obj.getPrefix()+path));

String act=request.getParameter("act");
if(act==null)
{
  act="newfolder";
}

String name="";
if("rename".equals(act))
{
  name=f.getName();
}


%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script>
function f_load()
{
  form1.name.focus();
}
</script>
</head>
<body onload="f_load()">

<h1><%=r.getString(teasession._nLanguage, "新建/编辑")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" action="/servlet/EditNetDiskMember" onsubmit="return submitText(this.name,'名称');">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="act" value="<%=act%>">
<input type="hidden" name="base" value="<%=base%>">
<input type="hidden" name="path" value="<%=path%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=obj.getAncestor(null)%></td>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "名称")%></td>
    <td><input type="text" name="name" size="40" value="<%=name%>"></td>
  </tr>
</table>

<input type="submit" value="提交">
<input type="button" value="返回" onclick="history.back();">
</form>

</body>
</html>
