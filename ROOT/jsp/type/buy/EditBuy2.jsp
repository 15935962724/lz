<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.league.*" %><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
}

int cid = 0;
if(teasession.getParameter("cid")!=null&&teasession.getParameter("cid").length()>0)
{
  cid = Integer.parseInt(teasession.getParameter("cid"));
}
//设置价格的标示
String act = teasession.getParameter("act");
Commodity obj = Commodity.find(cid);

if("EditBuy2".equals(act))
{
  int supplier = Integer.parseInt(request.getParameter("Supplier"));//供货商
  //库存预警数量
  int minquantity = 0;
  if(teasession.getParameter("MinQuantity")!=null&&teasession.getParameter("MinQuantity").length()>0)
  {
    minquantity = Integer.parseInt(teasession.getParameter("MinQuantity"));
  }
  //进货价格
  java.math.BigDecimal list = new java.math.BigDecimal(teasession.getParameter("List"));
  //供货价格
  java.math.BigDecimal supply = new java.math.BigDecimal(teasession.getParameter("Supply"));
  //销售价格
  java.math.BigDecimal price = new java.math.BigDecimal(teasession.getParameter("Price"));

   if (cid >0)
   {
     obj.set(null, null, 0,0,minquantity, 0, 0,supplier, 0,0, teasession._nNode);
     BuyPrice buyprice = BuyPrice.find(cid, 1);
     buyprice.set(supply, list,price, null, null, null, 0, null, 0);
   } else
   {
       cid = Commodity.create("","",0,0,minquantity, 0, 0,supplier, 0,0, teasession._nNode);
       BuyPrice.create(cid, 1,supply, list,price, null, null, null, 0, null, 0);
   }
   out.print("<script>alert('供货商和价格设置成功'); window.returnValue=1;window.close();</script>");
   return;
}else if("delete".equals(act))
{
  BuyPrice bobj = BuyPrice.find(cid, 1);
  obj.delete();
  bobj.delete();
  out.print("供货商和价格删除成功");
  return;
}else if("f_submit".equals(act))
{
  int s = 0;
  if(teasession.getParameter("supplier")!=null && teasession.getParameter("supplier").length()>0)
  {
    s = Integer.parseInt(teasession.getParameter("supplier"));
  }
  int goods = 0;
  if(teasession.getParameter("goods")!=null && teasession.getParameter("goods").length()>0)
  {
    goods = Integer.parseInt(teasession.getParameter("goods"));
  }
  int cids = 0;
  if(teasession.getParameter("cids")!=null && teasession.getParameter("cids").length()>0)
  {
    cids = Integer.parseInt(teasession.getParameter("cids"));
  }
  if(cids==0){
    if(Commodity.isSupplier(s,goods))
    {
      out.print("已经有这个供货商的信息,不能重复添加");
    }
  }
  return;

}
int Supplier = 0,MinQuantity=0;
java.math.BigDecimal List = new java.math.BigDecimal("0.00");
java.math.BigDecimal Supply = new java.math.BigDecimal("0.00");
java.math.BigDecimal Price = new java.math.BigDecimal("0.00");
if(cid>0)
{
  BuyPrice bobj = BuyPrice.find(cid, 1);
  Supplier =obj.getSupplier();
  MinQuantity=obj.getMinQuantity();
  List = bobj.getList();
  Supply =bobj.getSupply();
  Price = bobj.getPrice();
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<script type="">
window.name='tar';
function f_submit()
{
  if(form1.Supplier.value==0)
  {
    alert('请选择供货商');
    form1.Supplier.focus();
    return false;
  }
    // 判断供货商不能重复提交
    sendx("/jsp/type/buy/EditBuy2.jsp?cids="+form1.cid.value+"&act=f_submit&supplier="+form1.Supplier.value+"&goods="+form1.node.value,
    function(data)
    {
      if(data.trim()!=null&&data.trim().length>0)
      {
        alert(data.trim());
        form1.Supplier.focus();
      }else
      {
         form1.submit();
      }
    }
    );
}
</script>
<h1>设置供货商和价格</h1>
<form action="?" method="POST" name="form1"  target="tar" onsubmit="f_submit(); return false;">
<input type="hidden" name="cid" value="<%=cid%>"/>
<input type="hidden" name="act" value="EditBuy2"/>
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
  <tr>
    <td nowrap>供货商:</td>
    <td>
    <%
    if(cid>0){
      out.print(tea.entity.admin.Supplier.find(Supplier).getName(teasession._nLanguage));
      out.print("<input type =hidden name=Supplier value="+Supplier+" >");
    }else{
    %>
      <select name="Supplier">
        <option value="0">------------</option>
        <%
        Node nobj = Node.find(teasession._nNode);
        String sss = nobj.getCommunity();
        java.util.Enumeration enumer=tea.entity.admin.Supplier.findByCommunity(sss);

        while(enumer.hasMoreElements())
        {
          int id=((Integer)enumer.nextElement()).intValue();
          tea.entity.admin.Supplier sobj=tea.entity.admin.Supplier.find(id);
          out.print("<OPTION VALUE="+id);
          if(id==Supplier)
          out.print(" SELECTED ");
          out.print(">"+sobj.getName(teasession._nLanguage));
        }
        %>
        </select>
        <%}%>
    </td>
    </tr>
    <tr>
      <td nowrap>库存预警数量</td>
      <td><input type="TEXT" class="edit_input"  name=MinQuantity VALUE="<%=MinQuantity%>" SIZE=6></td>
    </tr>
    <tr>
      <td nowrap>进货价</td>
      <td><input type="TEXT" class="edit_input"  name=List value="<%=List%>" size=6></td>
    </tr>
    <tr>
      <td nowrap>供货价</td>
      <td><input type="TEXT" class="edit_input"  name=Supply value="<%=Supply%>" size=6></td>
    </tr>
    <tr>
      <td nowrap>销售价</td>
      <td><input type="TEXT" class="edit_input"  name=Price value="<%=Price%>" size=6></td>
    </tr>
</table>
<br>

<input type="submit" value="提交" >&nbsp;
<input type="button" value="关闭"  onClick="javascript:window.close();">

</form>
<div id="head6"><img height="6" src="about:blank"></div>

</body>
</html>

