<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int id=Integer.parseInt(teasession.getParameter("id"));
int dynamictype=Integer.parseInt(teasession.getParameter("dynamictype"));

Resource r=new Resource();

String member=request.getParameter("member");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function f_open(v)
{
  window.open("?community=<%=teasession._strCommunity%>&id=<%=id%>&dynamictype=<%=dynamictype%>&member="+encodeURIComponent(v),"","width=500,height=300");
}
</script>
</head>
<body onload="">
<h1>会签意见栏</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<%
if(member!=null)
{
  DynamicCsign dc=DynamicCsign.find(id,dynamictype,member);
  out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
  out.print("<tr><td>");
  out.print(dc.getContent());
  out.print("</table>");
}else
{
%>
<form name="form1" action="?" method="post" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="id" value="<%=id%>">
<input type="hidden" name="dynamictype" value="<%=dynamictype%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td>送签时间</td>
    <td>会签部门/人员</td>
    <td>会签意见</td>
    <td>签名</td>
    <td>签出日期</td>
  </tr>
<%
Enumeration e=DynamicCsign.find(id,dynamictype);
while(e.hasMoreElements())
{
  String m=(String)e.nextElement();
  if(!m.equals(teasession._rv._strV))
  {
    DynamicCsign dc=DynamicCsign.find(id,dynamictype,m);
    out.print("<tr>");
    out.print("<td>"+dc.getStartTimeToString());
    out.print("<td>"+dc.getUnit());
    out.print("<td>"+DynamicCsign.COMMENT_TYPE[dc.getComment()]);
    if(dc.getComment()==2)
    {
      out.print("<a href=### onclick=f_open('"+m+"');>打开</a>");
    }
    out.print("<td><img src="+dc.getSign()+" onload=this.style.display=''; style=display:none>");
    out.print("<td>"+dc.getStartTimeToString());
  }
}
%>
</table>
</form>
<%}%>
<input type="button" value="关闭" onClick="window.close();">

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
