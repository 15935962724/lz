<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


String s = request.getParameter("member");
if(s == null)
if(teasession._rv != null)
{
  s = teasession._rv._strR;
} else
{
  response.sendRedirect("/servlet/StartLogin");
  return;
}

Resource r=new Resource("/tea/ui/member/feedback/FeedbackServlet");

r.add("/tea/ui/member/feedback/Feedbacks");
String s1 = request.getParameter("pos");
int i = s1 != null ? Integer.parseInt(s1) : 0;
int j = Feedback.count(teasession._strCommunity,s);

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
<h1><%=j%> <%=r.getString(teasession._nLanguage, "Feedbacks")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="PathDiv"><A href="/jsp/access/Glance.jsp?Member=<%=java.net.URLEncoder.encode(s,"UTF-8")%>" TARGET="_blank"><%=s%></A> >
  <%=r.getString(teasession._nLanguage, "Feedbacks")%>
</div>

<table cellspacing="0" cellpadding="0" id="tablecenter">
  <tr ID=tableonetr>
  <td><%=r.getString(teasession._nLanguage, "Subject")%></td>
  <td><%=r.getString(teasession._nLanguage, "Creator")%></td>
  <td>&nbsp;</td>
  </tr>
  <%
  if(j != 0)
  {
    for(Enumeration enumeration = Feedback.find(teasession._strCommunity,s, i, 25); enumeration.hasMoreElements();)
    {
      int k = ((Integer)enumeration.nextElement()).intValue();
      Feedback feedback =Feedback.find(k);
      tea.entity.RV rv = feedback.getRV();
      out.print("<tr onmouseover=bgColor='#BCD1E9' onMouseOut=bgColor=''><td><a href='/jsp/feedback/Feedback.jsp?Member="+s+"&Feedback="+k+"'><img src='/tea/image/hint/"+feedback.getHint()+".gif'/>"+feedback.getSubject(teasession._nLanguage)+"</a></td>");
      out.print("<td>"+rv);//ts.hrefGlance(rv)
      out.print("<td>&nbsp;");
      if(teasession._rv != null && teasession._rv.equals(rv) || teasession._rv.isWebMaster())
      {
        out.print("<input type='button' class='edit_button' value='"+r.getString(teasession._nLanguage, "CBDelete")+"' onclick=\"if(confirm('"+r.getString(teasession._nLanguage, "ConfirmDelete")+"'))window.open('/servlet/DeleteFeedback?Member="+s+"&Feedback="+k+"','_self');\">");
      }
    }
}%>
</table>
<%--
if(teasession._rv != null && teasession._rv.isWebMaster())
{%>
<input onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteAll")%>'))window.open('/servlet/DeleteAllFeedbacks?Member=<%=s%>','_self');" type=button class="edit_button" value=<%=r.getString(teasession._nLanguage, "DeleteAll")%>>
<%
}
--%>
<input type=button class="edit_button" onClick="window.open('/jsp/feedback/NewFeedback.jsp?member=<%=s%>','_self')" value="<%=r.getString(teasession._nLanguage, "PostFeedback")%>">
<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>

