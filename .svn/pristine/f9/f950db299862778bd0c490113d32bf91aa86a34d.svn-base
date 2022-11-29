<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="java.math.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.site.*" %>
<% request.setCharacterEncoding("UTF-8");

String referer=request.getHeader("referer");
if(referer==null||referer.indexOf(request.getServerName())==-1)
{
  response.sendError(404,request.getRequestURI());
  return;
}

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String nexturl=request.getParameter("nexturl");

String trade=request.getParameter("trade");

Trade obj=Trade.find(trade);

Resource r=new Resource("/tea/ui/member/offer/Offers");

Community community=Community.find(teasession._strCommunity);

String s2 = r.getString(teasession._nLanguage, Common.CURRENCY[obj.getCurrency()]);//货币种类

Supplier supplier=Supplier.find(obj.getSupplier());

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_submit(v)
{
  form1.status.value=v;
}
</script>
<script>
//打印之前
window.onbeforeprint=function ()
{
  var pb=document.all('printbutton');
  pb.style.display='none';
};
//打印之后
window.onafterprint=function ()
{
  var pb=document.all('printbutton');
  pb.style.display='';
};
</script>
</head>
<body id="bodynone">

<div id="jspbefore" style="display:none">
<script>if(top.location==self.location)jspbefore.style.display='';</script>
<%=community.getJspBefore(teasession._nLanguage)%>
</div>

<div id="tablebgnone">
<h1><%=r.getString(teasession._nLanguage, "等待收货地址确认")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name=form1 METHOD=POST action="/servlet/EditTrade">
<input type="hidden" name="nexturl" value="<%=nexturl%>" />
<input type="hidden" name="community" value="<%=teasession._strCommunity%>" />
<input type="hidden" name="status" value="0" />
<input type="hidden" name="act" value="saleneworder" />
<input type="hidden" name="trade" value="<%=trade%>" />

<h2>列表-<%=supplier.getName(teasession._nLanguage)%></h2>
<table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
<tr><td COLSPAN="5">购买商品</td></tr>
  <tr ID=tableonetr>
    <td>&nbsp;</td>
    <TD><%=r.getString(teasession._nLanguage, "Time")%></TD>
    <TD><%=r.getString(teasession._nLanguage, "TradeSubject")%></TD>
    <TD><%=r.getString(teasession._nLanguage, "Price")%></TD>
    <TD><%=r.getString(teasession._nLanguage, "Quantity")%></TD>
  </tr>
<%
java.math.BigDecimal total = new java.math.BigDecimal(0.0D);
Enumeration e=TradeItem.findByTrade(trade);

for(int count=1;e.hasMoreElements();count++)
{
  int tradeitem=((Integer)e.nextElement()).intValue();
  TradeItem obj_ti=TradeItem.find(tradeitem);
  int l = obj_ti.getNode();
  Node node = Node.find(l);

  BigDecimal price = obj_ti.getPrice();
  BigDecimal bigdecimal4=new BigDecimal(obj_ti.getQuantity());

  total=total.add(price.multiply(bigdecimal4));
  if(obj_ti.getType()!=1){

  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=count%></td>
    <td nowrap><%=obj_ti.getTimeToString()%></td>
    <td nowrap><a href="/servlet/Node?node=<%=l%>&Language=<%=teasession._nLanguage%>"><%=node.getSubject(teasession._nLanguage)%></a></td>
    <td><%=s2+price%></td>
    <td><%=obj_ti.getQuantity()%></td>
  </tr>
<%
	}
}
%>


<tr><td COLSPAN="5">赠品</td></tr>

  <tr ID=tableonetr>
    <td>&nbsp;</td>
    <TD><%=r.getString(teasession._nLanguage, "Time")%></TD>
    <TD><%=r.getString(teasession._nLanguage, "TradeSubject")%></TD>
    <TD><%=r.getString(teasession._nLanguage, "Price")%></TD>
    <TD><%=r.getString(teasession._nLanguage, "Quantity")%></TD>
  </tr>
