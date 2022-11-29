<%@ page import="tea.http.*"%>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="tea.entity.RV"%>
<%@ page import="tea.entity.member.Trade"%>
<%@ page import="tea.html.*"%>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.resource.Common"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.ui.TeaServlet"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.ui.member.order.*"%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Trade_Table")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2><%=r.getString(teasession._nLanguage, Trade.TRADE_TYPE[j])%></h2></tr>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
       <TD><%=r.getString(teasession._nLanguage, "Time")%></TD>
       <TD><%=r.getString(teasession._nLanguage, "TradeSubject")%></TD>
       <TD>&nbsp; </TD>
       <TD><%=r.getString(teasession._nLanguage, "Price")%></TD>
       <TD><%= r.getString(teasession._nLanguage, "OQuantity") %></TD>
       <TD><%=r.getString(teasession._nLanguage, "SQuantity")%></TD>
       <TD><%= r.getString(teasession._nLanguage, "Total")%></TD>
     </tr>
     <%
        boolean flag6 = true;
            int k1 = 0;
            for(Enumeration enumeration = TradeItem.findByTrade(i); enumeration.hasMoreElements();)
            {   int l1 = ((Integer)enumeration.nextElement()).intValue();
                TradeItem tradeitem = TradeItem.find(l1);
                java.util.Date date1 = tradeitem.getTime();
                int i2 = tradeitem.getSubject();
                int k2 = tradeitem.getSubjectx();
                BigDecimal bigdecimal4 = tradeitem.getPrice();
                int i3 = tradeitem.getOQuantity();
                int j3 = tradeitem.getSQuantity();
                BigDecimal bigdecimal5 = bigdecimal4.multiply(new BigDecimal(j3));
                bigdecimal3 = bigdecimal3.add(bigdecimal5);
%>
     <tr id=<%=flag6 ? "OddRow" : "EvenRow"%>>
       <TD><%=(new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(date1)%></TD>
       <%               // Row row16 = new Row(new Cell(new Text("" +  + "")));
                StringBuffer stringbuffer = new StringBuffer();
                if(j == 1 || j == 2 || j == 3)
                {
                    Node node = Node.find(i2);
                    Node node2 = Node.find(k2);
                    int l3 = node.getFather();
                    int j4 = Node.find(l3).getFather();
                    Node node3 = Node.find(j4);
                    if(node3.getType() == 12)
                    {
                        Book book = Book.find(j4);
                        String s42 = book.getPublisher(teasession._nLanguage);
                        try
                        {
                            int k4 = Integer.parseInt(s42);%>
       <td><%=Node.find(k4).getSubject(teasession._nLanguage)%>
           <%                      }
                        catch(Exception _ex)
                        {%>
       <td><%=s42%>
           <%                      }%>
           <br/>
           44<%=node3.getAnchor(teasession._nLanguage)%> <br/>
           55<%=book.getISBN()%>
           <%                  } else
                    {%>
       <td><%=node.getAnchor(teasession._nLanguage)%> <%=node2.getAnchor(teasession._nLanguage)%>
           <%                  }
                } else
                if(j == 7)
                {
                    Aded aded = Aded.find(i2);
                    int k3 = aded.getNode();
                    int i4 = aded.getAding();
                    Ading ading = Ading.find(i4);%>
       <td><%=ading.getName(teasession._nLanguage)%> (<a href="/servlet/Adeds?node=<%=k3%>"><%=Node.find(k3).getSubject(teasession._nLanguage)%></a>)
           <%              } else
                if(j == 4)
                {
                    Node node1 = Node.find(i2);%>
           <%=node1.getAnchor(teasession._nLanguage)%>
           <%              }%>
       <td>&nbsp;</td>
       <td><%=s28%><%=bigdecimal4%></td>
       <td align=CENTER><%=i3%></td>
       <td align=CENTER><%=j3%></td>
       <td align=RIGHT><%=s28%><%=bigdecimal5%></td>
     </tr>
     <%              flag6 = !flag6;
                k1++;
            }
            if(flag2 || flag3)
            {
                if(j == 1 || j == 2 || j == 3)
                {
                    if(bigdecimal.compareTo(new BigDecimal(0.0D)) != 0)
                    {%>
     <tr>
       <td align=RIGHT colspan=6><%=r.getString(teasession._nLanguage, "Shipping")%>:</td>
       <td align=RIGHT><%=s28%><%=bigdecimal%></td>
     </tr>
     <%                 }
                    if(bigdecimal1.compareTo(new BigDecimal(0.0D)) != 0)
                    {%>
     <tr>
       <td align=RIGHT colspan=6><%=r.getString(teasession._nLanguage, "Tax")%>:</td>
       <td align=RIGHT><%=s28%><%=bigdecimal1%></td>
     </tr>
     <%                  }
                }
                if(j1 != 0 && bigdecimal2.compareTo(new BigDecimal(0.0D)) != 0)
                {%>
     <tr>
       <td align=RIGHT colspan=6><%=r.getString(teasession._nLanguage, "Discount")%>:</td>
       <td align=RIGHT><%=s28%><%=bigdecimal2%></td>
     </tr>
     <%              }
            } else
            if(flag3 && (k == 0 || k == 3 || k == 4 || k == 10))
            {
                if(i1 != 0 && (j == 1 || j == 2 || j == 3))
                {%>
     <tr>
       <td align=RIGHT colspan=6><%=r.getString(teasession._nLanguage, "Shipping")%>:</td>
       <td align=RIGHT><%=s28%>
           <input type="TEXT" class="edit_input"  name=Sh value="<%=bigdecimal.toString()%>" size=5></td>
     </tr>
     <tr>
       <td align=RIGHT colspan=6><%=r.getString(teasession._nLanguage, "Tax")%>:</td>
       <td align=RIGHT><%=s28%>
           <input type="TEXT" class="edit_input"  name=Tax value="<%=bigdecimal1.toString()%>" size=5></td>
     </tr>
     <%
                } else
                {%>
     <input type="TEXT" class="edit_input"  name=Sh value="<%=bigdecimal.toString()%>">
     <input type="TEXT" class="edit_input"  name=Tax value="<%=bigdecimal1.toString()%>">
     <%              }
                if(j1 != 0)
                {%>
     <tr>
       <td align=RIGHT colspan=6><%=r.getString(teasession._nLanguage, "Discount")%>:</td>
       <td align=RIGHT><%=s28%>
           <input type="TEXT" class="edit_input"  name=Discount value="<%=bigdecimal2.toString()%>" size=5></td>
     </tr>
     <%              } else
                {%>
     <input type="TEXT" class="edit_input"  name=Discount value="<%=bigdecimal2.toString()%>">
     <%              }
            }%>
     <tr>
       <td align=RIGHT colspan=6><%=r.getString(teasession._nLanguage, "Total")%>:</td>
       <td align=RIGHT><%=s28%><%=bigdecimal3.add(bigdecimal).add(bigdecimal1).add(bigdecimal2)%></td>
       <%          if(trade.getPayByPoint().compareTo(new BigDecimal(0.0D)) == 1)
            {%>
     <tr>
       <td align=RIGHT colspan=6><%=r.getString(teasession._nLanguage, "Use")%><%=s28%><%=r.getString(teasession._nLanguage, "PayByPoint")%>:</td>
       <td><%=trade.getPayByPoint()%></td>
     </tr>
     cell13.setAlign(3);
     <tr>
       <td align=RIGHT colspan=6><%=r.getString(teasession._nLanguage, "Balance")%>:
       <td><%              if(l == 6)
                {%>
           <%=s29%> <%=bigdecimal3.add(bigdecimal).add(bigdecimal1).add(bigdecimal2).add(trade.getPayByPoint().negate())%>
           <%              }else
                {%>
           <%=s28%> <%=bigdecimal3.add(bigdecimal).add(bigdecimal1).add(bigdecimal2).add(trade.getPayByPoint().negate())%>
           <%              }
            }
			if(trade.getConvertedPoint().compareTo(new BigDecimal(0.0D)) == 1)
            {%>
     <tr>
       <td align=RIGHT colspan=6><%=r.getString(teasession._nLanguage, "NewObtainPoint") + s28 + r.getString(teasession._nLanguage, "Point")%>:
       <td><%=trade.getConvertedPoint()%>
                        <%          }
            for(int j2 = 0; j2 < Common.CURRENCY.length; j2++)
                if(trade.isExisted(j2) && trade.getBuyPoint(j2).compareTo(new BigDecimal(0.0D)) == 1)
                {
                    String s30 = r.getString(teasession._nLanguage, Common.CURRENCY[j2]);%>
                     <tr>
                       <td align=RIGHT colspan=6><%=r.getString(teasession._nLanguage, "NewObtainPoint") + s30 + r.getString(teasession._nLanguage, "Point")%>:
              	      <td><%=trade.getBuyPoint(j2)%>
                            <%              }
			if(trade.getRefundedPoint().compareTo(new BigDecimal(0.0D)) == 1)
            {%>
                                         <tr>
                                           <td align=RIGHT colspan=6><%=r.getString(teasession._nLanguage, "RefundedPoint") + s28 + r.getString(teasession._nLanguage, "Point")%>:
                                           <td><%=trade.getRefundedPoint()%>
                                               <%          }
            if(trade.getRefund().compareTo(new BigDecimal(0.0D)) == 1)
            {%>
                                                                                <tr>
                                                                                  <td align=RIGHT colspan=6><%=r.getString(teasession._nLanguage, "Refund")%>:
                                                                                  <td><%=s28 + trade.getRefund()%>
                                                                                      <%          }
            for(int l2 = 0; l2 < Common.CURRENCY.length; l2++)
                if(trade.isExisted(l2) && trade.getReclaimedBuyPoint(l2).compareTo(new BigDecimal(0.0D)) == 1)
                {
                    String s31 = r.getString(teasession._nLanguage, Common.CURRENCY[l2]);%>
                                                                                                                                                              <tr>
                                                                                                                                                                <td align=RIGHT colspan=6><%=r.getString(teasession._nLanguage, "ReclaimedPoint") + s31 + r.getString(teasession._nLanguage, "Point")%>:
                                                                                                                                                                <td><%=trade.getReclaimedBuyPoint(l2)%>
                                                                                                                                                                    <%                }
            if(k == 2)
                if((trade.getOptions() & 4) != 0)
                {%>
                                                                                                                                                                                                                                                                                                                          <tr>
                                                                                                                                                                                                                                                                                                                            <td align=RIGHT colspan=6><input  id="CHECKBOX" type="CHECKBOX" name=Paid value=<%=String.valueOf(i)%> checked>
                                                                                                                                                                                                                                                                                                                            <td><%=r.getString(teasession._nLanguage, "PaymentReceived")%>
                                                                                                                                                                                                                                                                                                                                <%              } else
                {%>
                                                                                                                                                                                                                                                                                                                          <tr>
                                                                                                                                                                                                                                                                                                                            <td align=RIGHT colspan=6><input  id="CHECKBOX" type="CHECKBOX" name=Unpaid value=<%=String.valueOf(i)%> checked>
                                                                                                                                                                                                                                                                                                                            <td><%=r.getString(teasession._nLanguage, "PaymentUnpaid")%>
                                                                                                                                                                                                                                                                                                                                <%              }
            if(i1 != 0)
            {%>
                                                                                                                                                                                                                                                                                                                          <tr>
                                                                                                                                                                                                                                                                                                                            <td><%=s24%>
                                                                                                                                                                                                                                                                                                                                <%          }
            if(j1 != 0)
            {%>
<div id="head6"><img height="6" src="about:blank"></div>			
</body>
</html>		                                                                                                                                                                                                                                                                                                                       <tr>
                                                                                                                                                                                                                                                                                                                            <td><%=s25%>
                                                                                                                                                                                                                                                                                                                                <%          }%>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   </table>

