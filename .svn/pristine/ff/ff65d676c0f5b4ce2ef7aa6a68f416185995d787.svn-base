<%@page contentType="text/html;charset=UTF-8" %>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
//teasession._nNode=Integer.parseInt(request.getParameter("Nodex"));
tea.entity.node.Node node=  tea.entity.node.Node.find(teasession._nNode);
String community=request.getParameter("community");
if(community==null)
{
    community=node.getCommunity();
}
int brand=Integer.parseInt(request.getParameter("brand"));
java.util.Enumeration enumer;
tea.entity.node.Brand brand_obj=tea.entity.node.Brand.find(brand);

String nexturl=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8");

%>

<table border="0" cellpadding="0" cellspacing="0" >


<%
enumer=tea.entity.node.Node.findAllSons(node.getFather());
while(enumer.hasMoreElements())
{
  int id=((Integer)enumer.nextElement()).intValue();
 // if(id==teasession._nNode)
 // continue ;
  System.out.println(id+":"+teasession._nNode);
  tea.entity.node.Node enumer_node=  tea.entity.node.Node.find(id);



java.util.Enumeration enumer22=tea.entity.node.Goods.findByBrand(brand,id);
int index22=0;
for(;enumer22.hasMoreElements();index22++)
{
  int id222=((Integer)enumer22.nextElement()).intValue();
  tea.entity.node.Node enumer_node222=  tea.entity.node.Node.find(id222);
   tea.entity.node.Goods enumer_goods=  tea.entity.node.Goods.find(id222,teasession._nLanguage);


   if(index22==0)
   {
     out.print("<tr bgcolor=\"#FFFFFF\" ><td colspan=\"3\"><strong>"+enumer_node.getSubject(teasession._nLanguage)+"</strong></td></tr>");
   }

  if(index22%3==0)
  out.print("<tr bgcolor=#FFFFFF>");
%>
    <td><table border="1" cellpadding="0" cellspacing="0"  id="chanpinlist">
      <tr >
        <td  rowspan="3">
        <A href="/servlet/Goods?node=<%=id222%>" target="_blank"><img src="<%=enumer_goods.getSmallpicture()%>" width="111" height="93"></A>
        </td>
        <td height="40">
  <A href="/servlet/Goods?node=<%=id222%>" target="_blank"><%=enumer_node222.getSubject(teasession._nLanguage)%></A>
 </td>
      </tr>
      <tr>
        <td >编号:<%=id222%></td></tr>
        <tr>
       <td >
         <%
         java.util.Enumeration commodity_enumer= tea.entity.node.Commodity.findByGoods(id222);
while(commodity_enumer.hasMoreElements())
{
int commodity_id= ((Integer)commodity_enumer.nextElement()).intValue();
tea.entity.node.Commodity commodity=tea.entity.node.Commodity.find(commodity_id);

tea.entity.node.BuyPrice bp=tea.entity.node.BuyPrice.find(commodity_id,1);
if(bp.isExists())
{
         %>
         市场价:<%=bp.getList()%>元<br>
         商城价:<%=bp.getPrice()%>元<br>
        <INPUT TYPE="TEXT" NAME="QuantityN<%=commodity_id%>L6758" VALUE="1" SIZE="4">
  <%
        if(teasession._rv==null)
        {
          %>
        <INPUT TYPE="button" NAME="ShoppingCart" VALUE="加入购物车" onClick="window.open('/servlet/StartLogin?node=<%=teasession._nNode%>&nexturl=<%=nexturl%>','_self');"/>
<%
        }else
        {%>
         <INPUT TYPE="button" NAME="ShoppingCart" VALUE="加入购物车" onClick="if(submitInteger(document.all['QuantityN<%=commodity_id%>L6758'],'InvalidQuantity'))window.open('/servlet/OfferBuy?node=<%=id222%>&Price=<%=bp.getPrice()%>&Commodity=<%=commodity_id%>&Currency=1&Quantity='+parseInt(document.all['QuantityN<%=commodity_id%>L6758'].value),'','height=170px,width=370px,left=250,top=150,resizable=no,scrollbars=no,toolbar=no,location=no,directories=no,status=no,menubar=no');"/>
<%}}}%>
        </td></tr>
</table></td>
<%}
for(;index22%3!=0;index22++)
{
  out.print("<td></td>");
}
}%>
</table>
<p>&nbsp;</p>

