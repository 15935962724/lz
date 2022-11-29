<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.*" %>
<%@ page import="tea.entity.site.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String nexturl=request.getParameter("nexturl");

String buys[]=request.getParameterValues("buys");
if(buys==null)
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("请先选择商品.","UTF-8")+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
  return;
}
int _nSupplier=-1;
for(int i=0;i<buys.length;i++)
{
  int buy=Integer.parseInt(buys[i]);
  Buy obj=Buy.find(buy);
  Commodity commodity = Commodity.find(obj.getCommodity());
  if(_nSupplier!=-1&&_nSupplier!=commodity.getSupplier())
  {
    response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("请您选择相同的“供应商”提供的产品下定单.","UTF-8")+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
    return;
  }
  _nSupplier=commodity.getSupplier();
}

Resource r=new Resource("/tea/ui/member/offer/Offers");

int currency=Integer.parseInt(request.getParameter("currency"));

String s2 = r.getString(teasession._nLanguage, Common.CURRENCY[currency]);//货币种类

java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy.MM.dd HH:mm aaa");

Community community=Community.find(teasession._strCommunity);

Supplier supplier=Supplier.find(_nSupplier);

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body id="bodynone">

<div id="jspbefore" style="display:none">
<%=community.getJspBefore(teasession._nLanguage)%>
</div>

<div id="tablebgnone">
<h1><%=r.getString(teasession._nLanguage, "填写收货地址")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name=foCheckout METHOD=POST action="/jsp/offer/CheckoutCart3.jsp">
<input type="hidden" name="trade" value="0"/>
<input type="hidden" name="supplier" value="<%=_nSupplier%>"/>


  <h2>列表-<%=supplier.getName(teasession._nLanguage)+" "+buys.length%></h2>
  <table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
  <tr ID=tableonetr>
    <TD><%=r.getString(teasession._nLanguage, "Time")%></TD>
    <TD><%=r.getString(teasession._nLanguage, "TradeSubject")%></TD>
    <TD><%=r.getString(teasession._nLanguage, "Price")%></TD>
    <TD><%=r.getString(teasession._nLanguage, "Quantity")%></TD>
    <TD><%=r.getString(teasession._nLanguage, "Point")%></TD>
  </tr>
<%
java.math.BigDecimal total = new java.math.BigDecimal(0.0D);
java.math.BigDecimal total_point = new java.math.BigDecimal(0.0D);
for(int i=0;i<buys.length;i++)
{
  int buy=Integer.parseInt(buys[i]);
  Buy obj=Buy.find(buy);
  int l = obj.getNode();
  Node node = Node.find(l);

  BuyPrice buyprice = BuyPrice.find(obj.getCommodity(), currency);
  Commodity commodity = Commodity.find(obj.getCommodity());


  BigDecimal price = buyprice.getPrice();
  int quantity = obj.getQuantity();
  BigDecimal bigdecimal4 = new BigDecimal(quantity);

  BigDecimal point = buyprice.getPoint();
  if(buyprice.getOptions() == 0)
  point = price.multiply(bigdecimal4).multiply(point);
  else
  point = point.multiply(bigdecimal4);

  total=total.add(price.multiply(bigdecimal4));
  total_point=total_point.add(point);

  out.print("<input type=hidden name=buys value="+buy+">");
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td nowrap><%=sdf.format(obj.getTime())%></td>
    <td nowrap><a href="/servlet/Node?node=<%=l%>&Language=<%=teasession._nLanguage%>"><%=node.getSubject(teasession._nLanguage)%></a></td>
    <td><%=s2+price%></td>
    <td><%=obj.getQuantity()%></td>
    <td><%=point.setScale(2,4)%></td>
  </tr>
<%
}
%>
<!-- 总共的价格 -->
<input type=hidden name=total value="<%=total%>" >
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td colspan="5">价格合计:<%=s2+total%></td>
</tr>
<!-- 总共的个数 -->
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td colspan="5">购买的商品数:<%=buys.length%></td>
</tr>
</table>

<!-- 积分管理在这个表格里 -->
<%
String point=request.getParameter("point");
if(point!=null&&(point=point.trim()).length()>0)
{
  out.print("<input type=hidden name=point value="+point+">");
%>
<h2>双重积分</h2>
<table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
  <tr>
    <td height="32">
      您本次购买将获得本站积分<%=total_point%>分，如果您拥<%=supplier.getName(teasession._nLanguage)%>的积分卡则可同时获得商场积分
      <a href="/jsp/admin/9000_3.jsp" target="_blank">（双积分）</a>；
    </td>
  </tr>
  <tr>
    <td>
      <table border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><%=supplier.getName(teasession._nLanguage)%></td>
          <td><%=point%></td>
            <td>请在此处填写您<%=supplier.getName(teasession._nLanguage)%>的积分卡号，如果没有可以为空；</td>
        </tr>
      </table>
</td>
  </tr>
</table>
<%}%>

<!--收货地址 -->
 <h2>填写收货地址</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" class="tablejh">
