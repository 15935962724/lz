<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
/*
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
*/
Resource r=new Resource("/tea/resource/Lucene");
%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<title>
升级包列表
</title>
</head>
<body>

<h1><%=r.getString(teasession._nLanguage, "升级包列表")%></h1>
<div id="head6"><img height="6" alt=""></div>
<br>

<table border="1" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
<td>版本号</td>
<td>上一版本</td>
<td>生成时间</td>
<td>压缩文件</td>

</tr>
<%
DbAdapter db=new DbAdapter();
db.executeQuery("select version ,preversion,updatetime,introduce,client from version");
while(db.next())
{
String version=db.getString(1);
String preversion=db.getString(2);
String updatetime=db.getString(3);
String introduce=db.getString(4);
String client=db.getString(5);
  %>
  <tr>
    <td width="1"><%=version%></td>
    <td><%=preversion%></td>
    <td><%=updatetime%></td>
     <td><a href="/update/<%=client%>_<%=version%>.zip"><%=client%>_<%=version%>.zip</a></td>

    <td>

  </tr>
<%
}
db.close();
%></table>




<div id="head6"><img height="6" alt=""></div>

</body>
</html>
