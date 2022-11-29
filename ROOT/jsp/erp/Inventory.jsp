<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.erp.*" %>
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
String nexturl = request.getRequestURI()+"?"+request.getContextPath();

StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&nexturl=").append(java.net.URLEncoder.encode(nexturl,"UTF-8"));

int waridname = 0;
if(teasession.getParameter("waridname")!=null && teasession.getParameter("waridname").length()>0)
{
  waridname = Integer.parseInt(teasession.getParameter("waridname"));
}
if(waridname>0)
{
  sql.append(" AND warname =").append(waridname);
  param.append("&warname=").append(waridname);
}

String subject = teasession.getParameter("subject");
if(subject!=null && subject.length()>0)
{
   sql.append(" AND goods in (SELECT node FROM NodeLayer WHERE subject LIKE '%"+subject+"%')");
   param.append("&subject=").append(java.net.URLEncoder.encode(subject,"UTF-8"));
}


int brand = 0;
if(teasession.getParameter("brand")!=null && teasession.getParameter("brand").length()>0)
{
  brand = Integer.parseInt(teasession.getParameter("brand"));
}
if(brand>0)
{
  sql.append(" AND goods in (").append("SELECT node FROM Goods WHERE brand =").append(brand).append(")");
  param.append("&brand=").append(brand);
}
String spec = teasession.getParameter("spec");
if(spec!=null && spec.length()>0)
{
  sql.append(" AND goods in (").append("SELECT node FROM Goods WHERE spec LIKE '%"+spec+"%'  ").append(")");
  param.append("&spec=").append(java.net.URLEncoder.encode(spec,"UTF-8"));
}
//库存数量
//int quantity = 0;
//if(teasession.getParameter("quantity")!=null && teasession.getParameter("quantity").length()>0)
//{
//  quantity  = Integer.parseInt(teasession.getParameter("quantity"));
//  sql.append(" AND quantity = ").append(quantity);
//  param.append("&quantity=").append(quantity);
//}


int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}

count = Inventory.count(teasession._strCommunity,sql.toString());
 String o=request.getParameter("o");
  if(o==null)
  {
    o="quantity";
  }
  boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
  sql.append(" ORDER BY ").append(o).append(" ").append(aq?"DESC":"ASC");
  param.append("&o=").append(o).append("&aq=").append(aq);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

<body >
<script type="">
 function f_order(v)
   {
     var aq=form1.aq.value=="true";
     if(form1.o.value==v)
     {
       form1.aq.value=!aq;
     }else
     {
       form1.o.value=v;
     }
     form1.action="?";
     form1.submit();
   }
   function f_show(igd)
   {

    var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:457px;dialogHeight:215px;';
    var url = '/jsp/erp/PurchaseShow.jsp?warid='+igd+'&act=cangku'
     var rs = window.showModalDialog(url,self,y);
   }
    function f_excel()
    {
      form1.act.value='Inventory';
      form1.action='/servlet/ExportExcel';
      form1.submit();
    }
</script>
<h1>库存管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" action="?" onsubmit="return f_submit();">
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="purid"/>
<input type="hidden" name="act"/>
 <input type="hidden" name="o" VALUE="<%=o%>">
  <input type="hidden" name="aq" VALUE="<%=aq%>">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
 <input type="hidden" name="sql" value="<%=sql.toString()%>">
<input type="hidden" name="files" value="库存统计表">
<h2>查询</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>仓库名称:&nbsp;
    <select name="waridname" class="lzj_huo">

       <option value="0">---------------</option>
       <%
          java.util.Enumeration e2 = Warehouse.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
          while (e2.hasMoreElements())
          {
            int warid = ((Integer)e2.nextElement()).intValue();
            Warehouse warobj = Warehouse.find(warid);
             out.print("<option value= "+warid);
             if(waridname==warid)
             {
               out.print(" selected");
             }
             out.print(">"+warobj.getWarname());
             out.print("</option>");
          }

       %>

      </select>
    </td>
    <td>商品名称:&nbsp;<input type="text" name="subject" value="<%if(subject!=null)out.print(subject);%>"></td>
    <td>商品品牌:&nbsp; <select name="brand">
     <option value="">-----</option>
     <%
       java.util.Enumeration be = Brand.findByCommunity(teasession._strCommunity,"",0,Integer.MAX_VALUE);
        while(be.hasMoreElements())
        {
          int bradnid = ((Integer)be.nextElement()).intValue();
           Brand bobj = Brand.find(bradnid);
           out.print("<option value="+bradnid);
           if(brand==bradnid)
           {
             out.print(" selected");
           }
           out.print(">"+bobj.getName(teasession._nLanguage));
           out.print("</option>");
        }
     %>
    </select></td>
    </tr>
    <tr>
    <td>商品规格:&nbsp;<input type="text" name="spec" value="<%if(spec!=null)out.print(spec);%>"></td>

    <td><input type="submit" value="查询"/></td>
  </tr>
