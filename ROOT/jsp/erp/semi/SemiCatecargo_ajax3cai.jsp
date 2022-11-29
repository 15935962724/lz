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

if("EditSemiCatecargo".equals(act))
{
  int type = Integer.parseInt(teasession.getParameter("type"));

    String num =teasession.getParameter("num");

  String purid = teasession.getParameter("purid");
  String puridsg = teasession.getParameter("puridsg");

  if(num.equals("1"))
  {
    purid=puridsg;
  }

  String chers = GoodsDetails.getNodearr(teasession._strCommunity,purid,type);//teasession.getParameter("chers");
  String chersarr[] = chers.split("/");
  %>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td align="center" nowrap>商品编号</td>
      <td align="center" nowrap>商品名称</td>
      <td align="center" nowrap>规格型号</td>
      <td align="center" nowrap>品牌</td>
      <td align="center" nowrap>单位</td>
       <td align="center" nowrap>单价</td>
      <td align="center" nowrap>数量</td>
    </tr>
    <%
    java.math.BigDecimal bs = new  java.math.BigDecimal(0);
    java.math.BigDecimal bs2 = new  java.math.BigDecimal(0);
    int bs3 = 0;
    boolean fa = false;
    boolean fa2 = false;

    java.util.Enumeration e = GoodsDetails.find(teasession._strCommunity," AND paid="+DbAdapter.cite(purid),0,Integer.MAX_VALUE);
    if(!e.hasMoreElements())
    {
      out.print("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\"  onclick=f_xuanze2(); title=点击表格可以添加商品  style=cursor:pointer><td colspan=12 align=center>暂无记录，请点击表格，来添加商品。</td></tr>");
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
      if(bpobj.getSupply()!=null){
        bs2=bs2.add(bpobj.getSupply());
      }
      bs=bs.add(new java.math.BigDecimal(gdobj.getTotal()));
      bs3= bs3+gdobj.getQuantity();
      // System.out.println(ReturnedShop.getDis(nodeid));
      if(ReturnedShop.getDis(nodeid)>0)
      {
        fa = true;
      }
      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
        <td align="center" onclick="f_xuanze2();" title="点击表格可以添加商品"  style=cursor:pointer><%=nobj.getNumber() %></td>
        <td onclick="f_xuanze2();" title="点击表格可以添加商品"  style=cursor:pointer><%=nobj.getSubject(teasession._nLanguage)%></td>
        <td align="center" onclick="f_xuanze2();" title="点击表格可以添加商品"  style=cursor:pointer><%=g.getSpec(teasession._nLanguage) %></td>
        <td align="center" onclick="f_xuanze2();" title="点击表格可以添加商品"  style=cursor:pointer><%
        Brand b=null;
        if(g.getBrand()>0&&(b=Brand.find(g.getBrand())).isExists())
        {
          if(b.getNode()>0)
          out.print(b.getName(teasession._nLanguage));
        }
        %></td>
        <td  onclick="f_xuanze2();" title="点击表格可以添加商品"  style=cursor:pointer><%=g.getMeasure(teasession._nLanguage)%></td>
        <!--选择的价格-->
        <td onclick="f_xuanze2();"  title="点击表格可以添加商品"   style=cursor:pointer> <input type="text" name="supplysg<%=i%>" value="<%out.print(gdobj.getSupply());%>" size="4" style="background:#cccccc" readonly="readonly">&nbsp;元</td>

          <!--数量--><td>  <input type="text" name="quantitysg<%=i%>" value="<%=gdobj.getQuantity()%>" size="4" onkeyup="f_quantity2('<%=gdobj.getSupply()%>','<%=i%>','<%=chers%>');"></td>
      </tr>
      <%} %>
      <%if(!fa2) {%>
      <tr>
        <td colspan="5">&nbsp;</td>

        <td ><b>合计数量:</b></td>
        <td>
          <input type="text" name="quantitysg" value="<%out.print(bs3);%>" size="4"  style="background:#cccccc" readonly="readonly">
        </td>

      </tr>
      <%} %>
  </table>
  <%} %>
