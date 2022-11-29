<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?Node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
}

String _strId=teasession.getParameter("id");

String goods=teasession.getParameter("goods");
String goodstype=teasession.getParameter("goodstype");
String brand=teasession.getParameter("brand");
String price1=teasession.getParameter("price1");
String price2=teasession.getParameter("price2");
String q=teasession.getParameter("q");
tea.resource.Resource r=new tea.resource.Resource();

String supplier=teasession.getParameter("supplier");
String serialnumber=teasession.getParameter("serialnumber");
//new
String time=teasession.getParameter("time");//时间
String productname=teasession.getParameter("productname");//商品名称
String rcreater=teasession.getParameter("rcreator");//按录入人员

StringBuffer param=new StringBuffer();
param.append("?community=").append(teasession._strCommunity);
//param.append("&id=").append(_strId);

  //StringBuffer sql=new StringBuffer(" WHERE n.community="+DbAdapter.cite(teasession._strCommunity)+" AND n.node=g.node ");
  StringBuffer sql=new StringBuffer(" WHERE n.community="+DbAdapter.cite(teasession._strCommunity)+" AND n.node=g.node AND g.node=c.goods and c.commodity=bp.commodity");
  //StringBuffer from=new StringBuffer(" FROM Node n,Goods g");
  StringBuffer from=new StringBuffer(" FROM Node n,Goods g,Commodity c,BuyPrice bp");


  if(goods!=null&&goods.length()>0)
  {
    sql.append(" AND n.node LIKE ").append(DbAdapter.cite("%"+goods+"%"));
    param.append("&node=").append(goods);
  }
  if(time!=null&&time.length()>0)//按时间查询
  {
		  String len=time.substring(time.lastIndexOf('-')+1);
		  if(len.length()==1){
		      len='0'+len;
		      time=time.substring(0,time.lastIndexOf('-')+1)+len;
		  }
		    sql.append(" AND n.time LIKE ").append(DbAdapter.cite("%"+time+"%"));
		    param.append("&time=").append(time);
  }
   String number = teasession.getParameter("number");
   if(number!=null && number.length()>0)
   {
     sql.append(" AND n.goodsnumber LIKE ").append(DbAdapter.cite("%"+number+"%"));
     param.append("&number=").append(java.net.URLEncoder.encode(number,"UTF-8"));
   }
  int root=GoodsType.getRootId(teasession._strCommunity);
  if(goodstype!=null&&goodstype.length()>0)
  {
    sql.append(" AND g.goodstype LIKE '/").append(root).append("/").append(goodstype).append("/%'");
    param.append("&goodstype=").append(goodstype);
  }
   	   if(rcreater!=null&&rcreater.length()>0)//按录入人员查询
	  {
	    sql.append(" AND n.rcreator LIKE ").append(DbAdapter.cite("%"+rcreater+"%"));
	    param.append("&rcreator=").append(rcreater);
	  }
  if(brand!=null&&brand.length()>0)
  {
    sql.append(" AND g.brand=").append(brand);
    param.append("&brand=").append(brand);
  }


  if((price1!=null&&price1.length()>0)||(price2!=null&&price2.length()>0))
  {
    from.append(",BuyPrice bp,Commodity c");
    sql.append(" AND c.commodity=bp.commodity AND c.goods=g.node");
    if((price1!=null&&price1.length()>0))
    {
      sql.append(" AND bp.price>=").append(price1);
      param.append("&price1=").append(price1);
    }
    if(price2!=null&&price2.length()>0)
    {
      sql.append(" AND bp.price<").append(price2);
      param.append("&price2=").append(price2);
    }
  }
  if(supplier!=null && supplier.length()>0)//供货商查询
  {
  		from.append(",Commodity c");
  		sql.append(" and c.goods=g.node");
  		sql.append(" and  goods in (select goods from Commodity where supplier = "+supplier+" )");
  		param.append("&supplier=").append(supplier);

  }
    if(productname!=null && productname.length()>0)//按商品名称查询
  {
  		from.append(",Nodelayer nl");
  		sql.append(" and n.node=nl.node");
  		sql.append(" AND nl.subject LIKE ").append(DbAdapter.cite("%"+productname+"%"));
  		param.append("&productname=").append(productname);

  }
  if(serialnumber!=null && serialnumber.length()>0)//货号的查询
  {
  		from.append(",Commodity c");
  		sql.append(" and c.goods=g.node");
  		sql.append(" and goods in (select goods from Commodity where serialnumber="+DbAdapter.cite(serialnumber)+")");
  		param.append("&serialnumber=").append(serialnumber);
  }
  if(q!=null&&q.length()>0)
  {
    from.append(",NodeLayer nl");
    /*
    String keys[]=q.split(" ");
    StringBuffer contains=new StringBuffer();
    contains.append("\"" ).append( keys[0] ).append( "\"");
    for(int index=1;index<keys.length;index++)
    {
      contains.append(" OR \"" ).append( keys[index] ).append( "\"");
    }
    sql.append(" AND nl.node=n.node AND (CONTAINS(nl.q,N'" ).append( contains.toString() ).append( "') OR CONTAINS(nl.content,N'" ).append( contains.toString() ).append( "'))");
    */
    sql.append(" AND nl.node=n.node AND ( nl.subject LIKE " ).append( DbAdapter.cite("%"+q+"%") ).append(" OR nl.content LIKE " ).append( DbAdapter.cite("%"+q+"%")).append( ")");
    param.append("&q=").append(q);
  }
  int count=0;
  int pos=0;
  int pageSize=25;
  if(teasession.getParameter("Pos")!=null)
  {
    pos=Integer.parseInt(teasession.getParameter("Pos"));
  }

