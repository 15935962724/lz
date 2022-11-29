<%@page contentType="text/html;charset=UTF-8" %><%@   page   language="java"   import="java.util.*"   %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=request.getParameter("community");

Date date = new Date();
Calendar calendar = Calendar.getInstance();
calendar.setTime(date);

calendar.get(calendar.MONTH);
calendar.get(calendar.DATE);

String years = null;
if(teasession.getParameter("year")!=null && teasession.getParameter("year").length()>0)
{
  years = teasession.getParameter("year");
}
else
{
  years = String.valueOf(calendar.get(calendar.YEAR));
}
String months = null;
if(teasession.getParameter("month")!=null && teasession.getParameter("month").length()>0)
{
  months = teasession.getParameter("month");
}
else
{
  months = String.valueOf(calendar.get(calendar.MONTH)+1);
}
String dates = null;
if(teasession.getParameter("date")!=null && teasession.getParameter("date").length()>0)
{
  dates = teasession.getParameter("date");
}
else
{
    dates = String.valueOf(calendar.get(calendar.DATE));
}


%>
<html>
<body bgcolor="#ffffff">
<table>
<tr>
<td><iframe name="iFrame1" src="/jsp/admin/flow/DayOrder.jsp" width="250" scrolling="no" height="249" frameborder="0">
</iframe>
</td>
<td valign="top"><iframe name="iFrame2" src="/jsp/admin/flow/NewAffair.jsp?community=<%=community %>&year=<%=years%>&month=<%=months%>&date=<%=dates%>" style="border:0px;"  frameborder="0" height="249"  scrolling="no" onload="this.width=iFrame2.document.body.scrollWidth">
</iframe></td>
</tr>
<tr>
<td valign="top" colspan="2"><iframe name="iFrame3" frameborder="0" style="border:0px;"  width="100%" src="/jsp/admin/flow/Affair.jsp?community=<%=community %>&year=<%=years%>&month=<%=months%>&date=<%=dates%>"  scrolling="no" onload="this.height=iFrame3.document.body.scrollHeight;">
</iframe>
</td>
</tr>
</table>
</body>
</html>
