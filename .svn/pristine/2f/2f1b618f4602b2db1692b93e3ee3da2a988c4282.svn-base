<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);




%><html><head>
<style type="text/css">
body,td,th {
	font-size: 13px;
}
</style>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>

<select id="vote" onchange="c(value)">
<%
Iterator it = BBSPoll.find(" AND node=" + h.node,0,200).iterator();
while(it.hasNext())
{
  BBSPoll bp = (BBSPoll) it.next();
  out.print("<option value='"+bp.member+"'>"+bp.question);
}
%>
</select>

<div id="view"></div>

<script>
function c(v)
{
  $('view').innerHTML=v=='|'?"暂无":v.replace(/[|]/g,'</a> <a href=### onclick=o(this)>')+'</a>';
}
function o(a)
{
  parent.location='/jsp/type/bbs/ViewBBSProfile.jsp?member='+encodeURIComponent(a.innerHTML);
}
$('vote').onchange();
</script>
</body>
</html>
