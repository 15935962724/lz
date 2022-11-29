<%@page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%
     long l5 = System.currentTimeMillis();
        java.util.Calendar calendar = java.util.Calendar.getInstance();
calendar.setTime(new Date(l5));


int CUR_YEAR = calendar.get(1);
int CUR_MON  = calendar.get(2) + 1;
int CUR_DAY = calendar.get(5) ;
String  SYEAR=request.getParameter("YEAR");
String SMONTH=request.getParameter("MONTH");
String FIELDNAME=request.getParameter("FIELDNAME");

if(SYEAR==null)
   SYEAR =(new Integer(CUR_YEAR)).toString();
if(SMONTH==null)
   SMONTH =(new Integer(CUR_MON)).toString();
int YEAR=Integer.parseInt(SYEAR);
int MONTH=Integer.parseInt(SMONTH);
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
%>
<html>
<head>
<script >
function setDate(step)
{
    var MONTH=<%=SMONTH%>+step;
    var YEAR=<%=SYEAR%>;
    if(MONTD>12)
    {
        YEAR++;
        MONTH=1;
    }
    if(MONTH<=0)
    {
        MONTH=12;
        YEAR--;
    }
    window.open('Calendar.jsp?YEAR='+YEAR+'&MONTH='+MONTH,'_self');
}
function getDate()
{
    n.setDate(1);
    dow=n.getDay();
    moy=n.getMonth();
    for (i=0;i<41;i++)
    {
        if ((i<dow)||(moy!=n.getMonth()))
        dt="&nbsp;";
        else
        {
            dt=n.getDate();
            n.setDate(n.getDate()+1);

            if(dt==<%=CUR_DAY%>&&cm==<%=CUR_MON%>&&yr==<%=CUR_YEAR%>)
            dt="<a href='#' onclick='dateClick("+dt+")'><font color=red>"+dt+"</font></a>";
            else
            dt="<a href='#' onclick='dateClick("+dt+")'>"+dt+"</a>";
        }
    }
}
    </script>
    </head>

    <body>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td><a href="#"  onclick="setDate(-1);" >&lt;&lt; &lt;</A></td>
                <td>:</td>
                <td><%=SMONTH%></td>
                <td>&nbsp;</td>
                <td><%=SYEAR%></td>
                <td>:</td>
                <td><a href="#" onclick="setDate(1);" >&gt; &gt;&gt;</A></td>
            </tr>
            <tr>
                <td>Sun</td>
                <td>Mon</td>
                <td>Tue</td>
                <td>Wed</td>
                <td>Thu</td>
                <td>Fri</td>
                <td>Sat</td>
            </tr>

  <tr><%java.util.Calendar calendar2 = java.util.Calendar.getInstance();
calendar2.set(YEAR,MONTH-1,1);
int week=calendar2.get(calendar2.DAY_OF_WEEK)-1;/*
System.out.println(week);
System.out.println("YEAR:"+ calendar.get(calendar.YEAR));
System.out.println("MONTH:"+ calendar.get(calendar.MONTH));
System.out.println("DAY_OF_MONTH:"+ calendar.get(calendar.DAY_OF_MONTH));*/
int sum=30;
if(MONTH==1||MONTH==3||MONTH==5||MONTH==7||MONTH==8||MONTH==10||MONTH==12)
{
   sum=31;
}else if(MONTH==2)
{
    sum=28;
}
       for(int i=0;i<42;i++)
       {
           if(i%7==0)out.println("<tr>");
           if(i>week-1&&sum>=i-week+1)
           {
               out.println("<TD>");
               if(tea.entity.node.Event.exists(YEAR,MONTH,i-week+1,teasession._nLanguage))
                   out.println("<a target=\"_parent\" href='/servlet/Event?node=14995&Listing=5484&timeStart="+YEAR+MONTH+(i-week+1)+"&id='>");//在id=的后面添加列举号----------
               if(calendar.get(calendar.YEAR)==YEAR&&calendar.get(calendar.MONTH)==MONTH-1&&calendar.get(calendar.DAY_OF_MONTH)==i-week+1)
                   out.println("<font color=\"#00FFFF\">");
               out.println((i-week+1)+"</td>");
           }else
               out.println("<td></td>");
}%>
  </tr>
</table>
</body>
</html>

