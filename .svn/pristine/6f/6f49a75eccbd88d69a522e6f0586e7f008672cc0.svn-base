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

StringBuffer sql=new StringBuffer(" FROM Node n WHERE n.community=");
sql.append(DbAdapter.cite(node.getCommunity())).append(" AND n.type=34");

sql.append(" AND n.path LIKE ").append(DbAdapter.cite(node.getPath()+"/%"));

StringBuffer param=new StringBuffer();
param.append("?node=").append(teasession._nNode);
param.append("&action=").append(action);
/*
String brand=request.getParameter("brand");
if(brand!=null&&brand.length()>0)
{
  sql.append(" AND g.brand=");
  sql.append(DbAdapter.cite(brand));
  param.append("&brand="+brand);
}

String goodstype=request.getParameter("goodstype");
if(goodstype!=null&&goodstype.length()>0)
{
  sql.append(" AND g.goodstype LIKE ");
  sql.append(DbAdapter.cite("%/"+goodstype+"/%"));
  param.append("&goodstype="+goodstype);
}

String father=request.getParameter("father");
if(father!=null&&father.length()>0)
{
  sql.append(" AND n.father=");
  sql.append(DbAdapter.cite(father));
  param.append("&father="+father);
}

String path=request.getParameter("path");
if(path!=null&&path.length()>0)
{
  sql.append(" AND n.path LIKE ");
  sql.append(DbAdapter.cite("%/"+path+"/%"));
  param.append("&path="+path);
}

String supplier=request.getParameter("supplier");
if(supplier!=null&&supplier.length()>0)
{
  sql.append(",Commodity c ");
  sql.append(" AND c.goods=g.node AND c.supplier=");
  sql.append(DbAdapter.cite(supplier));
  param.append("&supplier="+supplier);
}

String attribute=request.getParameter("attribute");
String attrvalue=request.getParameter("attrvalue");
if(attribute!=null&&attribute.length()>0&&attrvalue!=null&&attrvalue.length()>0)
{
  sql.append(",Attribute a ");
  sql.append(" AND a.node=g.node AND a.attribute=");
  sql.append(DbAdapter.cite(attribute));
  sql.append(" AND a.attrvalue LIKE ");
  sql.append(DbAdapter.cite("%"+attrvalue+"%"));
  param.append("&attribute="+attribute+"&attrvalue="+attrvalue);
}
*/

int quantity=10;
String _strQuantity=request.getParameter("quantity");
if(_strQuantity!=null&&_strQuantity.length()>0)
{
  quantity=Integer.parseInt(_strQuantity);
}

int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
int pagesize=20;

param.append("&pos=");


%>
<!--
参数说明:
action     点击"对比选中商品",转到的节点号.  必须有
quantity   主题的字数,默认10

//////以下参数,现已没用/////////
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
<input type="hidden" name="Node" value="<%=request.getParameter("action")%>"/>

<div class="nav_list_tbg2">
  <input type="submit" class="nav_compare" value="对比选中商品"  />
</div>
</div>

<div class="nav_list_content">



<%
DbAdapter db=new DbAdapter();
String fpnl=null;
try
{
  fpnl=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,db.getInt("SELECT COUNT(n.node) "+sql.toString()),pagesize).toString();
  db.executeQuery("SELECT n.node "+sql.toString());
  for (int l = 0; l < pos + pagesize && db.next(); l++)
  {
    if (l >= pos)
    {
      int node_id=db.getInt(1);
      Node node_obj=Node.find(node_id);
      String subject=node_obj.getSubject(teasession._nLanguage);
      if(subject!=null&&subject.length()>quantity)
      subject=subject.substring(0,quantity)+"...";
      Goods goods_obj=Goods.find(node_id,teasession._nLanguage);

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

          fonclick="window.open('/servlet/OfferBuy?node="+node_id+"&commodity="+commodity_id+"&currency=1&quantity=1','dialog_frame');";//,'height=170,width=370,left=250,top=150'
        }
      }

      //if(l%5==0)
      //out.print("<tr><td class=nav_list_rowone >");
      %>

      <div><A href="/servlet/Node?node=<%=node_id%>&Language=<%=teasession._nLanguage%>" ><img src="<%=goods_obj.getSmallpicture()%>" width="82" height="74" /></A><br />
        <input type="checkbox" name="nodes" value="<%=node_id%>" id="for<%=node_id%>" /><label for="for<%=node_id%>" ><%=subject%></label><br />
          ￥<%=goods_obj.getPrice()%><br />
          <input id="buybutton" type="button" onclick="window.open('/servlet/Node?node=<%=node_id%>&Language=<%=teasession._nLanguage%>','_self');" value="购买"/>
</div>

<%
}
}
}finally
{
  db.close();
}
%>



<table width="100%" border="0" cellpadding="0" cellspacing="0" class="nav_pagetable">
  <tbody>
    <tr>
      <td width="140"><input name="Submit2" type="submit" class="nav_compare" value="对比选中商品" /></form></td>
      <td width="260"><%=fpnl%>
      </td>
      <td><%
      if(fpnl.length()>0)
      {
        %>
        <form action="<%=request.getRequestURI()%>" onsubmit="this.postext.disabled=true;var pos=parseInt(this.postext.value);if(isNaN(pos))pos=1;this.pos.value=(pos-1)*<%=pagesize%>;">
        <input type="hidden" name="Node" value="<%=teasession._nNode%>" >
        <input type="hidden" name="pos" value="0"/>
        到第<input name="postext" type="text" class="nav_pagetf" />页
        <input type="submit" class="nav_pagebt" value="确定" />
        </form>
        <%}%></td>
    </tr>
  </tbody>
</table>
</div>
<%


%>

