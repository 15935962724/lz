<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="java.text.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.*" %>
<%@ page import="tea.entity.site.*" %>
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
  response.sendRedirect("/servlet/StartLogin?Node="+teasession._nNode);
  return;
}

String source=request.getParameter("source");
//System.out.println("EditSaleConfirmed.jsp----"+source);

String nexturl=request.getParameter("nexturl");

String trade=request.getParameter("trade");

Trade obj=Trade.find(trade);

Resource r=new Resource("/tea/ui/member/offer/Offers");

Community community=Community.find(teasession._strCommunity);

String s2 = r.getString(teasession._nLanguage, Common.CURRENCY[obj.getCurrency()]);//货币种类

Supplier supplier=Supplier.find(obj.getSupplier());

DecimalFormat df=new DecimalFormat("#,##0.00");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
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
 <div id="ddprin">
<div id="tablebgnone">

<table border="0" cellspacing="0" cellpadding="0"  id="tablecenter">
  <tr>
    <td rowspan="2" width="70%"><img src="/res/9000gw/u/0707/07073809.jpg"></td>
    <td>服务电话：400 722 6677</td>
  </tr>
  <tr>
    <td>网　　址：www.gouwuxiang.com</td>
  </tr>
</table>
<h1><%=r.getString(teasession._nLanguage, "准备发货")+"　　　订单号:"+trade+"　　　用户:"+obj.getCustomer()%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name=form1 METHOD=POST action="/servlet/EditTrade">
<input type="hidden" name="nexturl" value="<%=nexturl%>" />
<input type="hidden" name="community" value="<%=teasession._strCommunity%>" />
<input type="hidden" name="status" value="0" />
<input type="hidden" name="act" value="saleunshipped" />
<input type="hidden" name="trade" value="<%=trade%>" />

<h2>列表-<%=supplier.getName(teasession._nLanguage)%></h2>
<table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
  <tr ID=tableonetr>
    <td width="1">&nbsp;</td>
    <td><%=r.getString(teasession._nLanguage, "Time")%></td>
    <td><%=r.getString(teasession._nLanguage, "TradeSubject")%></td>
     <td><%=r.getString(teasession._nLanguage, "plaque")%></td>
    <td><%=r.getString(teasession._nLanguage, "Price")%></td>
    <td><%=r.getString(teasession._nLanguage, "Quantity")%></td>
    <td><%=r.getString(teasession._nLanguage, "货号")%></td>
        <td><%=r.getString(teasession._nLanguage, "次分类")%></td>
    <td><%=r.getString(teasession._nLanguage, "规格")%></td>
    <td><%=r.getString(teasession._nLanguage, "颜色")%></td>
     <td><%=r.getString(teasession._nLanguage, "备注")%></td>
  </tr>
<%
BigDecimal total = new BigDecimal(0.0D);
Enumeration e=TradeItem.findByTrade(trade);
if(!e.hasMoreElements()){out.print("暂无记录");}
for(int count=1;e.hasMoreElements();count++)
{

  int tradeitem=((Integer)e.nextElement()).intValue();
  TradeItem obj_ti=TradeItem.find(tradeitem);
  Trade te=Trade.find(obj_ti.getTrade());
  int l = obj_ti.getNode();
  Node node = Node.find(l);

  BigDecimal price = obj_ti.getPrice();
  BigDecimal bigdecimal4=new BigDecimal(obj_ti.getQuantity());

  total=total.add(price.multiply(bigdecimal4));

  Commodity c=Commodity.find(l,obj.getSupplier());
    Goods gobj=Goods.find(l,teasession._nLanguage);
     Brand brobj = Brand.find(gobj.getBrand());
  %>
  <tr onMouseOver="bgColor='#BCD1E9'" onMouseOut="bgColor=''">
     <%
      if(source!=null&&source!=""){
   %>
    <td width="1"><input type="checkbox" name="check" value="<%=tradeitem%>" checked="checked"/></td>
    <%
    }else{ %>
    <td width="1"><%=count %></td>
    <%
    }
    %>


    <td nowrap><%=te.getTimeToString()%></td>


    <td nowrap><a href="/servlet/Node?Node=<%=l%>&Language=<%=teasession._nLanguage%>"><%=node.getSubject(teasession._nLanguage)%></a></td>
    <td><%= brobj.getName(teasession._nLanguage) %></td>
    <td><%=s2+df.format(price)%></td>
    <td><%=obj_ti.getQuantity()%></td>
    <td>&nbsp;<%if(c.getSerialNumber()!=null)out.print(c.getSerialNumber());%></td>
    <td>&nbsp;</td>
    <td>&nbsp;<%=obj_ti.getSpec()%></td>
    <td>&nbsp;<%=obj_ti.getColor()%></td>
    <td>&nbsp;<%=obj_ti.getShopremark()%></td>
  </tr>
<%
}
%>
<!-- 总共的价格 -->
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td width="1">&nbsp;</td>
  <td colspan="8">价格合计:<%=s2+df.format(total)%></td>
