<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/Workreport");

String member=request.getParameter("member");

StringBuffer sql=new StringBuffer();
sql.append(" community="+DbAdapter.cite(teasession._strCommunity)+" AND member=").append(DbAdapter.cite(member));


//int unit=AdminUsrRole.find(teasession._strCommunity,member).getUnit();
//AdminUnit au=AdminUnit.find(unit);
//if(au.isExists())
//{
//  out.print(au.getName());
//}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<h1><%=member%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" METHOD=get action="?" >
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="act" value="exportworklogs"/>
<%
DbAdapter db=new DbAdapter();
try
{
  int count=db.getInt("SELECT COUNT(DISTINCT workproject) FROM Worklog WHERE"+sql.toString());
  out.print("<h2>"+r.getString(teasession._nLanguage,"1168575045718")+"( "+count+" )</h2>");
  //
  out.print("<table border='0' cellpadding='0' cellspacing='0' id='tablecenter'>");
  out.print("<tr id='tableonetr'><td>项目<td>平均分<td>日志条数");

  db.executeQuery("SELECT workproject,AVG(score),COUNT(workproject) FROM Worklog WHERE"+sql.toString()+" GROUP BY workproject");
  for(int i=0;db.next();i++)
  {
    int wpid=db.getInt(1);
    int avg=db.getInt(2);
    int cou=db.getInt(3);
    Flowitem fi=Flowitem.find(wpid);
    out.print("<tr><td>");
    if(fi.isExists())out.print(fi.getName(teasession._nLanguage));
    out.print("<td>"+(avg>0?String.valueOf(avg):"--"));
    out.print("<td>"+cou);
  }
  out.print("</table>");
}finally
{
  db.close();
}
%>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
