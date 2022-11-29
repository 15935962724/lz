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
  int t2t11111111111 = 0;//如果t2==1 说明是能显示库存
  if(teasession.getParameter("t2t11111111111")!=null && teasession.getParameter("t2t11111111111").length()>0)
  {
    t2t11111111111 = Integer.parseInt(teasession.getParameter("t2t11111111111"));
  }
  int war = 0;
  if(teasession.getParameter("war")!=null && teasession.getParameter("war").length()>0)
  {
    war = Integer.parseInt(teasession.getParameter("war"));
  }

  String purid = teasession.getParameter("purid");
  String chers = GoodsDetails.getNodearr(teasession._strCommunity,purid,0);//teasession.getParameter("chers");
  String chersarr[] = chers.split("/");


%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
  <td align="center" nowrap>条形码或编号</td>
  <td align="center" nowrap>商品名称</td>
  <td align="center" nowrap>规格型号</td>
  <td align="center" nowrap>品牌</td>
  <td align="center" nowrap>单位</td>
  <td align="center" nowrap>单价</td>
  <td align="center" nowrap>折扣</td>
  <td align="center" nowrap>活动打折</td>
   <td align="center" nowrap>折后单价</td>
  <td align="center" nowrap>数量</td>
  <td align="center" nowrap>金额</td>
  <td align="center" nowrap>备注</td>
  <%if(t2t11111111111==1){%>
   <td align="center" nowrap>库存</td>
   <%} %>
  <td align="center" nowrap>&nbsp;</td>
</tr>
<%


  java.math.BigDecimal bs = new  java.math.BigDecimal(0);
  java.math.BigDecimal bs2 = new  java.math.BigDecimal(0);
   int bs3 = 0;//总数量
  boolean fa = false;
boolean fa2 = false;
  int count = GoodsDetails.count(teasession._strCommunity," AND paid="+DbAdapter.cite(purid));
  java.util.Enumeration e = GoodsDetails.find(teasession._strCommunity," AND paid="+DbAdapter.cite(purid),0,Integer.MAX_VALUE);
   if(!e.hasMoreElements())
   {
     out.print("<tr><td colspan=12 align=center onclick=f_xuanze();  style=cursor:pointer>暂无记录，请点击这里，来添加商品。</td></tr>");
     fa2=true;
   }
     for(int i = 1;e.hasMoreElements();i++)
     {
       int gdid = ((Integer)e.nextElement()).intValue();
       GoodsDetails gdobj = GoodsDetails.find(gdid);

       int nodeid =gdobj.getNode(); //Integer.parseInt(chersarr[i]);

       Node nobj = Node.find(nodeid);
       Goods g=Goods.find(nodeid);
       Commodity cobj = Commodity.find_goods(nodeid);
       BuyPrice bpobj = BuyPrice.find(cobj.getCommodity(),1);
       if(bpobj.getSupply()!=null){
         bs2=bs2.add(bpobj.getSupply());
       }
         bs=bs.add(new java.math.BigDecimal(gdobj.getTotal()));
         bs3=bs3+gdobj.getQuantity();
       if(Paidinfull.getDis(nodeid)>0)
       {
         fa = true;
       }

//计算商品打折

//System.out.println(Paidinfull.getDis(nodeid));

  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
    <td align="center" onclick="f_xuanze();" title="点击表格可以添加商品"   style=cursor:pointer><%=nobj.getNumber() %></td>
    <td onclick="f_xuanze();" title="点击表格可以添加商品"   style=cursor:pointer><%=nobj.getSubject(teasession._nLanguage)%></td>
    <td align="center" onclick="f_xuanze();" title="点击表格可以添加商品"   style=cursor:pointer><%=g.getSpec(teasession._nLanguage) %></td>
    <td align="center" onclick="f_xuanze();" title="点击表格可以添加商品"   style=cursor:pointer><%
    Brand b=null;
    if(g.getBrand()>0&&(b=Brand.find(g.getBrand())).isExists())
    {
      if(b.getNode()>0)
      out.print(b.getName(teasession._nLanguage));
    }
    %></td>
    <td  onclick="f_xuanze();" title="点击表格可以添加商品"   style=cursor:pointer><%=g.getMeasure(teasession._nLanguage)%></td>
   <!--选择的价格--> <td onclick="f_xuanze();" title="点击表格可以添加商品"   style=cursor:pointer>
     <input type="text" name="supply<%=i%>" value="<%out.print(gdobj.getSupply());%>" size="4" style="background:#cccccc" readonly="readonly" >&nbsp;元</td>
   <!--折扣--><td>
     <input type="text" name="discount<%=i%>"  value="<%=gdobj.getDiscount()%>" size="4" onkeyup="f_quantity('<%=i%>','<%=count%>','<%=Paidinfull.getFloor(nodeid)%>','<%=Paidinfull.getDis(nodeid)%>','<%=fa%>','<%=gdid%>');">&nbsp;折</td>
  <!--打折折扣-->
      <td onclick="f_xuanze();" title="点击表格可以添加商品"   style=cursor:pointer>
       <input type="text" name="discount2<%=i%>"  value="<%=gdobj.getDiscount2()%>" size="2"  style="background:#cccccc" readonly="readonly">&nbsp;折
     </td>
     <!--折后单价--> <td onclick="f_xuanze();" title="点击表格可以添加商品"   style=cursor:pointer>
     <input type="text" name="dsupply<%=i%>" value="<%=gdobj.getDsupply()%>" size="4" style="background:#cccccc" readonly="readonly" >&nbsp;元</td>
     <!--数量--><td>
       <input type="text" name="quantity<%=i%>" value="<%=gdobj.getQuantity()%>" size="4" onkeyup="f_quantity('<%=i%>','<%=count%>','<%=Paidinfull.getFloor(nodeid)%>','<%=Paidinfull.getDis(nodeid)%>','<%=fa%>','<%=gdid%>');"></td>

     <!--折扣乘以数量的价格总计-->
     <td onclick="f_xuanze();" title="点击表格可以添加商品"   style=cursor:pointer>
       <input type="text" name="total<%=i%>" value="<%=gdobj.getTotal()%>" size="4"  style="background:#cccccc" readonly="readonly">&nbsp;元
     </td>
       <!--商品备注-->
       <td >
         <input type="text" name="remarksarr<%=i%>" value="<%=gdobj.getRemarksarr()%> " onkeyup="f_rem('<%=gdid%>','<%=i%>');">
       </td>
       <%if(t2t11111111111==1){%>
       <td  onclick="f_xuanze();" title="点击表格可以添加商品"   style=cursor:pointer>
        <%=Inventory.getQuan(teasession._strCommunity,nodeid,war)%>
       </td>

       <%} %>
       <td ><a href="#" onclick="f_delete('<%=gdid%>');">删除</a> </td>
  </tr>
  <%} %>
  <%if(!fa2) {%>
  <tr>

    <td colspan="5" align="right">折扣前金额:</td>
    <td><input type="text" name="total" value="<%out.print(bs2);%>" size="4"  style="background:#cccccc" readonly="readonly">&nbsp;元</td>

      <td colspan="3"  align="right">折扣后数量和金额:</td>
      <td ><input type="text" name="quantity" value="<%out.print(bs3);%>" size="4"  style="background:#cccccc" readonly="readonly"></td>
        <td colspan="4"><input type="text" name="total_2"  size="4" readonly="readonly"  style="background:#cccccc" value="<%out.print(bs);%>" onpropertychange="f_total_2();" >&nbsp;元</td>
  </tr>
  <%} %>
</table>
<%} %>
