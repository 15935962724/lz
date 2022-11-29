<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.ui.TeaSession" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.admin.*" %><% request.setCharacterEncoding("UTF-8");

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

String community=node.getCommunity();

StringBuffer param=new StringBuffer("&action="+action);

StringBuffer sql=new StringBuffer(" FROM Node n,Goods g,Brand b");
StringBuffer where_sql=new StringBuffer(" WHERE n.node=g.node AND g.brand=b.brand AND n.community=");
where_sql.append(DbAdapter.cite(community));

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
if(path==null||path.length()<1)
{
  path=String.valueOf(teasession._nNode);
}
if(!"0".equals(path))
{
	where_sql.append(" AND n.path LIKE ");
	where_sql.append(DbAdapter.cite("%/"+path+"/%"));
}
param.append("&path="+path);

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
path       路径  ，默认当前节点
supplier   供应商

attribute  属性ID
attrvalue  属性值

-->




<%
String fpnl=null;
DbAdapter db=new DbAdapter();
try
{
  fpnl=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+"?node="+teasession._nNode+param.toString()+"&pos=",pos,db.getInt("SELECT COUNT(DISTINCT(g.brand)) "+sql.toString()),pagesize).toString();
  db.executeQuery("SELECT DISTINCT b.brand,b.sequence "+sql.toString()+" ORDER BY b.sequence");
  for (int l = 0; l < pos + pagesize && db.next(); l++)
  {
    if (l >= pos)
    {
      int brand_id=db.getInt(1);
      Brand brand_obj=Brand.find(brand_id);
      out.print("<LI>");
      out.print("<SPAN ID=brand_logo ><A href=\"/servlet/Node?node="+action+"&brand="+brand_id+"\" ><IMG onload=\"javascript:this.style.display='';\" style=\"display:none\" SRC="+brand_obj.getLogo()+" /></A></SPAN>");
      out.print("<SPAN ID=brand_name ><A href=\"/servlet/Node?node="+action+"&brand="+brand_id+"\" >"+brand_obj.getName(teasession._nLanguage)+"</A></SPAN>");
      out.print("<SPAN ID=brand_goodstype ><A href=\"/servlet/Node?node="+action+"&brand="+brand_id+"\" >");
      java.util.Enumeration enumeration=GoodsType.findByBrand(brand_id);
      while(enumeration.hasMoreElements())
      {
        int goodstype_id=((Integer)enumeration.nextElement()).intValue();
        GoodsType goodstype_obj=GoodsType.find(goodstype_id);
        if(goodstype_obj.getFather()!=0)
        {
          out.print(goodstype_obj.getName(teasession._nLanguage)+" / ");
        }
      }
      out.print("</A></SPAN>");
      out.print("<SPAN ID=brand_member ><A href=\"/servlet/Node?node="+action+"&brand="+brand_id+"\" >");
      enumeration= AdminUsrRole.findByBrand(community,brand_id);
      if(enumeration.hasMoreElements())
      {
        String member_id=((String)enumeration.nextElement());
        out.print(member_id);
      }
      out.print("</A></SPAN>");
      out.println("</LI>");
    }
  }
}finally
{
  db.close();
}
out.print("<LI ID=BrandPage >"+fpnl+"</LI>");
%>





<%--


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

--%>

