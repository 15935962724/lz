<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.admin.erp.*" %><%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %><%@page import="java.math.*" %><%@page import="tea.ui.TeaSession" %><%@page import="tea.entity.admin.erp.*" %><%@page import="tea.entity.league.*" %><%@page import="tea.entity.util.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


String paid = teasession.getParameter("paid");
Paidinfull pobj = Paidinfull.find(paid);

LeagueShop leobj = LeagueShop.find(pobj.getSupplname());
StringBuffer sql = new StringBuffer(" AND time_s  is not  null AND  paid="+DbAdapter.cite(paid));
int count = GoodsDetails.count(teasession._strCommunity,sql.toString());
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>销售统计详细</title>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
  <META HTTP-EQUIV="Expires" CONTENT="0">
    <body bgcolor="#ffffff">
        <div id="lzi_rkd">
          <h1>销售统计详细</h1>
          <form action="/servlet/EditPurchase" method="POST" name="form1" onsubmit="return f_submit();">
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
           <tr><td colspan="4" align="center"><b><%=leobj.getLsname() %></b></td></tr>
           <tr>
             <td nowrap>销售单号：</td>
             <td nowrap><%=paid %></td>
             <td nowrap>销售日期：</td>
             <td nowrap><%=pobj.getTime_sToString()%></td>
           </tr>

          </table>
            <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr id="tableonetr">
                <td align="center" nowrap>条形码或编号</td>
                <td align="center" nowrap>商品名称</td>
                <td align="center" nowrap>商品单价</td>
                <td align="center" nowrap>销售数量</td>
                <td align="center" nowrap>销售金额</td>
                <td align="center" nowrap>退货数量</td>
                <td align="center" nowrap>退货金额</td>
              </tr>
              <%

              int a = 0,c=0;
              java.math.BigDecimal b = new java.math.BigDecimal("0");
                java.math.BigDecimal d = new java.math.BigDecimal("0");
              java.util.Enumeration e = GoodsDetails.find(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
              if(!e.hasMoreElements())
              {
                out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
              }
              while(e.hasMoreElements())
                {
                  int gdid= ((Integer)e.nextElement()).intValue();
                  GoodsDetails gdobj = GoodsDetails.find(gdid);
                  BigDecimal total=new BigDecimal(gdobj.getTotal());
                  a = a+gdobj.getQuantity();
                  b = b.add(total);
                  c = c+gdobj.getRsquantity();
                  d = d.add(new java.math.BigDecimal(gdobj.getRsquantity()).multiply(new java.math.BigDecimal(gdobj.getSupply())));
                  Node nobj = Node.find(gdobj.getNode());

              %>
              <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
                <td><%=nobj.getNumber()%></td>
                <td><%=nobj.getSubject(teasession._nLanguage) %></td>
                <td ><%=gdobj.getSupply()%></td>
                <td ><%=gdobj.getQuantity()%></td>
                <td ><%=total%>&nbsp;元</td>
                <td ><%=gdobj.getRsquantity()%></td>
                <td ><%= new java.math.BigDecimal(gdobj.getRsquantity()).multiply(new java.math.BigDecimal(gdobj.getSupply()))%>&nbsp;元</td>
              </tr>
              <%} %>
              <%if(count>0){ %>
              <tr>
              <td colspan="2">&nbsp;</td>
                <td align="right"><b>合计数量和金额：</b></td>
                <td><%=a %></td>
                <td><%=b %>&nbsp;元</td>
                <td><%=c %></td>
                <td><%=d %>&nbsp;元</td>
              </tr>
<%} %>
            </table>

          <br>
          <input type=button value="返回" onClick="javascript:history.back()">
        </div>

          </form>

        </body>
</html>
