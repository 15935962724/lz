<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%
java.util.Date date=new java.util.Date();
java.util.Calendar calendar=java.util.Calendar.getInstance();
calendar.setTime(date);
int year=calendar.get(calendar.YEAR);
String month=String.valueOf(calendar.get(calendar.MONTH)+1);
if(month.length()==1)
month=0+month;
String day=String.valueOf(calendar.get(calendar.DAY_OF_MONTH));
if(day.length()==1)
day=0+day;

calendar.setTimeInMillis(System.currentTimeMillis()+24l * 60l * 60l * 1000l);
int year_stop=calendar.get(calendar.YEAR);
String month_stop=String.valueOf(calendar.get(calendar.MONTH)+1);
if(month_stop.length()==1)
month_stop=0+month_stop;
String day_stop=String.valueOf(calendar.get(calendar.DAY_OF_MONTH));
if(day_stop.length()==1)
day_stop=0+day_stop;


int week=calendar.get(calendar.DAY_OF_WEEK)-1;
//out.println("--------------"+week*24L*60L*60L*1000L+"---------------:"+week);
java.util.Calendar calendar2=java.util.Calendar.getInstance();
calendar2.setTimeInMillis(System.currentTimeMillis() - (week * 24l * 60l * 60l * 1000l));
//calendar2.set(calendar.DAY_OF_MONTH,-(week));
//System.out.println("2:"+calendar2.getTime());
int year2=calendar2.get(calendar2.YEAR);
String month2=String.valueOf(calendar2.get(calendar2.MONTH)+1);
if(month2.length()==1)
month2="0"+month2;
//System.out.println(calendar2.toString());
String day2=String.valueOf(calendar2.get(calendar2.DAY_OF_MONTH));
if(day2.length()==1)
day2="0"+day2;


 calendar2.setTimeInMillis(calendar2.getTimeInMillis() + (6 * 24l * 60l * 60l * 1000l));
int year2_stop=calendar2.get(calendar2.YEAR);
String month2_stop=String.valueOf(calendar2.get(calendar2.MONTH)+1);
if(month2_stop.length()==1)
month2_stop="0"+month2_stop;
String day2_stop=String.valueOf(calendar2.get(calendar2.DAY_OF_MONTH));
if(day2_stop.length()==1)
day2_stop="0"+day2_stop;

int month3_stop_var=Integer.parseInt(month)+1;
int year3_stop=year;
if(month3_stop_var>12)
{  month3_stop_var=1;
   year3_stop++;
}
String month3_stop=String.valueOf(month3_stop_var);
if(month3_stop.length()<=1)
{
    month3_stop="0"+    month3_stop;
}
%>



  <%
     long l5 = System.currentTimeMillis();
        java.util.Calendar calendar123 = java.util.Calendar.getInstance();
calendar123.setTime(new Date(l5));


int CUR_YEAR = calendar123.get(1);
int CUR_MON  = calendar123.get(2) + 1;
int CUR_DAY = calendar123.get(5) ;
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
<%!
String getMonth(int month)
{
//    var nonth_name=new Array(12);
  switch(month)
  {
      case 1:
      return "January";
      case 2:
      return "February";
      case 3:
      return "March";
      case 4:
      return "April";
      case 5:
      return "May";
            case 6:
      return "June";
            case 7:
      return "July";
            case 8:
      return "August";
            case 9:
      return "September";
      case 10:
      return "October";
      case 11:
      return "November";}
   //   case 12:
      return "December";
  //}
}
%>





