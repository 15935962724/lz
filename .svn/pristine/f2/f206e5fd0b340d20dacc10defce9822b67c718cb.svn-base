<%@page contentType="text/html;charset=UTF-8" %>
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
%><head>
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
</script>
</head>

<form name="form1" method="post"  target="_parent" action="/servlet/Node?node=14999&Listing=5715&id=5717">
  <select name="timeStartBig" onchange="setStopTime()">
    <option value="<%=String.valueOf(year)+month+day%>">今天</option>
    <option value="<%=String.valueOf(year2)+month2+day2%>">本周</option>
    <option value="<%=year+month+"01"%>">本月</option>
  </select>
  <input type="hidden" value="" name="timeStartSmall"/>
  内容:   <select name="sort">
  </select>
关键字:<input name="Having" type="text">
    <input type="submit" value="SUBMIT"/>
</form>

