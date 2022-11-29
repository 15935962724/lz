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

int lsid = 0;
if(teasession.getParameter("lsid")!=null && teasession.getParameter("lsid").length()>0)
{
  lsid = Integer.parseInt(teasession.getParameter("lsid"));
}
LeagueShop leobj = LeagueShop.find(lsid);
String icid = teasession.getParameter("icid");
 ICSales icobj = ICSales.find(icid);
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
             <td nowrap><%=icid %></td>
             <td nowrap>销售日期：</td>
             <td nowrap><%=icobj.getTimeToString()%></td>
           </tr>

          </table>
            <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr id="tableonetr">
                <td align="center" nowrap>条形码或编号</td>
                <td align="center" nowrap>商品名称</td>
                <td align="center" nowrap>商品单价</td>
                <td align="center" nowrap>商品数量</td>
                 <td align="center" nowrap>优惠金额</td>
                <td align="center" nowrap>商品金额</td>
              </tr>
              <%
              int a = 0;
              java.math.BigDecimal b = new java.math.BigDecimal("0");
              java.util.Enumeration e = ICSalesList.find(" AND icsales="+DbAdapter.cite(icid),0,Integer.MAX_VALUE);
              while(e.hasMoreElements())
              {
                int lcsid= ((Integer)e.nextElement()).intValue();
                ICSalesList icsobj = ICSalesList.find(lcsid);
                BigDecimal total=icsobj.getPrice().multiply(new BigDecimal(icsobj.getQuantity()));
                total=total.subtract(icsobj.getDiscount());
                a = a+icsobj.getQuantity();
                b = b.add(total);
              %>
              <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
                <td><%=icsobj.getNo()%></td>
                <td><%=icsobj.getName() %></td>
                <td ><%=icsobj.getPrice()%></td>
                <td ><%=icsobj.getQuantity()%></td>
                  <td ><%=icsobj.getDiscount()%></td>
                <td ><%=total%>&nbsp;元</td>
              </tr>
              <%} %>
              <tr>
              <td colspan="2">&nbsp;</td>
                <td align="left"><b>合计数量和金额：</b></td>
                <td ><%=a %></td>
                <td ><%=b %>&nbsp;元</td>
              </tr>

            </table>

          <br>
          <input type=button value="返回" onClick="javascript:history.back()">
        </div>

          </form>

        </body>
</html>
