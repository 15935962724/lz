<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*"%>
<%@page import="tea.entity.node.access.*" %><%@page import="tea.ui.*"%><%@page import="tea.resource.*" %>
<script language="javascript" type="">
function gotoPage(value)
{
  var obj=form1.month;
  var month=parseInt(obj.value);
  if((month+value<1)||(month+value>12))
  {
    obj.options[obj.options.length]=new Option(month,month+value);
  }
  obj.value=month+value;
  form1.submit();
}

function gotoPageDay(value)
{
  var obj=form1.day;
  var day=parseInt(obj.value);
  if((day+value<1)||(day+value>12))
  {
    obj.options[obj.options.length]=new Option(day,day+value);
  }
  obj.value=day+value;
  form1.submit();
}

</script>
<%


String _strid=request.getParameter("id");
//TeaSession teasession = new TeaSession(request);
//Resource r=new Resource();
Calendar c = Calendar.getInstance();
c.setTimeInMillis(System.currentTimeMillis());
int cyear=c.get(c.YEAR);
c.set(11, 0);
c.set(12, 0);
c.set(13, 0);
c.set(14, 0);
Date cdate=c.getTime();

String tmp=request.getParameter("month");
if(tmp!=null)
{
  c.set(c.MONTH,Integer.parseInt(tmp)-1);
}

tmp=request.getParameter("year");
if(tmp!=null)
{
  c.set(c.YEAR,Integer.parseInt(tmp));
}
tmp=request.getParameter("day");
if(tmp!=null)
{
  c.set(c.DATE,Integer.parseInt(tmp));
}else
	 c.set(c.DATE,cdate.getDate());
int rs=cdate.compareTo(c.getTime());
if(rs==-1)
{
  out.print("<script>alert('不能大于当前日期');history.back();</script>");
  return;
}
int year=c.get(c.YEAR);
int month=c.get(c.MONTH) + 1;
int day=c.get(c.DATE);
String strPos=request.getParameter("pos");
int pos=0;
if(strPos!=null)
pos=Integer.parseInt(strPos);

String community=teasession._strCommunity;

float total=1F;
float top=1F;
%>

<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
  <tr>
    <td><h2>来源统计图表</h2></td>
  </tr>
  <tr><td>
  <table border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td align="center">
       <form name="form1" action="?">
  <input type="hidden" name="community" value="<%=community%>" >
  <input type="hidden" name="act" value="<%=act%>" >
  <input type="hidden" name="id" value="<%=_strid%>" >
      <%if (month!= cdate.getMonth()+1){%>
      <a href="javascript:gotoPage(-1);" >&lt;&lt;向前</a>&nbsp;&nbsp;&nbsp;
      <%}else{ %>
       <a href="javascript:gotoPageDay(-1);" >&lt;&lt;向前</a>&nbsp;&nbsp;&nbsp;
      <%} %>
      <%
       Enumeration years=NodeAccessDay.getYears(community);
       Enumeration months=NodeAccessDay.getMonths(community,year);
       %>
       
        <select name="year" id="year" onChange="form1.submit();">
          <%
        //  for(int i=2007;i<=cyear;i++)
          while(years.hasMoreElements())
          { int i=((Integer)years.nextElement()).intValue();
        
            out.print("<option value="+i);
            if(i==year)
            out.print(" SELECTED ");
            out.print(">"+i);
          }
          %>
        </select>
        <%=r.getString(teasession._nLanguage,"1215680597991")%>
        <select name="month" id="month" onChange="form1.submit();">
          <%
       //   for(int i=1;i<13;i++)
           while(months.hasMoreElements())
          {int i=((Integer)months.nextElement()).intValue();
            
            out.print("<option value="+i);
            if(i==month)
            out.print(" selected ");
            out.print(">"+i);
          }
          %>
        </select>月
 <%if (month== cdate.getMonth()+1){%>
          <select name="day" id="day" onChange="form1.submit();">
          <%
          for(int i=1;i<31;i++)
          {
            out.print("<option value="+i);
            if(i==day)
            out.print(" selected ");
            out.print(">"+i);
          }
          %>
        </select>日
        <%} %>

来源统计
       &nbsp;&nbsp;&nbsp;   <%if (month!= cdate.getMonth()+1){%>
      <a href="javascript:gotoPage(1);" >向后&gt;&gt;</a>&nbsp;&nbsp;&nbsp;
      <%}else{ %>
       <a href="javascript:gotoPageDay(1);" >向后&gt;&gt; </a>&nbsp;&nbsp;&nbsp;
      <%} %>
    
      &nbsp;&nbsp;&nbsp; </form></td>
    </tr>
  </table>

</td>
 </tr>
  <tr>
    <td align="center">
      <table border=0 cellpadding=2>
        <%
        ArrayList al=new ArrayList();
        if (month!= cdate.getMonth()+1){
        al=	NodeAccessReferer.findByCommunity(community,year,month,pos,15);
       alltotal=NodeAccessReferer.countByCommunity(community,year,month);
         total=alltotal/100F;
        }else
        {
            al=	NodeAccessReferer.findByCommunity(community,year,month,day,pos,15);
           alltotal=NodeAccessReferer.countByCommunity(community,year,month,day);
             total=alltotal/100F;
            }
        for(int i=0;i<al.size();i++)
        {
          Object naw[]=(Object[])al.get(i);
          int sum=((Integer)naw[0]).intValue();
              
          
            
            top=sum/100F;
         
          String addr=(String)naw[1];
          
           if(addr==null||addr.length()==0)
               addr=r.getString( teasession._nLanguage,"1216093609709" );
          float p=sum/total;

          out.print("<tr valign=bottom >");
          out.print("<td>"+addr+"</td>");
          //out.print("<td align='right'>"+df.format(sum)+"</td>");
          out.print("<td align='right'>"+df2.format(p)+"%</td>");
          out.print("<td align=left valign=middle width=200><img src='/tea/image/other/bar2.gif' style='width:"+(sum/total)+"' height=15></td>");
        }
        %>
            </table>
    </td>
        </tr>
<tr><td align="center">

<%=new tea.htmlx.FPNL(teasession._nLanguage, "/jsp/count/index.jsp?act=referer&community=" + community +"&year="+year+"&month="+month+"&day="+day+ "&pos=", pos, (int)alltotal,15)%>
      </table></td>
  </tr>
</table>



