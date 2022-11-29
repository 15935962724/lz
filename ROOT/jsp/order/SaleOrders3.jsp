<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/member/order/SaleOrders").add("/tea/ui/member/order/PurchaseOrders").add("/tea/ui/member/order/TradeServlet");
String s2 =  request.getParameter("Pos");
int l1 = s2 == null ? 0 : Integer.parseInt(s2);
if(!teasession._rv.isAccountant())
{
  response.sendError(403);
  return;
}
String community=request.getParameter("community");
if(community==null)
{
  community=node.getCommunity();
}
String s = request.getParameter("Type");
String s1 = request.getParameter("Status");
boolean flag = s == null;
boolean flag1 = s != null && s1 == null;
boolean flag2 = s != null && s1 != null;
boolean flag3 = teasession._rv.isReal() || teasession._rv.isAccountant();
int j = Integer.parseInt(s==null?"0":s);
int k = Integer.parseInt(s1==null?"0":s1);
int i2 = Trade.count(false, teasession._rv, j, k,community);
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "SaleOrders")%></h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
  <div id="pathdiv"><%=ts.hrefGlance(teasession._rv)%> ><a href="/servlet/SaleOrders"><%=r.getString(teasession._nLanguage, "SaleOrders")%></a> ><a href="/servlet/SaleOrders?Type=<%=j%>"><%=r.getString(teasession._nLanguage, Trade.TRADE_TYPE[j])%></a> ><%=r.getString(teasession._nLanguage, Trade.TRADE_STATUS[k])%></div>
