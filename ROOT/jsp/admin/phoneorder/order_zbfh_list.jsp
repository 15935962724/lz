<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.*" %>
<%@page import="java.math.*" %>
<%@page import="java.text.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?Node="+teasession._nNode);
  return;
}



//int ps=Integer.parseInt(request.getParameter("ps"));//配送方式

String _strId=request.getParameter("id");

StringBuffer sql=new StringBuffer(" and lurumember ="+DbAdapter.cite(teasession._rv.toString()));
StringBuffer param=new StringBuffer();
//sql.append(" AND status=").append(Trade.TRADES_CONFIRMED).append(" AND paystate=2");//地址已确认&&财务已确认
//sql.append(" AND ps=").append(ps);
param.append("&community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);




param.append("&pos=");

int count=0;//Trade.count(teasession._strCommunity,sql.toString());

String order=request.getParameter("order");
if(order==null)
order="trade";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);

sql.append(" ORDER BY ").append(order).append(" ").append(desc);

Resource r=new Resource("/tea/ui/member/offer/Offers");

Community community=Community.find(teasession._strCommunity);

int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null&&_strPos.length()>0)
{
  pos=Integer.parseInt(_strPos);
}
%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

</head>
<script type="">
function f_edit(t)
{
  form1.action='/jsp/admin/phoneorder/EditSalePayment.jsp';
  form1.method='GET';
  form1.trade.value=t;
  form1.submit();
}
</script>
<body id="bodynone">
<h1>订单信息</h1>
<div id="head6"><img height="6" alt=""></div>

<form action="/servlet/EditOrderInput" method="post" name="form1"  onsubmit="return query1();">
<script>document.write('<input type=hidden name=nexturl value='+location+'>');</script>
<input type="hidden" name ="act" value="order_list">
<input type="hidden" name="trade" value=""/>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	  <tr><td colspan="10" id="gouwuchebg">&nbsp;</td></tr>
      <tr id=tableonetr>
      <td>&nbsp;</td>
        <td><%=r.getString(teasession._nLanguage, "订单编号")%></td>
        <td><%=r.getString(teasession._nLanguage, "订单时间")%></td>
        <td><%=r.getString(teasession._nLanguage, "福利卡号")%></td>
        <td><%=r.getString(teasession._nLanguage, "总价")%></td>
        <td><%=r.getString(teasession._nLanguage, "地址")%></td>
          <td>&nbsp;</td>

<%
Enumeration e2=Trade.find(teasession._strCommunity,sql.toString(),pos,20);
while(e2.hasMoreElements())
{
  String trade=(String)e2.nextElement();
  Trade obj=Trade.find(trade);
  RV rv=obj.getCustomer();
  Profile p=Profile.find(rv._strR);//obj.getTradeCode()
  Supplier obj_s=Supplier.find(obj.getSupplier());


  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><input type="checkbox" name="trades" value="<%=trade%>"/></td>
    <td nowrap><a href="javascript:f_edit('<%=trade%>');" ><%=trade%></a></td>
    <td nowrap><%=obj.getTimeToString()%></td>
    <td nowrap><%=obj.getCustomer().toString()%></td>
    <td nowrap><%=obj.getTotal()%></td>
    <td nowrap><%=obj.getCityToString(teasession._nLanguage) %></td>
    <td><input type=button value="详细" onClick="f_edit('<%=trade%>');"></td>
  </tr>
<%
}
%>
<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
  <td colspan="2"><input type="checkbox" onClick="selectAll(form2.trades,this.checked);">全选</td>
    <td colspan="6" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString(),pos,count,20)%></td></tr>
</table>
<input type="submit" value="开始发货" onClick="return submitCheckbox(form2.trades,'请选中要发货的订单.');"/>
</FORM>

</body>
</HTML>
