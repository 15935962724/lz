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
  String num = teasession.getParameter("num");
  int type = Integer.parseInt(teasession.getParameter("type"));
  String purid = teasession.getParameter("purid");
  String puridsg = teasession.getParameter("puridsg");

  if(num.equals("1"))
  {
    purid=puridsg;
  }
  String chers = SemiGoodsDetails.getSemiGoodsarr(teasession._strCommunity,purid,type);//teasession.getParameter("chers");
  %>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <input type="hidden" value="<%=chers%>" name="chershecheng">
    <tr id="tableonetr">
      <td align="center" nowrap>商品编号</td>
      <td align="center" nowrap>商品名称</td>
      <td align="center" nowrap>规格型号</td>
      <td align="center" nowrap>单位</td>
      <td align="center" nowrap>规则数量</td>
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
      out.print("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\"  onclick=f_xuanze(); title=点击表格可以添加商品  style=cursor:pointer><td colspan=12 align=center>暂无记录，请点击表格，来添加商品。</td></tr>");
      fa2=true;
    }
    for(int i = 1;e.hasMoreElements();i++)
    {
      int gdid = ((Integer)e.nextElement()).intValue();
      SemiGoodsDetails gdobj = SemiGoodsDetails.find(gdid);
      String goodsnumber="";
      String subject="";
      String spec="";
      String measure="";

      if(num.equals("1"))///等1 是规则
      {
        purid=puridsg;
        SemiGoods sgobj = SemiGoods.find(gdobj.getSgid());
        goodsnumber=sgobj.getGoodsnumber();
        subject=sgobj.getSubject();
        spec=sgobj.getSpec();
        measure=sgobj.getMeasure();
        bs3=bs3+gdobj.getQuantity();
      }
      else
      {
        SemiSupplier ssobj = SemiSupplier.find(gdobj.getSgid());
        SemiGoods sgobj = SemiGoods.find(ssobj.getSgid());
        goodsnumber=sgobj.getGoodsnumber();
        subject=sgobj.getSubject();
        spec=sgobj.getSpec();
        measure=sgobj.getMeasure();
        bs3=bs3+gdobj.getQuantity();
      }
      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
        <td align="center" onclick="f_xuanze();" title="点击表格可以添加商品"  style=cursor:pointer><%=goodsnumber %></td>
        <td onclick="f_xuanze();" title="点击表格可以添加商品"  style=cursor:pointer><%=subject%></td>
        <td align="center" onclick="f_xuanze();" title="点击表格可以添加商品"  style=cursor:pointer><%=spec%></td>
        <td  onclick="f_xuanze();" title="点击表格可以添加商品"  style=cursor:pointer><%=measure%></td>
        <td>
          <input type="text" style="background:#cccccc" readonly="readonly" name="quantity<%=i%>" value="<%=gdobj.getQuantity()%>" size="4" onkeyup="f_quantity('<%=gdobj.getSupply()%>','<%=i%>','<%=chers%>');"/>
        </td>
        <td>
        <%
        if(num.equals("1"))
        {

        }else
        {
          %>
          <a href="#" onclick="f_delete('<%=gdid%>');">删除</a>
          <%
        }
        %> </td>
      </tr>
      <%} %>
      <%if(!fa2)
      {%>
      <tr>
        <td colspan="3">&nbsp;</td>

        <td ><b>合计数量:</b></td>
        <td ><input type="text" name="quantity" value="<%out.print(bs3);%>" size="4"  style="background:#cccccc" readonly="readonly"></td>

      </tr>
      <%} %>
  </table>
  <%} %>
