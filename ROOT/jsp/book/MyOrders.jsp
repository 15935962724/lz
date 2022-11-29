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
	request.getRequestDispatcher("/html/jskxcbs/folder/14010780-1.htm").forward(request, response);
  return;
}
StringBuffer par=new StringBuffer();
StringBuffer sql=new StringBuffer(" and submit_men="+DbAdapter.cite(h.username));
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
		%>
		<tr bgcolor="#E5E5E5">
		<td><a href="#" onclick=mt.act('view',"<%=o.getId() %>")><%=o.getCode() %></a></td>
		<td><%=MT.f(o.getSubmitTime(),1) %></td>
		<td><%=o.getCustomer() %></td>
		<td><%=o.getTotalMoney() %></td>
		<td><%=o.getStatus()==1?"<font color='#FFA500'><a href='#' style='color:#FFA500' onclick=mt.show('尊敬的客户"+h.username+"，您好！您的订单正在计算运费中，请耐心等候.')>计算运费中..</a></font>":o.getFreight() %></td>
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
		List<OrderDedail> list=OrderDedail.findByOrderId(id);
		
        for(int j=0;j<list.size();j++){
        	OrderDedail od=(OrderDedail)list.get(j);
        	Node n=Node.find(od.node);
        	Book b=Book.find(od.node);
        	String url = "/html/jskxcbs/folder/14011316-1.htm?node="
        			+ n._nNode;
  %>
		<tr>
			<td class="td1">&nbsp;<%=od.getGoodsCode()%></td>
			<td class="td1"><a href="#" onclick="parent.mt.close();location='<%=url%>';"><img width="30px"
					height="45px" src="<%=b.getSmallPicture(h.language) %>"></a></td>
			<td class="td1" style="color: #11844B;" colspan="3"><a href="<%=url%>"><%=n.getSubject(h.language)%></a></td>
			<td class="price"><%=od.getMoney()%></td>
			<td class="td2"><%=od.getNum()%></td>
			<td><%if(o.getStatus()==6&&NReview.count(" and node="+od.node+" and member="+h.member)==0){out.print(" <a href='#' onclick=mt.act('evaluation','"+od.node+"')>我要评价</a>");} %></td>

		</tr>
		<%
        }
%>
	
	
		<%
			}
		%>
	
</table>

<div class="fy">
<%=new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,size) %>
</div>
<div class="bank">
    <table class="bank1" cellpadding="0" cellspacing="0">
      <tr>
        <td class="td1">银行汇款方式：</td>
        <td class="td1">邮局汇款方式：</td>
      </tr>
      <tr>
        <td>开户名称：军事科学出版社</td>
        <td>地&nbsp;&nbsp;&nbsp;&nbsp;址：北京海淀区厢红旗军事科学出版社</td>
      </tr>
      <tr>
        <td>地&nbsp;&nbsp;&nbsp;&nbsp;址：北京市海淀区青龙桥军事科学院</td>
        <td>收款人：出版社发行部</td>
      </tr>
      <tr>
        <td>邮&nbsp;&nbsp;&nbsp;&nbsp;编：100091</td>
        <td>邮&nbsp;&nbsp;&nbsp;&nbsp;编：100091</td>
      </tr>
      <tr>
        <td>开户行全称：中国工商银行北京厢红旗支行</td>
        <td>电&nbsp;&nbsp;&nbsp;&nbsp;话：010-66768544</td>
      </tr>
      <tr>
        <td>税&nbsp;&nbsp;&nbsp;&nbsp;号：110108801976265</td>
        <td>注明邮购姓名、电话、书名、册数、收货地址</td>
      </tr>
      <tr>
        <td>帐&nbsp;&nbsp;&nbsp;&nbsp;号：0200004509008681215 </td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>电&nbsp;&nbsp;&nbsp;&nbsp;话：010-66768544</td>
        <td>&nbsp;</td>
      </tr>
    </table>
</div>
<table class="bank1" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="2" class="td1">联系方式：</td>
  </tr>
  <tr>
    <td colspan="2">传&nbsp;&nbsp;&nbsp;&nbsp;真：（0201）768547 (军线)<br />
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（010）66768547（地方线）</td>
  </tr>
  <tr>
    <td colspan="2">电&nbsp;&nbsp;&nbsp;&nbsp;话：（0201）768547、767216（军线）<br />
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;62882626、66767216（地方线）</td>
  </tr>
  <tr>
    <td colspan="2">发行部主任： 高斌</td>
  </tr>
  <tr>
    <td colspan="2">发行业务联系人：郝虎虎  &nbsp;刘丹 &nbsp; 李国军&nbsp;  杜丰果 </td>
  </tr>
</table>

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