</tr>
</table>

<!--收货地址 -->
 <h2>收货地址</h2>
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" class="tablejh">
   <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
     <Td id="left"><%=r.getString(teasession._nLanguage, "State")%>:</Td>
     <td><%=obj.getCityToString(teasession._nLanguage)%></td><td></td>
   </tr>
   <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
     <td id="left"><%=r.getString(teasession._nLanguage, "收货地址")%></Td>
     <td><%=obj.getAddress(teasession._nLanguage).replaceAll("</","&lt;/")%></td>  <td>*我们将根据此地址发送您选的商品并计算发货费用；</td>
   </tr>
   <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
     <Td id="left"><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</Td>
     <td><%=obj.getEmail()%></td><td>*我们会通过邮件形式通知您发货情况；</td>
   </tr>
   <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
     <Td id="left"><%=r.getString(teasession._nLanguage, "LastName")%><%=r.getString(teasession._nLanguage, "FirstName")%>:</Td>
     <td><%=obj.getFirstName(teasession._nLanguage)%></td>
     <td>*接收时需要接受人签字；</td></tr>
   <%--  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
       <Td id="left"><%=r.getString(teasession._nLanguage, "Organization")%>:</Td>
       <td><%=obj.getOrganization(teasession._nLanguage)%></td><td>*指明接收单位，以免地址有误时错送；</td>
     </tr>--%>
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
       <Td id="left"><%=r.getString(teasession._nLanguage, "Zip")%>:</Td>
       <td><%=obj.getZip(teasession._nLanguage)%></td><td>*正确填写，以方便发货方更快的找到您；</td>
     </tr>
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
       <Td id="left"><%=r.getString(teasession._nLanguage, "Telephone")%>:</td>
       <td><%=obj.getTelephone(teasession._nLanguage)%></td><td>*紧急联系方式，请正确填写。</td>
     </tr>
 </table>

<h2>配送方式</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <!--<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
    <td nowrap ><input name="ps" type="radio" value="0" checked>平邮 </td>
    <td> 如果您不急于使用此商品可以考虑选择平邮，此种方式邮购费用最低但邮递时间很长； </td>
  </tr>-->
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td>快递</td>
    <td>运费:<%=obj.getFreight()%></td>
  </tr>
  <!--<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''> <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input name="ps" type="radio" value="2">EMS</td>
    <td> 邮政特快专递服务，是中国邮政的一个服务产品，主要是采取空运方式，加快递送速度，一般来说根据地区远近，1－4天到达。 </td>
  </tr>-->
</table>

<h2>发票</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
switch(obj.getFp())
{
  case 0:
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''><td nowrap>不要发票</td><td></td></tr>");
  break;
  case 1:
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''><td nowrap>要普通发票,</td><td>抬头为(公司名称):"+obj.getFptt()+"</td></tr>");
  break;
  case 2:
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''><td nowrap>要增值税发票,</td><td>抬头为(公司名称):"+obj.getFptt()+"</td></tr>");
}
%>
</table>

<h2>备注</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
    <td>会员留言:</td>
    <td><%=obj.getRemark(teasession._nLanguage)%></td>
  </tr>
  <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
    <td>供货商留言:</td>
    <td><textarea name="remark2" cols="50" rows="4"><%=obj.getRemark2(teasession._nLanguage)%></textarea></td>
  </tr>
  <%
  if(obj.getStatus()>=2)
  {
    out.println("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''><td>发货时间:</td><td>"+new tea.htmlx.TimeSelection("stime", obj.getStime())+"</td></tr>");//<input type=text size=15 name=stime value="+obj.getStimeToString()+" ></td>
    Date ftime=obj.getFtime();
    if(ftime==null)
    {
      ftime=new Date(System.currentTimeMillis()+1000*60*60*24*3L);
    }
    out.println("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''><td>预计到达时间:</td><td>"+new tea.htmlx.TimeSelection("ftime", ftime)+"</td></tr>");//<input type=text size=15 name=ftime value="+obj.getFtimeToString()+"
  }
  %>
</table>
<div id="printbutton">
<%

out.println("<input type=submit value=提交订单 onclick='form1.status.value="+obj.getStatus()+";'>");
out.println("<input type=submit value=准备发货 onclick='form1.status.value="+Trade.TRADES_UNSHIPPED+";'>");
out.println("<input type=submit value=取消订单 onclick='form1.status.value="+Trade.TRADES_CANCEL+";'>");
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
</div></div>
</body>
</HTML>
