<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.entity.node.access.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%
String community=request.getParameter("community");


String _strid=request.getParameter("id");

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

int rs=cdate.compareTo(c.getTime());
if(rs==-1)
{
  out.print("<script>alert('不能大于当前日期');history.back();</script>");
  return;
}


int year=c.get(c.YEAR);
int month=c.get(c.MONTH) + 1;

int k=NodeAccessDay.getCountDay(year,month);

int curday=(rs==1?k:c.get(c.DAY_OF_MONTH));
if(rs!=1) k=NodeAccessDay.getCountDay(year,month-1);
else c.set(Calendar.DATE,k);
///////////每天///////////////
NodeAccessDay nad=NodeAccessDay.find(community,c.getTime());
int pv[] =nad.getPv();
int ip[] =nad.getIp();


int max=nad.getMaxPv();
if(max<1)
max=1;
double point = 100.0/max;


/////////////总//////////
NodeAccessDay nad2=NodeAccessDay.find(community);
int pv2[] =nad2.getPv();
int ip2[] =nad2.getIp();
int max2=nad2.getMaxPv();
if(max2<1)
max2=1;
max2=max2+oldpv/31;
double point2=100.0/max2;


%>
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
</script>
<form name="form1" action="?">
  <input type="hidden" name="community" value="<%=community%>" >
  <input type="hidden" name="act" value="<%=act%>" >
  <input type="hidden" name="id" value="<%=_strid%>" >
  <table border="0" cellspacing="0" cellpadding="0" style="border: 1px solid #CCCCCC; padding:10px">
    <tr>
      <td align="center"><a href="javascript:gotoPage(-1);" >&lt;&lt;<%=r.getString(teasession._nLanguage,"TOP")%></a>&nbsp;&nbsp;&nbsp;
       <%
       Enumeration years=NodeAccessDay.getYears(community);
       Enumeration months=NodeAccessDay.getMonths(community,year);
       %>
        <select name="year" id="year" onChange="form1.submit();">
          <%
          //for(int i=2007;i<=cyear;i++)
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
         // for(int i=1;i<13;i++)
             while(months.hasMoreElements())
          {int i=((Integer)months.nextElement()).intValue();
            out.print("<option value="+i);
            if(i==month)
            out.print(" selected ");
            out.print(">"+i);
          }
          %>
        </select>
        <%=r.getString(teasession._nLanguage,"1215680765366")%>&nbsp;&nbsp;&nbsp; <a href="javascript:gotoPage(1);"><%=r.getString(teasession._nLanguage,"BOTTOM")%>&gt;&gt;</a>
      </td>
    </tr>
  </table>
</form>



<p>
  <table border="0" cellspacing="0" cellpadding="0" style="border: 1px solid #CCCCCC; padding:10px">
    <tr>
      <td align="center"><h2><%=rs==1?year+"-"+month+"的统计图表":r.getString(teasession._nLanguage,"1216028089707")%></h2></td>
    </tr>
    <tr>
      <td align=center>
        <table border="0" align=center cellpadding="0" cellspacing="0">
          <tr valign=bottom>
            <td valign=top>
              <table border=0 align=center cellpadding=0 cellspacing=0 height=100>
                <tr>
                  <td height=25 valign=top align="right"  nowrap><%=df.format(max)%></td>
                </tr>
                <tr>
                  <td  height=25 valign=top align="right"  nowrap><%=df.format(max*0.75) %></td>
                </tr>
                <tr>
                  <td  height=25 valign=top align="right"  nowrap><%=df.format(max*0.5)%></td>
                </tr>
                <tr>
                  <td  height=25 valign=top align="right"  nowrap><%=df.format(max*0.25)%></td>
                </tr>
              </table>
</td>
<%

for(int i=curday;i<k;i++)
{
  int sHeight =(int)(pv[i]*point);
  int _nHeight2=(int)(ip[i]*point);
  String title=r.getString(teasession._nLanguage,"1216028449131")+year+"-"+(month-1)+"-"+(i+1)+"&#13;"+r.getString(teasession._nLanguage,"1216028526694")+df.format(pv[i])+" PV";
  out.print("<td align=center width=15 height=120 nowrap><img src=/tea/image/other/bar3.gif width=15 height="+sHeight+" title='"+title+"'><br>"+(i+1)+"</td>");
}
for(int i=0;i<curday;i++)
{
  int sHeight=(int)(pv[i]*point);
  int _nHeight2=(int)(ip[i]*point);
  String title=r.getString(teasession._nLanguage,"1216028449131")+year+"-"+month+"-"+(i+1)+"&#13;"+r.getString(teasession._nLanguage,"1216028526694")+df.format(pv[i])+" PV";
  out.print("<td align=center width=15 height=120 nowrap><img src=/tea/image/other/bar3.gif width=15 height="+sHeight+" title='"+title+"'><br>"+(i+1)+"</td>");
}
//max=nad.getSumMax();
%>
                <td><%=r.getString(teasession._nLanguage,"1216028880118")%></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td align="center">
            <img src="/tea/image/other/bar3.gif" class="gra" align="top"/><%=r.getString(teasession._nLanguage,"1216028526694")%><%=df.format(nad.getSumPv())%> PV　
           
          </td>
        </tr>


<!--////////////////////////////////////-->
     <tr><td align=center><h2><%=r.getString(teasession._nLanguage,"1216029001056")%></h2></td></tr>
      <tr>
          <td align=center><table border="0" align=center cellpadding="0" cellspacing="0">
              <tr valign=bottom >
                <td valign=top><table border=0 align=center cellpadding=0 cellspacing=0 height=100>
                    <tr>
                      <td height=25 valign=top align="right"  nowrap><%=df.format(max2)%></td>
                    </tr>
                    <tr>
                      <td  height=25 valign=top align="right"  nowrap><%=df.format(max2*0.75) %></td>
                    </tr>
                    <tr>
                      <td  height=25 valign=top align="right"  nowrap><%=df.format(max2*0.5)%></td>
                    </tr>
                    <tr>
                      <td  height=25 valign=top align="right"  nowrap><%=df.format(max2*0.25)%></td>
                    </tr>
                  </table></td>
<%
for(int i=0;i<31;i++)
{pv2[i]=pv2[i]+oldpv/31;
ip2[i]=ip2[i]+oldip/31;
  int sHeight =(int)(pv2[i]*point2);
  int _nHeight2=(int)(ip2[i]*point2);

  String title=r.getString(teasession._nLanguage,"1216028449131")+(i+1)+"&#13;"+r.getString(teasession._nLanguage,"1216028526694")+df.format(pv2[i])+" PV";

  out.print("<td align=center width=15 height=120 nowrap><img src=/tea/image/other/bar3.gif width=15 height="+sHeight+" title='"+title+"'><br>"+(i+1)+"</td>");
}
%>
                <td><%=r.getString(teasession._nLanguage,"1216028880118")%></td>
              </tr>
            </table>
            </td>
  </tr>
 <tr><td align="center"><img src="/tea/image/other/bar3.gif" class="gra" align="top"><%=r.getString(teasession._nLanguage,"1216028526694")%><%=df.format(nad2.getSumPv()+oldpv)%> PV　
</td></tr>
</table>

