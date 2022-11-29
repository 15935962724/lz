<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Enumeration"%>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}
String poid = teasession.getParameter("poid");//订单ID
PerformOrders  poobj = PerformOrders.find(poid); 


%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>

<title>订单详细信息</title>
</head>

<body id="bodynone">


<h1>订单详细信息</h1>

<div id="head6"><img height="6" src="about:blank"></div>


  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<TR>
		<TD nowrap align="right">订单号：</TD>
		<TD nowrap><%=poid %></TD>
	</TR>
	<%if(poobj.getMemberType()==1){ %>
    <TR>
		<TD nowrap align="right">会员卡号：</TD>
		<TD nowrap><%=poobj.getMember() %></TD>
	</TR>
	<%} %>
	<TR>
		<TD nowrap align="right">姓名：</TD>
		<TD nowrap><%=poobj.getNames() %></TD>
	</TR>

<TR>
		<TD nowrap align="right">证件类型：</TD>
		<TD nowrap><%=PerformOrders.ZJLX_TYPE[poobj.getZjlx()] %></TD>
	</TR>
	<TR>
		<TD nowrap align="right">证件号码：</TD>
		<TD nowrap><%=poobj.getZjhm() %></TD>
	</TR>
		<TR>
		<TD nowrap align="right">移动电话：</TD>
		<TD nowrap><%=poobj.getYddh() %></TD>
	</TR>
		<TR>
		<TD nowrap align="right">固定电话：</TD>
		<TD nowrap><%=poobj.getGddh() %></TD>
	</TR>
		<TR>
		<TD nowrap align="right">电子邮箱：</TD>
		<TD nowrap><%=poobj.getDzyx() %></TD>
	</TR>
		<TR>
		<TD nowrap align="right">是否送票：</TD>
		<TD nowrap><%if(poobj.getSfsp()==0){out.print("否");}else {out.print("是");} %></TD>
	</TR>
	<%if(poobj.getSfsp()==1){ %>
		<TR>
		<TD nowrap align="right">送票地址：</TD>
		<TD nowrap><%=PerformOrders.SPDZ1_TYPE[poobj.getSpdz1()]%>&nbsp;<%=poobj.getSpdz2() %></TD>
	</TR>
	<%} %>
	<tr>
		<td nowrap align="right">是否要发票：</td>
		<td><%if(poobj.getSffp()==0){out.print("否");}else{out.print("是");} %></td>
	</tr>
		<TR>
		<TD nowrap align="right">其他说明：</TD>
		<TD nowrap><%=poobj.getQtsm() %></TD>
	</TR>
	
 </table>
 <h1>订单中的演出票信息</h1>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <TR id="tableonetr">
      <TD nowrap>票据编号</TD>
      <TD nowrap>演出名称</TD>
      <TD nowrap>演出场馆</TD>
      <TD nowrap>演出时间</TD>
      <TD nowrap>座位位置</TD>
      <TD nowrap>演出票价</TD>
    </TR>
    <%
    	Enumeration e = OrderDetails.find(teasession._strCommunity," and orderid = "+DbAdapter.cite(poid),0,20);
      while(e.hasMoreElements())
      {
    	  int odid = ((Integer)e.nextElement()).intValue();
    	  OrderDetails odobj = OrderDetails.find(odid);
    
    %>
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
     	<td><%=odid %></td>
     	<td><%=odobj.getPerformname() %></td>
     	<td><%=odobj.getPsname() %></td>
     	<td><%=odobj.getPstime() %></td>
     	<td><%out.print(odobj.getRegion()+"&nbsp;"+odobj.getLinage()+"&nbsp;排&nbsp;"+odobj.getSeat()+"&nbsp;号"); %></td>
     	<td><%=odobj.getTotalprice() %>&nbsp;元</td>
	</tr>
	<%} %>
</table> 
<br>
<a href="javascript:history.go(-1);"><img src="/res/REDCOME/0911/09119911.gif"></a> 

  <div id="head6"><img height="6" src="about:blank"></div>

</body>
</html>
