<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

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
  int start=Integer.parseInt(request.getParameter("start"));
  obj.sethours(h,start);
  response.sendRedirect("/jsp/util/EditLucene.jsp?community="+community+"&lucenelist="+lucenelist);
  return;
}
%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

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
    <td>任务执行间隔</td><td><input name="hours" type="text" value="<%=obj.getHours()%>">小时</td>
  </tr>
   <tr>
    <td>任务执行时间</td><td><input name="start" type="text" value="<%=obj.getStart()%>">点</td>
  </tr>
  </table>
<input type="submit" name="class" value="<%=r.getString(teasession._nLanguage,"submit")%>"/>
</form>
<div id="head6"><img height="6" alt=""></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

