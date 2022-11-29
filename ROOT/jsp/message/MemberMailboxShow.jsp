<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*"  %>
<%@page import="java.net.*"  %>
<%@page import="tea.entity.*"  %>
<%@page import="tea.db.DbAdapter"  %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.html.*" %>
<%@page import="tea.entity.member.*" %><%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.*" %>
<%
request.setCharacterEncoding("UTF-8");

Http h=new Http(request);
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String member=teasession._rv._strV;

Resource r=new Resource();
r.add("tea/ui/member/message/MessageFolders").add("tea/ui/member/message/Messages").add("tea/ui/member/email/EmailBoxs").add("tea/ui/member/contact/CGroups").add("tea/ui/member/contact/Contacts").add("tea/ui/member/messagefolder/ManageMessageFolders");
String s = request.getParameter("Folder");
if(s == null)
s = "";

String s1 = request.getParameter("MessageFolder");
if(s1 == null)
s1 = "";

int i = Integer.parseInt(request.getParameter("message"));
Message obj = Message.find(i);

if(obj.tmember.indexOf("|"+h.member+"|")==-1)
{
  out.println("<script>alert('您没有权限查看');history.go(-1);</script>");
  return;
}

obj.setReader(h.member);




String content = obj.content.replaceAll("<script","<!--").replaceAll("</script>","-->");
String s5 = Text.toHTML(content);

Profile p=Profile.find(obj.member);

IfNotRead.create(i,teasession._rv._strV);

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Messages")%></h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<br>


<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>
<tr><td width="80" align="right" nowrap>发件人</td><td><%=p.getName(teasession._nLanguage)%> <!--<input type="button" value="拒收" onClick="window.open('/servlet/EditBlacklist?act=add&to=<%=obj.member%>&nexturl='+encodeURIComponent(location.href),'_self');"/>--></td>
<tr><td width="80" align="right" nowrap>收件人</td><td><%=obj.getToName(h.language)%></td>
<tr><td width="80" align="right" nowrap>时　间</td><td><%=MT.f(obj.time,1)%></td>
<tr><td width="80" align="right" nowrap>主　题</td><td><img src='/tea/image/hint/<%=obj.getHint()%>.gif' />&nbsp;<%=MT.f(obj.subject)%></td>
</table>

<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>
<tr><td><%=content%></td>

</table>
<input type="button" value="返回" onClick="history.back();">
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>
