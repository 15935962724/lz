<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.node.*" %>
<%
String community=request.getParameter("community");

%>
<table border="0" align=center cellpadding="0" cellspacing="0" id="tablecenter">
  <tr valign=bottom >
    <td colspan="5"><h2><%=r.getString(teasession._nLanguage,"1216087962506")%></h2></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><%=r.getString(teasession._nLanguage,"1216087674974")%></td>
    <td><%=r.getString(teasession._nLanguage,"Time")%></td>
    <td><%=r.getString(teasession._nLanguage,"1216087624896")%></td>
  </tr>
<%
java.util.Enumeration e=OnlineList.findByCommunity(community,"");
for(int index=1;e.hasMoreElements();index++)
{
  String sessionid=((String)e.nextElement());
  OnlineList ol=OnlineList.find(sessionid);
  String member=ol.getMember();
  String ip=ol.getIP();
  if(ol.getTime()==null)//不知道,这里为什么会=null
  {
    continue;
  }
%><tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
  <td><%=index%></td>
  <!--<td><%=sessionid%></td>-->
  <td>&nbsp;<%if(member!=null)out.print(member);%></td>
  <td><%=ol.getTimeToSeconds()%></td>
  <td><%=ip+"-"+NodeAccessWhere.findByIp(ip)%></td>
</tr>
<%
}
%>
</table>

