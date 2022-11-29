<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="java.lang.*,java.util.*,java.text.SimpleDateFormat,java.text.DateFormat" %>
<%@page import="tea.entity.node.access.*" %>
<%

ArrayList al=new ArrayList();
Enumeration e=NodeAccessLast.findByCommunity(request.getParameter("community"),0,500);
%>



<table border="0" align=center cellpadding="0" cellspacing="0" id="tablecenter">
  <tr valign=bottom >
    <td colspan="6"><h2><%=r.getString(teasession._nLanguage,"1216087389662")%></h2></td>
  </tr>
  <tr valign=bottom >
    <td>&nbsp;</td>
    <td><%=r.getString(teasession._nLanguage,"1216087426584")%></td>
    <td><%=r.getString(teasession._nLanguage,"1216087497412")%></td>
    <td><%=r.getString(teasession._nLanguage,"1216087580849")%></td>
    <td><%=r.getString(teasession._nLanguage,"1216087624896")%></td>
    <td><%=r.getString(teasession._nLanguage,"1216087674974")%></td>
  </tr>
<%
while(e.hasMoreElements()&&al.size()<50)
{
  NodeAccessLast na_obj=(NodeAccessLast)e.nextElement();
  String ip=na_obj.getIp();
  if(al.indexOf(ip)!=-1)continue;
  al.add(ip);
  String member=na_obj.getMember();
%><tr valign=bottom onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
  <td><%=al.size()%></td>
  <td><%=na_obj.getTimeToString()%></td>
  <td><a target="_blank" href="/servlet/Node?node=<%=na_obj.getNode()%>"><%=Node.find(na_obj.getNode()).getSubject(1)%></a></td>
  <td><%=NodeAccessWhere.findByIp(na_obj.getIp())%></td>
  <td><%=ip%></td>
  <td><%if(member!=null)out.print(member);%></td>
<%
}
%></tr>
</table>
