<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.site.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/ui/member/community/Communities");
int i = JoinRequest.countJoining(teasession._rv);
String s;
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
<h1><%=i%> <%=r.getString(teasession._nLanguage, "JoiningCommunities")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>


<div id="PathDiv"><%=TeaServlet.hrefGlance(teasession._rv)%> ><A href="/servlet/Communities"><%=r.getString(teasession._nLanguage, "Communities")%></A> ><%=r.getString(teasession._nLanguage, "JoiningCommunities")%>
</DIV>

<%
if(i>0)
{
%>
<table cellspacing="0" cellpadding="0" id="tablecenter">
<tr ID=tableonetr>
<td width="1"></td>
<td><%=r.getString(teasession._nLanguage,"Community")%></td>
</tr>

    <%
    int index=1;
    for(java.util.Enumeration enumeration =tea.entity.site. JoinRequest.findJoining(teasession._rv); enumeration.hasMoreElements();index++)
    {
      s = (String)enumeration.nextElement();
%>
    <tr>
    <td><%=index%></td>
      <TD><a href="/servlet/Node?Community=<%=s%>"><%=s%></a></TD></tr>
      <%
    }%>

  </table>
<%}%>

  <div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>



