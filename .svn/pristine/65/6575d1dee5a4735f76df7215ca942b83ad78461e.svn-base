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

  String purid = teasession.getParameter("purid");
Complimentary comobj = Complimentary.find(purid);
  %>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td align="center" nowrap>条形码或编号</td>
      <td align="center" nowrap>商品名称</td>
      <td align="center" nowrap>规格型号</td>
      <td align="center" nowrap>品牌</td>
      <td align="center" nowrap>单位</td>
      <td align="center" nowrap>数量</td>
      <td align="center" nowrap>备注</td>
       <td align="center" nowrap>&nbsp;</td>
    </tr>
    <%
 int count = GoodsDetails.count(teasession._strCommunity," AND paid="+DbAdapter.cite(purid));

    java.util.Enumeration e = GoodsDetails.find(teasession._strCommunity," AND paid="+DbAdapter.cite(purid),0,Integer.MAX_VALUE);
    if(!e.hasMoreElements())
    {
      out.print("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\"  onclick=f_xuanze(); title=点击表格可以添加商品  style=cursor:pointer><td colspan=12 align=center>暂无记录，请点击表格，来添加商品。</td></tr>");
    }
   int q = 0;
    for(int i = 0;e.hasMoreElements();i++)
    {
      int gdid = ((Integer)e.nextElement()).intValue();
      GoodsDetails gdobj = GoodsDetails.find(gdid);
      int nodeid =gdobj.getNode();
      Node nobj = Node.find(nodeid);
      Goods g=Goods.find(nodeid);
      Commodity cobj = Commodity.find_goods(nodeid);
      q = q+gdobj.getQuantity();

      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
        <td align="center" onclick="f_xuanze();" title="点击表格可以添加商品"  style=cursor:pointer><%=nobj.getNumber() %></td>
        <td onclick="f_xuanze();" title="点击表格可以添加商品"  style=cursor:pointer><%=nobj.getSubject(teasession._nLanguage)%></td>
        <td align="center" onclick="f_xuanze();" title="点击表格可以添加商品"  style=cursor:pointer><%=g.getSpec(teasession._nLanguage) %></td>
        <td align="center" onclick="f_xuanze();" title="点击表格可以添加商品"  style=cursor:pointer><%
        Brand b=null;
        if(g.getBrand()>0&&(b=Brand.find(g.getBrand())).isExists())
        {
          if(b.getNode()>0)
          out.print(b.getName(teasession._nLanguage));
        }
        %></td>
        <td  onclick="f_xuanze();" title="点击表格可以添加商品"  style=cursor:pointer><%=g.getMeasure(teasession._nLanguage)%></td>

          <!--数量--><td>  <input type="text" name="quantity<%=i%>" value="<%=gdobj.getQuantity()%>" size="4" onkeyup="f_quantity('<%=gdid%>','<%=i%>','<%=count%>');"></td>
             <td >
               <input type="text" name="remarksarr<%=i%>" value="<%=gdobj.getRemarksarr()%>" onkeyup="f_rem('<%=gdid%>','<%=i%>');"></td>

              <td ><a href="#" onclick="f_delete('<%=gdid%>');">删除</a> </td>
      </tr>
      <%} %>
      <tr>
        <td colspan="4">&nbsp;</td>
        <td align="right" ><b>合计数量:</b></td>
        <td ><input type="text" name="quantity" value="<%=q%>" size="4"  style="background:#cccccc" readonly="readonly"></td>
      </tr>

  </table>

