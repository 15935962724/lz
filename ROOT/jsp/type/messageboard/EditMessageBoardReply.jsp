<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="javax.servlet.ServletConfig" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.html.HtmlElement"%>
<%!
String getCheck(boolean bool)
{
	return bool?" CHECKED ":" ";
}
String getCheck(int value)
{
	return value!=0?" CHECKED ":" ";
}
String getNull(String strNull)
{	return strNull==null?"":strNull;
}%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
Resource r = new Resource();TeaSession teasession = new TeaSession(request);
Node   node=Node.find(teasession._nNode);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "EditMessageBoardReply")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<form NAME=foEdit METHOD=POST action="/servlet/EditMessageBoard" onSubmit="mt.show(null,0)">
<input type=hidden name=node value="<%=teasession._nNode%>">
<input type=hidden name=act value="editreply">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td></td>
    <td>
      <input  id="radio" type="radio" name=TextOrHtml value=0  checked="checked" ><%=r.getString(teasession._nLanguage, "TEXT")%>
      <input  id="radio" type="radio" name=TextOrHtml value=1 >HTML
    </td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
    <td nowrap><textarea name="content"  rows="8" cols="70" class="edit_input"></textarea></td>
  </tr>
</table>

<input type=submit onclick="return(submitText(foEdit.Text, '<%=r.getString(teasession._nLanguage,"InvalidParameter")%>'));" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
</form>

<script>document.foEdit.Text.focus();</script>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"> <%=new Languages(teasession._nLanguage,request)%> </DIV>
</body>
</html>
