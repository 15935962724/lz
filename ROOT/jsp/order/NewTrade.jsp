﻿<%
            int i = Integer.parseInt(httpservletrequest.getParameter("Trade"));
            Trade trade = Trade.find(i);
%>
<html>
<head>
<link href="/tea/CssJs/fashiongolf.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><style type="text/css">
<!--
body,td,th {
	font-family: 宋体;
}
-->
</style></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "NewTrade")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<A HREF="/servlet/Glance?Member=webmaster" ID=MemberOffline>webmaster</A>><A HREF="SaleOrders">销售单</A>><A HREF="SaleOrders?Type=1">购买</A>><A HREF="SaleOrders?Type=1&Status=0">新订单</A>>#8
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
    <TD COLSPAN=3><A HREF="mailto:<%= trade.getbEmail()%>" TARGET="_blank"><%= trade.getbEmail()%></A></TD>
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
    <TD>    <%
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
    %></TD>
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
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
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
    <tr id=OddRow>
        <td><font>2005.07.08 17:58 下午</font></td>
        <td>&nbsp; </td>
        <td><a href="/servlet/Buy?node=16711" title=cfdhes9wd>cfdhes9wd</a><a href="/servlet/Folder?node=16663"></a></td>
        <td>&nbsp; </td>
        <td>&yen;8000.00</td>
        <td align=CENTER>1</td>
        <td align=CENTER>1</td>
        <td align=RIGHT>&yen;8000.00</td>
    </tr>
      <tr id=EvenRow>
        <td><font>2005.07.08 17:58 下午</font></td>
        <td>&nbsp; </td>
        <td><a href="/servlet/Buy?node=18877" title=球T>球T</a><a href="/servlet/Goods?node=18876" title=球T>球T</a></td>
        <td>&nbsp; </td>
        <td>&yen;60.00</td>
        <td align=CENTER>1</td>
        <td align=CENTER>1</td>
        <td align=RIGHT>&yen;60.00</td>
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
      </tr>
  </table>
  <!--INPUT  id=CHECKBOX type="CHECKBOX" NAME=SendEmail VALUE=null CHECKED>
  同时按E-MAIL发送<BR-->
  <INPUT  id="radio" type="radio" NAME=Status VALUE=11 CHECKED>
  接收订单
  <INPUT  id="radio" type="radio" NAME=Status VALUE=1>
  取消订单
  <INPUT TYPE="SUBMIT" VALUE="提交" ID="CBEnglish" CLASS="CB" onClick=""/>
</FORM>
<div id="language"><%=new Languages(teasession._nLanguage, request)%></div><div id="head6"><img height="6" src="about:blank"></div>
</body>
<html>

