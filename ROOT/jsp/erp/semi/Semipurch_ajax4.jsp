<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.TeaSession" %><%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.erp.semi.*" %><%
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
  String chers = SemiGoodsDetails.getSemiGoodsarr(teasession._strCommunity,purid,type);//teasession.getParameter("chers");
  String chersarr[] = chers.split("/");
  Purchase pobj = Purchase.find(purid);
  if(pobj.isExists())
  {
    flowtype=pobj.getFlowtype();
  }

  out.print("4@;"+flowtype);
  %>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td align="center" nowrap>商品编号</td>
      <td align="center" nowrap>商品名称</td>
      <td align="center" nowrap>规格型号</td>
      <td align="center" nowrap>单位</td>
      <td align="center" nowrap>单价</td>
      <td align=center nowrap>采购数量</td>
      <td align="center" nowrap>到货数量</td>
      <td align="center" nowrap>剩余数量</td>
      <td align="center" nowrap>金额</td>
      <td align="center" nowrap>&nbsp;</td>
    </tr>
    <%
    java.math.BigDecimal bs = new  java.math.BigDecimal(0);
    java.math.BigDecimal bs2 = new  java.math.BigDecimal(0);
    int bs3 = 0;
    boolean fa = false;
    boolean fa2 = false;
    java.util.Enumeration e = SemiGoodsDetails.find(teasession._strCommunity," AND paid="+DbAdapter.cite(purid),0,Integer.MAX_VALUE);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=12 align=center>暂无记录，请点击表格，来添加商品。</td></tr>");
      fa2=true;
    }
    for(int i = 1;e.hasMoreElements();i++)
    {
      int gdid = ((Integer)e.nextElement()).intValue();
      SemiGoodsDetails gdobj = SemiGoodsDetails.find(gdid);
      SemiSupplier ssobj =SemiSupplier.find(gdobj.getSgid());

      SemiGoods sgobj = SemiGoods.find(ssobj.getSgid());
      bs3 = bs3+gdobj.getQuantity();

      if(gdobj.getTotal()!=null && gdobj.getTotal().length()>0)
      {
        bs=bs.add(new java.math.BigDecimal(gdobj.getTotal()));
      }
      else
      {         bs=bs.add(ssobj.getSupply());      }
      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
        <td align="center"><%=sgobj.getGoodsnumber() %></td>
        <td><%=sgobj.getSubject()%></td>
        <td align="center"><%=ssobj.getSpec()%></td>
        <td><%=ssobj.getMeasure()%></td>
        <!--选择的价格-->
        <td><input type="text" name="supply<%=i%>" value="<%out.print(ssobj.getSupply());%>" size="4" style="background:#cccccc" readonly="readonly">&nbsp;元</td>

          <%
          if(flowtype==2)
          {
            out.print("<td><input  style=\"background:#cccccc\" readonly=\"readonly\" type=\"text\" name=\"quantity22"+i+"\" value=\""+gdobj.getQuantity22()+"\" size=\"4\" ></td> ");

          }
          %>
          <td><input  type="hidden" name="quantitymm<%=i%>" value="<%=gdobj.getQuantity2()%>" /><input type="text" style="background:#cccccc" readonly="readonly" name="quantitydd<%=i%>" value="<%if(gdobj.getQuantity()!=0){out.print(gdobj.getQuantity());}else{out.print(ssobj.getNum());}%>" size="4" onkeyup="f_quantity('<%=gdobj.getSupply()%>','<%=i%>','<%=chers%>');"></td>
          <td><input type="text"  name="quantity<%=i%>" value="<%if(gdobj.getQuantity2()!=0){out.print(gdobj.getQuantity2());}%>" size="4" onkeyup="f_quantity2('<%=gdobj.getSupply()%>','<%=i%>','<%=chers%>');"></td>
          <td>
            <input type="text" name="total<%=i%>" value="<%=gdobj.getTotal()%>" size="4"  style="background:#cccccc" readonly="readonly">&nbsp;元</td>
            <td ><a href="#" onclick="f_delete('<%=gdid%>');">删除</a>
</td>
      </tr>
      <%} %>
      <%if(!fa2)
      {%>
      <tr>
        <td colspan="4">&nbsp;</td>

        <td ><b>合计数量和金额:</b></td><td></td><td></td>
        <td ><input type="text" name="quantity" value="<%out.print(bs3);%>" size="4"  style="background:#cccccc" readonly="readonly"></td>
          <td><input type="text" name="total"  size="4" readonly="readonly"  style="background:#cccccc" value="<%out.print(bs);%>">&nbsp;元</td>
      </tr>
      <%} %>
  </table>
  <%} %>
