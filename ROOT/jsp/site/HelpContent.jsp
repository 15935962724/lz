<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.resource.Resource"  %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*"%><%
request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);


int help=Integer.parseInt(request.getParameter("help"));


//Resource r=new Resource();





%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%
if(help<1)return;

Help obj=Help.find(help);

obj.set("hits",String.valueOf(obj.getHits()+1));

%>
<h1><%=obj.getSubject(teasession._nLanguage)%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<table border="0" cellpadding="0" cellspacing="0" id="bangzhu">
 <tr><td><%=obj.getContent(teasession._nLanguage)%></td></tr>
</table>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