</table>
<h2>列表(<%=count%>)</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap><a href="javascript:f_order('warname');">仓库名称</a>
     <%
          if(o.equals("warname"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %>
    </td>
    <td nowrap><a href="javascript:f_order('goods');">商品名称</a>
     <%
          if(o.equals("goods"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
    <td nowrap><a href="javascript:f_order('goods');">商品品牌</a>
     <%
          if(o.equals("goods"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
    <td nowrap><a href="javascript:f_order('goods');">商品规格</a>
     <%
          if(o.equals("goods"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
        <td nowrap><a href="#">商品销售价</a></td>
         <td nowrap>库存预警数量</td>
          <td nowrap><a href="javascript:f_order('quantity');">库存数量</a>
          <%
          if(o.equals("quantity"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>

    <td nowrap><a href="javascript:f_order('total');">商品总价</a>
     <%
          if(o.equals("total"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
          <td nowrap>操作</td>

  </tr>
<%

   java.util.Enumeration e = Inventory.find(teasession._strCommunity,sql.toString(),pos,pageSize);
   if(!e.hasMoreElements())
   {
      out.print("<tr><td colspan=10 align=center>暂没有库存记录</td></tr>");
   }
   int i =1;
   while(e.hasMoreElements()){
   int invid = ((Integer)e.nextElement()).intValue();
   Inventory iobj =Inventory.find(invid);
   Warehouse warobj = Warehouse.find(iobj.getWarname());
   Node nobj = Node.find(iobj.getGoods());

   Goods g=Goods.find(iobj.getGoods());
   Commodity cobj = Commodity.find_goods(iobj.getGoods());
   BuyPrice bpobj = BuyPrice.find(cobj.getCommodity(),1);
   //iobj.setTotal(teasession._strCommunity,iobj.getGoods(),iobj.getWarname());
   Brand b = Brand.find(g.getBrand());



%>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor='<%if(iobj.getQuantity()<=cobj.getMinQuantity()){out.print("red");}%>'" <%if(iobj.getQuantity()<=cobj.getMinQuantity()){out.print("bgcolor=red");}%>>
    <td ><a href="#" onclick="f_show('<%=iobj.getWarname()%>');" ><%=warobj.getWarname() %></a></td>
    <td><%if(nobj.getSubject(teasession._nLanguage)!=null)out.print(nobj.getSubject(teasession._nLanguage)); %></td>
    <td><%
             out.print(b.getName(teasession._nLanguage));
        %></td>
    <td><%=g.getSpec(teasession._nLanguage) %></td>
    <td><%=bpobj.getPrice() %></td>
       <td><%=cobj.getMinQuantity() %></td>
     <td><%=iobj.getQuantity() %></td>
    <td><%=iobj.setInvenTotal(teasession._strCommunity,iobj.getGoods(),iobj.getWarname())%></td>
    <td><a href="/jsp/erp/InventoryShow.jsp?warid=<%=iobj.getWarname()%>&nid=<%=iobj.getGoods()%>">查看商品库存明细</a></td>
  </tr>
<%i++;} %>
  <%if (count > pageSize) {  %>
   <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
  <%}  %>
  <%if(i>1){ %>
  <tr>
  <td colspan="6" align="right">总计</td>
  <td><%=Inventory.getQTotal(teasession._strCommunity,sql.toString())%></td>
  <td colspan="2"><%=Inventory.getTTotal(teasession._strCommunity,sql.toString()) %></td>
  </tr>
  <tr>
  <td colspan="9" align="center"><input type="button" value="导出Excel"  onclick="f_excel();"> </td>
  </tr>
<%} %>
</table>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<tr><td><b>注：</b>红色行表示库存预警颜色.</td></tr>
</table>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>


</body>
</html>
