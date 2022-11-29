<%@page contentType="text/html;charset=UTF-8" %><%@include file="/jsp/Header.jsp"%><%

r.add("/tea/ui/member/order/SaleOrders");
String s2 =  request.getParameter("Pos");
int l1 = s2 == null ? 0 : Integer.parseInt(s2);
if(!teasession._rv.isAccountant())
{
  response.sendError(403);
  return;
}
            String s = request.getParameter("Type");
            String s1 = request.getParameter("Status");
            boolean flag = s == null;
            boolean flag1 = s != null && s1 == null;
            boolean flag2 = s != null && s1 != null;
            boolean flag3 = teasession._rv.isReal() || teasession._rv.isAccountant();
            int j = Integer.parseInt(s==null?"0":s);
            int k = Integer.parseInt(s1==null?"0":s1);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
</head>
<body><h1><%
switch(k)
{
  case 0:
  out.print("接收新订单");
  break;
  case 4:
  out.print("订单确认");
  break;
  case 1:
    out.print("失效订单处理");
  break;
  case 2:
  out.print("订单完成");
  break;

  case 3:
  out.print("已完成");
  break;
}
%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

	<br><br><table border="0" cellpadding="0" cellspacing="0"  id="tablecenter">
         <tr id="tableonetr">
            <td>订单编号</td>
            <td>下单时间</td>
            <td>会员ID</td>
          </tr>  <%
          String nexturl="&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8");
          for(java.util.Enumeration enumeration = tea.entity.node.SOrder.find(node.getCommunity(),teasession._rv._strR,Integer.parseInt(s1)); enumeration.hasMoreElements(); )
          {
            int j2 = ((Integer)enumeration.nextElement()).intValue();
            tea.entity.node.SOrder so_obj=       tea.entity.node.SOrder.find(j2,teasession._nLanguage);
            tea.entity.node.Node node_obj=                 tea.entity.node.Node.find(j2);
            tea.entity.RV rv = node_obj.getCreator();

            %>
          <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
            <td><A href="/jsp/type/sorder/<%
            switch(k)
            {
              case 0:
              out.print("BgInceptSOrder.jsp"); break;
              case 3:
              out.print("BgFinishedSOrder.jsp"); break;
              default:
              out.print("BgEditSOrder.jsp");
            }
            %>?node=<%=j2+nexturl%>">#<%=j2%></A> </td>
            <td><%=(new java.text.SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(node_obj.getTime())%></td>
            <td><%-- <%=ts.hrefGlance(rv)%>--%><%=rv.toString() %></td>
          <%}%>
        </tr>
</table><br><br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

