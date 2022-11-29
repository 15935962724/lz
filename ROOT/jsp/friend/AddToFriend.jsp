<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
if(request.getMethod().equals("POST"))
{
  String member=request.getParameter("Member");
  int id=0;
  if(request.getParameter("id")!=null)
  id=Integer.parseInt(request.getParameter("id"));
  tea.entity.member.FriendList.create(teasession._rv.toString(),member,0,id);
  response.sendRedirect("/jsp/friend/FriendList.jsp?groupid="+id);
  return;
}

r.add("/tea/ui/member/contact/AddToContact");
if(!teasession._rv.isSupport())
{
  response.sendError(403);
  return;
}

String member = request.getParameter("Member");
if(member == null)
member = node.getCreator().toString();
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBAddToContact")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name=foAdd METHOD=POST action="">
<%=new tea.html.HiddenField("Member",member)%>

<a href="/jsp/message/CGroups.jsp?community=<%=teasession._strCommunity%>">组管理</a>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
java.util.Enumeration enumer = CGroup.find(teasession._rv._strV,"",0,Integer.MAX_VALUE);
while (enumer.hasMoreElements())
{
  int id = ((Integer) enumer.nextElement()).intValue();
  CGroup cg = CGroup.find(id);
  out.print("<tr><td><input id='radio' type='radio' name='id' value="+id+" checked='checked'>"+cg.getName(teasession._nLanguage));
}
%>
</table>
<input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
</form>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

