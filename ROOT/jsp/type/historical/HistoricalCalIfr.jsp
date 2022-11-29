<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.text.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);

String[] WEEK={"<font color=red>日</font>","一","二","三","四","五","<font color=red>六</font>"};

Calendar c=Calendar.getInstance();

//c.add(Calendar.MONTH,h.getInt("add"));

int MONTH=c.get(Calendar.MONTH)+1,DAY=c.get(Calendar.DAY_OF_MONTH);

int month=h.getInt("month",-1);
if(month!=-1)c.set(Calendar.MONTH,month-1);
month=c.get(Calendar.MONTH)+1;


c.set(Calendar.DAY_OF_MONTH,1);

DecimalFormat DF2=new DecimalFormat("00");


%>
<html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<style>
.exist{ background-color:#FF0000; cursor:pointer}
</style>
</head>
<body style="background-color:transparent">
<div class="month">
<table border="0" class="monthTable">
  <tr id="TableControl">
    <td><a href="?node=<%=h.node%>&month=<%=month-1%>">&lt;&lt;</a></td>
    <td><%=Entity.MONTH_zh[month]%>月</td>
    <td><a href="?node=<%=h.node%>&month=<%=month+1%>">&gt;&gt;</a></td>
  </tr>
</table>
<div class="TimeTableDiv">
<table class="TimeTable" cellspacing="0">
<%
out.print("<tr id='tableonetr'>");
for(int i=0;i<7;i++)
{
  out.print("<td>"+WEEK[i]);
}


out.print("<tr>");
int total=0;
while(++total<c.get(Calendar.DAY_OF_WEEK))
{
  out.print("<td>&nbsp;");
}
total--;
for(int day=1;month==c.get(Calendar.MONTH)+1;total++,day++,c.add(Calendar.DAY_OF_MONTH,1))
{
  if(total%7==0)out.print("<tr>");
  out.print("<td");

  Iterator it=Historical.find(" AND month="+month+" AND day="+day+" AND micro>0",0,200).iterator();
  if(it.hasNext())
  {
    out.print(" class='exist' title='");
    for(int i=1;it.hasNext();i++)
    {
      Historical t=(Historical)it.next();
      Node n=Node.find(t.node);
      if(i>1)out.print("&#13;");
      out.print(i+"、"+n.getSubject(h.language));
    }
    out.print("' onclick=parent.location='/html/category/"+h.node+"-"+h.language+".htm?oday="+DF2.format(month)+DF2.format(day)+"'");
  }
  if(month==MONTH&&day==DAY)out.print(" class='now'");
  out.print(">"+day);
}
%>
</table></div>
<div class="more"><a href="/html/category/4869-1.htm" target="_parent">查看详细事件日历</a></div>
</div>
</body>
</html>