<h2><%=i2%> <%=r.getString(teasession._nLanguage, Trade.TRADE_TYPE[j])%> <%=r.getString(teasession._nLanguage, Trade.TRADE_STATUS[k])%> <%=r.getString(teasession._nLanguage, "SaleOrders")%></h2>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <%    if(i2 != 0)
                {
                  for(Enumeration enumeration = Trade.find(false, teasession._rv, j, k, l1, 100,community); enumeration.hasMoreElements(); )
                    {
                        int j2 = ((Integer)enumeration.nextElement()).intValue();
                        tea.entity.member.Trade trade = tea.entity.member.Trade.find(j2);
                        int k2 = trade.getCurrency();

                        RV rv = trade.getVendor();		%>
          <tr>
            <td><%=ts.hrefGlance(rv)%></td>
            <td><%=(new java.text.SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(trade.getTime())%></td>
            <td><!--A href="/servlet/Trade?Trade=<%=j2%>">#<%=j2%></A-->
            <%
            if(trade.getStatus()==0)//新订单
            {
              out.print(new tea.html.Anchor("/jsp/order/SaleNewOrder.jsp?Trade="+j2,"#"+j2));
            }else
            if(trade.getStatus()==1)//取消订单
            {
              out.print(new tea.html.Anchor("/jsp/order/CancelTrade.jsp?Trade="+j2,"#"+j2));
            }else
            if(trade.getStatus()==2)//已接收订单
            {
              out.print(new tea.html.Anchor("/jsp/order/InceptTrade.jsp?Trade="+j2,"#"+j2));
            }else
            if(trade.getStatus()==3&&trade.getPayType()==0)//已确认&& 货到付款
            {
              out.print(new tea.html.Anchor("/jsp/order/ConfirmedTrade0.jsp?Trade="+j2,"#"+j2));
            }else
            if(trade.getStatus()==3&&trade.getPayType()==1)//已确认&& 充值卡支付
            {
              out.print(new tea.html.Anchor("/jsp/order/ConfirmedTrade0.jsp?Trade="+j2,"#"+j2));
            }else
            /*if(trade.getStatus()==3)//已确认
            {
              out.print(new tea.html.Anchor("/jsp/order/ConfirmedTrade.jsp?Trade="+j2,"#"+j2));
            }else*/
            if(trade.getStatus()==4)//准备发货
            {
              out.print(new tea.html.Anchor("/jsp/order/UnshippedTrade.jsp?Trade="+j2,"#"+j2));
            }else
            if(trade.getStatus()==5)//已发货
            {
              out.print(new tea.html.Anchor("/jsp/order/ApprovedShippedTrade.jsp?Trade="+j2,"#"+j2));
            }else
            if(trade.getStatus()==6)//收款
            {
              out.print(new tea.html.Anchor("/jsp/order/GatheringTrade.jsp?Trade="+j2,"#"+j2));
            }else
            if(trade.getStatus()==7)//完成
            {
              out.print(new tea.html.Anchor("/jsp/order/FinishedTrade.jsp?Trade="+j2,"#"+j2));
            }
            %>
            <!--A href="/jsp/order/NewTrade.jsp?Trade=<%=j2%>">#<%=j2%></A-->
</td>
            <td><%=r.getString(teasession._nLanguage, Common.CURRENCY[k2])%><%=trade.getTotal().toString()%></td>
            <%          if(k == 2)
                        {
                            int l2 = trade.getOptions();
                            if((l2 & 4) != 0)
                            {%>
            <td><%=new Radio("Paid" + j2, j2, true)%><%=r.getString(teasession._nLanguage, "PaymentReceived")%></td></tr>
              <%                               if(flag3){%>
          <tr>
            <td><input type=SUBMIT VALUE="<%=r.getString(teasession._nLanguage, "CBCorrect")%>" ID="CBCorrect" CLASS="CB" onClick="window.open('/servlet/TradePayment?type=<%=j%>&Status=<%=k%>&Unpaid=<%=j2%>', '_self');"></td>
              <%}
                            } else
                            {%>
            <td><input  id="CHECKBOX" type="CHECKBOX" name=Paid>
              <%=String.valueOf(j2)%><%=r.getString(teasession._nLanguage, "ConfirmPayment")%></td>
              <%                          }
                            if((l2 & 8) != 0)
                            {%>
            <td><input  id="radio" type="radio" name="Split<%=j2%>" checked >
              <%=r.getString(teasession._nLanguage, "OrderSplit")%></td>
              <%     if(flag3)
                                {%></tr>
          <tr>
            <td><input type=SUBMIT VALUE="<%=r.getString(teasession._nLanguage, "CBCorrect")%>" ID="CBCorrect" CLASS="CB" onClick="window.open('/servlet/TradePayment?type=<%=j%>&Status=<%=k%>&Unpaid=<%=j2%>', '_self');"></td>
              <%}
					} else
                     {%>
            <td><input  id="CHECKBOX" type="CHECKBOX" name=Split>
              <%=String.valueOf(j2)%><%=r.getString(teasession._nLanguage, "SplitOrder")%>
              <%}
                        }
                    }

                }%>
              <FORM name=foPayment METHOD=POST action="/servlet/TradePayment">
                <%			if(k == 2)
                {%>
                <input type='hidden' name=Type VALUE="<%=j%>">
                <input type='hidden' name=Status VALUE="<%=k%>">
                <%
                    if(flag3)
                    {%></td></tr>
                <tr>
                    <td><input type=SUBMIT VALUE="<%=r.getString(teasession._nLanguage, "CBSubmit")%>" ID="CBSubmit" CLASS="CB" onClick="">
                      <%                  }
                } %></td></tr>
              </form>
</table>
        <table border="0"  style="display:none" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr>
            <td><%              if(i2 != 0 && (j == 1 || j == 2 || j == 3) && (k == 2 || k == 5))
                {%>
              <FORM name=foDataOutput METHOD=POST action="/servlet/TradeDataOutput">
                <%                int i3;
                    for(Enumeration enumeration1 = Trade.find(false, teasession._rv, j, k, 0, i2,community); enumeration1.hasMoreElements(); )
                    {    i3 = ((Integer)enumeration1.nextElement()).intValue();%>
                <input type='hidden' name=Trades VALUE="<%=i3%>">
                <%                  }%>
                <input type='hidden' name=Batch VALUE="true">
                <input type='hidden' name=Type VALUE="<%=j%>">
                <input type='hidden' name=Status VALUE="<%=k%>">
                <input type=SUBMIT VALUE="<%=r.getString(teasession._nLanguage, "CBDataOutput")%>" ID="CBDataOutput" CLASS="CB" onClick="">
                <%                  DropDown dropdown = new DropDown("Method", r.getString(teasession._nLanguage, "TradeDataOutputMethodDefault"));
                    dropdown.addOption("-1", r.getString(teasession._nLanguage, "None"));
                    for(int j3 = 0; j3 < TradeDataOutput.TRADEDATAOUTPUT_METHOD.length; j3++)
                        dropdown.addOption(j3, r.getString(teasession._nLanguage, TradeDataOutput.TRADEDATAOUTPUT_METHOD[j3]));
%>
                <%=dropdown%>
              </form>
              <%
                }
                if(i2 != 0)
                {%>
              <FORM name=foInvoice METHOD=POST action="/servlet/TradeInvoice" target="_blank">
                <%                  int k3;
                    for(Enumeration enumeration2 = Trade.find(false, teasession._rv, j, k, 0, i2,community); enumeration2.hasMoreElements(); )
                    {    k3 = ((Integer)enumeration2.nextElement()).intValue();
%>
                <input type='hidden' name=Trades VALUE="<%=k3%>">
                <%}%>
                <input type='hidden' name=Batch VALUE="true">
                <input type='hidden' name=Type VALUE="<%=j%>">
                <input type='hidden' name=Status VALUE="<%=k%>">
                <input type=SUBMIT VALUE="<%=r.getString(teasession._nLanguage, "CBInvoice")%>" ID="CBInvoice" CLASS="CB" onClick="">
                <%                  DropDown dropdown1 = new DropDown("InvoiceFormat", r.getString(teasession._nLanguage, "TradeInvoiceFormatDefault"));
                    for(int l3 = 0; l3 < TradeInvoice.TRADEINVOICE_FORMAT.length; l3++)
                        dropdown1.addOption(l3, r.getString(teasession._nLanguage, TradeInvoice.TRADEINVOICE_FORMAT[l3]));
%>
                <%=dropdown1%>
              </form>
              <%                }%>
</table>
        <%=new FPNL(teasession._nLanguage, "/servlet/SaleOrders?type=" + j + "&Status=" + k + "&Pos=", l1, i2)%>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<div id="language"><%=new Languages(teasession._nLanguage, request)%></div>
</body>
</html>

