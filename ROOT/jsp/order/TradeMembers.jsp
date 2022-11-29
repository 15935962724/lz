<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.*" %>
<%@ page import="tea.entity.site.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();
r.add("/tea/ui/member/order/SaleOrders");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "流程图")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr id=tableonetr>
    <td>状态</td>
    <td>操作员</td>
    <td>时间</td>
  </tr>
<%
  String trade =request.getParameter("trade");
  java.util.Enumeration e = TradeMember.findByTrade(trade);
  while (e.hasMoreElements())
  {
    TradeMember obj = TradeMember.find(((Integer) e.nextElement()).intValue());
%>
   <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><%
    out.print(r.getString(teasession._nLanguage,Trade.TRADE_STATUS[obj.getStatus()]));
    /*if(obj.getStatus()<3)
    {
      out.print(" "+r.getString(teasession._nLanguage,Trade.PAYSTATE_TYPE[obj.getStatus()]));
    }*/
    %></td>
    <td><%=obj.getMember()%></td>
    <td><%=obj.getTime()%></td>
  </tr>
<%}%>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

