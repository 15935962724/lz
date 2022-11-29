<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.TeaSession" %><%@page import="tea.entity.admin.erp.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession=new TeaSession(request);

if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String act = teasession.getParameter("act");

if("EditPurchase".equals(act))
{
  int type = Integer.parseInt(teasession.getParameter("type"));
  int flowtype = 0;
  if(teasession.getParameter("flowtype")!=null && teasession.getParameter("flowtype").length()>0)
  {
    flowtype=Integer.parseInt(teasession.getParameter("flowtype"));
  }
  String purid = teasession.getParameter("purid");

  %>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td align="center" nowrap>商品编号</td>
      <td align="center" nowrap>商品名称</td>
      <td align="center" nowrap>规格型号</td>
      <td align="center" nowrap>品牌</td>
      <td align="center" nowrap>单位</td>
      <td align="center" nowrap>单价</td>
      <td align="center" nowrap>采购数量</td>
      <td align="center" nowrap>到货数量</td>
      <td align="center" nowrap>剩余数量</td>
      <td align="center" nowrap>金额</td>

    </tr>
    <%
    java.math.BigDecimal bs = new  java.math.BigDecimal(0);
    java.math.BigDecimal bs2 = new  java.math.BigDecimal(0);
    int bs3 = 0;
    boolean fa = false;
    boolean fa2 = false;
    StringBuffer sql = new StringBuffer(" AND paid="+DbAdapter.cite(purid));
    if(flowtype==3)
    {
      sql.append(" and quantity2!=0");
    }
    int count = GoodsDetails.count(teasession._strCommunity,sql.toString());
    java.util.Enumeration e = GoodsDetails.find(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
    if(!e.hasMoreElements())
    {
      out.print("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\"  onclick=f_xuanze_pur(); title=点击表格可以添加商品  style=cursor:pointer><td colspan=12 align=center>暂无记录，请点击表格，来添加商品。</td></tr>");
      fa2=true;
    }
    for(int i = 1;e.hasMoreElements();i++)
    {
      int gdid = ((Integer)e.nextElement()).intValue();
      GoodsDetails gdobj = GoodsDetails.find(gdid);
      int nodeid =gdobj.getNode();
      Node nobj = Node.find(nodeid);
      Goods g=Goods.find(nodeid);
      Commodity cobj = Commodity.find_goods(nodeid);
      BuyPrice bpobj = BuyPrice.find(cobj.getCommodity(),1);
      if(bpobj.getList()!=null){
        bs2=bs2.add(bpobj.getList());
      }


      bs=bs.add(bpobj.getList().multiply(new java.math.BigDecimal(gdobj.getQuantity2())));
      bs3= bs3+gdobj.getQuantity2();
      // System.out.println(ReturnedShop.getDis(nodeid));
      if(ReturnedShop.getDis(nodeid)>0)
      {
        fa = true;
      }


      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
        <td><%=nobj.getNumber() %></td>
        <td><%=nobj.getSubject(teasession._nLanguage)%></td>
        <td ><%=g.getSpec(teasession._nLanguage) %></td>
        <td ><%
        Brand b=null;
        if(g.getBrand()>0&&(b=Brand.find(g.getBrand())).isExists())
        {
          if(b.getNode()>0)
          out.print(b.getName(teasession._nLanguage));
        }
        %></td>
        <td ><%=g.getMeasure(teasession._nLanguage)%></td>
        <!--选择的价格-->
        <td ><input type="text" name="supply<%=i%>" value="<%out.print(gdobj.getSupply());%>" size="4" style="background:#cccccc" readonly="readonly">&nbsp;元</td>
          <!--采购数量-->
          <td><input type="text" name="quantity22<%=i%>" value="<%=gdobj.getQuantity22()%>" size="4" style="background:#cccccc" readonly="readonly"></td>
          <!--到货数量-->
            <td><input type="text" name="quantity<%=i%>" value="<%=gdobj.getQuantity()%>" size="4" style="background:#cccccc" readonly="readonly"></td>
          <!--剩余数量-->
          <td>  <input type="text" name="quantity2<%=i%>" value="<%=gdobj.getQuantity2()%>" size="4" onkeyup="f_quantity2('<%=gdid%>','<%=i%>','<%=count%>','<%=flowtype%>');"></td>

            <!--价格乘以数量的价格总计-->
            <td>  <input type="text" name="total<%=i%>" value="<%= bpobj.getList().multiply(new java.math.BigDecimal(gdobj.getQuantity2()))%>" size="4"  style="background:#cccccc" readonly="readonly">&nbsp;元</td>


      </tr>
      <%} %>
      <%if(!fa2) {%>
      <tr>
        <td colspan="7">&nbsp;</td>

        <td align="right" ><b>合计数量和金额:</b></td>
        <td ><input type="text" name="quantity" value="<%out.print(bs3);%>" size="4"  style="background:#cccccc" readonly="readonly"></td>
          <td><input type="text" name="total"  size="4" readonly="readonly"  style="background:#cccccc" value="<%out.print(bs);%>">&nbsp;元</td>
      </tr>
      <%} %>
  </table>
  <%} %>
