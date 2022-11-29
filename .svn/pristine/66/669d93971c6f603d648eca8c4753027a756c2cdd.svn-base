<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.node.Book"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);


String nexturl=h.get("nexturl", "/html/jskxcbs/folder/14010055-1.htm"); 
int node =h.getInt("node", 14010055);


%><html><head>
<link href="/res/cssjs/base.css" rel="stylesheet" type="text/css"/>
<link href="/res/cssjs/my.css" rel="stylesheet" type="text/css"/>
<script src="/tea/view.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style type="text/css">
.cart input
{
width:38px;
text-align:center;
border:1px solid #C4C4C4;
float:left;cursor:pointer;
}
.qadd,.qsub
{
border:1px solid #C4C4C4;
line-height:8px;height:8px;float:left;
display:block;padding-right:3px;
width:12px;margin:0px 2px; 
}
.qadd
{
background:#FFF url(/tea/image/combo.gif) no-repeat 5px 3px;font-size:10px;
}
.qsub
{
background:#FFF url(/tea/image/combo.gif) no-repeat 5px -7px;float:left;margin-top:2px;
}

</style>
</head>
<body>
<%-- <%=s.header%> --%>
<div class="ShoppingCart">
<ul class="Order_cart" id="Order_cart_S1">
	<li class="step1">1.我的购物车</li>
	<li class="step2">2.填写核对订单信息</li>
	<li class="step3">3.成功提交订单</li>
</ul>
<div class="cartimg"></div>
<div class="carttitle">
<h2>我挑选的商品</h2>
<form name="fcar" action="/Favs.do" method="post" target="_ajax">
<input type="hidden" name="fav"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table class="cart" cellpadding="0" cellspacing="0">
<tr>
  <th>商品编号</th>
  <th>商品图片</th>
  <th>商品名称</th>
  <th>商品价格</th>
  <th>商品数量</th>
  <th>操作</th>
</tr>
<%
String[] ps=h.getCook("cart","|").split("[|]");
if(ps.length<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  for(int i=1;i<ps.length;i++)
  {
    String[] arr=ps[i].split("&");
    Node n=Node.find(Integer.parseInt(arr[0]));
    if(n.getTime()==null)continue;
    Book b=Book.find(n._nNode);
    String url = "/html/jskxcbs/folder/14011316-1.htm?node="
			+ n._nNode;
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td>&nbsp;<%=b.getISBN()%></td>
    <td><a href="<%=url%>"><img width="30px" height="45px" src="<%=b.getSmallPicture(h.language) %>"></a></td>
    <td style="color:#11844B;"><a href="<%=url%>"><%=n.getSubject(h.language)%></a></td>
    <td class="price"><%=b.getPrice()%></td>
   <td align="center" valign="middle" class="td_01"><div style="width:65px;margin:0px auto;height:25px;"><input name="quantity"  value="<%=arr[1]%>"  product="<%=ps[i]%>" price="<%=b.getPrice()%>" onChange="car.update(this)" style="height:22px;line-height:22px;"/><a class="qadd" href="javascript:;" onClick="car.update(this,true)">&nbsp;</a><a class="qsub" href="javascript:;" onClick="car.update(this,false)">&nbsp;</a></div></td>
    <td><a href="#" onClick="car.del(this,'<%=ps[i]%>','','<%=nexturl %>')">删除</a></td>
  </tr>
  <%}
}
%>
<tr><td colspan="10" align="right">
<!-- <p>重量总计：<span id="gross">0.00</span>kg　原始金额：￥<span id="price">0.00</span>元 - 返现：￥0.00元</p> -->
<p><b>商品总金额：￥<span id="total">0.00</span>元</b></p>
<div class="EmptyCart" style="position:relative;">
<a href="javascript:car.clear('<%=nexturl %>');" style="float:left;padding:0px 30px;color:#f00;position:absolute;top:-20px;right:200px;">清空购物车</a>
<input type="button" value="去提交订单" onClick="location='/html/jskxcbs/folder/14011380-1.htm?nexturl=<%=nexturl %>'"/>
<input type="button" value="继续购物" onClick="location='<%=nexturl %>'" style="background:url(/res/jskxcbs/structure/201401230932.png) center no-repeat;color:#535353;font-weight:lighter;"/>
</div>
</td></tr>
</table>
<!-- <a href="#" onClick="car.count()">ssss</a> -->
</form>

</div>
<div class="carttitle">
<%-- <h2><span class="left">我收藏的商品(现在就放入购物车吧！)</span><a href="/my/Favs.jsp">进入收藏夹>></a></h2>
<table cellspacing="0" cellpadding="0" class="favoritestable">
<%
Iterator it=Fav.findByMember(h.member,0,20).iterator();
if(!it.hasNext())
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  for(int i=0;it.hasNext();i++)
  {
    Fav t=(Fav)it.next();
    int id=t.fav;
    Product p=Product.find(t.product);
    if(p.time==null)continue;
    if(i%3==0)
	{
		if(i>0)out.print("</tr>");
		out.print("<tr>");
	}
    %>
      <td><img src="<%=p.getPicture('t')%>"/></td>
      <td><%=p.getAnchor(h.language)%><br/><span class="price"><%=MT.f(p.price)%></span><br/><input type="button" value="加入购物车" onClick="car.add(<%=p.product%>)"/></td>
  <%}
}
%></tr>
</table> --%>
</div>
<script>
car.update(null);
fcar.nexturl.value=location.pathname+location.search;
</script>
</div>
<%-- <%=s.footer%> --%>
</body>
</html>
