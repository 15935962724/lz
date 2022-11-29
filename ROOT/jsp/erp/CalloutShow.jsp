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


    String purid = teasession.getParameter("purid");
    Callout pobj = Callout.find(purid);


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>调拨单</title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<body bgcolor="#ffffff" >
<script type="">
function f_p(igd)
{
  window.showModalDialog('/jsp/erp/CalloutPrint.jsp?purid='+igd,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:927px;dialogHeight:506px;');
}
</script>

<div id="lzi_rkd">
<h1>调拨单信息</h1>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td width="9%">调出仓库：</td>
      <td width="24%">
         <%
             Warehouse sobj1=Warehouse.find(pobj.getSupplname());
             out.print(sobj1.getWarname());
         %>
     </td>
       <td nowrap>调入仓库：</td>
      <td colspan="2">
       <%
            Warehouse warobj = Warehouse.find(pobj.getWaridname());
             out.print(warobj.getWarname());
       %>
      </td>
      </tr>
    <tr>
      <td nowrap>调拨日期：</td>
      <td><%if(pobj.getTime_s()!=null){out.print(pobj.getTime_sToString());}else{out.print(sdf1.format(timestring));}%></td>
      <td width="6%" nowrap>调拨单号：</td>
      <td width="29%"><%if(purid!=null){out.print(purid);}%></td>
    </tr>
  </table>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
  <td align="center" nowrap>条形码或编号</td>
    <td align="center" nowrap>商品名称</td>
    <td align="center" nowrap>规格型号</td>
    <td align="center" nowrap>品牌</td>
    <td align="center" nowrap>单位</td>
    <td align="center" nowrap>数量</td>
    <td align="center" nowrap>金额</td>
  </tr>
  <%


      java.util.Enumeration e  = GoodsDetails.find(teasession._strCommunity," AND paid = "+DbAdapter.cite(purid),0,Integer.MAX_VALUE);
     for(int i = 1;e.hasMoreElements();i++)
     {
       int gdid = ((Integer)e.nextElement()).intValue();
       GoodsDetails gdobj = GoodsDetails.find(gdid);
       int nodeid = gdobj.getNode();
       Node nobj = Node.find(nodeid);
       Goods g=Goods.find(nodeid);
       Commodity cobj = Commodity.find_goods(nodeid);
       BuyPrice bpobj = BuyPrice.find(cobj.getCommodity(),1);
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td><%=nobj.getNumber() %></td>
    <td><%=nobj.getSubject(teasession._nLanguage)%></td>
    <td><%=g.getSpec(teasession._nLanguage) %></td>
    <td><%
        Brand b=null;
        if(g.getBrand()>0&&(b=Brand.find(g.getBrand())).isExists())
        {
          if(b.getNode()>0)
             out.print(b.getName(teasession._nLanguage));
        }
        %></td>
    <td><%=g.getMeasure(teasession._nLanguage)%></td>
    <td><%=gdobj.getQuantity()%></td>
    <td><%=gdobj.getTotal() %>&nbsp;元</td>
  </tr>
  <%} %>
 <tr>
    <td colspan="4">&nbsp;</td>
     <td align="right"><b>合计数量和金额：</b></td>
     <td><%=pobj.getQuantity() %></td>
    <td><%=pobj.getTotal()%>&nbsp;元</td>
  </tr>
</table>

</div>
</form>
<input type="button" value="关闭"  onClick="javascript:window.close();">&nbsp;
<input type="button" value="打印"  onclick="f_p('<%=purid%>');"/>


</body>
</html>
