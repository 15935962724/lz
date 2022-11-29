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
</head>
<body id="bodynone">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

<div id="tablebgnone">
<h1><%=r.getString(teasession._nLanguage, "修改订单信息")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name=form1 METHOD=POST action="/servlet/EditTrade">
<input type="hidden" name="nexturl" value="<%=nexturl%>" />
<input type="hidden" name="community" value="<%=teasession._strCommunity%>" />
<input type="hidden" name="status" value="0" />
<input type="hidden" name="act" value="edittrade" />
<input type="hidden" name="trade" value="<%=trade%>" />

<h2>列表-<%=supplier.getName(teasession._nLanguage)%></h2>
<table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
  <tr ID=tableonetr>
    <TD><%=r.getString(teasession._nLanguage, "Time")%></TD>
    <TD><%=r.getString(teasession._nLanguage, "TradeSubject")%></TD>
    <TD><%=r.getString(teasession._nLanguage, "Price")%></TD>
    <TD><%=r.getString(teasession._nLanguage, "Quantity")%></TD>
  </tr>
<%
java.math.BigDecimal total = new java.math.BigDecimal(0.0D);
Enumeration e=TradeItem.findByTrade(trade);
int count=0;
while(e.hasMoreElements())
{
  int tradeitem=((Integer)e.nextElement()).intValue();
  TradeItem obj_ti=TradeItem.find(tradeitem);
  int l = obj_ti.getNode();
  Node node = Node.find(l);

  BigDecimal price = obj_ti.getPrice();
  BigDecimal bigdecimal4=new BigDecimal(obj_ti.getQuantity());

  total=total.add(price.multiply(bigdecimal4));

  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td nowrap><%=obj_ti.getTimeToString()%></td>
    <td nowrap><a href="/servlet/Node?node=<%=l%>&Language=<%=teasession._nLanguage%>"><%=node.getSubject(teasession._nLanguage)%></a></td>
    <td><%=s2+price%></td>
    <td><%=obj_ti.getQuantity()%></td>
  </tr>
<%
count++;
}
%>
<!-- 总共的价格 -->
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td colspan="5">价格合计:<%=s2+total%></td>
</tr>
<!-- 总共的个数 -->
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td colspan="5">购买的商品数:<%=count%></td>
</tr>
</table>

<%--
<!-- 积分管理在这个表格里 -->
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
<tr>
  <Td id="left"><%=r.getString(teasession._nLanguage, "State")%>:</Td>
  <td>
    <select name="state">
      <option value="">--------------</option>
      <%
      for(int bstate_i=0;bstate_i<Common.PROVINCE.length;bstate_i++)
      {
        out.print("<option value="+Common.PROVINCE[bstate_i]);
        if(Common.PROVINCE[bstate_i].equals(obj.getState(teasession._nLanguage)))
        {
          out.print(" SELECTED ");
        }
        out.print(" >"+r.getString(teasession._nLanguage,"Province."+Common.PROVINCE[bstate_i]));
      }
      %>
      </select>
      <%=r.getString(teasession._nLanguage, "City")%>:
      <input type="TEXT" class="edit_input"  name=city value="<%=obj.getCity(teasession._nLanguage)%>" size=20 maxlength=20>
  </td>
</tr>
<tr>
  <td id="left"><%=r.getString(teasession._nLanguage, "收货地址")%></Td>
  <td><textarea name=address rows=2 cols=40><%=obj.getAddress(teasession._nLanguage).replaceAll("</","&lt;/")%></textarea></td>  <td>*我们将根据此地址发送您选的商品并计算发货费用；</td>
</tr>
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</Td>
    <td><input type="TEXT" class="edit_input"  name=email value="<%=obj.getEmail()%>" size=40 maxlength=40></td><td>*我们会通过邮件形式通知您发货情况；</td>
  </tr>
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "LastName")%><%=r.getString(teasession._nLanguage, "FirstName")%>:</Td>
    <td><input type="TEXT" class="edit_input"  name=firstname value="<%=obj.getFirstName(teasession._nLanguage)%>" size=20 maxlength=20>          </td>
      <td>*接收时需要接受人签字；</td>        </tr>
      <tr>
        <Td id="left"><%=r.getString(teasession._nLanguage, "Organization")%>:</Td>
        <td><input type="TEXT" class="edit_input"  name=organization value="<%=obj.getOrganization(teasession._nLanguage)%>" size=40 maxlength=40></td>  <td>*指明接收单位，以免地址有误时错送；</td>
      </tr>
      <tr>
  <Td id="left"><%=r.getString(teasession._nLanguage, "Zip")%>:</Td>
  <td><input type="TEXT" class="edit_input"  name=zip value="<%=obj.getZip(teasession._nLanguage)%>" size=20 maxlength=20></td><td>*正确填写，以方便发货方更快的找到您；</td>
