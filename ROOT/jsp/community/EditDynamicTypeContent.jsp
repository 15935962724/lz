<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Resource r=new Resource();

int dynamictype=Integer.parseInt(request.getParameter("dynamictype"));

String act=request.getParameter("act");
String id=request.getParameter("id");
if("POST".equals(request.getMethod()))
{
  DynamicType dt=DynamicType.find(dynamictype);
  String content=dt.getContent(teasession._nLanguage);
  if(!content.startsWith("/"))
  {
    content="/"+content;
  }
  if(!content.endsWith("/"))
  {
    content=content+"/";
  }
  String name=request.getParameter("name");
  if(act.equals("delete"))
  {
    content=content.replaceFirst("/"+id+"/","/");
  }else if(act.equals("new"))
  {
    content=content+name+"/";
  }else if(act.equals("edit"))
  {
    content=content.replaceFirst("/"+id+"/","/"+name+"/");
  }
  dt.setContent(teasession._nLanguage,content);
  response.sendRedirect("/jsp/community/DynamicTypeContents.jsp?community="+teasession._strCommunity+"&dynamictype="+dynamictype);
  return;
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body>

<h1><%=r.getString(teasession._nLanguage, "编辑内容")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" action="?" method="post" onsubmit="return submitText(this.name,'无效-名称')">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="dynamictype" value="<%=dynamictype%>">
<input type="hidden" name="id" value="<%=id%>">
<input type="hidden" name="act" value="<%=act%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>名称</td>
  <td><input type="text" name="name" value="<%=id%>"/></td>
</tr>
</table>

<input type=submit value="<%=r.getString(teasession._nLanguage,"CBSubmit")%>">
<input type=button value="<%=r.getString(teasession._nLanguage,"返回")%>" onclick="history.back()">
</form>

</body>
</html>
