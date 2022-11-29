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
obj.setReader(member);

String tmember=obj.getTMember();
String tunit=obj.getTUnit();
String to=obj.getTo(teasession._nLanguage);

String fmember=obj.getFMember();
String subject = obj.getSubject(teasession._nLanguage);
String content = obj.getContent(teasession._nLanguage).replaceAll("<script","<!--").replaceAll("</script>","-->");
String s5 = Text.toHTML(content);

//Profile p=Profile.find(fmember);

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
<tr>
  <td>
    <input type="button" value="返回" onClick="history.back();">
    <input type="button" value="回复" onClick="window.open('/jsp/message/NewMessage.jsp?to=<%=URLEncoder.encode(fmember,"UTF-8")%>&act=re&message=<%=i%>','_self');">
    <input type="button" value="转发" onClick="window.open('/jsp/message/NewMessage.jsp?act=fw&message=<%=i%>','_blank');">
    <input type="button" value="删除" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))window.open('/servlet/EditMessage?act=Delete&messages=<%=i%>','_self');">
  </td>
</tr>
</table>

<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>
<tr><td width="80" align="right" nowrap>发件人</td><td><%=MT.f(fmember,'；')%> <!--<input type="button" value="拒收" onClick="window.open('/servlet/EditBlacklist?act=add&to=<%=URLEncoder.encode(fmember,"UTF-8")%>&nexturl='+encodeURIComponent(location.href),'_self');"/>--></td>
<tr><td width="80" align="right" nowrap>收件人</td><td><%=to%></td>
<tr><td width="80" align="right" nowrap>时　间</td><td><%=obj.getTimeToString()%></td>
<tr><td width="80" align="right" nowrap>主　题</td><td><img src='/tea/image/hint/<%=obj.getHint()%>.gif' />&nbsp;<%=subject%></td>
</table>

<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>
<tr><td><%=content%></td>
<tr><td>
<%
if(obj.countAttachment()>0)
{
  for(Enumeration e = obj.findAttachment(); e.hasMoreElements();)
  {

    int part = ((Integer)e.nextElement()).intValue();
    String fpath=obj.getAttachmentFilePath(part);
    String fname=obj.getAttachmentFileName(part,teasession._nLanguage);
    String ext=fname.substring(fname.lastIndexOf(".")+1).toLowerCase();
    out.print("<A href=/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(fpath,"UTF-8")+"&name="+java.net.URLEncoder.encode(fname,"UTF-8")+"><img src=/tea/image/netdisk/"+ext+".gif onerror=\"src='/tea/image/netdisk/defaut.gif';onerror=null;\">"+fname+"</A>　");
  }
}
%>
</td>
</tr>
</table>

<div id="head6"><img height="6" src="about:blank" alt=""></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>
