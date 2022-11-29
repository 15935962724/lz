<%@page contentType="text/html;charset=utf-8"%><%@page import="tea.entity.node.Node" %><%

tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
tea.resource.Resource r=new tea.resource.Resource();
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "NightShopList")%></h1>
<div id="head6"><img SRC=cel"/images/1k.gif" height="6"></div>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%

String name=request.getParameter("index");
  java.util.Enumeration enumeration = tea.entity.node.Node.findByType(45, node.getCommunity());
  int nodecode;
  while (enumeration.hasMoreElements()){
    nodecode = ((Integer) enumeration.nextElement()).intValue();
    node = Node.find(nodecode);

%>
<tr><td>
<A href="#" onclick="fclick('<%=nodecode%>')" ><%=nodecode%></A> </td>
<td><A href="#" onclick="fclick('<%=nodecode%>')" ><%=node.getSubject(teasession._nLanguage)%></A></td>
<td><A href="#" onclick="fclick('<%=nodecode%>')" ><%=node.getTimeToString()%></A></td>
</tr>
<%}%>
<script type="">
var parent_window = window.dialogArguments;
function fclick(theDate)
{
   parent_window.<%=name%>.value=theDate;
   window.close();
}
</script>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

