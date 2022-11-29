<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.node.*" %><%@ page  import="tea.resource.Resource"  %><%@ page import="java.math.*" %><%@ page  import="tea.entity.admin.*" %><%@ page  import="java.util.*" %><%@ page  import="tea.entity.*" %><%@ page  import="tea.entity.member.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;

Resource r=new Resource("/tea/resource/Workreport");

String member=request.getParameter("member");

int worklog=0;
if(request.getParameter("worklog")!=null)
{
  worklog=Integer.parseInt(request.getParameter("worklog"));
}
int workproject=0,worktype=0,goods=0;
boolean publicity=false;
String content=null,time=null,worklinkman=null;
if(worklog>0)
{
  Worklog obj=Worklog.find(worklog);
  workproject=obj.getWorkproject();
  worklinkman=obj.getWorklinkman();
  worktype=obj.getWorktype();
  publicity=obj.isPublicity();
  time=obj.getTimeToString();
  content=obj.getContent(teasession._nLanguage);
}else
{
  time=Worklog.sdf.format(new java.util.Date());
}


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body >
<!--新建/编辑销售记录-->
<h1><%=r.getString(teasession._nLanguage,"1169451073098")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
 <%
  int i=0;
  RV c_rv=new tea.entity.RV(member,teasession._strCommunity);
  for(Enumeration enumeration = tea.entity.node.Buy.findCarts(c_rv,teasession._strCommunity,Buy.BUY_PENDING_BG); enumeration.hasMoreElements();)
  {
    tea.entity.node.Cart cart = (tea.entity.node.Cart)enumeration.nextElement();
    String s = r.getString(teasession._nLanguage, tea.resource.Common.CURRENCY[cart._nCurrency]);
    %>
    <!--/jsp/offer/CheckoutCart1.jsp-->
    <form name=foCheckout<%=i%> METHOD=POST action="/servlet/EditWorkreport">
      <input type='hidden' name=vendor VALUE="<%=cart._strVendor%>">
      <input type='hidden' name=currency VALUE="<%=cart._nCurrency%>">
      <input type='hidden' name=community VALUE="<%=community%>">
      <input type='hidden' name=member VALUE="<%=member%>">
      <input type='hidden' name="action" VALUE="editwrtrade2">
      <input type='hidden' name=nexturl VALUE="<%=request.getRequestURI()+"?"+request.getQueryString()%>">

      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr ID=tableonetr>
          <td><%=r.getString(teasession._nLanguage, "Time")%></td>
          <td><%=r.getString(teasession._nLanguage, "TradeSubject")%></td>
          <td><%=r.getString(teasession._nLanguage, "BuyPList")%></td>
          <td><%=r.getString(teasession._nLanguage, "BuyPPrice")%></td>
          <td><%=r.getString(teasession._nLanguage, "Quantity")%></td>
          <td><%=r.getString(teasession._nLanguage, "Total")%></td>
          <td></td>
        </tr>
      <%
      int j = 0;
      java.math.BigDecimal bigdecimal = new java.math.BigDecimal(0.0D);
      java.math.BigDecimal bigdecimal1 = new java.math.BigDecimal(0.0D);

      for(java.util.Enumeration enumeration1 = tea.entity.node.Buy.findInCart(cart, c_rv,Buy.BUY_PENDING_BG); enumeration1.hasMoreElements();)
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
        if(l2 == 0)
        bigdecimal6 = bigdecimal6.add(bigdecimal3.multiply(bigdecimal4).multiply(bigdecimal7));
        if(l2 == 1)
        bigdecimal6 = bigdecimal6.add(bigdecimal7.multiply(bigdecimal4));
%>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td><%=Entity.sdf.format(date)%></td>

        <td><a href="/servlet/Node?node=<%=l%>"><%=s1%></a><%if(i1!=0){%> <a href="/servlet/Node?node=<%=i1%>"><%=s2%></a><%}%></td>

        <td><%=s%><%=bigdecimal2%></td>
        <td><%=s%><%=bigdecimal3%></td>
        <td align=CENTER><%=j2%><!-- <input type="TEXT" class="CB"  name="Quantity<%=j%>" value="<%=j2%>" size=2> --></td>
        <td><%=s%><%=bigdecimal5%></td>
        <td>
          <input  CLASS="CB"  type="button" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))window.open('/servlet/DeleteCartItem?CartItem=<%=k%>&member=<%=java.net.URLEncoder.encode(member,"UTF-8")%>&nexturl=<%=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8")%>','_self');" value="<%=r.getString(teasession._nLanguage, "Delete")%>"/>
         </td>
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
        <td><%=r.getString(teasession._nLanguage, "SubTotal")%>:</td>
        <td><%=s+bigdecimal1%>
            <input type='hidden' name=ListTotal value="<%=bigdecimal%>"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "ListTotal")%>:</td>
        <td><%=s%><%=bigdecimal%></td>
      </tr>
      <%if(bigdecimal.subtract(bigdecimal1).compareTo(new BigDecimal(0.0D)) == 1)
 	{%>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "YouSave")%>:</td>
        <td align=RIGHT><%=s%><%=bigdecimal.subtract(bigdecimal1)%></td>
      </tr>
      <%}%>
<!--  <td>
      <td><input type=SUBMIT  CLASS="CB" name="ChangeQuantity" value="<%=r.getString(teasession._nLanguage, "ChangeQuantity")%>"></td>
  </tr>-->
  <%
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
    <input type=SUBMIT CLASS="CB" name="Checkout" VALUE="<%=r.getString(teasession._nLanguage, "Checkout")%>" onclick="foCheckout<%=i%>.elements[83]='';">
  </FORM>
  <%              i++;
            }
%>

<input type="button" value="<%=r.getString(teasession._nLanguage, "Add")%>" onclick="window.open('/jsp/admin/workreport/EditWrTrade_3.jsp?node=<%=teasession._nNode%>&member=<%=java.net.URLEncoder.encode(member,"UTF-8")%>','_self');"/>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



