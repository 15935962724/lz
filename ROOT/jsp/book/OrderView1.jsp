<%@page import="tea.entity.node.Book"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.order.Order"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="java.util.List"%>
<%@page import="tea.entity.order.OrderDedail"%>
<%@page import="tea.entity.util.Card"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	Http h = new Http(request);
    if(h.member<1){
    	response.sendRedirect("/servlet/StartLogin?node="+h.node);
    	 return;
    }
	int id = h.getInt("id", 0);
%>
<style>
p{padding:0px;margin:0px;}
/*.OrderView{position:fixed;top:-1px;width:600px;background-color: rgb(255, 255, 255);z-index:4597429;font-size:13px; background-position:initial initial;background-repeat: initial initial;}*/
.OrderView p.p1{width:580px;float:left;font-size:12px;font-weight:bold;color:#333333;line-height:30px;}
.OrderView .xian{width:580px;float:left;display:block;color:#333333;border-top:1px solid #EDEDED;border-bottom:1px solid #EDEDED;margin:5px 0px;padding-bottom:5px;}
.OrderView .xian span{line-height:22px;}
.OrderView table.permsg{width:100%;float:left;font-size:12px;color:#313140;}
.OrderView table.permsg td{line-height:22px;}
.OrderView table.msg{width:100%;float:left;font-size:12px;color:#313140;}
.OrderView table.msg td{line-height:22px;}
.OrderList table.cart{width:580px;float:left;font-size:12px;margin-top:5px;border:1px #DEDEDE solid;border-bottom:none;}
.OrderList table.cart a{color:#11844B; text-decoration:none;}
.OrderList table.cart td{padding:5px 0px;}
.OrderList table.cart td.td1{border-bottom:1px #DEDEDE solid;border-right:1px #F0F0F0 solid;}
.OrderList table.cart td.td2{border-bottom:1px #DEDEDE solid;}
.OrderList table.cart td.price{border-bottom:1px #DEDEDE solid;border-right:1px #F0F0F0 solid;color:#FF0000;}
.OrderList table.cart td.td1 a img{padding:3px 15px;border:1px solid #f0f0f0;}

.OrderList table.cart tbody th{font-size:12px;font-weight:lighter;background:#EEEEEE;height:30px;line-height:20px;}
.OrderList table.cart tbody tr{border-bottom:1px solid #ccc;border-top:1px solid #ccc;text-align:center;}
.OrderList table.cart tbody tr.tr1{border:none;}

.Or{width:580px;float:left;padding:10px 0px 10px 0px;font-size:14px;}
.Or p{width:50%;float:right;display:block;clear:both;height:25px;line-height:25px;font-weight:bold;}
.Or b{line-height:22px;}
.Or p span{float:left;display:block;}
.Or p span.b1{color:#FFA500;font-size:12px;}
.Or p span.b2{color:#FF003B;}
.Or p span.span1{width:180px;text-align:right;}
.Or .EmptyCart{width:100%;float:left;text-align:right;}
/*.Or table#or{width:80%;float:right;}
.Or table#or td{font-weight:bold;font-weight:14px;text-align:right;}
.Or table#or td.b2{color:#FF003B; text-align:left;}
.Or table#or td.b1{color:#FFA500;font-size:12px; text-align:left;}
*/</style>
<div class="OrderView">
<%
	if (id > 0) {
		Order o=Order.find(id);	
%>
<p class="p1">基本信息</p>
<table class="msg">
	<tr>
		<td><span class="span1">订单单号：</span> <%=MT.f(o.getCode())%></td>
		<td><span class="span1">提交时间：</span> <%=MT.f(o.getSubmitTime(),1)%></td>
	</tr>
	<tr>
		<td><span class="span1">订单状态：</span> <%=Order.ORDER_STATE1[o.getStatus()] %></td>
		<td><span class="span1">订单总额：</span> <%=o.getTotalMoney().add(o.getFreight())%>（含运费<%=o.getFreight()%>）元</td>
	</tr>
	<%if(o.getStatus()>1&&o.getStatus()<8){ %>
	<tr>
		<td><span class="span1">填运费人：</span> <%=MT.f(o.getFreighMan())%></td>
		<td><span class="span1">填运费时间：</span> <%=MT.f(o.getFreightTime(),1)%></td>
	</tr>
	<%}if(o.getStatus()>3&&o.getStatus()<8){%>
	<tr>
		<td><span class="span1">确认付款人：</span> <%=MT.f(o.getPayee())%></td>
		<td><span class="span1">确认付款时间：</span> <%=MT.f(o.getPayeeTime(),1)%></td>
	</tr>
	<%}if(o.getStatus()>4&&o.getStatus()<8){%>
	<tr>
		<td><span class="span1">发货人：</span> <%=MT.f(o.getSendMan())%></td>
		<td><span class="span1">发货时间：</span> <%=MT.f(o.getSendTime(),1)%></td>
	</tr>
	<%}if(o.getStatus()>6&&o.getStatus()<8){%>
	<tr>
		<td><span class="span1">完成人：</span> <%=MT.f(o.getCompleteMan())%></td>
		<td><span class="span1">完成时间：</span> <%=MT.f(o.getCompleteTime(),1)%></td>
	</tr>
	<%}if(o.getStatus()>7){%>
	<tr>
		<td><span class="span1">取消人：</span> <%=MT.f(o.getCancelMan())%></td>
		<td><span class="span1">取消时间：</span> <%=MT.f(o.getCancelTime(),1)%></td>
	</tr>
	<%}%>
	<tr>
		
	</tr>

</table>
<p class="p1">收货人信息</p>
<table class="permsg">
	<tr>
		<td><span class="span1">收货人：</span> <%=o.getCustomer()%></td>
	</tr>
	<tr>
		<td><span class="span1">详细地址：</span><script>mt.city(<%=o.getCity()%>)</script>&nbsp;&nbsp;<%=o.getAddress()%></td>
	</tr>
	<tr>
		<td><span class="span1">手机号码：</span> <%=o.getMobile()%></td>
		<%-- 或&nbsp;&nbsp;固定电话<%=p.getPTelephone(h.language)%> --%>
	</tr>
	<tr>
		<td><span class="span1">邮箱：</span> <%=o.getEmail()%></td>
	</tr>

</table>
<div class="xian">
<p class="p1">发票信息</p>
<%
if(o.getIsInvoive()==1){
%>

<span class="span1" style="font-size: 12px;">发票类型：<%=Profile.INVOIVE_TYPE[o.getInvoiveType()-1] %>&nbsp;&nbsp;&nbsp;<%=o.getInvoiveType()==2?o.getUnitName():"" %></span>
<br>
<span class="span1" style="font-size: 12px;">发票内容：<%=Profile.INVOIVE_CONTENT[o.getInvoiveContent()-1] %></span>
<%	
}else{%>
<font style="font-size: 12px;">不开发票</font>
<%	
}
%>
</div>
<div class="OrderList">
	<p class="p1">商品清单</p>

	<table class="cart" cellpadding="0" cellspacing="0">
		<tr>
			<th>商品编号</th>
			<th>商品图片</th>
			<th>商品名称</th>
			<th>商品单价</th>
			<th>商品数量</th>
		</tr>
		<%
		List<OrderDedail> list=OrderDedail.findByOrderId(id);
		
        for(int i=0;i<list.size();i++){
        	OrderDedail od=(OrderDedail)list.get(i);
        	Book b=Book.find(od.node);
        	Node n=Node.find(od.node);
        	String url = "/html/jskxcbs/folder/14011316-1.htm?node="
        			+ n._nNode;
  %>
		<tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
			<td class="td1">&nbsp;<%=od.getGoodsCode()%></td>
			<td class="td1"><a href="<%=url%>"><img width="30px"
					height="45px" src="<%=b.getSmallPicture(h.language) %>"></a></td>
			<td class="td1" style="color: #11844B;"><a href="<%=url%>"><%=n.getSubject(h.language)%></a></td>
			<td class="price"><%=od.getMoney()%></td>
			<td class="td2"><%=od.getNum()%></td>

		</tr>
		<%
        }
%>
	</table>
</div>

<%
	}
%>
</div>