<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.util.*" %>
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

java.util.ArrayList al = (ArrayList) session.getAttribute("list");
String [] buyss = new String[al.size()];

for(int i=0;i<al.size();i++)
{
  buyss[i]=((Integer)al.get(i)).toString();
}




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



Supplier supplier=Supplier.find(_nSupplier);

Community community=Community.find(teasession._strCommunity);

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
<body id="bodynone">
<script src="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></script>



<div id="head6"><img height="6" src="about:blank"></div>

<span id="gopath3"></span>
<FORM name=form1 METHOD=POST action="/jsp/offer/EditCheckout.jsp">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="supplier" value="<%=_nSupplier%>"/>
<input type="hidden" name="act" value="createorder"/>

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
BigDecimal points  = new java.math.BigDecimal(0.0D);
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

  BigDecimal point = new BigDecimal("0");
  if(buyprice.getPoint()!=null) 
  {
	  point = buyprice.getPoint();
  }

if(buyprice.getOptions() == 0)
{
  point = point.multiply(bigdecimal4);
}
else
{
  point = point.multiply(bigdecimal4);
}
points = points.add(point);//积分总和

  total=total.add(price.multiply(bigdecimal4));
  total_point =price.multiply(bigdecimal4);

  out.print("<input type=hidden name=buys value="+buy+">");
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td nowrap><%=sdf.format(obj.getTime())%></td>
    <td nowrap><a href="/servlet/Node?node=<%=l%>&Language=<%=teasession._nLanguage%>"><%=node.getSubject(teasession._nLanguage)%></a></td>
    <td><%=s2+price%></td>
    <td><%=obj.getQuantity()%></td>
    <td><%=point.intValue()%></td>
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
      }
      int city=Integer.parseInt(request.getParameter("city"));
      out.print("<input type=hidden name=city value="+city+">");
      out.print(Card.find(city).toString());

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


<input type="submit" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Continue")%>" >
<input type="button" class="edit_button" value="返回" onClick="history.back();" >

</FORM>
<div id="head6"><img height="6" src="about:blank"></div>



<script src="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></script>


</body>
</html>
