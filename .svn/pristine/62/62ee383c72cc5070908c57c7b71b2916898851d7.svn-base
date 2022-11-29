<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/ui/member/node/Nodes");

String menuid=request.getParameter("id");
StringBuffer par=new StringBuffer();
par.append("?community=").append(teasession._strCommunity);
par.append("&id=").append(menuid);
par.append("&pos=");

String sql=" AND n.rcreator=" + DbAdapter.cite(teasession._rv._strR)+" AND node IN(SELECT node FROM Listing)";

String tmp = request.getParameter("pos");
int pos = tmp != null ? Integer.parseInt(tmp) : 0;
int j = Node.count(sql);

//定义列举的节点

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
<h1><%=j%> <%=r.getString(teasession._nLanguage, "ListingNodes")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <div id="PathDiv"><%=TeaServlet.hrefGlance(teasession._rv)%> ><a href="/jsp/node/Nodes.jsp"><%=r.getString(teasession._nLanguage, "Nodes")%></A> ><%=r.getString(teasession._nLanguage, "ListingNodes")%></div>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id=tableonetr>
      <td><%=r.getString(teasession._nLanguage,"Subject")%></td>
      <td></td>
    </tr>
<%
if(j<1)
out.print("<tr><td align='center'>暂无记录");
else
{
  Enumeration e=Node.find(sql,pos,25);
  while(e.hasMoreElements())
  {
    int k = ((Integer)e.nextElement()).intValue();
    out.print("<tr onmouseover=bgColor='#BCD1E9' onMouseOut=bgColor=''><td>"+Node.find(k).getAncestor(teasession._nLanguage));
    out.print("<td><input type='button' onClick=window.open('/jsp/listing/Listings.jsp?node="+k+"'); value='"+r.getString(teasession._nLanguage, "Detail")+"'>");
  }
}
%>
</table>
<%=new tea.htmlx.FPNL(teasession._nLanguage, par.toString(), pos, j)%>

<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>
