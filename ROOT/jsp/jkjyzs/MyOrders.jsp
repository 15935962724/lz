<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.node.NReview"%>
<%@page import="tea.entity.node.Book"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.order.OrderDedail"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="java.util.Enumeration"%>
<%@page import="tea.entity.order.Order"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<script src="/tea/mt.js" type="text/javascript"></script>
<%
	Http h = new Http(request);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}
StringBuffer par=new StringBuffer();
StringBuffer sql=new StringBuffer(" and submit_men="+DbAdapter.cite(Profile.find(h.username).getMobile()));
int pos=h.getInt("pos", 0);
par.append("?pos=");
int size=10;
String community=h.get("community",h.community);
sql.append(" AND o.community = "+DbAdapter.cite(community));
par.append("&community="+community);
if("POST".equals(request.getMethod())){
	String act =h.get("act", "");
	int id=h.getInt("id", 0);
	Order order=Order.find(id);
	int status=h.getInt("status");
	String content=h.get("content");
	if("cancel".equals(act)){
		if(id>0){
		order.set("status", String.valueOf(8));
		order.set("cancel_man", h.username);
		order.set("cancel_time",new Date());
		out.print("<script>mt.show('取消订单成功！')</script>");
		}
	}
	if("fillin".equals(act)){
		if(id>0){
			order.set("moneyOrder", h.get("moneyOrder"));
		order.set("status", String.valueOf(3));
		out.print("<script>mt.show('填写汇款单号成功！')</script>");
		}
	}
	if("confirm".equals(act)){
		if(id>0){
		order.set("status", String.valueOf(6));
		out.print("<script>mt.show('确认收货成功！')</script>");
		}
	}
	if("search".equals(act)){
		if(status>0){
			if(status==6){
				sql.append(" and status in(6,7)");
			}else{
				sql.append(" and status="+status);
			}
			
		}
		if(content.length()>0&&!"订单号、商品名称".equals(content)){
		sql.append(" and code="+DbAdapter.cite(content)+" or code in(select saleordercode from saleorderdedail where goodstitle like '%"+content+"%')");
		}
		
	}
}
int sum=Order.count(sql.toString());
sql.append(" order by status asc,submit_time desc");
%>

<form method="post" action="?" name="form1">
<input type="hidden" name="act" value="search">
<table class="search" cellpadding="0" cellspacing="0">
  <tr>
    <td>
    	<select name="status">
        	<option value="0">订单状态</option>
            <option value="1">等待计算运费</option>
            <option value="2">待汇款</option>
            <option value="3">已汇款</option>
            <option value="4">已确认汇款</option>
            <option value="5">已发货</option>
            <option value="6">完成交易</option>
            <option value="8">已取消</option>
        </select>
    </td>
    <td align="right">
    	<input id="searchKey" type="text" name="content" value="订单号、商品名称" onfocus="if(value=='订单号、商品名称') {value=''}" onblur="if (value=='') {value='订单号、商品名称'}" class="text"/><input type="submit" class="button" value="搜索" />
    </td>
  </tr>
  
</table>
</form>
<form method="post" action="?" name="form2">
<input type="hidden" name="nexturl" value="/html/jskxcbs/folder/14010980-1.htm">
<input type="hidden" name="act">
<input type="hidden" name="id">
<input type="hidden" name="moneyOrder">


<table cellpadding="0" cellspacing="0" class="myorders">
	<tr>
		<th>订单编号</th>
		<th>提交时间</th>
		<th>收货人</th>
		<th>订单金额</th>
		<th>运费金额</th>
		<th>总金额</th>
		<th>订单状态</th>
		<th>操作</th>
	</tr>
	   
		<%
		if(sum<1){out.print("<tr><td colspan='20' align='center'>暂无记录！</td></tr>");}
			Enumeration e = Order.find(sql.toString(),pos,size);
			for (int i = 0; e.hasMoreElements(); i++) {
				int id = ((Integer) e.nextElement()).intValue();
				Order o = Order.find(id);
				OrderDedail od=OrderDedail.find(id);
		%>
		<tr bgcolor="#E5E5E5">
		<td><a href="#" onclick=mt.act('view',"<%=o.getId() %>")><%=o.getCode() %></a></td>
		<td><%=MT.f(o.getSubmitTime(),1) %></td>
		<td><%=o.getCustomer() %></td>
		<td><%=o.getTotalMoney() %></td>
		<td><%=o.getStatus()==1?"":o.getFreight() %></td>
		<td><%=o.getTotalMoney().add(o.getFreight()) %></td>
		<td><%=Order.ORDER_STATE2[o.getStatus()] %></td>
		<td>
		<a href="#" onclick=mt.act('view',"<%=o.getId() %>")>订单明细</a>
		<%
		if(o.getStatus()==1){out.print(" <a href='#' onclick=mt.act('cancel','"+o.getId()+"')>取消订单</a>");}
		else if(o.getStatus()==2){out.print(" <a href='#' onclick=mt.act('fillin','"+o.getId()+"')>填写汇款单号</a> <a href='#' onclick=mt.act('cancel','"+o.getId()+"')>取消订单</a>");}
		else if(o.getStatus()==5){out.print(" <a href='#' onclick=mt.act('confirm','"+o.getId()+"')>确认收货</a>");}
		
		%>
		</td>
	</tr>
	
	
		<%
			}
		%>
	
</table>

<div class="fy">
<%=new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,size) %>
</div>


</form>
<script type="text/javascript">
mt.act=function(a,id){
	form2.act.value=a;
	form2.id.value=id;
	if(a=='view'){
		mt.show("/jsp/book/OrderView.jsp?id="+id,1,"订单明细",600,590);
	}
	if(a=='cancel'){
		mt.show("您确定要取消订单吗？",2);
		mt.ok=function(){
			form2.submit();
		}
	}
	if(a=='fillin'){
		mt.show("<font color='#FF8C00'>请仔细核对汇款单号，确认无误后再点击确定，谢谢合作</font><form name='form4'>汇款单号:<input type='text' name='moneyOrder'></form>",2,"填写汇款单号");
		mt.ok=function(){
			var v=form4.moneyOrder.value;
			if(v.length<1){
				parent.mt.close();
				alert('汇款单号不能为空！');
			}else{
				form2.moneyOrder.value=v;
				form2.submit();
			}
			
		}
		
	}
	if(a=='confirm'){
		mt.show("请确定已经收到此货物再点击确定！",2);
		mt.ok=function(){
			form2.submit();
		}
	}
	if(a=='evaluation'){
		mt.show("/jsp/book/NReviewEdit.jsp?node="+id+"&nexturl=/html/jskxcbs/folder/14010980-1.htm",1,"我要评价",500,320);
		
	}
}
</script>

