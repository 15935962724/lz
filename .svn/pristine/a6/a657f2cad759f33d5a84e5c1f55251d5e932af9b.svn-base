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
//            if(inventory<1)
//            {
//              alert("缺货,暂不能进行支付.");
//              obj.checked=false;
//            }else
//            {
//              if(parseInt(obj.value)>inventory)
//              {
//                alert("不能大于库存("+inventory+").");
//                obj.value=inventory;
//              }
//            }
          }
          </script>
          </head>
          <body id="bodynone">
          <div id="tablebgnone">
             <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
              <div id="head6"><img height="6" src="about:blank"></div>
               <%--   <div id="PathDiv"><%=TeaServlet.hrefGlance(teasession._rv)%>><A href="/servlet/Offers"><%=r.getString(teasession._nLanguage, "Offers")%></A> <%=r.getString(teasession._nLanguage, "ShoppingCarts")%></div>--%>

                <span id="gopath"></span>
                <%--
                Enumeration e = Buy.findCarts(teasession._rv,teasession._strCommunity,0);
                while(e.hasMoreElements())
                {
                Cart cart = (Cart)e.nextElement();
                String s = r.getString(teasession._nLanguage, Common.CURRENCY[cart._nCurrency]);

                --%>
                <%
                String url = null;
                if(teasession._rv==null)
                {
                  url = "/jsp/offer/login.jsp";
                }else
                {
                  url ="/jsp/offer/CheckoutCart1s.jsp";
                }
                %>
                <FORM name=foCheckout<%=i%> METHOD=POST action="<%=url%>">
                  <input type='hidden' name=Vendor VALUE="">
                  <input type='hidden' name=currency VALUE="<%=1%>">
                  <input type='hidden' name=community VALUE="<%=teasession._strCommunity%>">
                  <input type='hidden' name=nexturl VALUE="<%=request.getRequestURI()+"?"+request.getQueryString()%>">

                  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                   <%

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
                       javax.servlet.http.HttpSession se = request.getSession();
                    if(teasession._rv==null)
                    {

                       int j2 = 0;
                    java.math.BigDecimal total2 = new java.math.BigDecimal(0.0D);
                      java.util.Enumeration es = ShoppingCarts.find(teasession._strCommunity," AND sessionid = "+DbAdapter.cite(se.getId()));
                      while(es.hasMoreElements())
                      {
                        int scid = ((Integer)es.nextElement()).intValue();
                        ShoppingCarts  scobj = ShoppingCarts.find(scid);
                        int nid = scobj.getNode();
                        Node nobj = Node.find(nid);

                        BuyPrice buyprice2 = BuyPrice.find(scobj.getCommodity(), scobj.getCurrency());
                        Commodity commodity2 = Commodity.find(scobj.getCommodity());
                        int inventory2=commodity2.getInventory();//库存

                        Supplier supplier2=Supplier.find(commodity2.getSupplier());

                        String s32 = commodity2.getSKU();
                        String s42 = commodity2.getSerialNumber();
                        int l12 = commodity2.getQuality();

                        BigDecimal price2 = buyprice2.getPrice();
                        int quantity2 = scobj.getQuantity();
                        BigDecimal bigdecimal42 = new BigDecimal(quantity2);

                        BigDecimal point2 = buyprice2.getPoint();
                        int k22 = buyprice2.getConvertCurrency();

                        if(buyprice2.getOptions() == 0)
                        {
                          point2 = point2.multiply(bigdecimal42);
                        }
                        else
                        {
                          point2 = point2.multiply(bigdecimal42);
                        }

                        BigDecimal sum2 = price2.multiply(bigdecimal42);
                        total2=total2.add(sum2);
                      %>

                       <tr id="<%=j2%2!=0?"true":"flase"%>" onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
                        <td>
                        <%
                        out.print("<input type=checkbox name=buys value="+scid);
                        if(inventory2<1)//库存
                        {
                          //out.print(" onclick=alert('缺货,暂不能进行支付.');this.checked=false; >");
                        }else
                        {
                          out.print(" checked >");
                        }
                        %></td>
                        <td nowrap id="time"><%=sdf.format(scobj.getTimes())%></td>
                        <td nowrap><a href="/servlet/Node?node=<%=nid%>&Language=<%=teasession._nLanguage%>"><%=nobj.getSubject(teasession._nLanguage)%></a></td>
                        <td><%=s+df.format(price2)%></td>
                        <td><%=supplier2.getName(teasession._nLanguage)%></td>
                        <td align=CENTER>
                        <%
                        out.print("<input name=quantity"+j2+" value="+quantity2+" size=2 onkeypress=inputInteger(); onchange=f_change(this,"+inventory2+"); >");
                        %></td>
                        <td align=right><%=point2.intValue()%></td><!--积分-->
                        <td align=right><%=s+df.format(sum2.setScale(2,4))%></td>
                        <td id="delete"><input name="button"  type="button" class="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))window.open('/jsp/offer/login.jsp?delete=delete&scid=<%=scid%>&nexturl=<%=request.getRequestURI()+"?"+request.getQueryString()%>','_self');" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>"/>
                        </td>
                      </tr>
                       <input type='hidden' name=buy<%=j2%> value="<%=scid%>">
                      <%
                      j2++;
                    }%>
                            <tr id="xj">
                      <td>&nbsp;</td>
                      <td><%=r.getString(teasession._nLanguage, "SubTotal")%>:</td>
                      <td colspan="7" id="price2"><%=s+df.format(total2)%></td>
                    </tr>
                    <%
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
                      BigDecimal point = new BigDecimal("0");
						if(buyprice.getPoint()!=null)
						{
							point = buyprice.getPoint();
						}
                     
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
                        inventory=10;
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
                        <%
                        if(teasession._rv==null)
                        out.print("<input type=button value='预定' onclick=alert('请先登陆！') >");
                        else
                        out.print("<input type=SUBMIT class='CB' name='Checkout' value="+r.getString(teasession._nLanguage, "预定")+" id='bt'>");
                        %>
                      </td>
                    </tr>
                  </table>

                </FORM>
                <%--
                i++;
                }
                --%>

             <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

                <div id="head6"><img height="6" src="about:blank"></div>
                  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage, request)%></div></div>
          </body>
</html>



