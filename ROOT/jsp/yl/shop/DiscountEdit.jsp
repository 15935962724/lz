<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int discount=h.getInt("discount");
Discount t=Discount.find(discount);




%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>商品折扣 添加/编辑</h1>

<form name="form1" action="/Discounts.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return f_check()">
<input type="hidden" name="discount" value="<%=discount%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>类型：</td>
    <td><%=h.radios(Discount.TYPE_NAME,"type",t.type)%></td>
  </tr>
  <tr>
    <td>范围：</td>
    <td>
      <input type="radio" name="cust" value="0" id="_cust0" onclick="f_cust(this)" checked="checked"/><label for="_cust0">全部</label>
      <input type="radio" name="cust" value="1" id="_cust1" onclick="f_cust(this)"/><label for="_cust1">自定义</label>
    </td>
  </tr>
  <tbody id="t_cust" style="display:none">
  <tr>
    <td>品牌：</td>
    <td><input type="button" onclick="tag='t_brand';mt.show('/jsp/yl/shop/BrandSel.jsp?brand='+mt.value(form1.brands,'|'),2,value,500,400);" value="选择品牌"/><div id="t_brand"><%
    String[] ab=t.brand.split("[|]");
    for(int i=1;i<ab.length;i++)
    {
      Brand b=Brand.find(Integer.parseInt(ab[i]));
      out.print("<span id='"+ab[i]+"'><input type='hidden' name='brands' value='"+ab[i]+"'/>"+b.name[1]+"<img src='/tea/image/d.gif' onclick='var p=parentNode;p.parentNode.removeChild(p);' />　</span>");
    }
    %></div></td>
  </tr>
  <tr>
    <td>类别：</td>
    <td><select name="category0" onchange="mt.load(this,0)"><option value="0">---请选择---</option>
<%
Iterator it=Category.findByFather(0).iterator();
while(it.hasNext())
{
  Category c=(Category)it.next();
  out.print("<option value="+c.category+">"+MT.f(c.name[1]));
}
%>
        </select>
        <select name="category1"><option value="0">---请选择---</option></select>
    </td>
  </tr>
  <tr>
    <td>商品：</td>
    <td><input type="button" onclick="tag='t_product';mt.show('/jsp/yl/shop/ProductSel.jsp?product='+mt.value(form1.products,'|'),2,value,500,400);" value="选择商品"/><div id="t_product"><%
    String[] ar=t.product.split("[|]");
    for(int i=1;i<ar.length;i++)
    {
      Product g=Product.find(Integer.parseInt(ar[i]));
      out.print("<span id='"+ar[i]+"'><input type='hidden' name='products' value='"+ar[i]+"'/>"+g.name[1]+"<img src='/tea/image/d.gif' onclick='var p=parentNode;p.parentNode.removeChild(p);' />　</span>");
    }
    %></div></td>
  </tr>
  </tbody>
  <tr>
    <td>折扣：</td>
    <td><input name="value" value="<%=MT.f(t.value)%>" alt="折扣" mask="int"/>折</td>
  </tr>
  <tr>
    <td>状态：</td>
    <td><%=h.radios(Discount.STATE_TYPE,"state",t.state)%></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>
var tag;
mt.receive=function(v,n,h)
{
  $(tag).innerHTML+=h;
}

//类别
mt.load=function(a,v)
{
  var t=form1.category1,op=t.options;
  while(op.length>1)op[1]=null;
  if(a.value=='0')return;
  mt.send('/Categorys.do?act=ajax&type=js&father='+a.value,function(h){eval(h);t.value=v;});
}
var t=form1.category0;
t.value="<%=Category.find(t.category).father%>";
mt.load(t,<%=t.category%>);

//类别
t=form1.type0;
t.style.display='none';
t=t.nextSibling;
t.style.display='none';

//自定义
function f_cust(a)
{
  $('t_cust').style.display=a.value=='0'?'none':'';
}
function f_check()
{
  if(form1.cust[1].checked)
  {
    if(!form1.brands&&form1.category1.value=='0'&&!form1.products)
    {
      mt.show("“品牌、类别、商品”至少要填写一项！");
      return false;
    }
  }
  return mt.check(form1);
}
form1.cust[<%=t.cust?1:0%>].click();


mt.focus(form1);
</script>

</body>
</html>
