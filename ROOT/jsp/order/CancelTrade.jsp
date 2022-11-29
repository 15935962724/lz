<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%><%

int i = Integer.parseInt(request.getParameter("Trade"));
Trade trade = Trade.find(i);
BigDecimal bigdecimal3 = new BigDecimal(0.0D);
int j = trade.getType();
int l = trade.getCurrency();
String s28 = r.getString(teasession._nLanguage, Common.CURRENCY[l]);
String s29 = r.getString(teasession._nLanguage, Common.CURRENCY[1]);


r.add("/tea/ui/member/order/SaleOrders").add("/tea/ui/member/order/PurchaseOrders").add("/tea/ui/member/order/TradeServlet");

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><style type="text/css">
<!--
body,td,th {
	font-family: 宋体;
}
-->
</style></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CancelTrade")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv"><%=ts.hrefGlance(teasession._rv)%> ><a href="/servlet/SaleOrders"><%=r.getString(teasession._nLanguage, "SaleOrders")%></a> ><a href="/servlet/SaleOrders?Type=<%=j%>"><%=r.getString(teasession._nLanguage, Trade.TRADE_TYPE[j])%></a> ><A href="/jsp/order/SaleOrders3.jsp?Trade=<%=i%>&Type=<%=j%>" ><%=r.getString(teasession._nLanguage, Trade.TRADE_STATUS[trade.getStatus()])%></A> >#<%=i%></div>

