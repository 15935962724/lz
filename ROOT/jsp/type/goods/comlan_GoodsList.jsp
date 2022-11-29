<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.ui.TeaSession" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.node.*" %><% request.setCharacterEncoding("UTF-8");

int action=1;
try
{
  action=Integer.parseInt(request.getParameter("action"));
}catch(NumberFormatException ex)
{
  out.print("action参数:点击\"对比选中商品\",转到的节点号.  必须有.");
  return;
}

TeaSession teasession=new TeaSession(request);

Node node=Node.find(teasession._nNode);

StringBuffer param=new StringBuffer("&action="+action);

StringBuffer sql=new StringBuffer(" FROM Node n,Goods g");
StringBuffer where_sql=new StringBuffer(" WHERE n.node=g.node AND n.community=");
where_sql.append(DbAdapter.cite(node.getCommunity()));

String brand=request.getParameter("brand");
if(brand!=null&&brand.length()>0)
{
  where_sql.append(" AND g.brand=");
  where_sql.append(DbAdapter.cite(brand));
  param.append("&brand="+brand);
}

String goodstype=request.getParameter("goodstype");
if(goodstype!=null&&goodstype.length()>0)
{
  where_sql.append(" AND g.goodstype LIKE ");
  where_sql.append(DbAdapter.cite("%/"+goodstype+"/%"));
  param.append("&goodstype="+goodstype);
}

String father=request.getParameter("father");
if(father!=null&&father.length()>0)
{
  where_sql.append(" AND n.father=");
  where_sql.append(DbAdapter.cite(father));
  param.append("&father="+father);
}

String path=request.getParameter("path");
if(path!=null&&path.length()>0)
{
  where_sql.append(" AND n.path LIKE ");
  where_sql.append(DbAdapter.cite("%/"+path+"/%"));
  param.append("&path="+path);
}

String supplier=request.getParameter("supplier");
if(supplier!=null&&supplier.length()>0)
{
  sql.append(",Commodity c ");
  where_sql.append(" AND c.goods=g.node AND c.supplier=");
  where_sql.append(DbAdapter.cite(supplier));
  param.append("&supplier="+supplier);
}

String attribute=request.getParameter("attribute");
String attrvalue=request.getParameter("attrvalue");
if(attribute!=null&&attribute.length()>0&&attrvalue!=null&&attrvalue.length()>0)
{
  sql.append(",Attribute a ");
  where_sql.append(" AND a.node=g.node AND a.attribute=");
  where_sql.append(DbAdapter.cite(attribute));
  where_sql.append(" AND a.attrvalue LIKE ");
  where_sql.append(DbAdapter.cite("%"+attrvalue+"%"));
  param.append("&attribute="+attribute+"&attrvalue="+attrvalue);
}
sql.append(where_sql);

int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
int pagesize=20;
%>
<!--
参数说明:
action     点击"对比选中商品",转到的节点号.  必须有
brand      品牌
goodstype  类型
father     父节
path       路径
supplier   供应商

attribute  属性ID
attrvalue  属性值

-->
<script>
function fonsubmit_goodslist(obj)
{
  if(obj.checked)
  return true;
  for(var i=0;i<obj.length;i++)
  {
    if(obj[i].checked)
    {
      return true;
    }
  }
  alert('请先选中您要对比的商品.');
  return false;
}
</script>
<form action="/servlet/Node" onsubmit="return fonsubmit_goodslist(this.nodes);" >
<input type="hidden" name="Node" value="<%=action%>"/>

<div class="nav_list_tbg2">
  <input type="submit" class="nav_compare" value="对比选中商品"  />
</div>





<%
DbAdapter db=new DbAdapter();
String fpnl=null;
try
{
fpnl=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+"?node="+teasession._nNode+param.toString()+"&pos=",pos,db.getInt("SELECT COUNT(n.node) "+sql.toString()),pagesize).toString();
db.executeQuery("SELECT n.node "+sql.toString());
for (int l = 0; l < pos + pagesize && db.next(); l++)
{
  if (l >= pos)
  {
    int node_id=db.getInt(1);
    Node node_obj=Node.find(node_id);
    Goods goods_obj=Goods.find(node_id);

String fonclick=null;
if(teasession._rv==null)
{
  fonclick="window.open('/servlet/StartLogin?node="+node_id+"','_self');";
}else
{
  java.util.Enumeration enumer=Commodity.findByGoods(node_id);
  if(enumer.hasMoreElements())
  {
    int commodity_id=((Integer)enumer.nextElement()).intValue();
//    Commodity commodity_obj=(Commodity)enumer.nextElement();

    fonclick="window.open('/servlet/OfferBuy?node="+node_id+"&Price="+goods_obj.getPrice()+"&Commodity="+commodity_id+"&Currency=1&Quantity=1','','height=170,width=370,left=250,top=150');";
  }
}

//if(l%5==0)
//out.print("<tr><td class=nav_list_rowone >");
%>
<LI>
<SPAN ID=goods_checkbox ><input type="checkbox" name="nodes" value="<%=node_id%>" /></SPAN>
<SPAN ID="goods_smallpicture" ><a href="/servlet/Node?node=<%=node_id%>" ><img src="<%=goods_obj.getSmallpicture(teasession._nLanguage)%>" onload="javascript:this.style.display='';" style="display:none" /></A></SPAN>
<SPAN ID=goods_subject ><a href="/servlet/Node?node=<%=node_id%>" ><%=node_obj.getSubject(teasession._nLanguage)%></A></SPAN>
<SPAN ID="goods_price">￥<%=goods_obj.getPrice()%></SPAN>
<SPAN ID="goods_button"><input id="buybutton" type="button" onclick="<%=fonclick%>" value="购买"/></SPAN>
</LI>

<%
}
}
}finally
{
db.close();
}
%>



<li id="nav_pagetable">
  <input name="Submit2" type="submit" class="nav_compare" value="对比选中商品" /></form>
     <%=fpnl%>

     <%
      if(fpnl.length()>0)
      {
        %>
        <form action="<%=request.getRequestURI()%>" onsubmit="this.postext.disabled=true;var pos=parseInt(this.postext.value);if(isNaN(pos))pos=1;this.pos.value=(pos-1)*<%=pagesize%>;">
        <input type="hidden" name="Node" value="<%=teasession._nNode%>" >
        <input type="hidden" name="pos" value="0"/>
        到第<input name="postext" type="text" class="nav_pagetf" />页
        <input type="submit" class="nav_pagebt" value="确定" />
        </form>
        <%}%>

  </li>


<%


%>

