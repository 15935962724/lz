<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
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

String nexturl=request.getParameter("nexturl");

String trade=request.getParameter("trade");

Trade obj=Trade.find(trade);

Resource r=new Resource("/tea/ui/member/offer/Offers");

Community community=Community.find(teasession._strCommunity);

String s2 = r.getString(teasession._nLanguage, Common.CURRENCY[obj.getCurrency()]);//货币种类

Supplier supplier=Supplier.find(obj.getSupplier());

%>
<html>
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

 <div id="ddprin">
<div id="tablebgnone">


<h1><%=r.getString(teasession._nLanguage, "查看订单信息")+" 订单号:"+trade+" 用户名:"+obj.getCustomer()%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>供货商-<%=supplier.getName(teasession._nLanguage)%></h2>


<table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
  <tr ID=tableonetr>
    <td>&nbsp;</td>
    <td><%=r.getString(teasession._nLanguage, "Time")%></td>
    <td><%=r.getString(teasession._nLanguage, "TradeSubject")%></td>
    <td><%=r.getString(teasession._nLanguage, "Price")%></td>
    <td><%=r.getString(teasession._nLanguage, "Quantity")%></td>
    <td><%=r.getString(teasession._nLanguage, "货号")%></td>
    <td><%=r.getString(teasession._nLanguage, "品牌")%></td>
    <td><%=r.getString(teasession._nLanguage, "次分类")%></td>
    <td><%=r.getString(teasession._nLanguage, "规格")%></td>
    <td><%=r.getString(teasession._nLanguage, "颜色")%></td>
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
  Goods g = Goods.find(l,teasession._nLanguage);

  BigDecimal price = obj_ti.getPrice();
  BigDecimal bigdecimal4=new BigDecimal(obj_ti.getQuantity());

  total=total.add(price.multiply(bigdecimal4));

  Commodity c=Commodity.find(l,obj.getSupplier());
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=count%></td>
    <td nowrap><%=obj_ti.getTimeToString()%></td>
    <td nowrap><a href="/servlet/Node?Node=<%=l%>&Language=<%=teasession._nLanguage%>"><%=node.getSubject(teasession._nLanguage)%></a></td>
    <td><%=s2+price%></td>
    <td><%=obj_ti.getQuantity()%></td>
    <td><%=(c.getSerialNumber()!=null)?c.getSerialNumber():"&nbsp;"%></td>
    <td><%
    if(g.getBrand()>0)
    {
    	Brand b=Brand.find(g.getBrand());
    	if(b.isExists())
    	{
    		out.print(b.getName(teasession._nLanguage));
    	}
    }
    %></td>
    <td>&nbsp;</td>
    <td>&nbsp;<%=obj_ti.getSpec()%></td>
    <td>&nbsp;<%=obj_ti.getColor()%></td>
  </tr>
<%
}
%>
  <!-- 总共的价格 -->
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td></td>
    <td colspan="9">价格合计：<%=s2+total%></td>
  </tr>
</table>
<%--
<!-- 积分管理在这个表格里 -->
<h2>双重积分</h2>
<table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
  <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
    <td height="32">
      您本次购买将获得本站积分<%=total_point%>分，如果您拥<%=supplier.getName(teasession._nLanguage)%>的积分卡则可同时获得商场积分
      <a href="/jsp/admin/9000_3.jsp" target="_blank">（双积分）</a>；
    </td>
  </tr>

  <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
    <td>
      <table border="0" cellspacing="0" cellpadding="0">
        <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
          <td><%=supplier.getName(teasession._nLanguage)%></td>
          <td><input type="text" name="point"></td>
            <td>请在此处填写您<%=supplier.getName(teasession._nLanguage)%>的积分卡号，如果没有可以为空；</td>
        </tr>
      </table>
</td>
  </tr>
</table>
--%>
<!--收货地址 -->
<h2>填写收货地址</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" class="tablejh">
   <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
     <Td id="left"><%=r.getString(teasession._nLanguage, "State")%>:</Td>
     <td><%=obj.getCityToString(teasession._nLanguage)%></td><td></td>
   </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td id="left"><%=r.getString(teasession._nLanguage, "收货地址")%></Td>
    <td><%=obj.getAddress(teasession._nLanguage).replaceAll("</","&lt;/")%></td>
    <td>*我们将根据此地址发送您选的商品并计算发货费用；</td>
  </tr>
  <%-- <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <Td id="left"><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</Td>
    <td><%=obj.getEmail()%></td>
    <td>*我们会通过邮件形式通知您发货情况；</td>
  </tr>--%>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <Td id="left"><%=r.getString(teasession._nLanguage, "LastName")%><%=r.getString(teasession._nLanguage, "FirstName")%>:</Td>
    <td><%=obj.getFirstName(teasession._nLanguage)%></td>
    <td>*接收时需要接受人签字；</td>
  </tr>
 <%-- <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <Td id="left"><%=r.getString(teasession._nLanguage, "Organization")%>:</Td>
    <td><%=obj.getOrganization(teasession._nLanguage)%></td>
    <td>*指明接收单位，以免地址有误时错送；</td>
  </tr>--%>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <Td id="left"><%=r.getString(teasession._nLanguage, "Zip")%>:</Td>
    <td><%=obj.getZip(teasession._nLanguage)%></td>
    <td>*正确填写，以方便发货方更快的找到您；</td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <Td id="left"><%=r.getString(teasession._nLanguage, "Telephone")%>:</td>
    <td><%=obj.getTelephone(teasession._nLanguage)%></td>
    <td>*紧急联系方式，请正确填写。</td>
  </tr>
</table>
<h2>配送运费</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">

    <td align="left">运费:<%=obj.getFreight()%></td>
  </tr>

</table>

<div align="center">
<input type="button" name="printbutton" value="打印" onClick="window.print();">
 <input type="button" class="edit_button" value="取消" onClick="history.back();" >
</div>
<div id="head6"><img height="6" src="about:blank"></div>
</div></div>
</body>
</HTML>