<head>
<script>
function setStopTime()
{
switch(document.form1.timeStartBig.selectedIndex)
{
case 0:
document.form1.timeStartSmall.value=<%=String.valueOf(year_stop)+month_stop+day_stop%>;
break;

case 1:
document.form1.timeStartSmall.value=<%=String.valueOf(year2_stop)+month2_stop+day2_stop%>;
break;

case 2:
document.form1.timeStartSmall.value=<%=String.valueOf(year3_stop)+month3_stop+"01"%>;
break;

}
}




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
    window.open('EventSearch.jsp?YEAR='+YEAR+'&MONTH='+MONTH,'_self');
}
function getMonth(month)
{
//    var nonth_name=new Array(12);
  switch(month)
  {
      case 1:
      return "January";
      case 2:
      return "February";
      case 3:
      return "March";
      case 4:
      return "April";
      case 5:
      return "May";
            case 6:
      return "June";
            case 7:
      return "July";
            case 8:
      return "August";
            case 9:
      return "September";
      case 10:
      return "October";
      case 11:
      return "November";
  }
  //    case 12:
      return "December";

}
</script>
<style type="text/css">
<!--
.b1{display:block;background:#4A494A;}
table{color:#635531}
.b2{background:#4A494A;}
.b2 a{color:#FFFF00;font-weight:600;text-decoration:none;}

-->
</style>
</head>
<body scroll="no" style="padding:0px; margin:0px; border:none;background-color=transparent">
<table border="0" cellspacing="0" cellpadding="5">
    <form action="/servlet/Event?node=14995&Listing=5484&id=5721"  style="margin:-right:80px;"><!--//???id=????????????????????????-----?????????????????????????????????"???????????????????????????"----->
<tr>
      <td align="right">?????????</td>
      <td>
      <select name="timeStartBig" onChange="setStopTime()" style="color:#635531">
    <option value="<%=String.valueOf(year)+month+day%>">??????</option>
    <option value="<%=String.valueOf(year2)+month2+day2%>">??????</option>
    <option value="<%=year+month+"01"%>">??????</option>
  </select> <input type="hidden" value="" name="timeStartSmall"/>
?????????
<select name="sort"  style="color:#635531">
  <option>????????????</option>
  <option>????????????</option>
  <option>HIP-POP</option>
  <option>????????????</option>
  <option>DJ ??????</option>
  <option>????????????</option>
  <option>JAZZ</option>
  <option>????????????</option>
  <option>RAVE PARTY</option>
  <option>????????????</option>
  <option>ROCK</option>
  <option>????????????</option>
</select> </td>
      </tr>

    <tr>
      <td align="right">????????????</td>
      <td><input name="Having" type="text"  style="color:#635531" size="15">
      <input type="image" src="/tea/image/section/11080.jpg" name="Submit" value="Submit"></td>
    </tr>
    <tr>
      <td>???????????????</td>
      <td><table width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#4A494A" style="color:#BDBABD; ">
        <tr align="center" bgcolor="#97987F">
          <td colspan="7"><a href="#"  onClick="setDate(-1);" style="font-size:9pt;color:#282828;text-decoration: none; " >&lt;&lt; &lt;</a> : <%=getMonth(Integer.parseInt(SMONTH))%> &nbsp; <%=SYEAR%> : <a href="#" onClick="setDate(1);" style="font-size:9pt;color:#282828;text-decoration: none; ">&gt; &gt;&gt;</a></td>
        </tr>
        <tr bgcolor="#4A494A">
          <td>Sun</td>
          <td bgcolor="#4A494A">Mon</td>
          <td>Tue</td>
          <td>Wed</td>
          <td bgcolor="#4A494A">Thu</td>
          <td>Fri</td>
          <td>Sat</td>
        </tr>
        <tr>
          <%java.util.Calendar calendar234 = java.util.Calendar.getInstance();
calendar234.set(YEAR,MONTH-1,1);
int WEEK234=calendar234.get(calendar234.DAY_OF_WEEK)-1;/*
System.out.println(WEEK234);
System.out.println("YEAR:"+ calendar123.get(calendar123.YEAR));
System.out.println("MONTH:"+ calendar123.get(calendar123.MONTH));
System.out.println("DAY_OF_MONTH:"+ calendar123.get(calendar123.DAY_OF_MONTH));*/
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
           if(i>WEEK234-1&&sum>=i-WEEK234+1)
           {
               out.println("<TD bgcolor=\"#6D6E5C\" align=center>");
               //???????????????
               if(tea.entity.node.Event.exists(YEAR,MONTH,i-WEEK234+1,teasession._nLanguage))
               {
                   String strMonth=String.valueOf(MONTH);
                   if(strMonth.length()==1)
                   strMonth="0"+strMonth;
                                      String strDay=String.valueOf(i-WEEK234+1);
                   if(strDay.length()==1)
                   strDay="0"+strDay;
                   out.println("<font color=\"#ffFFFF\" class=b2>");
                   out.println("<a target=\"_parent\" href='/servlet/Event?node=14995&Listing=5484&timeStart="+YEAR+strMonth+strDay+"&id=5721'>");//???id=????????????????????????----------
               }
               //out.println("Year:"+YEAR+"\t"+MONTH+"\t"+(i-WEEK234+1));
               //??????
               if(calendar123.get(calendar123.YEAR)==YEAR&&calendar123.get(calendar123.MONTH)==MONTH-1&&calendar123.get(calendar123.DAY_OF_MONTH)==i-WEEK234+1)
                   out.println("<font color=\"#ffFFFF\" class=b1>");
               out.println((i-WEEK234+1)+"</td>");
           }else
               out.println("<td bgcolor=\"#6D6E5C\" align=center></td>");
}%>
        </tr>
      </table></td>
      </tr></form>
</table>
</body>








