<%@page import="java.math.BigDecimal"%>
<%@page import="tea.entity.node.Book"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 Http h=new Http(request,response);
if(h.member<1)
{
	//response.sendRedirect("/html/jskxcbs/folder/14010780-1.htm");
  request.getRequestDispatcher("/html/jskxcbs/folder/14010780-1.htm").forward(request, response);
  return;
}
%>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
<script>

</script>
<ul class="Order_cart" id="Order_cart_S2">
	<li class="step1">1.我的购物车</li>
	<li class="step2">2.填写核对订单信息</li>
	<li class="step3">3.成功提交订单</li>
    <!--<li class="step4">4.填写汇款</li>
    <li class="step5">5.补充付款信息</li>
    <li class="step6">6.确认收货</li>-->
</ul>
<span class="tip"><span class="span1">提示：</span>提交订单完成后，请将图书总计金额汇款到<span class="span1">中国工商银行北京厢红旗支行</span>，卡号<span class="span1">0200004509008681215</span>，汇款成功后，将汇款单号提交到我的订单中补充付款信息，完成订单。填写完补充付款信息后，我们的工作人员将在24小时之内电话和Email予以确认，确认之后，我们将进行订单处理。您的订单重复提交或您填写的收货地址的信息不准确时，我们会尽快与您取得联系。</span>

<div class="title"><p>填写并核对订单信息</p></div>
<div class="conten">
<div class="PersonMsg">
<h1>收货人信息</h1>
<iframe src="/jsp/book/PersonMsg.jsp" frameborder="0" width="100%" height="245px" allowTransparency></iframe>
</div>
<div class="InvoiceMsg">
<h1>发票信息</h1>
<iframe src="/jsp/book/InvoiceMsg.jsp" frameborder="0" width="100%" height="120px" allowTransparency></iframe>

</div>
<div class="OrderList">
<h1>商品清单</h1>

<table class="cart" cellpadding="0" cellspacing="0">
<tr>
  <th>商品编号</th>
  <th>商品图片</th>
  <th>商品名称</th>
  <th>商品价格</th>
  <th>商品数量</th>
</tr>
<%
BigDecimal totalmaney=new BigDecimal(0);
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
    totalmaney=totalmaney.add(b.getPrice().multiply(new BigDecimal(Integer.valueOf(arr[1]))));
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td class="td1">&nbsp;<%=b.getISBN()%></td>
    <td class="td1"><a href="<%=url%>"><img width="30px" height="45px" src="<%=b.getSmallPicture(h.language) %>"></a></td>
    <td class="td1" style="color:#11844B;"><a href="<%=url%>"><%=n.getSubject(h.language)%></a></td>
    <td class="price"><%=b.getPrice()%></td>
    <td class="td2"><%=arr[1]%></td>
    
  </tr>
  <%}
}
%>
</table>
<style>

</style>
</div>
<div class="Or">
    <!-- <p>重量总计：<span id="gross">0.00</span>kg　原始金额：￥<span id="price">0.00</span>元 - 返现：￥0.00元</p> -->
    <p><b>商品总金额：￥<span id="total"><%=totalmaney %></span>元</b></p>
    <div class="EmptyCart" style="position:relative;">
    	<form action="/Orders.do" method="post" name="form1" >
<input type="hidden" value="<%=totalmaney %>" name="totalmaney">
<input type="hidden" value="submit" name="act">
<input type="hidden" value="<%=h.community %>" name="community">
<input type="hidden" value="<%=h.get("nexturl","/html/jskxcbs/folder/14010055-1.htm") %>" name="jinexturl">
<input type="hidden" value="/html/jskxcbs/folder/14020022-1.htm" name="nexturl">
<input type="button" class="Order2" onclick=mt.sub() value="提交订单" />
</form>
<script type="text/javascript">
mt.sub=function(){
	sendx("/Orders.do?act=verify",
			function(data)
			 {
				if(data=="suc"){
					form1.submit();
				}else{
					mt.show(data);
				}
               
			 }
	);
}
</script>
    </div>
</div>
</div>
