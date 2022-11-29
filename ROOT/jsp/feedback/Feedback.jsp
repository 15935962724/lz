<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


String s =request.getParameter("Member");
if(s == null)
if(teasession._rv != null)
{
  s = teasession._rv._strR;
} else
{
  response.sendRedirect("/servlet/StartLogin");
  return;
}

int i = Integer.parseInt(request.getParameter("Feedback"));
Feedback feedback = Feedback.find(i);
if(!s.equals(feedback.getMember()))
{
  response.sendError(403);
  return;
}
tea.entity.RV rv = feedback.getRV();


Resource r=new Resource("/tea/ui/member/feedback/Feedbacks").add("/tea/ui/member/feedback/FeedbackServlet");

java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("MM.dd HH:mm");

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
<h1><%=r.getString(teasession._nLanguage, "Feedbacks")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<div id="PathDiv">
<A href="/servlet/Glance?Member=<%=teasession._rv%>" TARGET="_blank"><%=teasession._rv%></A> >
<A href="/servlet/Feedbacks?Member=<%=s%>"><%=r.getString(teasession._nLanguage, "Feedbacks")%></A> >
<img src='/tea/image/hint/<%=feedback.getHint()%>.gif'/><%=feedback.getSubject(teasession._nLanguage)%>
</div>

<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Poster")%>:</td>
    <td><%=rv%> </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Time")%>:</td>
    <td><%=sdf.format(feedback.getTime())%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
    <td><img src='/tea/image/hint/<%=feedback.getHint()%>.gif'/><%=feedback.getSubject(teasession._nLanguage)%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Content")%>:</td>
    <td><%=feedback.getContent(teasession._nLanguage)%></td>
  </tr>
</table>
<%
String picture=feedback.getPicture(teasession._nLanguage);
if(picture!=null&&picture.length()>0)
{
  out.print(new tea.html.Image(picture));
}

String voice=feedback.getVoice(teasession._nLanguage);
if(voice!=null&&voice.length()>0)
{
  %>
<input type="button" onclick="window.open('<%=voice%>');" value="<%=r.getString(teasession._nLanguage, "Play")%>"/>
<%
}

String file=feedback.getFileData(teasession._nLanguage);
if(file!=null&&file.length()>0)
{%>
<input type="button" onclick="window.open('/jsp/include/DownFile.jsp?uri=<%=java.net.URLEncoder.encode(file,"UTF-8")%>&name=<%=java.net.URLEncoder.encode(feedback.getFileName(teasession._nLanguage),"UTF-8")%>','_self');" value="<%=r.getString(teasession._nLanguage, "Download")%>"/>
<%}

if(teasession._rv != null && (teasession._rv.equals(rv) || teasession._rv.isWebMaster()))
{%>
<input type=button onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))window.open('/servlet/DeleteFeedback?Member=<%=s%>&Feedback=<%=i%>','_self') ;"  value="<%=r.getString(teasession._nLanguage, "Delete")%>"/>
<%}%>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

