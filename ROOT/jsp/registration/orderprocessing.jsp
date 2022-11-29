<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.db.*" %>
<%
    request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
//
//Community community =Community.find(teasession._strCommunity);
//String sql="select destine from Destine where state=1 order by destinedate desc";
%>
<html>
<head>
<link  href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>

<title>订单受理</title>
</head>
<body>
<h1>订单受理</h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<h2>订单受理</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td colspan="2" align="center">未受理的订单</td>
</tr>
<tr>
<td>订单号</td><td>酒店</td><td>订单时间</td><td>最晚到达时间</td><td>处理</td>
</tr>
<%
//DbAdapter db = new DbAdapter();
//db.executeQuery(sql);
java.util.Enumeration e = Destine.find(teasession._strCommunity,"and dstate=0 and state=1",0,Integer.MAX_VALUE);
while(e.hasMoreElements())
{
  int destine = ((Integer)e.nextElement()).intValue();
  Destine obj = Destine.find(destine);
  Node node = Node.find(obj.getNode());
%>
<tr>
<td><a href="/jsp/registration/order.jsp?destine=<%=obj.getDestine()%>">订单号 <%=obj.getDestine()%></a></td><!--订单号-->
<td><a href=""><%=node.getSubject(teasession._nLanguage)%></a></td><!--酒店-->
<td><%=obj.getDestinedateToString()%></td><!--订单时间-->
<td><%=obj.getEveningarrive()%></td>
<td><a href="/jsp/registration/auditorders.jsp?member=<%=teasession._rv%>&destine=<%=obj.getDestine()%>">接受</a>&nbsp;&nbsp;&nbsp;
    <a href="/jsp/registration/deleteorders.jsp?member=<%=teasession._rv%>&destine=<%=obj.getDestine()%>">拒绝</a>
</td>
<!--处理-->
</tr>
<%}%>
<tr><td colspan="5" align="left">
  <%//=new tea.htmlx.FPNL(teasession._nLanguage,par.toString()+"&pos1=",pos1,count1,size)%></td></tr>
</table>
</body>
</html>
