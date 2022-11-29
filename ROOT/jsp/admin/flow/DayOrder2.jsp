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
String community="";
if(teasession.getParameter("community")!=null && teasession.getParameter("community").length()>0)
{
  community=request.getParameter("community");
}
else
{
  community = teasession._strCommunity;
}
%>

<%
long l5 = System.currentTimeMillis();
Date date = new Date(l5);
Calendar calendar = Calendar.getInstance();
calendar.setTime(date);


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

%>



  <%!   String   year;
      String   month;
  %>
  <%   month=request.getParameter("month");
      year   =request.getParameter("year");
  %>
  <html>
  <head>
 <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
  <title>日程安排</title>
  <h1>日程安排</h1>

<div id="head6"><img height="6" src="about:blank"></div>
  <script   Language="JavaScript">
  <!--
  function   changeMonth()
  {
  	var mm="/jsp/admin/flow/DayOrder.jsp?community=<%=community%>&month="+document.sm.month.value+"&year="+<%=year%>;
 	 window.open(mm,"_self");
  }
  function changeYear()
  {
  	var mm="/jsp/admin/flow/DayOrder.jsp?community=<%=community%>&month="+document.sm.month.value+"&year="+document.sm.YEAR.value;
 	 window.open(mm,"_self");
  }
  //--></script>
  </head>
<%!   String   days[];   %>
<%
days=new   String[42];
for(int   i=0;i<42;i++)
{
  days[i]="";
}

Calendar   thisMonth=Calendar.getInstance();
if(month!=null&&(!month.equals("null")))
thisMonth.set(Calendar.MONTH,   Integer.parseInt(month)   );
if(year!=null&&(!year.equals("null")))
thisMonth.set(Calendar.YEAR,   Integer.parseInt(year)   );
year=String.valueOf(thisMonth.get(Calendar.YEAR));
month=String.valueOf(thisMonth.get(Calendar.MONTH));
thisMonth.setFirstDayOfWeek(Calendar.SUNDAY);
thisMonth.set(Calendar.DAY_OF_MONTH,1);
int   firstIndex=thisMonth.get(Calendar.DAY_OF_WEEK)-1;     //在星期几开始 是一号
int   maxIndex=thisMonth.getActualMaximum(Calendar.DAY_OF_MONTH); //判断一个月多少天
Date d = new Date();
int dd = d.getDate();
for(int   i=0;i<maxIndex;i++)
{
  days[firstIndex+i]=String.valueOf(i+1);

}

int  years = Integer.parseInt(year);


%>
  <body>
  <form   name="sm"   method="post"   action="/jsp/admin/flow/DayOrder.jsp?community=<%=community %>">
   <table   border="0"   width="168"   height="20">

  <tr id="TableControl">
  <td   width=28%>
  <select name="YEAR"  onchange="changeYear();" >
  <%
        for(int I=1930;I<=2050;I++)
        {
%>
          <option value="<%=I%>" <% if(I==years)  out.print("selected");%>><%=I%></option>
<%
        }
%>
        </select>
  </td>
  <td>年</td>
    <td   width=30%><select   name="month"  onchange="changeMonth()"   >
    	   <%
    	   	for (int j=1;j<=12;j++){
    	    %>
    	    <option value="<%=j-1 %>"><%=j %></option>
       <%} %>
    </select></td>

  <td width=28%>&nbsp;</td>
  <td width=28%><input   type=button   value="本月" onclick="location='/jsp/admin/flow/DayOrder.jsp?community=<%=community %>'"></td>
  </tr>
  </table>

    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <div   align=center>
    <tr id="tableonetr">
        <td nowrap ><font   color="red">日</font>
  </td>
        <td nowrap >一</td>
        <td nowrap >二</td>
        <td  nowrap >三</td>
        <td  nowrap >四</td>
        <td  nowrap >五</td>
        <td  nowrap>
        <font   color="green">六</font></td>
    </tr>
