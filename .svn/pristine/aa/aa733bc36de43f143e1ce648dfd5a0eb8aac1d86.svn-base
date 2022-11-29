<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
////////完成////////////////////////////////////////////////////////////////
int i = Integer.parseInt(request.getParameter("Trade"));
tea.entity.member.Trade trade = tea.entity.member.Trade.find(i);
java.math.BigDecimal bigdecimal3 = new java.math.BigDecimal(0.0D);
int j = trade.getType();
int l = trade.getCurrency();
String s28 = r.getString(teasession._nLanguage, tea.resource.Common.CURRENCY[l]);
String s29 = r.getString(teasession._nLanguage, tea.resource.Common.CURRENCY[1]);

r.add("/tea/ui/member/order/SaleOrders").add("/tea/ui/member/order/PurchaseOrders").add("/tea/ui/member/order/TradeServlet");
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "FinishedTrade")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv"><%=ts.hrefGlance(teasession._rv)%> ><a href="/servlet/SaleOrders"><%=r.getString(teasession._nLanguage, "SaleOrders")%></a> ><a href="/servlet/SaleOrders?Type=<%=j%>"><%=r.getString(teasession._nLanguage, Trade.TRADE_TYPE[j])%></a> ><A href="/jsp/order/SaleOrders3.jsp?Trade=<%=i%>&Type=<%=j%>" ><%=r.getString(teasession._nLanguage, Trade.TRADE_STATUS[trade.getStatus()])%></A> >#<%=i%></div>
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" ID="tablecenter">
  <TR ID=TableCaption>
    <TD COLSPAN=10>付款地址</TD>
  </TR>
  <TR>
    <td ID=RowHeader>消费者:</TD>
    <TD COLSPAN=3><%= trade.getCustomer()%></TD>
  </TR>
  <TR>
    <td ID=RowHeader>电子邮箱:</TD>
    <TD COLSPAN=3><A HREF="mailto:<%=trade.getbEmail()%>" TARGET="_blank"><%= trade.getbEmail()%></A></TD>
  </TR>
  <TR>
    <td ID=RowHeader>姓名:</TD>
    <TD COLSPAN=3><%=trade.getbFirstName(teasession._nLanguage)%></TD>
  </TR>
  <TR>
    <td ID=RowHeader>单位:</TD>
    <TD COLSPAN=3><%=trade.getbOrganization(teasession._nLanguage)%></TD>
  </TR>
  <TR>
    <td ID=RowHeader>地址:</TD>
    <TD COLSPAN=3><%=trade.getbAddress(teasession._nLanguage)%></TD>
  </TR>
  <TR>
    <td ID=RowHeader>市(县):</TD>
    <TD><%=trade.getbCity(teasession._nLanguage)%></TD>
    <td ID=RowHeader>省(洲):</TD>
    <TD>
    <%
    String bstate=trade.getbState(teasession._nLanguage);
    for(int bstate_i=0;bstate_i<=Common.PROVINCE.length;bstate_i++)
    {
      if(bstate_i==Common.PROVINCE.length)
      {
        out.print(bstate);
      }else
      if(Common.PROVINCE[bstate_i].equals(bstate))
      {
        out.print(r.getString(teasession._nLanguage,"Province."+Common.PROVINCE[bstate_i]));
        break;
      }
    }
    %>
    </TD>
  </TR>
  <TR>
    <td ID=RowHeader>邮编:</TD>
    <TD><%=trade.getbZip()%></TD>
    <td ID=RowHeader>国家:</TD>
    <TD>
    <%
String bcountry=trade.getbCountry(teasession._nLanguage);
for (int loop = 0; loop < CountrySelection.COUNTRY_TYPE.length; loop++)
{
  if (CountrySelection.COUNTRY_TYPE[loop].equals(bcountry))
  {
    out.print( r.getString(teasession._nLanguage,"Country."+CountrySelection.COUNTRY_TYPE[loop]));
    break;
  }
}
%>
    </TD>
  </TR>
  <TR>
    <td ID=RowHeader>电话:</TD>
    <TD><%=trade.getbTelephone(teasession._nLanguage)%></TD>
    <td ID=RowHeader>传真:</TD>
    <TD><%=trade.getbFax(teasession._nLanguage)%></TD>
  </TR>
