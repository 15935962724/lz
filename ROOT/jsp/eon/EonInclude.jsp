<%@page contentType="text/html;charset=UTF-8" %>
<%@page session="false" %>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.eon.*"%>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");

int node=Integer.parseInt(request.getParameter("node"));
int lang=1;
Node n=Node.find(node);
String member=n.getCreator()._strV;
EonTeleset et = EonTeleset.find(member);

String sn="http://"+request.getServerName()+":"+request.getServerPort();

StringBuffer sb=new StringBuffer();

sb.append("<A ID=EonCallTel href=javascript:f_eon(" + n._nNode + ",0); title=\"点击呼叫 " + n.getSubject(lang) + "\"><IMG SRC="+sn+"/tea/image/eon/tel.gif></A>");
if (et.isAutoMessage())
{
  sb.append("　<A ID=EonCallAuto href=javascript:f_eon(" + n._nNode + ",1); title=\"自动语音服务 " + n.getSubject(lang) + "\"><IMG SRC="+sn+"/tea/image/eon/auto.gif></A>");
}
sb.append("　<A ID=EonCallMsg href=javascript:f_eon(" + n._nNode + ",2); title=\"用户留言 " + n.getSubject(lang) + "\"><IMG SRC="+sn+"/tea/image/eon/msg.gif></A>");

%>
function f_eon(n,v)
{
  window.open('<%=sn%>/jsp/eon/EonCall1.jsp?node='+n+'&member=<%=java.net.URLEncoder.encode(member, "UTF-8")%>&processnum='+v,'','width=500,height=400,scrollbars=1');
}
document.write('<%=sb.toString()%>');
