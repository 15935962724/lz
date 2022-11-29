<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/include/Header.jsp"%>
<%
if(request.getMethod().equals("POST"))
{
  int answer=Integer.parseInt(request.getParameter("answer"));
  tea.entity.node.PollResult.create(teasession._nNode,teasession._nNode,teasession._rv,answer,teasession._nLanguage,null,null);
  response.sendRedirect("/jsp/type/poll/EditPollNode.jsp?node="+teasession._nNode);
  return;
}

r.add("/tea/resource/Poll");
String POLL_TYPE[]={"VeryGood","Good","General","Badly"};
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Poll")%><%=r.getString(teasession._nLanguage, "Node")%><%=r.getString(teasession._nLanguage, "Edit")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
  <form action="" method="POST">
    <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
    <input name="answer"  id="radio" type="radio" value="1">
    <%=r.getString(teasession._nLanguage,"VeryGood")%>
    <input name="answer"  id="radio" type="radio" value="2">
    <%=r.getString(teasession._nLanguage,"Good")%>
    <input name="answer"  id="radio" type="radio" value="3" checked="checked">
    <%=r.getString(teasession._nLanguage,"General")%>
    <input name="answer"  id="radio" type="radio" value="4">
    <%=r.getString(teasession._nLanguage,"Badly")%>
    <input name="" type="submit" value="<%=r.getString(teasession._nLanguage, "Poll")%>">
  </form>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <%
  for(int index=0;index<POLL_TYPE.length;index++)
  {
  %>
    <tr>
      <td><%=r.getString(teasession._nLanguage,POLL_TYPE[index])%></td>
      <td><div style="width:<%=tea.entity.node.PollResult.getResult(teasession._nNode,teasession._nLanguage,index+1,1,true)%>%; background-color:#3775CA;"></div></td>
      <td><%=tea.entity.node.PollResult.getResult(teasession._nNode,teasession._nLanguage,index+1,1,false)%></td>
    </tr>
    <%}%>
  </table>
  <div id="head6"><img height="6" src="about:blank"></div>

</body>
</html>

