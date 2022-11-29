<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.admin.earth.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

StringBuffer sql=new StringBuffer();
String tmp;

int pos=0;
tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE="JAVASCRIPT" SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function f_act(act)
{
  switch(act)
  {
    case 'edit':
    form1.action="/jsp/admin/earth/EditEarthCdn.jsp";
    break;
  }
  form1.nexturl.value=location;
  form1.submit();
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "内容发布网络")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="earthcdn">
<input type="hidden" name="nexturl">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap width="1">&nbsp;</td>
    <td>编号</td>
    <td>密码</td>
    <td>激活时间</td>
    <td>激活时的IP</td>
  </tr>
<%
Enumeration e=EarthCdn.find(sql.toString(),pos,10);
while(e.hasMoreElements())
{
  String id=(String)e.nextElement();
  EarthCdn ec=EarthCdn.find(id);
  String ip=ec.getIp();
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''><td>");
  out.print("<td>"+id);
  out.print("<td>"+ec.getPwd());
  out.print("<td>"+ec.getTimeToString());
  out.print("<td>");
  if(ip!=null)out.print(ip);
}
%>
</table>

<input type="button" value="添加" onclick="f_act('edit')">

</form>


<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