<FORM NAME=foProcess METHOD=POST ACTION="/servlet/EditPurchaseOrder" ENCTYPE=multipart/form-data onSubmit="<%="return(submitEmail(this.bEmail,'" + r.getString(teasession._nLanguage, "InvalidEmailAddress") + "')" + "&&submitText(this.bFirstName,'" + r.getString(teasession._nLanguage, "InvalidFirstName") + "')" +  "&&submitText(this.bAddress,'" +
                                     r.getString(teasession._nLanguage, "InvalidAddress") + "')" + "&&submitText(this.bCity,'" +
                                     r.getString(teasession._nLanguage, "InvalidCity") + "')" + "&&submitText(this.bState,'" + r.getString(teasession._nLanguage, "InvalidState") + "')" + "&&submitText(this.bCountry,'" + r.getString(teasession._nLanguage, "InvalidCountry") + "')" + "&&submitText(this.bTelephone,'" + r.getString(teasession._nLanguage, "InvalidTelephone") +
                                     "')" + "&&confirm('" + r.getString(teasession._nLanguage, "ConfirmProcessOrder") + "')" + ");"%>" >
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <TR ID=TableCaption>
    <TD COLSPAN=10>付款地址</TD>
  </TR>
  <TR>
    <td ID=RowHeader>消费者:</TD>
    <TD COLSPAN=3><%= trade.getCustomer()%></TD>
  </TR>
  <TR>
    <td ID=RowHeader>电子邮箱:</TD>
    <TD COLSPAN=3><input name=bEmail value="<%= trade.getbEmail()%>"></TD>
  </TR>
  <TR>
    <td ID=RowHeader>姓名:</TD>
    <TD COLSPAN=3><input name="bFirstName" value="<%=trade.getbFirstName(teasession._nLanguage)%>" ></TD>
  </TR>
  <TR>
    <td ID=RowHeader>单位:</TD>
    <TD COLSPAN=3><input name="bOrganization"  value="<%=trade.getbOrganization(teasession._nLanguage)%>"></TD>
  </TR>
  <TR>
    <td ID=RowHeader>地址:</TD>
    <TD COLSPAN=3><input name="bAddress" value="<%=trade.getbAddress(teasession._nLanguage)%>"/></TD>
  </TR>
  <TR>
    <td ID=RowHeader>市(县):</TD>
    <TD><input name="bCity" value="<%=trade.getbCity(teasession._nLanguage)%>"/></TD>
    <td ID=RowHeader>省(洲):</TD>
    <TD>
      <select name="bState">
        <option value="">--------------</option>
        <%
        String bstate=trade.getbState(teasession._nLanguage);
        for(int bstate_i=0;bstate_i<Common.PROVINCE.length;bstate_i++)
        {
          out.print("<option value="+Common.PROVINCE[bstate_i]);
          if(Common.PROVINCE[bstate_i].equals(bstate))
          {
            out.print(" SELECTED ");
          }
          out.print(" >"+r.getString(teasession._nLanguage,"Province."+Common.PROVINCE[bstate_i]));
        }
        %>
        </select></TD>
  </TR>
  <TR>
    <td ID=RowHeader>邮编:</TD>
    <TD><input name=bZip value="<%=trade.getbZip()%>"/></TD>
    <td ID=RowHeader>国家:</TD>
    <TD><%=new CountrySelection("bCountry",teasession._nLanguage,trade.getbCountry(teasession._nLanguage))%>
    </TD>
  </TR>
  <TR>
    <td ID=RowHeader>电话:</TD>
    <TD><input name="bTelephone" value="<%=trade.getbTelephone(teasession._nLanguage)%>"/></TD>
    <td ID=RowHeader>传真:</TD>
    <TD><input name="bFax" value="<%=trade.getbFax(teasession._nLanguage)%>"/></TD>
  </TR>
</TABLE>
<input  id="CHECKBOX" type="CHECKBOX" name="ShipToBilling"/>发货到付款地址
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <TR ID=TableCaption>
    <TD COLSPAN=10>交货地址</TD>
  </TR>
  <TR>
    <td ID=RowHeader>电子邮箱:</TD>
    <TD COLSPAN=3><input name="sEmail" value="<%=trade.getsEmail()%>"/></TD>
  </TR>
  <TR>
    <td ID=RowHeader>姓名:</TD>
    <TD COLSPAN=3><input name="sFirstName" value="<%=trade.getsFirstName(teasession._nLanguage)%>"></TD>
  </TR>
  <TR>
    <td ID=RowHeader>单位:</TD>
    <TD COLSPAN=3><input name="sOrganization" value="<%=trade.getsOrganization(teasession._nLanguage)%>"/></TD>
  </TR>
  <TR>
    <td ID=RowHeader>地址:</TD>
    <TD COLSPAN=3><input name="sAddress" value="<%=trade.getsAddress(teasession._nLanguage)%>"/></TD>
  </TR>
  <TR>
    <td ID=RowHeader>市(县):</TD>
    <TD><input name="sCity" value="<%=trade.getsCity(teasession._nLanguage)%>"/></TD>
    <td ID=RowHeader>省(洲):</TD>
    <TD>
           <select name="sState">
             <option value="">--------------</option>
             <%
             String sstate=trade.getsState(teasession._nLanguage);
             for(int bstate_i=0;bstate_i<Common.PROVINCE.length;bstate_i++)
             {
               out.print("<option value="+Common.PROVINCE[bstate_i]);
               if(Common.PROVINCE[bstate_i].equals(sstate))
               {
                 out.print(" SELECTED ");
               }
               out.print(" >"+r.getString(teasession._nLanguage,"Province."+Common.PROVINCE[bstate_i]));
             }
             %>
             </select>
</TD>
  </TR>
  <TR>
    <td ID=RowHeader>邮编:</TD>
    <TD><input name="sZip" value="<%=trade.getsZip()%>"/></TD>
    <td ID=RowHeader>国家:</TD>
    <TD>
   <%=new CountrySelection("sCountry",teasession._nLanguage,trade.getsCountry(teasession._nLanguage))%>

</TD>
  </TR>
  <TR>
    <td ID=RowHeader>电话:</TD>
    <TD><input name="sTelephone" value="<%= trade.getsTelephone(teasession._nLanguage)%>"/></TD>
    <td ID=RowHeader>传真:</TD>
    <TD><input name="sFax" value="<%=trade.getsFax(teasession._nLanguage)%>"/></TD>
  </TR>
</TABLE>
<!--FORM NAME=foProcess METHOD=POST ACTION="/servlet/ProcessSaleOrder" ENCTYPE=multipart/form-data -->
  <INPUT TYPE="HIDDEN" NAME="Trade" VALUE="<%=i%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
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
    for (java.util.Enumeration enumeration =  tea.entity.member.TradeItem.findByTrade(i); enumeration.hasMoreElements(); )
    {
      int l1 = ((Integer) enumeration.nextElement()).intValue();
      tea.entity.member.TradeItem tradeitem = tea.entity.member.TradeItem.find(l1);
      java.util.Date date1 = tradeitem.getTime();
      int i2 = tradeitem.getSubject();
      int k2 = tradeitem.getSubjectx();
      java.math.BigDecimal bigdecimal4 = tradeitem.getPrice();
      int i3 = tradeitem.getOQuantity();
      int j3 = tradeitem.getSQuantity();
      java.math.BigDecimal bigdecimal5 = bigdecimal4.multiply(new java.math.BigDecimal(j3));
      bigdecimal3 = bigdecimal3.add(bigdecimal5);
      %>
    <tr><td><font>
      <%=(new java.text.SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(date1) %></font>
          <%
          StringBuffer stringbuffer = new StringBuffer();
          if (j == 1 || j == 2 || j == 3)
          {
            tea.entity.node.Node node = tea.entity.node.Node.find(i2);
            tea.entity.node.Node node2 = tea.entity.node.Node.find(k2);
            int l3 = node.getFather();
            int j4 = tea.entity.node.Node.find(l3).getFather();
            tea.entity.node.Node node3 = tea.entity.node.Node.find(j4);
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
            tea.entity.node.Aded aded = tea.entity.node.Aded.find(i2);
            int k3 = aded.getNode();
            int i4 = aded.getAding();
            tea.entity.node.Ading ading = tea.entity.node.Ading.find(i4);
            stringbuffer.append(ading.getName(teasession._nLanguage));
            stringbuffer.append(" (" + new tea.html.Anchor("Adeds?node=" + k3, tea.entity.node.Node.find(k3).getSubject(teasession._nLanguage)) + ")");
          } else
          if (j == 4)
          {
            tea.entity.node.Node node1 = tea.entity.node.Node.find(i2);
            stringbuffer.append(node1.getAnchor(teasession._nLanguage));
          }
          out.print(new tea.html.Cell(new tea.html.Text(" &nbsp;")));
          out.print(new tea.html.Cell(new tea.html.Text(stringbuffer.toString())));
          out.print(new tea.html.Cell(new tea.html.Text(" &nbsp;")));
          out.print(new tea.html.Cell(new tea.html.Text(s28 + bigdecimal4)));
          tea.html.Cell cell26 = new tea.html.Cell(new tea.html.Text(Integer.toString(i3)));
          cell26.setAlign(2);
          out.print(cell26);
          tea.html.Cell cell27 = new tea.html.Cell(new tea.html.Text(Integer.toString(j3)));
          cell27.setAlign(2);
          out.print(cell27);
          tea.html.Cell cell28 = new tea.html.Cell(new tea.html.Text(s28 + bigdecimal5));
          cell28.setAlign(3);
          out.print(cell28);
          k1++;
        }
	%><tr>
  <td align=RIGHT colspan=7><%=r.getString(teasession._nLanguage, "Total")%>:</td>
  <td align=RIGHT><%=s28 + bigdecimal3.add(trade.getSh()).add(trade.getTax()).add( trade.getDiscount())%></td>
</tr>

  </table>
  <!--INPUT  id=CHECKBOX type="CHECKBOX" NAME=SendEmail VALUE=null CHECKED>
  同时按E-MAIL发送<BR-->



    <TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
    <TR ID=TableCaption>
      <TD COLSPAN=10>客户留言</TD>
    </TR>
    <% if (trade.isCustomer(teasession._rv))
            {%>
                    <TR>
      <td ID=RowHeader>声音:</TD>
      <TD COLSPAN=6><INPUT TYPE=FILE NAME=Voice>
        <INPUT  id=CHECKBOX type="CHECKBOX" NAME=ClearVoice VALUE=null>
        清空<A HREF="/tea/html/0/recorder.html" TARGET=_blank>录音</A></TD>
    </TR>
    <TR>
      <TD COLSPAN=2><TEXTAREA NAME="CText" ROWS="8" COLS="60" CLASS="edit_input"><%= trade.getCText(teasession._nLanguage)%></TEXTAREA></TD>
    </TR>
  <%} else
            if (trade.getCText(teasession._nLanguage).length() != 0 || trade.getCVoiceFlag())
            {
                out.print(new Row(new Cell(new Text(trade.getCText(teasession._nLanguage)), 2)));
                if (trade.getCVoiceFlag())
                {
                    out.print(new Row(new Cell(new Button(1, "CB", "CBPlay", r.getString(teasession._nLanguage, "CBPlay"), "window.open('TradeCVoice?Trade=" + i + "', '_self');"))));
                }
            }
            %></TABLE>
  <TABLE border="0" CELLPADDING=0 CELLSPACING=0 ID="TABLECENTER">
    <TR ID=TableCaption>
      <TD COLSPAN=10>供货商留言</TD>
    </TR><%
            if (trade.isVendor(teasession._rv))
            {%>
            <TR>
              <td ID=RowHeader>声音:</TD>
              <TD COLSPAN=6><INPUT TYPE=FILE NAME=Voice><INPUT  id=CHECKBOX type="CHECKBOX" NAME=ClearVoice VALUE=null>清空<A HREF="/tea/html/0/recorder.html" TARGET=_blank>录音</A></TD>
            </TR>
            <TR>
            <td ID=RowHeader><%=r.getString(teasession._nLanguage,"Content")%>:</TD>
              <TD COLSPAN=2><TEXTAREA NAME="VText" ROWS="8" COLS="60" CLASS="edit_input"><%=trade.getVText(teasession._nLanguage)%></TEXTAREA></TD>
            </TR>
  <%
          } else
            if (trade.getVText(teasession._nLanguage).length() != 0 || trade.getVVoiceFlag())
            {
                out.print(new Row(new Cell(new Text(trade.getVText(teasession._nLanguage)), 2)));
                if (trade.getVVoiceFlag())
                {
                    out.print(new Row(new Cell(new Button(1, "CB", "CBPlay", r.getString(teasession._nLanguage, "CBPlay"), "window.open('TradeVVoice?Trade=" + i + "', '_self');"))));
                }
            }
  %>  </TABLE>
  <TABLE border="0" CELLPADDING=0 CELLSPACING=0 ID="TABLECENTER">
    <TR ID=TableCaption>
      <TD COLSPAN=10>取消理由:</TD>
    </TR>
    <tr><td><textarea name="explain" cols="50" rows="4" id="explain"><%if(trade.getExplain()!=null)out.print(trade.getExplain());%></textarea></td></tr>
    </TABLE>
  <!--INPUT  id=CHECKBOX type="CHECKBOX" NAME=SendEmail VALUE=null CHECKED>
  同时按E-MAIL发送<BR-->
  <p>
    <INPUT  id="radio" type="radio" NAME=Status VALUE=0 CHECKED>新订单
    <INPUT  id="radio" type="radio" NAME=Status VALUE=1>取消订单
    <INPUT TYPE="SUBMIT" VALUE="提交" ID="CBEnglish" CLASS="CB" onClick=""/>
  </p>
</FORM>

<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
