<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="tea.entity.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %>
<html>
<head>

<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/Lucene");

int lucenelist=Integer.parseInt(request.getParameter("lucenelist"));
LuceneList obj=LuceneList.find(lucenelist);
String community=teasession._strCommunity;
String nexturl=request.getParameter("nexturl");
if(request.getMethod().equals("POST"))
{
  int h=Integer.parseInt(request.getParameter("hours"));
  int starttime=Integer.parseInt(request.getParameter("starttime"));
  obj.sethours(h,starttime);
  response.sendRedirect("/jsp/util/EditLucene.jsp?community="+community+"&lucenelist="+lucenelist);
  return;
}
%>
function computehours()
{ obj=document.form1;
  var hours=obj.hours.value;
  var timetype=obj.timetype.value;
  if(timetype=="day")
   hours=hours*24;
  else if(timetype=="week")
   hours=hours*24*7;

obj.hours.value=hours;
obj.submit();
}

</script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body onload="form1.hours.focus();">
<h1><%=r.getString(teasession._nLanguage, "1167881089765")%></h1>
<div id="head6"><img height="6" alt=""></div>
   <br>
<FORM name=form1 METHOD=POST action="<%=request.getRequestURI()%>" onSubmit="">
<input type="hidden" name="lucenelist" value="<%=lucenelist%>"/>
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
  <%
  int hour= obj.hours;
  int timetype=1;
  if(hour>=24)
  { if(hour%(24*7)==0){
   hour=hour/(24*7);
   timetype=3;
   }
    else  if(hour%24==0)
   {hour=hour/24;
   timetype=2;
   }
  }

  %>

    <td>任务执行间隔</td><td><input name="hours" type="text" value="<%=hour%>">

    <select name="timetype">
    <option value="hour"  <% if(timetype==1) out.print("selected"); %>>小时</option>
    <option value="day"  <% if(timetype==2) out.print("selected"); %>>天</option>
    <option value="week"  <% if(timetype==3) out.print("selected"); %>>周</option>
    </select></td>
  </tr>
   <tr>
    <td>任务执行时间</td><td><input name="starttime" type="text" value="<%=obj.starttime%>">点</td>
  </tr>
  </table>
<input type="button" onclick="computehours()" name="class" value="<%=r.getString(teasession._nLanguage,"submit")%>"/>
</form>
<div id="head6"><img height="6" alt=""></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

