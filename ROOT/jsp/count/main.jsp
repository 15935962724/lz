<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.Node" %>
<%@page import="tea.entity.node.access.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>
<%

String sImage;

String community=request.getParameter("community");
//	String strNode;
//	strNode = ((Integer) session.getAttribute("tea.Node")).toString();
 // tea.ui.node.count.dispcount dcount = new tea.ui.node.count.dispcount(strNode);
//	long[] ihour = new long[24];
java.util.Date date=new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

int month=Integer.parseInt( new SimpleDateFormat("MM").format(date));

Community com_obj=Community.find(community);

java.util.Date count_date=Node.find(com_obj.getNode()).getTime();

//count_date=new java.util.Date(count_date.getTime()-(long)365*24*60*60*1000);

int count_day=(int)((System.currentTimeMillis()-count_date.getTime())/1000/60/60/24);

NodeAccessDay nad_obj=NodeAccessDay.find(community);

long avg_day=0;
for(int index=0;index<nad_obj.getPv().length;index++)
{
  avg_day+=nad_obj.getPv()[index];
}
avg_day=alltotal/(long)count_day;

long count_ref=0l;
//NodeAccessMonth nam_obj=NodeAccessMonth.find(community);
NodeAccessMonth nam_obj=NodeAccessMonth.find(community,new Date());

String dn="";
Enumeration e=DNS.findByCommunity(community,0);
if(e.hasMoreElements())
{
  dn=(String)e.nextElement();
}
%> 

<p>
<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
                  <tr>
                    <td><h2><%=r.getString(teasession._nLanguage,"1216026723448")%></h2></td>
          </tr>

          <tr>
            <td align="center"><%//out.println(sImage);%>


              <table width="707" border="0" cellspacing="0">
                <tr>
                  <td><%=r.getString(teasession._nLanguage,"1216026806699")%>：</td>
                  <td><%=com_obj.getName(1)%></td>
                  <td><%=r.getString(teasession._nLanguage,"1216026845730")%>：</td>
                  <td><A href="http://<%=dn%>"><%=dn%></A></td>
                </tr>
                <tr>
                  <td><%=r.getString(teasession._nLanguage,"1216026967668")%>：</td>
                  <td><A href="mailto:<%=com_obj.getEmail()%>"><%=com_obj.getEmail()%></A></td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td colspan="4"><hr size=1 noshade></td>
                </tr>
                <tr>
                  <td><%=r.getString(teasession._nLanguage,"1216027060106")%></td>
                  <td><%=df.format(alltotal) %></td>
                  <td><%=r.getString(teasession._nLanguage,"1216027122122")%></td>
                  <td><%=formatter.format(count_date)%></td>
                </tr>
                <tr>
                  <td>今日访问量</td>
                  <td><%=df.format(daytotal)%></td>
                  <td><%=r.getString(teasession._nLanguage,"1216027209201")%></td>
                  <td><%=df.format(nam_obj.getPv()[month-1])%></td>
                </tr>
                <tr>
                  <td><%=r.getString(teasession._nLanguage,"1216027261389")%></td>
                  <td><%=df.format(count_day)%></td>
                  <td><%=r.getString(teasession._nLanguage,"1216027322702")%></td>
                  <td><%=df.format(avg_day)%></td>
                </tr>
<!--
                <tr>
                  <td>在线人数</td>
                  <td><%//=tea.entity.site.Listener.getOnline(community)%></td>
                  <td>登录会员</td>
                  <td><%//=tea.entity.member.Log.countByDate()%></td>
                </tr>
-->
              </table></td>
          </tr>

</table>
