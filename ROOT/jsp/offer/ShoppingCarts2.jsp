<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect(request.getContextPath()+"/servlet/StartLogin?Node="+teasession._nNode);
  return;
}

Resource r=new Resource("tea/ui/member/offer/Offers").add("tea/ui/member/offer/ShoppingCarts").add("tea/ui/member/Glance");
int i = 0;

String community=teasession._strCommunity;

java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy.MM.dd HH:mm aaa");


%><HTML>
<HEAD>
<link href="/tea/CssJs/<%=teasession._strCommunity%>.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</HEAD>
<body>
<h1><%=Buy.countBuys(teasession._rv,teasession._strCommunity)%> <%=r.getString(teasession._nLanguage, "Buys")%></h1>
<div id="head6"><img height="6"></div>
  <div id="PathDiv"><%=TeaServlet.hrefGlance(teasession._rv,request.getContextPath())%>><A href="/servlet/Offers"><%=r.getString(teasession._nLanguage, "Offers")%></A> ><%=r.getString(teasession._nLanguage, "ShoppingCarts")%></div>
  <%
   Enumeration enumeration = tea.entity.node.Buy.findCarts(teasession._rv,teasession._strCommunity,0);

  while(enumeration.hasMoreElements())
  {
    tea.entity.node.Cart cart = (tea.entity.node.Cart)enumeration.nextElement();

    String s = r.getString(teasession._nLanguage, tea.resource.Common.CURRENCY[cart._nCurrency]);

    %>
  <FORM name=foCheckout<%=i%> METHOD=POST action="/jsp/offer/CheckoutCart1.jsp">
    <input type='hidden' name=Vendor VALUE="<%=cart._strVendor%>">
    <input type='hidden' name=Currency VALUE="<%=cart._nCurrency%>">
    <input type='hidden' name=community VALUE="<%=community%>">

    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr ID=tableonetr>
        <TD><%=r.getString(teasession._nLanguage, "Time")%></TD>

        <TD><%=r.getString(teasession._nLanguage, "TradeSubject")%></TD>

        <TD><%=r.getString(teasession._nLanguage, "BuyPList")%></TD>

        <TD><%=r.getString(teasession._nLanguage, "BuyPPrice")%></TD>

        <TD><%=r.getString(teasession._nLanguage, "Quantity")%></TD>
        <TD><%=r.getString(teasession._nLanguage, "Total")%></TD>
        <td></td>
      </tr>
      <%
      int j = 0;
      java.math.BigDecimal bigdecimal = new java.math.BigDecimal(0.0D);
      java.math.BigDecimal bigdecimal1 = new java.math.BigDecimal(0.0D);





      for(java.util.Enumeration enumeration1 = tea.entity.node.Buy.findInCart(cart, teasession._rv,0);enumeration1.hasMoreElements();)
      {
        int k = ((Integer)enumeration1.nextElement()).intValue();

        Buy buy = Buy.find(k);
        String s1 = "";
        String s2 = "";
        int l = buy.getNode();
        int i1 = buy.getNodex();
        Node node = Node.find(l);
        if((node.getOptions() & 0x40000) != 0)//0x40000-->显示父亲节点的内容
        {
          Node node2 = Node.find(Node.find(node.getFather()).getFather());
          s1 = node2.getSubject(teasession._nLanguage);
        } else
        {
          s1 = node.getSubject(teasession._nLanguage);

          if(i1!=0)
          {
            Node node1 = Node.find(i1);
            s2 = node1.getSubject(teasession._nLanguage);
          }
        }
        BuyPrice buyprice = BuyPrice.find(buy.getCommodity(), cart._nCurrency);
        BigDecimal bigdecimal2 = buyprice.getList();
        Commodity commodity = Commodity.find(l);
        String s3 = commodity.getSKU();
        String s4 = commodity.getSerialNumber();
        int l1 = commodity.getQuality();
        java.util.Date date = buy.getTime();
        BigDecimal bigdecimal3 = buy.getPrice();
        int j2 = buy.getQuantity();
        BigDecimal bigdecimal4 = new BigDecimal(j2);
        BigDecimal bigdecimal5 = bigdecimal3.multiply(bigdecimal4);
        bigdecimal1 = bigdecimal1.add(bigdecimal5);
        if(bigdecimal2!=null)
        bigdecimal = bigdecimal.add(bigdecimal2.multiply(bigdecimal4));
        BigDecimal bigdecimal6 = new BigDecimal(0.0D);
        BigDecimal bigdecimal7 = buyprice.getPoint();
        int k2 = buyprice.getConvertCurrency();
        int l2 = buyprice.getOptions();
        //System.out.println("bigdecimal7:"+bigdecimal7);
        //System.out.println("bigdecimal3:"+bigdecimal3);
        //System.out.println("bigdecimal4:"+bigdecimal4);
        if(l2 == 0)
        bigdecimal6 = bigdecimal6.add(bigdecimal3.multiply(bigdecimal4).multiply(bigdecimal7));
        if(l2 == 1)
        bigdecimal6 = bigdecimal6.add(bigdecimal7.multiply(bigdecimal4));
%>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td><%=sdf.format(date)%></td>

        <td><a href="/servlet/Node?Node=<%=l%>"><%=s1%></a><%if(i1!=0){%> <a href="/servlet/Node?Node=<%=i1%>"><%=s2%></a><%}%></td>

        <td><%=s%><%=bigdecimal2%></td>
        <td><%=s%><%=bigdecimal3%></td>
        <td align=CENTER><input type="TEXT" class="CB"  name="Quantity<%=j%>" value="<%=j2%>" size=2></td>
        <td><%=s%><%=bigdecimal5%></td>
        <td>
          <input  CLASS="CB"  type="button" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))window.open('/servlet/DeleteCartItem?CartItem=<%=k%>','_self');" value="<%=r.getString(teasession._nLanguage, "Delete")%>"/>
         </a> </td>
      </tr>
      <input type='hidden' name=Buy<%=j%> value="<%=k%>">
      <input type='hidden' name=Node<%=j%> value="<%=l%>">
      <input type='hidden' name=Nodex<%=j%> value="<%=i1%>">
      <input type='hidden' name=SKU<%=j%> value="<%=s3%>">
      <input type='hidden' name=SerialNumber<%=j%> value="<%=s4%>">
      <input type='hidden' name=Quality<%=j%> value="<%=l1%>">
      <input type='hidden' name=Subject<%=j%> value="<%=s1%>">
      <input type='hidden' name=Subjectx<%=j%> value="<%=s2%>">
      <input type='hidden' name=Price<%=j%> value="<%=bigdecimal3.toString()%>">
      <input type='hidden' name=ConvertCurrency<%=j%> value="<%=k2%>">
      <input type='hidden' name=ConvertPoint<%=j%> value="<%=bigdecimal6.toString()%>">
      <%                   j++;
                }%>
      <input type='hidden' name=SubTotal value="<%=bigdecimal1%>">
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "SubTotal")%>:</TD>
        <td colspan="6"><%=s+bigdecimal1%>
            <input type='hidden' name=ListTotal value="<%=bigdecimal%>"></td>
      </tr>

      <tr>
        <TD><%=r.getString(teasession._nLanguage, "ListTotal")%>:</TD>
        <td colspan="6"><%=s%><%=bigdecimal%></td>
      </tr>
      <%if(bigdecimal.subtract(bigdecimal1).compareTo(new BigDecimal(0.0D)) == 1)
 	{%>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "YouSave")%>:</TD>
        <td  colspan="6"><%=s%><%=bigdecimal.subtract(bigdecimal1)%></td>
      </tr>
      <%}%>
  <td>


      <td><input type=SUBMIT  CLASS="CB" name="ChangeQuantity" value="<%=r.getString(teasession._nLanguage, "ChangeQuantity")%>"></td>
  </tr><%
                RV rv = new RV(cart._strVendor,community);
                int j1;
                BuyPoint buypoint;
                if(tea.entity.member.BuyPoint.isExisted(rv, teasession._rv, cart._nCurrency))
                {
                    j1 = BuyPoint.find(rv, teasession._rv, cart._nCurrency);
                    buypoint = BuyPoint.find(j1);
                } else
                {
                    j1 = tea.entity.member.BuyPoint.create(rv, teasession._rv, cart._nCurrency, new BigDecimal(0.0D), new BigDecimal(0.0D));
                    buypoint = BuyPoint.find(j1);
                }
                if(buypoint.getCurrentPoint().compareTo(new BigDecimal(0.0D)) == 1)
                { %>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "YourCurrentPoint")%>: <%=buypoint.getCurrentPoint().toString()%>
        <%      }%>
        <input type='hidden' name=BuyPoint value="<%=j1%>">
    </table>
    <%              int k1 = BuyInstruction.find(cart._strVendor, cart._nCurrency);
                if(k1 != 0)
                {
                    BuyInstruction buyinstruction = BuyInstruction.find(k1);%>
                    <%=buyinstruction.getText(teasession._nLanguage)%>
  <% }
                boolean flag = true;
                for(Enumeration enumeration2 = tea.entity.member.Shipping.find(community,cart._strVendor, cart._nCurrency, 8192); enumeration2.hasMoreElements();)
                {
                    int i2 = ((Integer)enumeration2.nextElement()).intValue();
                    Shipping shipping = Shipping.find(i2); %>
    <input  id="radio" type="radio" name=Shipping VALUE="<%=i2%>" <%if(flag)out.print(" CHECKED ");%> >
    <%=shipping.getName(teasession._nLanguage)%>
    <% if(flag)
                        flag = false;
                }%>
    <input type=SUBMIT CLASS="CB" name="Checkout" VALUE="<%=r.getString(teasession._nLanguage, "下一步")%>">
  </FORM>
  <%              i++;
            }
%>
  <div id="head6"><img height="6"></div>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage, request)%></div>
</body>
</HTML>
