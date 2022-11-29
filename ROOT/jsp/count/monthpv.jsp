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

String tmp=request.getParameter("year");
if(tmp!=null)
{
  c.set(c.YEAR,Integer.parseInt(tmp));
}
int year=c.get(c.YEAR);
int month=(cyear!=year?12:c.get(c.MONTH) + 1);

///////////每月///////////////
NodeAccessMonth nam=NodeAccessMonth.find(community,c.getTime());
int pv[] =nam.getPv();
int ip[] =nam.getIp();

int max=nam.getMaxPv();
if(max<1)
max=1;
double point = 100.0/max;

/////////////总//////////
NodeAccessMonth nam2=NodeAccessMonth.find(community);
int pv2[] =nam2.getPv();
int ip2[] =nam2.getIp();
int max2=nam2.getMaxPv();
if(max2<1)
max2=1;
max2=max2+oldpv/12;
double point2 = 100.0/max2;



%>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=community%>" >
<input type="hidden" name="act" value="<%=act%>" >
<input type="hidden" name="id" value="<%=_strid%>" >
 <%
       Enumeration years=NodeAccessDay.getYears(community);
   
       %>
<select name="year" onChange="form1.submit();">
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
</form>



<p>
<table border="0" cellspacing="0" cellpadding="0" style="border: 1px solid #CCCCCC; padding:10px">
   <tr>
    <td align="center"><h2><%=cyear!=year?year+"年的统计图表":r.getString(teasession._nLanguage,"1216085993849")%></h2></td>
        </tr>
        <tr>
          <td align=center><table border="0" align=center cellpadding="0" cellspacing="0">
              <tr valign=bottom >
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
for(int i=month;i<12;i++)
{
  int sHeight =(int)(pv[i]*point);
  int _nHeight2=(int)(ip[i]*point);

  String title=r.getString(teasession._nLanguage,"1216028449131")+(year-1)+"-"+(i+1)+"&#13;"+r.getString(teasession._nLanguage,"1216028526694")+df.format(pv[i])+" PV";
  out.print("<td align=center width=15 height=120 nowrap><img src=/tea/image/other/bar3.gif width=15 height="+sHeight+" title='"+title+"'><br>"+(i+1)+"</td>");
}

for(int i=0;i<month;i++)
{
  int sHeight=(int)(pv[i]*point);
  int _nHeight2=(int)(ip[i]*point);

  String title=r.getString(teasession._nLanguage,"1216028449131")+year+"-"+(i+1)+"&#13;"+r.getString(teasession._nLanguage,"1216028526694")+df.format(pv[i])+" PV";

  out.print("<td align=center width=15 height=120 nowrap><img src=/tea/image/other/bar3.gif width=15 height="+sHeight+" title='"+title+"'><br>"+(i+1)+"</td>");
}
%>
                <td><%=r.getString(teasession._nLanguage,"1216086476428")%></td>
              </tr>
            </table></td>
     </tr>
    <tr><td align="center">
    <img src="/tea/image/other/bar3.gif" class="gra" ><%=r.getString(teasession._nLanguage,"1216028526694")%><%=df.format(nam.getSumPv())%> PV
   </td></tr>

<!--///////////////////////////-->
     <tr><td align=center><h2><%=r.getString(teasession._nLanguage,"1216086522881")%></h2></td></tr>
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
for(int i=0;i<12;i++)
{pv2[i]=pv2[i]+oldpv/12;
ip2[i]=ip2[i]+oldip/12;
  int sHeight =(int)(pv2[i]*point2);
  int _nHeight2=(int)(ip2[i]*point2);

  String title=r.getString(teasession._nLanguage,"1216028449131")+(i+1)+"月&#13;"+r.getString(teasession._nLanguage,"1216028526694")+df.format(pv2[i])+" PV";

  out.print("<td align=center width=15 height=120 nowrap><img src=/tea/image/other/bar3.gif width=15 height="+sHeight+" title='"+title+"'><br>"+(i+1)+"</td>");
}
%>
                <td><%=r.getString(teasession._nLanguage,"1216086476428")%></td>
              </tr>
            </table>
            </td>
  </tr>
 <tr><td align="center"><img src="/tea/image/other/bar3.gif" class="gra" ><%=r.getString(teasession._nLanguage,"1216028526694")%><%=df.format(nam2.getSumPv()+oldpv)%> PV
   </td></tr>
</table>



