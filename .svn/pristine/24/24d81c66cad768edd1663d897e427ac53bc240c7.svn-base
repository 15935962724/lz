<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page  import="tea.entity.admin.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

tea.resource.Resource r=new tea.resource.Resource();

r.add("/tea/ui/node/type/poll/EditPoll");

String community=request.getParameter("community");

int answer=Integer.parseInt(request.getParameter("answer"));
int poll=Integer.parseInt(request.getParameter("poll"));

%><html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
 <h1><%=r.getString(teasession._nLanguage, "Poll")%></h1>
 <br>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<table border=0 cellpadding=0 cellspacing=0 id=tablecenter >
<tr id="tableonetr">
<td><%=r.getString(teasession._nLanguage,"MemberId")%></td>
 <%
 java.util.Enumeration  enumeration3= Poll.find(" AND type=2 AND node="+teasession._nNode);
 while(enumeration3.hasMoreElements())
 {
   int poll_id=((Integer)enumeration3.nextElement()).intValue();
   Poll poll_obj=Poll.find(poll_id);
   out.print("<td>"+poll_obj.getQuestion()+"</td>");
 }
 DbAdapter db=new DbAdapter();
 try
 {
   db.executeQuery("SELECT DISTINCT vmember FROM PollResult WHERE poll="+poll+" AND answer="+answer);
   while(db.next())
   {
     String member=db.getString(1);
     out.print("<tr onmouseover=\"javascript:this.bgColor='#BCD1E9'\" onmouseout=\"javascript:this.bgColor=''\"><td>");
     if(member.length()==32&&member.equals(member.toUpperCase()))
     {
       out.print("匿名");
     }else
     {
       out.print(member);
     }

     java.util.Enumeration enumeration4= Poll.find(" AND type=2 AND node="+teasession._nNode);
     while(enumeration4.hasMoreElements())
     {
       int poll_id=((Integer)enumeration4.nextElement()).intValue();

       PollResult obj=PollResult.find(poll_id,member);
       out.print("<td>"+obj.getText(teasession._nLanguage)+"</td>");
     }

   }
 }finally
 {
   db.close();
 }
 %>
 </table>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