<%
Enumeration ee=TradeItem.findByTrade(trade);
for(int counts=1;ee.hasMoreElements();counts++)
{
  int tradeitem=((Integer)ee.nextElement()).intValue();
  TradeItem obj_ti=TradeItem.find(tradeitem);
  int l = obj_ti.getNode();
  Node node = Node.find(l);

  BigDecimal price = obj_ti.getPrice();
  BigDecimal bigdecimal4=new BigDecimal(obj_ti.getQuantity());

  total=total.add(price.multiply(bigdecimal4));
  if(obj_ti.getType()==1){

  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=counts%></td>
    <td nowrap><%=obj_ti.getTimeToString()%></td>
    <td nowrap><a href="/servlet/Node?node=<%=l%>&Language=<%=teasession._nLanguage%>"><%=node.getSubject(teasession._nLanguage)%></a></td>
    <td><%=s2+price%></td>
    <td><%=obj_ti.getQuantity()%></td>
  </tr>
<%
	}
}
%>
<!-- 总共的价格 -->
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td></td><td colspan="4">价格合计:<%=s2+total%></td>
</tr>
</table>



<!--收货地址 -->
 <h2>填写收货地址</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" class="tablejh">
<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
  <Td id="left"><%=r.getString(teasession._nLanguage, "State")%>:</Td>
  <td><%=obj.getCityToString(teasession._nLanguage)%></td>
</tr>
<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
  <td id="left"><%=r.getString(teasession._nLanguage, "收货地址")%></Td>
  <td><textarea name=address rows=2 cols=40><%=obj.getAddress(teasession._nLanguage).replaceAll("</","&lt;/")%></textarea></td>  <td>*我们将根据此地址发送您选的商品并计算发货费用；</td>
</tr>
  <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
    <Td id="left"><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</Td>
    <td><input type="TEXT"  name=email value="<%=obj.getEmail()%>" size=40 maxlength=40></td><td>*我们会通过邮件形式通知您发货情况；</td>
  </tr>
  <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
    <Td id="left"><%=r.getString(teasession._nLanguage, "LastName")%><%=r.getString(teasession._nLanguage, "FirstName")%>:</Td>
    <td><input type="TEXT"  name=firstname value="<%=obj.getFirstName(teasession._nLanguage)%>" size=20 maxlength=20>          </td>
      <td>*接收时需要接受人签字；</td>        </tr>
      <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
        <Td id="left"><%=r.getString(teasession._nLanguage, "Organization")%>:</Td>
        <td><input type="TEXT"  name=organization value="<%=obj.getOrganization(teasession._nLanguage)%>" size=40 maxlength=40></td>  <td>*指明接收单位，以免地址有误时错送；</td>
      </tr>
      <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
  <Td id="left"><%=r.getString(teasession._nLanguage, "Zip")%>:</Td>
  <td><input type="TEXT"  name=zip value="<%=obj.getZip(teasession._nLanguage)%>" size=20 maxlength=20></td><td>*正确填写，以方便发货方更快的找到您；</td>
</tr>
<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
  <Td id="left"><%=r.getString(teasession._nLanguage, "Telephone")%>:</td>
  <td><input type="TEXT"  name=telephone value="<%=obj.getTelephone(teasession._nLanguage)%>" size=20 maxlength=20></td><td>*紧急联系方式，请正确填写。</td>
</tr>
</table>
<div id="printbutton">
<%

out.println("<input type=submit value=提交订单 onclick='f_submit("+obj.getStatus()+");'>");
out.println("<input type=submit value=审核地址信息 onclick='f_submit("+Trade.TRADES_CONFIRMED+");'>");
if(obj.getPaystate()==0)//如果没有支付,则可以取消订单
{
  out.println("<input type=submit value=取消订单 onclick='f_submit("+Trade.TRADES_CANCEL+");'>");
}
out.println("<input type=reset value=重置>");
out.println("<input type=button value=返回 onclick='window.history.back();'>");

%>
<input type="button" value="打印" onClick="window.print();">
</div>
</FORM>
<div id="head6"><img height="6" src="about:blank"></div>

<div id="jspafter" style="display:none">
<script>if(top.location==self.location)jspafter.style.display='';</script>
<%=community.getJspAfter(teasession._nLanguage)%>
</div>

</body>
</html>



