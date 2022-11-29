<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"  %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/Other");

CommunityOption obj=CommunityOption.find("[SYSTEM]");
String synchost=obj.get("synchost");
if(synchost==null)
{
  synchost="";
}
int syncport=obj.getInt("syncport");
if(syncport==0)
{
  syncport=80;
}
int syncperiod=obj.getInt("syncperiod");
if(syncperiod==0)
{
  syncperiod=1;
}
Date synctime=obj.getDate("synctime");


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onload="form1.synchost.focus();">
<h1><%=r.getString(teasession._nLanguage, "数据同步")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditCommunityOption" method="post" target="_ajax">
<input type="hidden" name="community" value="[SYSTEM]">
<input type="hidden" name="name" value="/synchost/syncport/syncperiod/">

<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"主机")%></td>
    <td><input name="synchost" value="<%=synchost%>"></td>
    <td></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"端口")%></td>
    <td><input name="syncport" value="<%=syncport%>" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" ></td>
    <td></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"同步频率")%></td>
    <td><input name="syncperiod" value="<%=syncperiod%>" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" >小时</td>
    <td></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"上次同步日期")%></td>
    <td><%if(synctime!=null)out.print(CommunityOption.sdf2.format(synctime));%></td>
    <td></td>
  </tr>
</table>

<input type="submit" class="edit_input" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
</form>

<font color="red"> (注：修改后，重启服务后生效) </font>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
