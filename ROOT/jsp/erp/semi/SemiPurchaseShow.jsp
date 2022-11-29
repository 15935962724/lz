<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.eon.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.text.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.erp.semi.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
SimpleDateFormat sdf1 = new  SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat sdf = new  SimpleDateFormat("yyyyMMdd");
Date timestring = new Date();
String trade = sdf.format(timestring) + SeqTable.getSeqNo("trade");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>采购单</title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<body bgcolor="#ffffff" >
<script>
function f_p(igd)
{
  rs = window.showModalDialog('/jsp/erp/PurchasePrint.jsp?purid='+igd,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:927px;dialogHeight:506px;');
}
</script>

<%
  if("ruku".equals(teasession.getParameter("act"))){
    String purid = teasession.getParameter("purid");
    Purchase pobj = Purchase.find(purid);
%>
<div id="lzi_rkd">
<h1>采购单信息</h1>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td width="9%">供货商：</td>
      <td width="24%">
      <%
      Supplier sobj=Supplier.find(pobj.getSupplname());
      out.print(sobj.getName(teasession._nLanguage));
      %>
      </td>
       <td nowrap>仓库名称：</td>
      <td colspan="2">
      <%
      Warehouse warobj = Warehouse.find(pobj.getWaridname());
      out.print(warobj.getWarname());
      %>
      </td>
      </tr>
    <tr>
      <td nowrap>采购日期：</td>
      <td><%if(pobj.getTime_s()!=null){out.print(pobj.getTime_sToString());}else{out.print(sdf1.format(timestring));}%></td>
      <td width="6%" nowrap>采购单号：</td>
      <td width="29%"><%if(purid!=null){out.print(purid);}%></td>
    </tr>
  </table>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td align="center" nowrap>商品名称</td>
    <td align="center" nowrap>规格型号</td>
    <td align="center" nowrap>单位</td>
    <td align="center" nowrap>进货价</td>
    <td align="center" nowrap>数量</td>
    <td align="center" nowrap>金额</td>
  </tr>
  <%
  //String chers = pobj.getRsgoods();
 // String chersarr[] = chers.split("/");
  java.math.BigDecimal bs = new  java.math.BigDecimal(0);
  java.util.Enumeration e  = SemiGoodsDetails.find(teasession._strCommunity," AND paid = "+DbAdapter.cite(purid),0,Integer.MAX_VALUE);
     for(int i = 1;e.hasMoreElements();i++)
     {

       int gdid = ((Integer)e.nextElement()).intValue();
       SemiGoodsDetails gdobj = SemiGoodsDetails.find(gdid);
       SemiSupplier ssobj = SemiSupplier.find(gdobj.getSgid());
       SemiGoods sgobj = SemiGoods.find(ssobj.getSgid());

  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td><%=sgobj.getSubject() %></td>
  <td><%=sgobj.getSpec() %></td>
  <td><%=sgobj.getMeasure()%></td>
  <td><%=gdobj.getSupply()%></td>
  <td><%=gdobj.getQuantity22()-gdobj.getQuantity2()%></td>
  <td><%=gdobj.getTotal()%>&nbsp;元</td>
  </tr>
  <%} %>
  <tr>
    <td colspan="3">&nbsp;</td>
     <td align="right"><b>合计数量和金额:</b></td>
     <td><%=pobj.getQuantity()%></td>
    <td><%=pobj.getTotal().trim()%>&nbsp;元</td>
  </tr>
</table>
<br>
<input type="button" value="关闭"  onClick="javascript:window.close();">&nbsp;

 <input type="button" value="打印"  onclick="f_p('<%=purid%>');"/>
</div>
</form>

<%}else if("cangku".equals(teasession.getParameter("act"))){
  int warid = 0;
  if(teasession.getParameter("warid")!=null && teasession.getParameter("warid").length()>0)
  {
    warid = Integer.parseInt(teasession.getParameter("warid"));
  }
  Warehouse wobj = Warehouse.find(warid);
%>
<h1>仓库详细信息</h1>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td nowrap>仓库名称</td>
    <td><%=wobj.getWarname()%></td>
  </tr>
  <tr>
    <td nowrap>联系人</td>
    <td><%=wobj.getContact()%></td>
  </tr>
  <tr>
    <td nowrap>电话</td>
    <td><%=wobj.getTelephone()%></td>
  </tr>
  <tr>
    <td nowrap>仓库地址</td>
    <td><%=wobj.getAddress()%></td>
  </tr>
</table>
<br>
<input type="button" value="关闭"  onClick="javascript:window.close();">
<%} %>
</body>
</html>
