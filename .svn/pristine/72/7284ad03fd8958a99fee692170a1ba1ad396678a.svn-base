<%@page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<ul>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
java.util.Enumeration enumer=tea.entity.node.NodeAccess.findLastByIp(request.getRemoteAddr());
while(enumer.hasMoreElements())
{
 // tea.entity.node.NodeAccess na=  tea.entity.node.NodeAccess.find(enumer.nextElement().toString());
int _nNode=  ((Integer)enumer.nextElement()).intValue();
tea.entity.node.Node node=tea.entity.node.Node.find(_nNode);
%>
<li>
<A href="/servlet/Node?node=<%=_nNode%>"><%=node.getSubject(teasession._nLanguage)%></A></li>
<%
}
%></ul>
</body>
</html>