</tr>
<tr>
  <Td id="left"><%=r.getString(teasession._nLanguage, "Telephone")%>:</td>
  <td><input type="TEXT" class="edit_input"  name=telephone value="<%=obj.getTelephone(teasession._nLanguage)%>" size=20 maxlength=20></td><td>*紧急联系方式，请正确填写。</td>
</tr>
</table>

<h2>配送方式</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td nowrap ><input name="ps" type="radio" value="0" checked>平邮 </td>
    <td> 如果您不急于使用此商品可以考虑选择平邮，此种方式邮购费用最低但邮递时间很长； </td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input name="ps" type="radio" value="1">快递</td>
    <td> 此方式邮递时间很短，但需要携带个人相关证件到快地公司去取，费用也相应贵些； </td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input name="ps" type="radio" value="2">EMS</td>
    <td> 邮政特快专递服务，是中国邮政的一个服务产品，主要是采取空运方式，加快递送速度，一般来说根据地区远近，1－4天到达。 </td>
  </tr>
</table>

<h2>支付方式</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input name="defray" type="radio" value="0">储值卡</td>
    <td>您储值卡中的余额为:0.00，本次消费需要<%=s2+total%></td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td nowrap ><input name="defray" type="radio" value="1" checked>网上支付</td>
    <td>通过您的网上银行进行支付，安全便捷；</td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input name="defray" type="radio" value="2">
      邮局汇款 </td>
    <td>:通过邮局将钱汇到指定帐号，安全可靠，只是速度慢！</td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input name="defray" type="radio" value="3">
      银行电汇 </td>
    <td>:xxxxxxxxxxxxxxxxx</td>
  </tr>
<%
//如果支付状态是:未支付或已支付未审核
if(obj.getPaystate()<2)
{
  out.println("<tr><td>支付证明</td><td><input type=text name=proof value="+obj.getProof()+" ></td></tr>");
}
%>
</table>

<h2>发票</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><input name="fp" type="radio" value="0" checked="checked" />
    </td>
    <td> 不要发票 </td>
  </tr>
  <tr>
    <td><input name="fp" type="radio" value="1">
    </td>
    <td> 要发票 </td>
  </tr>
</table>

<h2>备注</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>会员留言:</td>
    <td><%=obj.getRemark(teasession._nLanguage)%></td>
  </tr>
  <tr>
    <td>供货商留言:</td>
    <td><textarea name="remark2" cols="50" rows="4"><%=obj.getRemark2(teasession._nLanguage)%></textarea></td>
  </tr>
  <%
  if(obj.getStatus()>=2)
  {
    out.println("<tr><td>发货时间:</td><td>"+new tea.htmlx.TimeSelection("stime", obj.getStime())+"</td></tr>");//<input type=text size=15 name=stime value="+obj.getStimeToString()+" ></td>
    Date ftime=obj.getFtime();
    if(ftime==null)
    {
      ftime=new Date(System.currentTimeMillis()+1000*60*60*24*3L);
    }
    out.println("<tr><td>预计到达时间:</td><td>"+new tea.htmlx.TimeSelection("ftime", ftime)+"</td></tr>");//<input type=text size=15 name=ftime value="+obj.getFtimeToString()+"
  }
  %>
</table>
<%

out.println("<input type=submit value=提交订单 onclick='form1.status.value="+obj.getStatus()+";'>");
switch(obj.getStatus())
{
  case 0:
  out.println("<input type=submit value=审核地址信息 onclick='form1.status.value="+Trade.TRADES_CONFIRMED+";'>");
  out.println("<input type=submit value=取消订单 onclick='form1.status.value="+Trade.TRADES_CANCEL+";'>");
  out.println("<input type=reset value=重置>");
  out.println("<input type=button value=返回 onclick='window.history.back();'>");
  break;
  case 1:
  out.println("<input type=submit value=审核地址信息 onclick='form1.status.value="+Trade.TRADES_CONFIRMED+";'>");
  //out.println("<input type=submit value=审核财务信息 onclick='form1.status.value=3;'>");
  out.println("<input type=reset value=重置>");
  out.println("<input type=button value=返回 onclick='window.history.back();'>");
  break;
  case 2://已确认
  out.println("<input type=submit value=准备发货 onclick='form1.status.value="+Trade.TRADES_UNSHIPPED+";'>");
  out.println("<input type=submit value=取消订单 onclick='form1.status.value="+Trade.TRADES_CANCEL+";'>");
  out.println("<input type=reset value=重置>");
  out.println("<input type=button value=返回 onclick='window.history.back();'>");
  break;
  case 3://已发货
  out.println("<input type=submit value=完成订单 onclick='form1.status.value="+Trade.TRADES_FINISHED+";'>");
  out.println("<input type=submit value=拒收订单 onclick='form1.status.value="+Trade.TRADES_REJECTED+";'>");
  out.println("<input type=reset value=重置>");
  out.println("<input type=button value=返回 onclick='window.history.back();'>");
  break;
}

%>
</FORM>
<div id="head6"><img height="6" src="about:blank"></div>

<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

</body>
</html>
