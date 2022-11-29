<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.*" %>
<%@page import="java.math.*" %>
<%@page import="java.text.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page  import="tea.resource.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
//if(teasession._rv==null)
//{
//  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
//  return;
//}

Resource r=new Resource("/tea/ui/member/offer/Offers").add("/tea/ui/member/offer/ShoppingCarts").add("/tea/ui/member/Glance");
int i = 0;

SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd HH:mm aaa");
DecimalFormat df = new DecimalFormat("#,###0.00");

Community community=Community.find(teasession._strCommunity);

String s="¥";

%>
<html>
<head>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
      <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
        <META HTTP-EQUIV="Expires" CONTENT="0">
          <script>
          function f_change(obj,inventory)
          {
            if(inventory<1)
            {
              alert("缺货,暂不能进行支付.");
              obj.checked=false;
            }else
            {
              if(parseInt(obj.value)>inventory)
              {
                alert("不能大于库存("+inventory+").");
                obj.value=inventory;
              }
            }
          }
          </script>
          </head>
          <body id="bodynone">
          <div id="tablebgnone">
            <div id="jspbefore" style="display:none">
              <script>if(top.location==self.location)jspbefore.style.display='';</script><%=community.getJspBefore(teasession._nLanguage)%>
              <h1><%=Buy.countBuys(teasession._rv,teasession._strCommunity)%> <%=r.getString(teasession._nLanguage, "Buys")%></h1></div>
              <div id="head6"><img height="6" src="about:blank"></div>
                <div id="PathDiv"><%=TeaServlet.hrefGlance(teasession._rv)%>><A href="/servlet/Offers"><%=r.getString(teasession._nLanguage, "Offers")%></A> <%=r.getString(teasession._nLanguage, "ShoppingCarts")%></div>

                <span id="gopath"><img src="/res/Home/u/0810/081016299.jpg"></span>
                <%--
                Enumeration e = Buy.findCarts(teasession._rv,teasession._strCommunity,0);
                while(e.hasMoreElements())
                {
                Cart cart = (Cart)e.nextElement();
                String s = r.getString(teasession._nLanguage, Common.CURRENCY[cart._nCurrency]);

                --%>
                <FORM name=foCheckout<%=i%> METHOD=POST action="/jsp/offer/CheckoutCart1.jsp">
                  <input type='hidden' name=Vendor VALUE="">
                  <input type='hidden' name=currency VALUE="<%=1%>">
                  <input type='hidden' name=community VALUE="<%=teasession._strCommunity%>">
                  <input type='hidden' name=nexturl VALUE="<%=request.getRequestURI()+"?"+request.getQueryString()%>">

                  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                   <%
                   System.out.println(teasession._rv.toString());
                   if(teasession._rv==null)
                   {

                   }
                   else
                   {
                   %>
                    <tr>
                      <td colspan="9"  id="tablehead">您的购物车目前有： <font color="#FF6600"><%=Buy.countBuys(teasession._rv,teasession._strCommunity)%></font> 件商品</td>
                    </tr>

                    <%} %>
                    <tr id=tableonetr>
                      <td>　</td>
                      <td><%=r.getString(teasession._nLanguage, "Time")%></td>
                      <td><%=r.getString(teasession._nLanguage, "TradeSubject")%></td>
                      <td><%=r.getString(teasession._nLanguage, "BuyPPrice")%></td>
                      <td><%=r.getString(teasession._nLanguage, "供货商")%></td>
                      <td><%=r.getString(teasession._nLanguage, "Quantity")%></td>
                      <td>积分</td>
                      <td><%=r.getString(teasession._nLanguage, "Total")%></td>
                      <td>&nbsp;</td>
                    </tr>
                    <%
                    if(teasession._rv==null)
                    {
                    }else{
                    int j = 0;
                    java.math.BigDecimal total = new java.math.BigDecimal(0.0D);

                    java.util.Enumeration e2 = Buy.findBuys(teasession._rv,teasession._strCommunity);
                    while(e2.hasMoreElements())
                    {
                      int k = ((Integer)e2.nextElement()).intValue();
                      Buy buy = Buy.find(k);
                      int l = buy.getNode();
                      Node node = Node.find(l);

                      BuyPrice buyprice = BuyPrice.find(buy.getCommodity(), buy.getCurrency());
                      Commodity commodity = Commodity.find(buy.getCommodity());
                      int inventory=commodity.getInventory();//库存

                      Supplier supplier=Supplier.find(commodity.getSupplier());

                      String s3 = commodity.getSKU();
                      String s4 = commodity.getSerialNumber();
                      int l1 = commodity.getQuality();

                      BigDecimal price = buyprice.getPrice();
                      int quantity = buy.getQuantity();
                      BigDecimal bigdecimal4 = new BigDecimal(quantity);

                      BigDecimal point = buyprice.getPoint();
                      int k2 = buyprice.getConvertCurrency();


//                      if(buyprice.getOptions() == 0)
//                      {
//                      point = price.multiply(bigdecimal4).multiply(point);
//                      }
//                      else
//                      {
//                      point = point.multiply(bigdecimal4);
//                      }
                                    /******Csv积分算法*****/
                       if(buyprice.getOptions() == 0)
                      {
                      point = point.multiply(bigdecimal4);
                      }
                      else
                      {
                      point = point.multiply(bigdecimal4);
                      }

                      BigDecimal sum = price.multiply(bigdecimal4);
                      total=total.add(sum);
                      %>
                      <tr id="<%=j%2!=0?"true":"flase"%>" onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
                        <td>
                        <%
                        out.print("<input type=checkbox name=buys value="+k);
                        if(inventory<1)//库存
                        {
                          out.print(" onclick=alert('缺货,暂不能进行支付.');this.checked=false; >");
                        }else
                        {
                          out.print(" checked >");
                        }
                        %></td>
                        <td nowrap id="time"><%=sdf.format(buy.getTime())%></td>
                        <td nowrap><a href="/servlet/Node?node=<%=l%>&Language=<%=teasession._nLanguage%>"><%=node.getSubject(teasession._nLanguage)%></a></td>
                        <td><%=s+df.format(price)%></td>
                        <td><%=supplier.getName(teasession._nLanguage)%></td>
                        <td align=CENTER>
                        <%
                        out.print("<input name=quantity"+j+" value="+quantity+" size=2 onkeypress=inputInteger(); onchange=f_change(this,"+inventory+"); >");
                        %></td>
                        <td align=right><%=point.intValue()%></td><!--积分-->
                        <td align=right><%=s+df.format(sum.setScale(2,4))%></td>
                        <td id="delete"><input name="button"  type="button" class="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))window.open('/servlet/DeleteCartItem?CartItem=<%=k%>','_self');" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>"/>
                        </td>
                      </tr>
                      <input type='hidden' name=buy<%=j%> value="<%=k%>">
                      <%
                      j++;
                    }//while
                    %>
                    <tr id="xj">
                      <td>&nbsp;</td>
                      <td><%=r.getString(teasession._nLanguage, "SubTotal")%>:</td>
                      <td colspan="7" id="price2"><%=s+df.format(total)%></td>
                    </tr>
                    <% }//else 里面的 %>
                    <tr>
                      <td id="buttons" colspan="9">
                        <span id="gotishi"></span>
                        <input type=SUBMIT  class="CB" name="changequantity" value="<%=r.getString(teasession._nLanguage, "ChangeQuantity")%>" id="bt">
                        <input type=SUBMIT value="清空购物车" id="bt" name="clearsc">
                        <input name="button" type=button id="bt" onClick="window.open('/servlet/Node?node=<%=teasession._nNode%>&Language=<%=teasession._nLanguage%>','_self');" value="继续购物">
                        <input type=SUBMIT class="CB" name="Checkout" value="<%=r.getString(teasession._nLanguage, "Checkout")%>" id="bt">
                      </td>
                    </tr>
                  </table>

                </FORM>
                <%--
                i++;
                }
                --%>

                <div id="jspafter" style="display:none">
                  <script>if(top.location==self.location)jspafter.style.display='';</script>
                  <%=community.getJspAfter(teasession._nLanguage)%>
                </div>

                <div id="head6"><img height="6" src="about:blank"></div>
                  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage, request)%></div></div>
          </body>
</html>



