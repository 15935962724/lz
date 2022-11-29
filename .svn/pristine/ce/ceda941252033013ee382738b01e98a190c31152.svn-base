<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>

<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "ProductSel")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id=tableonetr>
    <td><%=r.getString(teasession._nLanguage, "Code")%></td>
    <td><%=r.getString(teasession._nLanguage, "Subject")%></td>
    <td><%=r.getString(teasession._nLanguage, "IssueTime")%></td>
  </tr>
<%
String name=request.getParameter("index");
java.util.Enumeration e=Node.find(" AND type=34 AND community="+DbAdapter.cite(node.getCommunity())+" AND rcreator="+DbAdapter.cite(teasession._rv._strR),0,100);
int nodecode;
while(e.hasMoreElements())
{
  nodecode = ((Integer) e.nextElement()).intValue();
  tea.entity.node.Node obj = tea.entity.node.Node.find(nodecode);

%><A href="#" onclick="fclick('<%=nodecode%>')" >
<tr onmouseover="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" style="cursor:hand ">
<TD><%=nodecode%></TD>
<td> <%=obj.getSubject(teasession._nLanguage)%></td>
<td><%=obj.getTimeToString()%></td>
</tr></A>
<%}%>
<script>
var parent_window = window.dialogArguments;
function fclick(theDate)
{
   parent_window.<%=name%>.value=theDate;
   window.close();
}
</script>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</html>
