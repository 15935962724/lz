<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.Entity"%>
<%@   page   language="java"   import="java.util.*"   %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
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




String   year="";
String   month="";

month=teasession.getParameter("month");
year=teasession.getParameter("year");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
        <title>日程</title>
        <script   Language="JavaScript">
        <!--
        function   changeMonth()
        {
          var mm="/jsp/admin/flow/DxDayOrder.jsp?community=<%=community%>&month="+document.sm.month.value+"&year="+<%=year%>;
          window.open(mm,"_self");
        }
        function changeYear()
        {
          var mm="/jsp/admin/flow/DxDayOrder.jsp?community=<%=community%>&month="+document.sm.month.value+"&year="+document.sm.YEAR.value;
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
        {
          thisMonth.set(Calendar.MONTH,Integer.parseInt(month));
        }
        else
        {
          month=String.valueOf(thisMonth.get(Calendar.MONTH));
        }
        if(year!=null&&(!year.equals("null")))
        {
          thisMonth.set(Calendar.YEAR,Integer.parseInt(year));
        }else
        {
          year=String.valueOf(thisMonth.get(Calendar.YEAR));
        }



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
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/simple/ymPrompt.css" rel="stylesheet" type="text/css">
<script>
function f_open(y,m,d,cc)
{
  var ye = y+'-'+m+'-'+d;
  var url = '/jsp/admin/flow/DxdayOrdercon.jsp?id='+cc+'&ymd='+ye;
  ymPrompt.win({message:encodeURI(url),width:750,height:400,title:y+'年'+m+'月'+d+'日——日历内容',handler:function(){},maxBtn:false,minBtn:false,iframe:true});
}
</script>
<body>
<form   name="sm"   method="post"   action="/jsp/admin/flow/DxDayOrder.jsp?community=<%=community %>">
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
                <option value="<%=j-1%>" <%
                if((j-1)==(Integer.parseInt(month)))
                {
                  out.print(" selected ");
                }
                %>
                >
                <%=j%></option>
                <%} %>
</select></td>

<td width=28%>&nbsp;</td>
<td width=28%><input   type=button   value="本月" onclick="location='/jsp/admin/flow/DxDayOrder.jsp?community=<%=community %>'"></td>
            </tr>
          </table>

          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <div   align=center>
              <tr id="tableonetr">
                <td nowrap ><font   color="red">星期日</font>
</td>
<td nowrap >星期一</td>
<td nowrap >星期二</td>
<td  nowrap >星期三</td>
<td  nowrap >星期四</td>
<td  nowrap >星期五</td>
<td  nowrap>
  <font   color="green">星期六</font></td>
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
                <%   for(int   i=j*7;i<(j+1)*7;i++)   {

                	Date t =null;
                	if(days[i]!=null && days[i].length()>0)
                	{
                		t = Entity.sdf.parse(year+"-"+(Integer.parseInt(month)+1)+"-"+days[i]);
                	}

                	int idt = DayOrder.getId(teasession._strCommunity,t);
                		DayOrder dobj =DayOrder.find(idt);


                	%>
                  <td    nowrap>
                    <a   href="javascript:f_open('<%=year%>','<%=Integer.parseInt(month)+1%>','<%=days[i]%>','<%=idt %>');"  >
                    <%

                    if(days[i].length()>0&&thisMonth.get(thisMonth.YEAR)==Integer.parseInt(year)&&thisMonth.get(thisMonth.MONTH)==Integer.parseInt(month)&&thisMonth.get(thisMonth.DAY_OF_MONTH)==Integer.parseInt(days[i]))
                    {
                      out.print("<font color=red >"+days[i]+"</font>");
                    }else{
                      out.print(days[i]);
                    }
                    %>
                    </a>

                    <%
                    if(dobj.getAffaircontent()!=null && dobj.getAffaircontent().length()>0)
                    {
                    	 out.println("<span id=affid"+idt+">"+dobj.getAffaircontent()+"<span>");
                    }


                    %>
                    </td>

                    <%}%>
              </tr>
              <%}%>

          </table>
        </FORM>

        </body>
</html>
