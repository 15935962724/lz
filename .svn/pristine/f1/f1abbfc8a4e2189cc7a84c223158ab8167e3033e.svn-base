<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);

String[] WEEK={"<font color=red>Sun</font>","Mon","Tur","Wed","Thu","Fri","<font color=red>Sat</font>"};

Calendar c=Calendar.getInstance();
int month=h.getInt("month",c.get(Calendar.MONTH)+1)-1;

c.set(Calendar.DAY_OF_MONTH,1);
c.set(Calendar.MONTH,month);
%>

<div class="calendarTop"><div class="left"></div><div class="right">
<table cellspacing="0">
<tr>
<%
for(int i=1;i<13;i++)
{
  out.print("<td><a href='?month="+i+"'");
  if(i-1==month)out.print(" class='cur'");
  out.print(">"+i+"</a></td>");
}
%>
</tr>
</table>
</div>
</div>
<table class="bigCalendar" cellspacing="0">
<%

StringBuilder sb=new StringBuilder();
for(int i=0;month==c.get(Calendar.MONTH);i++,c.add(Calendar.DAY_OF_MONTH,1))
{
  if(i%5==0)
  {
    out.print(sb.toString());
    sb=new StringBuilder("<tr>");
    out.print(sb.toString());
  }
  int day=c.get(Calendar.DAY_OF_MONTH);
  out.print("<th>"+WEEK[c.get(Calendar.DAY_OF_WEEK)-1]+" "+day+"</th>");

  sb.append("<td>");

  Iterator it=Historical.find(" AND month="+(month+1)+" AND day="+day+" AND micro>0",0,200).iterator();
  while(it.hasNext())
  {
    Historical t=(Historical)it.next();
    Node n=Node.find(t.node);
    sb.append("<div class=title>"+n.getAnchor(h.language)+"</div>");
    String pic=n.getPicture(h.language);
    if(pic!=null)sb.append("<span class=img><img src="+pic+"></span>");
    sb.append("<span class=content>"+n.getText(h.language)+"</span>");
  }
}
out.print(sb.toString());
%>
</table>
