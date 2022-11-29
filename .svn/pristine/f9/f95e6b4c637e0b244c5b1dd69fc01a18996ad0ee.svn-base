<%@page contentType="text/html;charset=utf-8" %>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
//java.util.Enumeration enumer=tea.entity.node.Node.findAllSons(teasession._nNode);
String community=request.getParameter("community");
if(community==null)
{
    tea.entity.node.Node node=  tea.entity.node.Node.find(teasession._nNode);
    community=node.getCommunity();
}
String type=teasession.getParameter("type");
String brand=teasession.getParameter("brand");
String price1=teasession.getParameter("price1");
String price2=teasession.getParameter("price2");
String keyword=teasession.getParameter("keyword");

String nexturl=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8");
%>

<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>


<div id="head6"><img height="6" alt=""></div>
<style>
#tablecenter{border: 1px solid #cccccc;clear: both;width:100%;margin:5px;padding:5px}
</style>
<table width="100%" border="0" cellpadding="0" cellspacing="0" id="tablecenter"><form action="" method="get">
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<tr>
  <td>类别</td><td><select name="type">
          <option value="" >----------</option>
          <%
java.util.Enumeration enumer_form111=tea.entity.node.Node.findAllSons(teasession._nNode);
while(enumer_form111.hasMoreElements())
{
  int id=((Integer)enumer_form111.nextElement()).intValue();
  tea.entity.node.Node obj=tea.entity.node.Node.find(id);
  out.print("<option value="+id+" >"+obj.getSubject(teasession._nLanguage)+"</option>");
}%>
        </select></td>
  <td>品牌</td><td><select name="brand">
          <option value="" >----------</option>
          <%
java.util.Enumeration enumer54313=tea.entity.node.Brand.findByCommunity(community,null);
while(enumer54313.hasMoreElements())
{
  int id=((Integer)enumer54313.nextElement()).intValue();
  tea.entity.node.Brand obj=tea.entity.node.Brand.find(id);
  out.print("<option value="+obj.getBrand()+" >"+obj.getName(teasession._nLanguage)+"</option>");
}%>
        </select></td><td>价格</td><td><input name="price1" type="text" size="5">-<input name="price2" type="text" size="5"></td><td>关键字</td><td><input name="keyword" type="text" size="5"></td><td><input type="submit" value="搜索"></td></tr>
</form></table>

<div id="head6"><img height="6" alt=""></div>

<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#ececec"" style="padding:5px">

<%
  StringBuffer param=new StringBuffer("?node="+teasession._nNode);
  StringBuffer sql=new StringBuffer(" WHERE n.community="+tea.db.DbAdapter.cite(community)+" AND n.node=g.node");
  StringBuffer from=new StringBuffer(" FROM Node n,Goods g");
  if(type!=null&&type.length()>0)
  {
    sql.append(" AND n.father="+type);
    param.append("&type="+type);
  }
  if(brand!=null&&brand.length()>0)
  {
    sql.append(" AND g.brand LIKE "+tea.db.DbAdapter.cite("%/"+brand+"/%"));
    param.append("&brand="+brand);
  }
  if((price1!=null&&price1.length()>0)||(price2!=null&&price2.length()>0))
  {
    from.append(",BuyPrice bp,Commodity c");
    sql.append(" AND c.commodity=bp.commodity AND c.goods=g.node");
    if((price1!=null&&price1.length()>0))
    {
      sql.append(" AND bp.price>="+price1);
      param.append("&price1="+price1);
    }
    if(price2!=null&&price2.length()>0)
    {
      sql.append(" AND bp.price<"+price2);
      param.append("&price2="+price2);
    }
  }
  if(keyword!=null&&keyword.length()>0)
  {
    from.append(",NodeLayer nl");
    String keys[]=keyword.split(" ");
    StringBuffer contains=new StringBuffer();
    contains.append("\"" + keys[0] + "\"");
    for(int index=1;index<keys.length;index++)
    {
      contains.append(" OR \"" + keys[index] + "\"");
    }
    sql.append(" AND nl.node=n.node AND (CONTAINS(nl.keywords,N'" + contains.toString() + "') OR CONTAINS(nl.content,N'" + contains.toString() + "'))");
    param.append("&keywords="+keyword);
  }
  int count=0;
  int pos=0;
  int pageSize=24;
  if( teasession.getParameter("Pos")!=null)
  {
    pos=Integer.parseInt(  teasession.getParameter("Pos"));
  }
tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
try
{
  count=  dbadapter.getInt("SELECT DISTINCT COUNT( n.node ) "+from.toString()+sql.toString());
//  System.out.println("SELECT DISTINCT n.node "+from.toString()+sql.toString());
  dbadapter.executeQuery("SELECT DISTINCT n.node "+from.toString()+sql.toString());
int i=0;
  for (int index = 0; index < pos + pageSize && dbadapter.next(); index++)
  {
    if (index >= pos)
    {
      int id=dbadapter.getInt(1);
      tea.entity.node.Node node=    tea.entity.node.Node.find(id);
      tea.entity.node.Goods enumer_goods=  tea.entity.node.Goods.find(id,teasession._nLanguage);
      String subject=node.getSubject(teasession._nLanguage);
      if(i%3==0)
      {
        out.print("<tr bgcolor=#FFFFFF>");
      }
      i++;
      %>
<td><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#999999" style="padding:5px"  id="pinpai">
      <tr bgcolor="#FFFFFF">
        <td width="121" rowspan="3">
        <A href="/servlet/Goods?node=<%=id%>" target="_blank"><img src="<%= enumer_goods.getSmallpicture()%>" width="111" height="93"></A></td>
        <td width="218" height="28">

  <A href="/servlet/Goods?node=<%=id%>" target="_blank"><%=subject%></A>
  </td>
 </tr>
	        <tr>
        <td bgcolor="#FFFFFF">编号:<%=id%></td>
      </tr>
	      <tr>
        <td bgcolor="#FFFFFF">
           <%
         java.util.Enumeration commodity_enumer= tea.entity.node.Commodity.findByGoods(id);
while(commodity_enumer.hasMoreElements())
{
int commodity_id= ((Integer)commodity_enumer.nextElement()).intValue();
tea.entity.node.Commodity commodity=tea.entity.node.Commodity.find(commodity_id);

tea.entity.node.BuyPrice bp=tea.entity.node.BuyPrice.find(commodity_id,1);
if(bp.isExists())
{
         %>市场价:<%=bp.getList()%>元  商城价:<%=bp.getPrice()%>元

        <INPUT TYPE="TEXT" NAME="QuantityN<%=commodity_id%>L6758" VALUE="1" SIZE="4">
        <%
        if(teasession._rv==null)
        {
          %>
        <INPUT TYPE="button" NAME="ShoppingCart" VALUE="加入购物车" onClick="window.open('/servlet/StartLogin?node=<%=teasession._nNode%>&nexturl=<%=nexturl%>','_self');"/>
<%
        }else
        {%>
        <INPUT TYPE="button" NAME="ShoppingCart" VALUE="加入购物车" onClick="if(submitInteger(document.all['QuantityN<%=commodity_id%>L6758'],'InvalidQuantity'))window.open('/servlet/OfferBuy?node=<%=id%>&Price=<%=bp.getPrice()%>&Commodity=<%=commodity_id%>&Currency=1&Quantity='+parseInt(document.all['QuantityN<%=commodity_id%>L6758'].value),'','height=170px,width=370px,left=250,top=150,resizable=no,scrollbars=no,toolbar=no,location=no,directories=no,status=no,menubar=no');"/>
<%}}}%>
        </td>
      </tr></table></td>
      <%
      }
    }
    for(;i%3!=0;i++)
    {
      out.print("<td></td>");
    }
}catch(Exception e)
{
  e.printStackTrace();
}finally
{
  dbadapter.close();
}

%>
<%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param.toString() + "&Pos=", pos, count, pageSize)%>
</td>
      </tr></table>