<%
    String Time = null;
    String Days[];
    Days=new   String[42];
    for(int   i=0;i<42;i++)
    {
      Days[i]="";
    }

    thisMonth.setTimeInMillis(System.currentTimeMillis());
    for(int j=0;j<6;j++)   {   %>
  <tr>
            <%   for(int   i=j*7;i<(j+1)*7;i++)   {   %>
          <td    nowrap>
          <a   href="javascript:f_open(<%=year%>,<%=Integer.parseInt(month)+1%>,<%=days[i]%>);"  ><%

		if(days[i].length()>0&&thisMonth.get(thisMonth.YEAR)==Integer.parseInt(year)&&thisMonth.get(thisMonth.MONTH)==Integer.parseInt(month)&&thisMonth.get(thisMonth.DAY_OF_MONTH)==Integer.parseInt(days[i]))
		{
			out.print("<font color=red >"+days[i]+"</font>");
		}else{
			out.print(days[i]);
        }
  %>
  </a>
  <script type="">
  function f_open(y,m,d)
  {
//    window.open("/jsp/admin/flow/NewAffair.jsp?community=<%=teasession._strCommunity%>&year="+y+"&month="+m+"&date="+d,"iFrame2");
    window.open("/jsp/admin/flow/Affair2.jsp?community=<%=teasession._strCommunity%>&year="+y+"&month="+m+"&date="+d,"iFrame3");

  }
  </script>

  <%
  String member = teasession._rv.toString();//当前用户

  AdminUsrRole au_obj=AdminUsrRole.find(teasession._strCommunity,member);
  if(au_obj.isExists())
  {
    String  sql = " and l.member = '"+member+"'";
    //if(au_obj.getUnit()!=0 && au_obj.getClasses()==0)
    //{
      //sql = " and dept="+au_obj.getUnit()+" and member = '"+member+"'";
      //}

      //if(au_obj.getClasses()==1)
      //{
        //sql = " and dept="+au_obj.getUnit();
        //}
        //if(au_obj.getClasses()==2)
        //{
          ///sql ="";
          //}

          java.util.Enumeration e = DayOrder.findByCommunity(teasession._strCommunity,sql);
          if(days[i].length()>0)
          {
            if(Integer.parseInt(month)+1 < 10)
            {
              Time = year+"-0"+(Integer.parseInt(month)+1);
            }            else
            {
              Time = year+"-"+(Integer.parseInt(month)+1);
            }
            if(Integer.parseInt(days[i])<10)
            {
              Days[i] = "-0"+days[i];
            }else
            {
              Days[i] = "-"+days[i];
            }

            //Time = year+"-0"+(Integer.parseInt(month)+1)+"-0"+days[i];
            // out.print(Time+Days[i]);
            while(e.hasMoreElements())
            {
              int id = ((Integer)e.nextElement()).intValue();
              DayOrder obj = DayOrder.find(id);
              if((Time+Days[i]).equals(obj.getTime().toString().substring(0,10)))
              {
                out.print("<br>");
                if(obj.getBegintime()<10){
                  out.print("0"+obj.getBegintime()+":");
                }else
                {
                  out.print(obj.getBegintime()+":");
                }
                if(obj.getBegintime1()<10)
                {
                  out.print("0"+obj.getBegintime1());
                }else
                {
                  out.print(obj.getBegintime1());
                }
                out.print("-");
                if(obj.getEndtime()<10)
                {
                  out.print("0"+obj.getEndtime()+":");
                }else
                {
                  out.print(obj.getEndtime()+":");
                }
                if(obj.getEndtime1()<10)
                {
                  out.print("0"+obj.getEndtime1());
                }else
                {
                  out.print(obj.getEndtime1());
                }
                Worktype wor =Worktype.find(obj.getAffairtype());
                out.print("<br>"+wor.getName(1)+":<a href =\"/jsp/admin/flow/AffairContent.jsp?community="+community+"&year="+year+"&month="+(Integer.parseInt(month)+1)+"&date="+days[i]+"&aid="+id+"\" target=\"_blank \" > "+obj.getAffaircontent()+"</a>");
              }
            }
          }
        }
		%>
          </td>

        <%   }     %>
    </tr>
  <%   }     %>

</table>

</FORM>
<script   Language="JavaScript">
<!--
 document.sm.month.options.selectedIndex=<%=month%>;
//-->
</script>
</body>
</html>