</TABLE>
<TABLE border=0 CELLPADDING=0 CELLSPACING=0 id="tablecenter">
  <TR ID=TableCaption>
    <TD COLSPAN=10>交货地址</TD>
  </TR>
  <TR>
    <td ID=RowHeader>电子邮箱:</TD>
    <TD COLSPAN=3><%=trade.getsEmail()%></TD>
  </TR>
  <TR>
    <td ID=RowHeader>姓名:</TD>
    <TD COLSPAN=3><%=trade.getsFirstName(teasession._nLanguage)%></TD>
  </TR>
  <TR>
    <td ID=RowHeader>单位:</TD>
    <TD COLSPAN=3><%=trade.getsOrganization(teasession._nLanguage)%></TD>
  </TR>
  <TR>
    <td ID=RowHeader>地址:</TD>
    <TD COLSPAN=3><%=trade.getsAddress(teasession._nLanguage)%></TD>
  </TR>
  <TR>
    <td ID=RowHeader>市(县):</TD>
    <TD><%=trade.getsCity(teasession._nLanguage)%></TD>
    <td ID=RowHeader>省(洲):</TD>
    <TD>
        <%
    String sstate=trade.getsState(teasession._nLanguage);
    for(int sstate_i=0;sstate_i<=Common.PROVINCE.length;sstate_i++)
    {
      if(sstate_i==Common.PROVINCE.length)
      out.print(sstate);
	else
      if(Common.PROVINCE[sstate_i].equals(sstate))
      {
        out.print(r.getString(teasession._nLanguage,"Province."+Common.PROVINCE[sstate_i]));
        break;
      }
    }
    %>
    </TD>
  </TR>
  <TR>
    <td ID=RowHeader>邮编:</TD>
    <TD><%=trade.getsZip()%></TD>
    <td ID=RowHeader>国家:</TD>
    <TD>    <%
    String scountry=trade.getsCountry(teasession._nLanguage);
    for (int scountry_i = 0; scountry_i <= CountrySelection.COUNTRY_TYPE.length; scountry_i++)
    {
      if(scountry_i==CountrySelection.COUNTRY_TYPE.length)
      {
        out.print(scountry);
      }else
      if (CountrySelection.COUNTRY_TYPE[scountry_i].equals(scountry))
      {
        out.print( r.getString(teasession._nLanguage,"Country."+CountrySelection.COUNTRY_TYPE[scountry_i]));
        break;
      }
    }
%>
</TD>
  </TR>
  <TR>
    <td ID=RowHeader>电话:</TD>
    <TD><%= trade.getsTelephone(teasession._nLanguage)%></TD>
    <td ID=RowHeader>传真:</TD>
    <TD><%=trade.getsFax(teasession._nLanguage)%></TD>
  </TR>
