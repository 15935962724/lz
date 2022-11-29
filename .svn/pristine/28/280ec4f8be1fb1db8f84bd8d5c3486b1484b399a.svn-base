<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.resource.Resource"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.eon.*"%>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Enumeration e=Node.find(" AND father="+teasession._nNode+" AND vcreator="+DbAdapter.cite(teasession._rv._strV),0,1);
if(!e.hasMoreElements())
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("你还没有设置你的信息...","UTF-8"));
  return;
}
String sn=request.getScheme()+"://"+request.getServerName();
int port=request.getServerPort();
if(port!=80)
{
  sn=sn+":"+port;
}
int nodeid=((Integer)e.nextElement()).intValue();

Resource r=new Resource();

%>
<!--
参数说明
node: 父节点号
-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body>

<h1><%=r.getString(teasession._nLanguage, "获取代码")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>代码:</td>
  </tr>
  <tr><td><textarea name="textarea" id="textarea" cols="60" rows="5"><script src="<%=sn%>/jsp/eon/EonInclude.jsp?node=<%=nodeid%>" charset="UTF-8"></script></textarea></td>
  </tr>
  <tr>
    <td>预览:<script src="<%=sn%>/jsp/eon/EonInclude.jsp?node=<%=nodeid%>" charset="UTF-8"></script></td>
  </tr>
</table>

</body>
</html>
