<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/member/order/SaleOrders");
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
<script type="">
function fprint(value)
{
  window.print();
  window.location='EditPrint.jsp?node='+value;
}
</script>
</head>
<body>
<!--1172719643421=订单打印-->
<h1><%=r.getString(teasession._nLanguage, "1172719643421")%></h1>
<div id="head6"><img height="6" src="about:blank"></div><br><br>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   <tr id="tableonetr">
            <td>订单编号</td>
            <td>下单时间</td>
            <td>会员ID</td>
          </tr>
          <%
          for(java.util.Enumeration enumeration = tea.entity.node.SOrder.find(node.getCommunity(),teasession._rv._strR,(2)); enumeration.hasMoreElements(); )
          {
            int j2 = ((Integer)enumeration.nextElement()).intValue();
            System.out.println(j2);
            tea.entity.node.SOrder so_obj=       tea.entity.node.SOrder.find(j2,teasession._nLanguage);
            tea.entity.node.Node node_obj=                 tea.entity.node.Node.find(j2);
            tea.entity.RV rv = node_obj.getCreator();		%>
          <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
            <td><A href="/jsp/type/sorder/EditPrint.jsp?node=<%=j2%>">#<%=j2%></A> </td>
            <td><%=(new java.text.SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(node_obj.getTime())%></td>
            <td><%=ts.hrefGlance(rv)%></td>
          </tr>
      <%}%>
</table><br><br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