String order=request.getParameter("order");
if(order==null)
order="n.node";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);




String nexturl=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"utf-8");
Community communitys=Community.find(teasession._strCommunity);



%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
</head>

<body id="bodynone">

<script src="<%=communitys.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></script>


<h1>商品查阅</h1>
<div id="head6"><img height="6" alt=""></div>

<form name="form1" action="?" method="get">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=_strId%>"/>

<h2>查询</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>时间：
 从&nbsp;
        <input id="time" name="time" size="7"  value="<%if(time!=null)out.print(time);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time');"> 
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.time');" />


</td>
<td nowrap >商品编号：<input name="number" value="<%if(number!=null)out.print(number);%>"></td>
<td nowrap >名称：<input name="productname" value="<%if(productname!=null)out.println(productname);%>"></td>
        <td>品牌:<select name="brand">
          <option value="" >----------</option>
          <%
          java.util.Enumeration enumer54313=tea.entity.node.Brand.findByCommunity(teasession._strCommunity,"",0,Integer.MAX_VALUE);
          while(enumer54313.hasMoreElements())
          {
            int id=((Integer)enumer54313.nextElement()).intValue();
            Brand obj=Brand.find(id);
            out.print("<option value="+obj.getBrand());
            if(String.valueOf(id).equals(brand))
            out.print(" SELECTED ");
            out.print(" >"+obj.getName(teasession._nLanguage));
          }%>
        </select><input type="button" value="..." onclick="window.open('/jsp/type/brand/DialogBrand.jsp?community=<%=teasession._strCommunity%>&field=form1.brand','','height=500,width=550,scrollbars=yes');"/>
        </td>

        </tr>

        <tr>
        <td nowrap>录入人员<select name="rcreator" style="width:120"><option value="" >----------------</option>
        <%
        DbAdapter db1=new DbAdapter();
        try
        {
          db1.executeQuery("SELECT rcreator,COUNT(*) FROM Node WHERE community="+DbAdapter.cite(teasession._strCommunity)+" AND type=34 GROUP BY rcreator");
          while(db1.next())
          {
            String str=db1.getString(1);
            int co=db1.getInt(2);
            out.print("<option value="+str);
            if(str.equals(rcreater))
            out.print(" SELECTED ");
            out.print(" >"+str+" ( "+co+" )");
          }
        }finally
        {
          db1.close();
        }
        %></select></td>
        <td nowrap>供应商<select name="supplier" ><option value="" >----------</option>
        <%
        Enumeration e_s=Supplier.findByCommunity(teasession._strCommunity);
        while(e_s.hasMoreElements())
        {
          int id=((Integer)e_s.nextElement()).intValue();
          Supplier obj=Supplier.find(id);
          out.print("<option value="+id);
          if(String.valueOf(id).equals(supplier))
          out.print(" SELECTED ");
          out.print(" >"+obj.getName(teasession._nLanguage));
        }
        %>
        </select></td>

        <td><input type="submit" value="搜索"></td></tr>
</table>

</form>
<br>


<h2>列表 ( <span id=spancount>0</span> )</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR id="tableonetr">
    <td width="1">&nbsp;</td>
    <td>商品编号</td>
    <td>商品名称</td>
    <td>类型</td>
    <td>品牌</td>
    <td>录入人员</td>
    <td>供应商</td>
    <td>人气</td>
    <td>时间</td>

</tr>
<%

DbAdapter db=new DbAdapter();
try
{
  count=  db.getInt("SELECT DISTINCT COUNT( n.node ) "+from.toString()+sql.toString());

  sql.append(" ORDER BY ").append(order).append(" ").append(desc);

  db.executeQuery("SELECT DISTINCT n.node "+from.toString()+sql.toString());
   //out.print("SELECT DISTINCT n.node "+from.toString()+sql.toString());

  for (int index = 0; index < pos + pageSize && db.next(); index++)
  {
    if (index >= pos)
    {
      int id=db.getInt(1);
      Node node=Node.find(id);
      String subject=node.getSubject(teasession._nLanguage);

      Goods g=Goods.find(id);
       Profile probj = Profile.find(  node.getCreator().toString());
      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td width="1"><%=index+1%></td>
        <td><%=node.getNumber() %></td>
        <td>
          <A href="/servlet/Goods?Node=<%=id%>" ><%=subject%></A>
        </td>
        <td><%=Node.find(node.getFather()).getSubject(teasession._nLanguage)%></td>
        <td>&nbsp;<%
        Brand b=null;
        if(g.getBrand()>0&&(b=Brand.find(g.getBrand())).isExists())
        {
          if(b.getNode()>0)
          out.print("<a target=_blank href=/servlet/Node?Node="+b.getNode()+">");
          out.print(b.getName(teasession._nLanguage)+"</a>");
        }
        %></td>

        <td><%=probj.getLastName(teasession._nLanguage)+probj.getFirstName(teasession._nLanguage) %></td>
        <%
           int i=Commodity.findSupplierByGoods(node._nNode);
           Supplier obj2=Supplier.find(i);
           //System.out.println(obj2.getName(teasession._nLanguage));
         %>
        <td><%=obj2.getName(teasession._nLanguage) %></td>
          <td><%=node.getClick()%></td>
        <td><%=node.getTimeToString()%></td>

      </tr>
      <%
      }
    }
}catch(Exception e)
{
  e.printStackTrace();
}finally
{
  db.close();
}

%>
</table>
<%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param.toString() + "&Pos=", pos, count)%>

<div id="head6"><img height="6" alt=""></div>


<script src="<%=communitys.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></script>




<script>spancount.innerHTML="<%=count%>";</script>
</body>
</html>
