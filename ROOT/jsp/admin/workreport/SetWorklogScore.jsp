<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.ui.TeaSession"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if (teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

String community = teasession._strCommunity;
Resource r = new Resource("/tea/resource/Workreport");
int worklog = Integer.parseInt(request.getParameter("worklog"));

Worklog obj = Worklog.find(worklog);

if("POST".equals(request.getMethod()))
{
  int score = Integer.parseInt(request.getParameter("score"));
  obj.setScore(score);
  out.print("<script>window.close();</script>");
  return;
}

int score=obj.getScore();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body >
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" METHOD="post" action="?">
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="worklog" value="<%=worklog%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage,"MemberId") %></td>
    <td><%=obj.getMember()%></td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage,"1168584443703")%><!--  客户或项目-->    </td>
    <td>
    <%
    int wpid=obj.getWorkproject();
    Flowitem wp=Flowitem.find(wpid);
    if(wp.isExists())
    {
      out.print(wp.getName(teasession._nLanguage));
    }
    %>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"分数")%></td>
    <td>
    <select name="score">
    <!--<option value="">-------</option>-->
    <%
    for(int i=0;i<101;i++)
    {
      out.print("<option value='"+i+"'");
      if(score==i)
      {
        out.print(" selected='true'");
      }
      out.print(">"+i);
    }
    %>
    </select>
    </td>
  </tr>
</table>
<input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>" >
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBClose")%>" onclick="window.close();">
</form>

<br>
<div id="head6">
  <img height="6" src="about:blank">
</div>
</body>
</html>
