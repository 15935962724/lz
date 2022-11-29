<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Resource r=new Resource("/tea/ui/member/node/Nodes");

String s =  request.getParameter("Pos");
int i = s != null ? Integer.parseInt(s) : 0;

String sql=" AND node IN(SELECT node FROM Aded WHERE rmember=" + DbAdapter.cite(teasession._rv._strR) + " AND vmember=" + DbAdapter.cite(teasession._rv._strV)+")";
int j=Node.count(sql);




%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<h1><%=j%> <%=r.getString(teasession._nLanguage, "AdedNodes")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="PathDiv"><%=TeaServlet.hrefGlance(teasession._rv)%> ><A HREF="/jsp/node/Nodes.jsp"><%=r.getString(teasession._nLanguage, "Nodes")%></A> ><%=r.getString(teasession._nLanguage, "AdedNodes")%></div>

<table cellspacing="0" cellpadding="0" id="tablecenter">
  <tr id=tableonetr>
    <td><%=r.getString(teasession._nLanguage,"Subject")%></td>
    <td></td>
  </tr>

<%
if(j<1)
out.print("<tr><td align='center'>暂无记录");
else
{
  Enumeration e = Node.find(sql,i,25);
  while(e.hasMoreElements())
  {
    int k = ((Integer)e.nextElement()).intValue();
    out.print("<tr onmouseover=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
    out.print("<td>"+Node.find(k).getAncestor(teasession._nLanguage));
    out.print("<td><input type='button' onClick=window.open('/servlet/Adeds?node="+k+"','_self'); value='"+r.getString(teasession._nLanguage, "Detail")+"'>");
  }
}
%>
</table>
<%=new tea.htmlx.FPNL(teasession._nLanguage, "/servlet/AdedNodes?Pos=", i, j)%>


  <div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>
