<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@page import="tea.ui.TeaSession"%><%@page import="tea.entity.site.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.resource.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.admin.orthonline.*"%><%@page import="java.util.Date"%><%@page import="java.util.*"%>
<%

request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);

int ids = 0;
if(teasession.getParameter("ids")!=null && teasession.getParameter("ids").length()>0)
{
  ids = Integer.parseInt(teasession.getParameter("ids"));
}
CaseCollection ccobj = CaseCollection.find(ids);

%>
<head><link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
</head>
<body bgcolor="#ffffff">
<table>
<tr>
<td>专家姓名：</td><td><%if(ccobj.getZjname()!=null)out.print(ccobj.getZjname());%></td>
<td>所在医院：</td><td><%if(ccobj.getZjyy()!=null)out.print(ccobj.getZjyy());%></td>
<td>点评：</td><td> <%if(ccobj.getZhuanjiadp()!=null)out.print(ccobj.getZhuanjiadp());%>  </td>
</tr>
</table>
</body>
