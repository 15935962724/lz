<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.*"%>
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
String  str="",strpath="";

if(teasession.getParameter("str")!=null && teasession.getParameter("str").length()>0)
{
  str= teasession.getParameter("str");
  if("first".equals(str))
  {
    strpath = ccobj.getYxfirstpath();
  }
  else if("last".equals(str))
  {
    strpath = ccobj.getYxlastpath();
  }
}

%>
<head><link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
</head>
<body bgcolor="#ffffff">
<table>
<tr>
<td><img alt="" src="<%=strpath%>" /></td>
</tr>
</table>
</body>
