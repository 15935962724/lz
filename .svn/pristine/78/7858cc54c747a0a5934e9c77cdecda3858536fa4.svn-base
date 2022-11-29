<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.node.type.mpoll.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/my/Login.jsp?nexturl=" + Http.enc(request.getRequestURI() + "?" + request.getQueryString()));
  return;
}

%><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script>var pmt=parent.mt;</script>
</head>
<body>

<form name="form1" action="?">


<table id="tablecenter" cellspacing="0">
<%
Iterator it=Question.find(" AND poll=0",0,10).iterator();
for(int i=0;it.hasNext();i++)
{
  Question t=(Question)it.next();
  if(i%5==0)out.print("<tr>");
  %>
    <td><input type="button" name="invites" value="<%=t.name[1]%>" onclick="mt.act(<%=t.question%>)"/></td>
  <%
}
%>
</table>


</form>
<script>
mt.act=function(i)
{
  pmt.act('add',0,i);
};
</script>

</body>
</html>