<tr>
  <Td id="left"><%=r.getString(teasession._nLanguage, "State")%>:</Td>
  <td>
      <%
      String state=request.getParameter("state");
      if(state!=null&&state.length()>0)
      {
        out.print("<input type=hidden name=state value="+state+">");
        for(int bstate_i=0;bstate_i<Common.PROVINCE.length;bstate_i++)
        {
          out.print("<option value="+Common.PROVINCE[bstate_i]);
          if(Common.PROVINCE[bstate_i].equals(state))
          {
            out.print(r.getString(teasession._nLanguage,"Province."+Common.PROVINCE[bstate_i]));
            break;
          }
        }
      }
      %>
      <%=r.getString(teasession._nLanguage, "City")%>:
      <%
      String city=request.getParameter("city");
      if(city!=null&&city.length()>0)
      {
        out.print("<input type=hidden name=city value="+city+">");
        out.print(city);
      }
      %>
  </td>
</tr>
<tr>
  <td id="left"><%=r.getString(teasession._nLanguage, "收货地址")%></Td>
  <td>
  <%
  String address=request.getParameter("address");
  if(address!=null&&address.length()>0)
  {
    out.print("<input type=hidden name=address value="+address+">");
    out.print(address);
  }
  %>
  </td><td>*我们将根据此地址发送您选的商品并计算发货费用；</td>
</tr>
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</Td>
    <td>  <%
  String email=request.getParameter("email");
  if(email!=null&&email.length()>0)
  {
    out.print("<input type=hidden name=email value="+email+">");
    out.print(email);
  }
  %>
    </td><td>*我们会通过邮件形式通知您发货情况；</td>
  </tr>
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "LastName")%><%=r.getString(teasession._nLanguage, "FirstName")%>:</Td>
    <td><%
    String firstname=request.getParameter("firstname");
    if(firstname!=null&&firstname.length()>0)
    {
      out.print("<input type=hidden name=firstname value="+firstname+">");
      out.print(firstname);
    }
    %>
    </td>
      <td>*接收时需要接受人签字；</td></tr>
      <tr>
        <Td id="left"><%=r.getString(teasession._nLanguage, "Organization")%>:</Td>
        <td><%
        String organization=request.getParameter("organization");
        if(organization!=null&&organization.length()>0)
        {
          out.print("<input type=hidden name=organization value="+organization+">");
          out.print(organization);
        }
        %></td><td>*指明接收单位，以免地址有误时错送；</td>
      </tr>
      <tr>
  <Td id="left"><%=r.getString(teasession._nLanguage, "Zip")%>:</Td>
  <td>
  <%
  String zip=request.getParameter("zip");
  if(zip!=null&&zip.length()>0)
  {
    out.print("<input type=hidden name=zip value="+zip+">");
    out.print(zip);
  }
  %></td><td>*正确填写，以方便发货方更快的找到您；</td>
</tr>
<tr>
  <Td id="left"><%=r.getString(teasession._nLanguage, "Telephone")%>:</td>
  <td><%
  String telephone=request.getParameter("telephone");
  if(telephone!=null&&telephone.length()>0)
  {
    out.print("<input type=hidden name=telephone value="+telephone+">");
    out.print(telephone);
  }
  %><td>*紧急联系方式，请正确填写。</td>
</tr>
</table>

<h2>配送方式</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
String ps=request.getParameter("ps");
if(ps!=null&&ps.length()>0)
{
  out.print("<input type=hidden name=ps value="+ps+">");
  if("0".equals(ps))
  out.print("<tr><td nowrap>平邮</td><td>如果您不急于使用此商品可以考虑选择平邮，此种方式邮购费用最低但邮递时间很长；</td></tr>");
  else
  if("1".equals(ps))
  out.print("<tr><td nowrap>快递</td><td>此方式邮递时间很短，但需要携带个人相关证件到快地公司去取，费用也相应贵些；</td></tr>");
  else
  if("2".equals(ps))
  out.print("<tr><td nowrap>EMS</td><td>邮政特快专递服务，是中国邮政的一个服务产品，主要是采取空运方式，加快递送速度，一般来说根据地区远近，1－4天到达。</td></tr>");
}
%>
</table>

<h2>支付方式</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
String defray=request.getParameter("defray");
if(defray!=null&&defray.length()>0)
{
  out.print("<input type=hidden name=defray value="+defray+">");
  if("0".equals(defray))
  out.print("<tr><td nowrap>储值卡</td><td></td></tr>");
  else
  if("1".equals(defray))
  out.print("<tr><td nowrap>网上支付</td><td>通过您的网上银行进行支付，安全便捷；</td></tr>");
  else
  if("2".equals(defray))
  out.print("<tr><td nowrap>邮局汇款</td><td>通过邮局将钱汇到指定帐号，安全可靠，只是速度慢！</td></tr>");
  else
  if("3".equals(defray))
  out.print("<tr><td nowrap>银行电汇</td><td></td></tr>");
}
%>
</table>

<h2>发票</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
String fp=request.getParameter("fp");
if(fp!=null&&fp.length()>0)
{
  out.print("<input type=hidden name=fp value="+fp+">");
  if("false".equals(fp))
  out.print("<tr><td nowrap>不要发票</td><td></td></tr>");
  else
  if("true".equals(fp))
  out.print("<tr><td nowrap>要发票</td><td></td></tr>");
}
%>
</table>

<input type=SUBMIT class="edit_button" value="<%=r.getString(teasession._nLanguage, "Continue")%>" >
<input type="button" class="edit_button" value="返回" onClick="history.back();" >

</FORM>
<div id="head6"><img height="6" src="about:blank"></div>

<div id="jspafter" style="display:none">
<%=community.getJspAfter(teasession._nLanguage)%>
</div>
<script>
if(top.location==self.location)
{
  jspbefore.style.display='';
  jspafter.style.display='';
}
</script>

</body>
</html>

