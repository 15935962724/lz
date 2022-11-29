<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.eon.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.text.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.league.*" %>
<%@page import="tea.entity.util.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


String icid = teasession.getParameter("icid");

ICSales icobj = ICSales.find(icid);
LeagueShop leobj = LeagueShop.find(icobj.getLeagueshop());
Card card1 = Card.find(leobj.getProvince());
Card card2 = Card.find(leobj.getCity());
LeagueShopType objty = LeagueShopType.find(leobj.getLsstype());
LeagueShopServer obj2 = LeagueShopServer.find(leobj.getLsstype());
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>分店会员销售详细</title>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
  <META HTTP-EQUIV="Expires" CONTENT="0">
    <body bgcolor="#ffffff">
        <div id="lzi_rkd">
          <h1>分店会员销售详细</h1>
          <form action="/servlet/EditPurchase" method="POST" name="form1" onsubmit="return f_submit();">
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
           <tr><td align="center" colspan="6"><b>消费单号：</b>&nbsp;<%=icid%></td></tr>
            <tr>
              <td nowrap>会员名称：</td>
              <td nowrap>李先生</td>
              <td nowrap>消费卡号：</td>
              <td nowrap><%=ICSales.getIcMember(icid)%></td>
              <td nowrap>分店名称：</td>
              <td nowrap><%=leobj.getLsname()%></td>
            </tr>
            <tr>
              <td nowrap>加盟区域：</td>
              <td nowrap><%=LeagueShop.CSAREA[leobj.getCsarea()]%>&nbsp;<%if(card1.getAddress()!=null)out.print(card1.getAddress());%>&nbsp;<%if(card2.getAddress()!=null)out.print(card2.getAddress());%></td>
              <td nowrap>加盟类型：</td>
              <td nowrap><%if(objty.getLstypename()!=null)out.print(objty.getLstypename()); %></td>
              <td nowrap>加盟级别：</td>
              <td nowrap><%=obj2.getLssname()%></td>
            </tr>
          </table>
          <span id="show">
            <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr id="tableonetr">
                <td nowrap>商品编号</td>
                <td nowrap>商品及服务名称</td>

                <td nowrap>单价</td>
                <td nowrap>数量</td>
                 <td nowrap>优惠额</td>
                <td nowrap>金额</td>
              </tr>
              <%
              java.util.Enumeration e =ICSalesList.find(" AND icsales ="+DbAdapter.cite(icid),0,Integer.MAX_VALUE);
              while(e.hasMoreElements())
              {
                int icsid = ((Integer)e.nextElement()).intValue();
                ICSalesList icsobj = ICSalesList.find(icsid);
              %>
              <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
                <td align="center"><%=icsobj.getNo()%></td>
                <td><%=icsobj.getName()%></td>

                <td align="center"><%=icsobj.getPrice() %>&nbsp;元</td>
                <td align="center"><%=icsobj.getQuantity()%></td>
                <td align="center"><%=icsobj.getDiscount()%>&nbsp;元</td>
                <td align="center"><%
                java.math.BigDecimal money=icsobj.getPrice().multiply(new java.math.BigDecimal(icsobj.getQuantity()));
                money=money.subtract(icsobj.getDiscount());
                out.print(money);
%>&nbsp;元</td>
              </tr>
              <%} %>
            </table>
          </span>


          <br>
          <input type=button value="返回" onClick="javascript:history.back()">
        </div>

          </form>

        </body>
</html>