</TABLE>
<FORM NAME=foProcess METHOD=POST ACTION="/servlet/ProcessSaleOrder" ENCTYPE=multipart/form-data >
  <INPUT TYPE="HIDDEN" NAME="Trade" VALUE="<%=i%>"/>
  <table border="0" cellpadding=0 cellspacing=0 id="tablecenter">
    <tr id=TableCaption>
      <td colspan=10>购买</td>
    </tr>
    <tr id=TableHeader>
      <TD>时间</TD>
      <TD>&nbsp; </TD>
      <TD>交易内容</TD>
      <TD>&nbsp; </TD>
      <TD>单价</TD>
      <TD>订单数量</TD>
      <TD>发货数量</TD>
      <TD>合计</TD>
    </tr>
    <%

	 boolean flag6 = true;
            int k1 = 0;
            for (Enumeration enumeration = TradeItem.findByTrade(i); enumeration.hasMoreElements(); )
            {
                int l1 = ((Integer) enumeration.nextElement()).intValue();
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
    <tr>
      <td> <font><%=(new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(date1) %></font>
          <%
                StringBuffer stringbuffer = new StringBuffer();
                if (j == 1 || j == 2 || j == 3)
                {
                    Node node = Node.find(i2);
                    Node node2 = Node.find(k2);
                    int l3 = node.getFather();
                    int j4 = Node.find(l3).getFather();
                    Node node3 = Node.find(j4);
                    if (node3.getType() == 12)
                    {
                        Book book = Book.find(j4);
                        String s42 = book.getPublisher(teasession._nLanguage);
                        try
                        {
                            int k4 = Integer.parseInt(s42);
                            stringbuffer.append(Node.find(k4).getSubject(teasession._nLanguage));
                        } catch (Exception _ex)
                        {
                            stringbuffer.append(s42);
                        }
                        stringbuffer.append("<br/>" + node3.getAnchor(teasession._nLanguage));
                        stringbuffer.append("<br/>" + book.getISBN());
                    } else
                    {
                        stringbuffer.append(node.getAnchor(teasession._nLanguage));
                        stringbuffer.append(node2.getAnchor(teasession._nLanguage));
                    }
                } else
                if (j == 7)
                {
                    Aded aded = Aded.find(i2);
                    int k3 = aded.getNode();
                    int i4 = aded.getAding();
                    Ading ading = Ading.find(i4);
                    stringbuffer.append(ading.getName(teasession._nLanguage));
                    stringbuffer.append(" (" + new Anchor("Adeds?node=" + k3, Node.find(k3).getSubject(teasession._nLanguage)) + ")");
                } else
                if (j == 4)
                {
                    Node node1 = Node.find(i2);
                    stringbuffer.append(node1.getAnchor(teasession._nLanguage));
                }
                out.print(new Cell(new Text(" &nbsp;")));
                out.print(new Cell(new Text(stringbuffer.toString())));
                out.print(new Cell(new Text(" &nbsp;")));
                out.print(new Cell(new Text(s28 + bigdecimal4)));
                Cell cell26 = new Cell(new Text(Integer.toString(i3)));
                cell26.setAlign(2);
                out.print(cell26);
                Cell cell27 = new Cell(new Text(Integer.toString(j3)));
                cell27.setAlign(2);
                out.print(cell27);
                Cell cell28 = new Cell(new Text(s28 + bigdecimal5));
                cell28.setAlign(3);
                out.print(cell28);
                k1++;
            }

	%>
<tr>
  <td align=RIGHT colspan=7><%=r.getString(teasession._nLanguage, "Total")%>:</td>
  <td align=RIGHT><%=s28 + bigdecimal3.add(trade.getSh()).add(trade.getTax()).add( trade.getDiscount())%></td>
</tr>
      <!--tr id=EvenRow>

      </tr>
      <tr>
        <td align=RIGHT colspan=7>运费:</td>
        <td align=RIGHT>&yen;3.00</td>
      </tr>
      <tr>
        <td align=RIGHT colspan=7>合计:</td>
        <td align=RIGHT>&yen;8063.00</td>
      </tr>
      <tr>
        <td align=RIGHT colspan=7>新获得&yen;积分:</td>
        <td> 160000.00</td>
      </tr>
      <tr>
        <td colspan=6><font>1</font></td>
      </tr-->
  </table>
    <TABLE border=" 0" CELLPADDING=0 CELLSPACING=0 id="tablecenter">
    <TR ID=TableCaption>
      <TD COLSPAN=10>客户留言</TD>
    </TR>
  <%         if (trade.getCText(teasession._nLanguage).length() != 0 || trade.getCVoiceFlag())
            {
                out.print(new Row(new Cell(new Text(trade.getCText(teasession._nLanguage)), 2)));
                if (trade.getCVoiceFlag())
                {
                    out.print(new Row(new Cell(new Button(1, "CB", "CBPlay", r.getString(teasession._nLanguage, "CBPlay"), "window.open('TradeCVoice?Trade=" + i + "', '_self');"))));
                }
            }
            %></TABLE>
  <TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
    <TR ID=TableCaption>
      <TD COLSPAN=10>供货商留言</TD>
  </TR><%        if (trade.getVText(teasession._nLanguage).length() != 0 || trade.getVVoiceFlag())
            {
                out.print(new Row(new Cell(new Text(trade.getVText(teasession._nLanguage)), 2)));
                if (trade.getVVoiceFlag())
                {
                    out.print(new Row(new Cell(new Button(1, "CB", "CBPlay", r.getString(teasession._nLanguage, "CBPlay"), "window.open('TradeVVoice?Trade=" + i + "', '_self');"))));
                }
            }
  %>  </TABLE>
    <TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
    <tr><td>支付方式:</td><td><%=tea.entity.member.Trade.PAY_TYPE[trade.getPayType()]%></td></tr>
    <tr><td>发货时间:</td><td><%=trade.getUnshipped()%></td></tr>
    <tr><td>估计到达时间:</td><td><%=trade.getEstimate()%></td></tr>
    <tr><td>到达时间:</td><td><%=trade.getCome()%></td></tr>
    <tr><td>发票:</td><td>
<%
switch(trade.getInvoice())
{
  case 0:
  out.print("已付");
  break;
  case 1:
  out.print("未付");
  break;
  case 2:
  out.print("已付增值税发票");
}
%></td></tr>
</table>

<a href="/jsp/order/TradeMemberList.jsp?trade=<%=i%>">操作员列表</A>
</FORM>
<script type="">
function fexpress()
{/*
  if(foProcess.Status[0].checked&&foProcess.paytype.selectedIndex==0)
  {
    document.all('span_express').style.display='';
    foProcess.express.disabled=false;
  }else
  {
    document.all('span_express').style.display='none';
    foProcess.express.disabled=true;
  }*/
}
</script>
<div id="language"><%=new Languages(teasession._nLanguage, request)%></div><div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

