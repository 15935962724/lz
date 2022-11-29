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
String openidhost[]=new String[4];
openidhost[0]=obj.get("openidhost0");
openidhost[1]=obj.get("openidhost1");
openidhost[2]=obj.get("openidhost2");
openidhost[3]=obj.get("openidhost3");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onload="form1.openidhost.focus();">
<h1><%=r.getString(teasession._nLanguage, "EDN系统通行证")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditCommunityOption" method="post" target="_ajax">
<input type="hidden" name="community" value="[SYSTEM]">
<input type="hidden" name="name" value="/openidhost0/openidhost1/openidhost2/openidhost3/">

<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"主机1")%></td>
    <td><input name="openidhost0" value="<%if(openidhost[0]!=null)out.print(openidhost[0]);%>"></td>
    <td></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"主机2")%></td>
    <td><input name="openidhost1" value="<%if(openidhost[1]!=null)out.print(openidhost[1]);%>"></td>
    <td></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"主机3")%></td>
    <td><input name="openidhost2" value="<%if(openidhost[2]!=null)out.print(openidhost[2]);%>"></td>
      <td></td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage,"主机4")%></td>
    <td><input name="openidhost3" value="<%if(openidhost[3]!=null)out.print(openidhost[3]);%>"></td>
      <td></td>
  </tr>
</table>

<input type="submit" class="edit_input" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
