<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%

r.add("/tea/ui/node/type/poll/EditPoll");
String community=request.getParameter("community");
if(community==null)
community=node.getCommunity();

String member=request.getParameter("member");

%>



<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
 <h1><%=r.getString(teasession._nLanguage, "Poll")%></h1>
 <br>
<div id="head6"><img height="6" src="about:blank"></div>

<form action="/servlet/EditPoll" method="POST" name="home_form111_net">
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<%
if(request.getParameter("id")!=null)out.print("<input type=hidden name=id value="+request.getParameter("id")+" >");
%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr"><td><%=r.getString(teasession._nLanguage, "Question")%></td><td><%=r.getString(teasession._nLanguage, "Correct")%></td></tr>
    <%
DbAdapter dbadapter=new DbAdapter();
try
{
  dbadapter.executeQuery("SELECT pollresult FROM PollResult WHERE rmember="+DbAdapter.cite(member)+" AND node IN(SELECT node FROM Node WHERE community="+DbAdapter.cite(community)+")");
  while(dbadapter.next())
  {
    PollResult obj=PollResult.find(dbadapter.getInt(1));
    Poll poll_obj=Poll.find(obj.getPoll());
    PollChoice pc_obj=PollChoice.find(obj.getAnswer());

    out.print("<tr onmouseover=\"javascript:this.bgColor='#BCD1E9'\" onmouseout=\"javascript:this.bgColor=''\" >");
    out.print("<td>"+poll_obj.getQuestion()+"</td>");
    out.print("<td>");
    if(poll_obj.getType()<2)
    out.print(pc_obj.getChoice());
    else
    out.print(obj.getText(teasession._nLanguage));
    out.print("</td></tr>");
  }
}finally
{
 dbadapter.close();
}
%>
</table>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>

