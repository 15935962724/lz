<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
int i = Integer.parseInt(request.getParameter("Trade"));
tea.entity.member.Trade trade = tea.entity.member.Trade.find(i);
java.math.BigDecimal bigdecimal3 = new java.math.BigDecimal(0.0D);
int j = trade.getType();
int l = trade.getCurrency();
String s28 = r.getString(teasession._nLanguage, Common.CURRENCY[l]);
String s29 = r.getString(teasession._nLanguage, Common.CURRENCY[1]);
r.add("/tea/ui/member/order/PurchaseOrders").add("/tea/ui/member/order/SaleOrders").add("/tea/ui/member/order/TradeServlet").add("/tea/ui/member/offer/Offers");


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
<h1><%=r.getString(teasession._nLanguage, "InceptTrade")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv"><%=ts.hrefGlance(teasession._rv)%> ><a href="/servlet/PurchaseOrders"><%=r.getString(teasession._nLanguage, "PurchaseOrders")%></a> ><a href="/servlet/PurchaseOrders?Type=<%=j%>"><%=r.getString(teasession._nLanguage, Trade.TRADE_TYPE[j])%></a> ><A href="/servlet/PurchaseOrders?Status=2&Type=<%=j%>&Trade=<%=i%>" ><%=r.getString(teasession._nLanguage, Trade.TRADE_STATUS[trade.getStatus()])%></A> >#<%=i%></div>

<FORM NAME=foProcess METHOD=POST ACTION="/servlet/EditPurchaseOrder" ENCTYPE=multipart/form-data onSubmit="<%="return(submitEmail(this.bEmail,'" + r.getString(teasession._nLanguage, "InvalidEmailAddress") + "')" + "&&submitText(this.bFirstName,'" + r.getString(teasession._nLanguage, "InvalidFirstName") + "')" +  "&&submitText(this.bAddress,'" +
                                     r.getString(teasession._nLanguage, "InvalidAddress") + "')" + "&&submitText(this.bCity,'" +
                                     r.getString(teasession._nLanguage, "InvalidCity") + "')" + "&&submitText(this.bState,'" + r.getString(teasession._nLanguage, "InvalidState") + "')" + "&&submitText(this.bCountry,'" + r.getString(teasession._nLanguage, "InvalidCountry") + "')" + "&&submitText(this.bTelephone,'" + r.getString(teasession._nLanguage, "InvalidTelephone") +
                                     "')" + "&&confirm('" + r.getString(teasession._nLanguage, "ConfirmProcessOrder") + "')" + ");"%>" >
<TABLE boder="0" CELLSPACING=0 CELLPADDING=0 id="tablecenter">
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
             </select>
</TD>
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
<TABLE boder="0" CELLSPACING=0 CELLPADDING=0 id="tablecenter">
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

  <INPUT TYPE="HIDDEN" NAME="Trade" VALUE="<%=i%>"/>
<TABLE boder="0" CELLSPACING=0 CELLPADDING=0 id="tablecenter">
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
  <TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
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

    <TABLE boder="0" CELLSPACING="0" CELLPADDING="0" id="tablecenter">
	<tr id="tr_explain" style="display:none" ><td>取消理由:</td><td><textarea name="explain" cols="50" rows="4" id="explain"><%if(trade.getExplain()!=null)out.print(trade.getExplain());%></textarea></td></tr>
  </TABLE>


   <%
  if(trade.isVendor(teasession._rv))
  {
  %>
  支付方式:
  <SELECT NAME="paytype" onChange="fexpress()">
  <%
for(int index=0;index<Trade.PAY_TYPE.length;index++)
{
  out.print("<OPTION VALUE="+index);
  if(index==trade.getPayType())
  out.print(" SELECTED");
  out.println(" >"+Trade.PAY_TYPE[index]);
}
  %>
  </SELECT>
  <!--INPUT  id=CHECKBOX type="CHECKBOX" NAME=SendEmail VALUE=null CHECKED>
  同时按E-MAIL发送<BR--><br/>
    <%--
    <span id="span_express" style="display:none" >
      快递公司:
      <SELECT NAME="express" >
        <%
        java.util.Enumeration enumer=tea.entity.node.Node.findByType(70,node.getCommunity());
        while(enumer.hasMoreElements())
        {
        int node_code=((Integer)enumer.nextElement()).intValue();
        %>
        <OPTION SELECTED VALUE="<%=node_code%>"><%=tea.entity.node.Node.find(node_code).getSubject(teasession._nLanguage)%></OPTION>
        <%}%>
      </SELECT></span>--%>
      <br/>
        <INPUT  id="radio" type="radio" NAME=Status VALUE=3 onClick="fexpress()" CHECKED>确认订单
          <%}%>
      <INPUT  id="radio" type="radio" NAME=Status VALUE=2 onClick="fexpress()" CHECKED>接收订单(不改变状态)
      <INPUT  id="radio" type="radio" NAME=Status  VALUE=1 onClick="fexpress()" >取消订单
        <INPUT TYPE="submit" VALUE="提交" ID="CBEnglish" CLASS="CB" onClick=" fchange()"/>
</FORM>
<script type="">
function fchange()
{
  if(foProcess.paytype.selectedIndex==1)
  foProcess.Status[0].value='6';
}
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

  for(var index=0;foProcess.Status.length;index++)
  {
    if(foProcess.Status[index].checked)
    {
      switch(foProcess.Status[index].value)
      {
        case '0':
        document.getElementById("tr_explain").style.display="none";
        break;
        case '1':
        document.getElementById("tr_explain").style.display="";
        break;
        case '2':
        document.getElementById("tr_explain").style.display="none";
        break;
        case '3':
        document.getElementById("tr_explain").style.display="none";
        break;
      }
    }
  }
}
</script>
<div id="language"><%=new Languages(teasession._nLanguage, request)%></div>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

