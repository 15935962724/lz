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

CommunityOption obj=CommunityOption.find(teasession._strCommunity);
String eonip=obj.get("eonip");
String eonuser=obj.get("eonuser");
String eonpwd=obj.get("eonpwd");
int eonbalance=obj.getInt("eonbalance");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "EON设置")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditCommunityOption" method="post" target="_ajax" onsubmit="return submitText(this.eonip,'<%=r.getString(teasession._nLanguage, "EON主机")%>');">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="name" value="/eonip/eonuser/eonpwd/eonbalance/">

<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"EON主机")%></td>
    <td><input name="eonip" value="<%if(eonip!=null)out.print(eonip);%>"></td>
    <td>提供电话服务的服务器IP或主机名</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"FTP用户")%></td>
    <td><input name="eonuser" value="<%if(eonuser!=null)out.print(eonuser);%>"></td>
    <td>服务器的FPT用户</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"FTP密码")%></td>
    <td><input name="eonpwd" value="<%if(eonpwd!=null)out.print(eonpwd);%>"></td>
    <td>服务器的FPT密码</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"默认余额")%></td>
    <td><input name="eonbalance" value="<%=eonbalance%>" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;"></td>
    <td>会员的默认余额</td>
  </tr>
</table>

<input type="submit" class="edit_input" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
