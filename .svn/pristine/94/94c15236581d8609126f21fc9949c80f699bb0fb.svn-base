<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.util.*" %>
<%
TeaSession teasession=new TeaSession(request);

String field=request.getParameter("field");

int city=0;
String tmp=request.getParameter("city");
if(tmp!=null)
{
  city=Integer.parseInt(tmp);
}


String s1;
if(city==0)
{
  s1=" AND card<100";
}else
{
  s1=" AND card LIKE "+DbAdapter.cite(city+"__");
}

StringBuffer sb=new StringBuffer();
sb.append("<table id=chengs>");
Enumeration e=Card.find(s1,0,Integer.MAX_VALUE);
for(int i=0;e.hasMoreElements();i++)
{
  Card c=(Card)e.nextElement();
  int id=c.getCard();
  if(i%11==0)
  {
    sb.append("<tr>");
  }
  sb.append("<td><a href=javascript:f_city("+id+")>"+c.getAddress()+"</a>");
}
sb.append("</table>");
if(city!=0)
{
  sb.append("<a href=javascript:f_city(0)>返回&lt;&lt;</a>");
}

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script>
var f=parent.<%=field%>;
function f_city(id)
{
  if(id!=0)
  {
    f.value=id;
    f.form.submit();
  }
  if(id!=11&&id!=12&&id!=50&&id<100)
  {
    location.replace('?field=<%=field%>&city='+id);
  }
}
</script>
</head>
<body>

<%=sb.toString()%>

<!--
<div id="city">
document.write("<%//=sb.toString()%>");
</div>
-->
</body>
</html>
