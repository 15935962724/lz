<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/member/feedback/FeedbackServlet");
request.setCharacterEncoding("gb2312");
String s = request.getParameter("Member");
if(s == null)
if(teasession._rv != null)
{
  s = teasession._rv._strR;
}else
{
  response.sendRedirect("/servlet/StartLogin");
  return;
}
r.add("/tea/ui/member/feedback/Feedbacks");
String s1 = request.getParameter("Pos");
int i = s1 != null ? Integer.parseInt(s1) : 0;
int j = Feedback.count(teasession._strCommunity,s);

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Feedbacks")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="PathDiv"><%=ts.hrefGlance(teasession._rv)%> ><%=r.getString(teasession._nLanguage, "Feedbacks")%> </div>
<h2 hu="hu"><%=j%> <%=r.getString(teasession._nLanguage, "Feedbacks")%></h2>
<table cellspacing="0" cellpadding="0" id="tablecenter">
<%
if(j != 0)
{
  Enumeration enumeration = Feedback.find(teasession._strCommunity,s, i, 25);
  while(enumeration.hasMoreElements())
  {
    int k = ((Integer)enumeration.nextElement()).intValue();
    tea.entity.member.Feedback feedback =tea.entity.member. Feedback.find(k);
    RV rv = feedback.getRV();
    out.print("<tr><td><a href='/servlet/Feedback?Member="+s+"&Feedback="+k+"'><img src='/tea/image/hint/"+feedback.getHint()+".gif'/>"+feedback.getSubject(teasession._nLanguage)+"</a></td>");
    out.print("<td>"+ts.hrefGlance(rv));
    if(teasession._rv != null && teasession._rv.equals(rv) || teasession._rv.isWebMaster())
    {
      out.print("<input type='button' class='edit_button' value='"+r.getString(teasession._nLanguage, "CBDelete")+"' onclick=\"if(confirm('"+r.getString(teasession._nLanguage, "ConfirmDelete")+"'))window.open('/servlet/DeleteFeedback?Member="+s+"&Feedback="+k+"','_self');\">");
    }
  }
}
%>
</table>
<%
if(teasession._rv != null && teasession._rv.isWebMaster())
{%>
<A href="/servlet/DeleteAllFeedbacks?Member=<%=s%>">
<input onClick="return(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteAll")%>'));" type=button class="edit_button" value=<%=r.getString(teasession._nLanguage, "DeleteAll")%>>
</A>
<%
}%>
<input type=button class="edit_button" onClick="window.open('/servlet/NewFeedback?Member=<%=s%>')" value=<%=r.getString(teasession._nLanguage, "PostFeedback")%>>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage, request)%></div>
</body>
</html>

