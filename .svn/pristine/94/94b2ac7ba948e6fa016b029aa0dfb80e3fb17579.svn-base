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
int refundtype = 0;
if(teasession.getParameter("refundtype")!=null && teasession.getParameter("refundtype").length()>0)
{
  refundtype=Integer.parseInt(teasession.getParameter("refundtype"));
}


if("EditPurchase".equals(act))
{

  String purid = teasession.getParameter("purid");
  String chers = GoodsDetails.getNodearr(teasession._strCommunity,purid,1);//teasession.getParameter("chers");


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
    <td align="center" nowrap>活动折扣</td>
    <td align="center" nowrap>折后单价</td>
    <td align="center" nowrap>数量</td>
    <td align="center" nowrap>金额</td>
    <td align="center" nowrap>备注</td>
    <%if( refundtype!=0){%>
    <td align="center" nowrap>存放仓库</td>
    <%} %>
    <td align="center" nowrap>&nbsp;</td>
  </tr>
  <%
  java.math.BigDecimal bs = new  java.math.BigDecimal(0);
  java.math.BigDecimal bs2 = new  java.math.BigDecimal(0);
  int bs3 = 0;
  boolean fa = false;
  boolean fa2 = false;
int count = GoodsDetails.count(teasession._strCommunity," AND paid="+DbAdapter.cite(purid));
  java.util.Enumeration e = GoodsDetails.find(teasession._strCommunity," AND paid="+DbAdapter.cite(purid),0,Integer.MAX_VALUE);
   if(!e.hasMoreElements())
   {
     out.print("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\"  onclick=f_xuanze_rs('0'); title=点击表格可以添加商品  style=cursor:pointer><td colspan=12 align=center>暂无记录，请点击表格，来添加商品。</td></tr>");
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
         System.out.println(bpobj.getSupply());
       }
         bs=bs.add(new java.math.BigDecimal(gdobj.getTotal()));
         bs3= bs3+gdobj.getQuantity();
       if(ReturnedShop.getDis(nodeid)>0)
       {
         fa = true;
       }
//计算商品打折

//System.out.println(Paidinfull.getDis(nodeid));

  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
    <td align="center" onclick="f_xuanze_rs('<%= gdobj.getPurchaseid()%>');" title="点击表格可以添加商品"  style=cursor:pointer><%=nobj.getNumber() %></td>
    <td onclick="f_xuanze_rs('<%= gdobj.getPurchaseid()%>');" title="点击表格可以添加商品"  style=cursor:pointer><%=nobj.getSubject(teasession._nLanguage)%></td>
    <td align="center" onclick="f_xuanze_rs('<%= gdobj.getPurchaseid()%>');" title="点击表格可以添加商品"  style=cursor:pointer><%=g.getSpec(teasession._nLanguage) %></td>
    <td align="center" onclick="f_xuanze_rs('<%= gdobj.getPurchaseid()%>');" title="点击表格可以添加商品"  style=cursor:pointer><%
    Brand b=null;
    if(g.getBrand()>0&&(b=Brand.find(g.getBrand())).isExists())
    {
      if(b.getNode()>0)
      out.print(b.getName(teasession._nLanguage));
    }
    %></td>
    <td  onclick="f_xuanze_rs('<%= gdobj.getPurchaseid()%>');" title="点击表格可以添加商品"  style=cursor:pointer><%=g.getMeasure(teasession._nLanguage)%></td>
   <!--选择的价格--> <td onclick="f_xuanze_rs('<%= gdobj.getPurchaseid()%>');"  title="点击表格可以添加商品"   style=cursor:pointer>
     <input type="text" name="supply<%=i%>" value="<%out.print(gdobj.getSupply());%>" size="4" style="background:#cccccc" readonly="readonly">&nbsp;元</td>
  <!--折扣-->
  <td onclick="f_xuanze_rs('<%= gdobj.getPurchaseid()%>');" title="点击表格可以添加商品"  style=cursor:pointer>
     <input type="text" name="discount<%=i%>" value="<%=gdobj.getDiscount()%>" size="4" style="background:#cccccc" readonly="readonly">
     </td>
     <td onclick="f_xuanze_rs('<%= gdobj.getPurchaseid()%>');" title="点击表格可以添加商品"  style=cursor:pointer>
      <input type="text" name="discount2<%=i%>" value="<%=gdobj.getDiscount2()%>" size="2"  style="background:#cccccc" readonly="readonly">
      </td>
   <!--折后单价--> <td onclick="f_xuanze_rs('<%= gdobj.getPurchaseid()%>');" title="点击表格可以添加商品"  style=cursor:pointer>
     <input type="text" name="dsupply<%=i%>" value="<%=gdobj.getDsupply()%>" size="4" style="background:#cccccc" readonly="readonly" >&nbsp;元</td>
     <!--数量--><td>
       <input type="text" name="quantity<%=i%>" value="<%=gdobj.getQuantity()%>" size="4"  onkeyup="f_quantity('<%=i%>','<%=count%>','<%=Paidinfull.getFloor(nodeid)%>','<%=Paidinfull.getDis(nodeid)%>','<%=fa%>','<%=gdid%>');"></td>

     <!--折扣乘以数量的价格总计--> <td onclick="f_xuanze_rs('<%= gdobj.getPurchaseid()%>');" title="点击表格可以添加商品"  style=cursor:pointer>
       <input type="text" name="total<%=i%>" value="<%=gdobj.getTotal()%>" size="4"  style="background:#cccccc" readonly="readonly">&nbsp;元</td>
       <!--商品备注-->
       <td ><input type="text" name="remarksarr<%=i%>" value="<%=gdobj.getRemarksarr()%>" onkeyup="f_rem('<%=gdid%>','<%=i%>');"></td>
         <%if( refundtype!=0){%>
         <td >
         <select onchange="f_w('<%=i%>');" name="waridname<%=i%>">
         <option value="0">----------</option>
         <%
          java.util.Enumeration e2 = Warehouse.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
          while (e2.hasMoreElements())
          {
            int warid = ((Integer)e2.nextElement()).intValue();
            Warehouse warobj = Warehouse.find(warid);
            out.print("<option value= "+warid);
//            if(waridname==warid)
//            {
//              out.print(" selected");
//            }
            out.print(">"+warobj.getWarname());
            out.print("</option>");
          }
          %>
         </select>
         </td>
         <%} %>
       <td ><a href="#" onclick="f_delete_rs('<%=gdid%>');">删除</a> </td>
  </tr>
  <%} %>
  <%if(!fa2) {%>
  <tr>
    <td colspan="4">&nbsp;</td>
    <td align="right"><b>折扣前金额:</b></td>
    <td><input type="text" name="total" value="<%out.print(bs2);%>" size="4"  style="background:#cccccc" readonly="readonly">&nbsp;元</td>

      <td align="right" colspan="3"><b>折扣后数量和金额:</b></td>
      <td ><input type="text" name="quantity" value="<%out.print(bs3);%>" size="4"  style="background:#cccccc" readonly="readonly"></td>
        <td><input type="text" name="total_2"  size="4" readonly="readonly"  style="background:#cccccc" value="<%out.print(bs);%>" onpropertychange="f_total_2();" >&nbsp;元</td>
  </tr>
  <%} %>
</table>
<%} %>
