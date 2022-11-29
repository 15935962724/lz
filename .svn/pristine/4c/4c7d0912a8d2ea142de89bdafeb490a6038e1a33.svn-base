<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="java.util.Enumeration"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.entity.order.Order"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/jquery.js" type="text/javascript"></script>
<%
Http h=new Http(request);
if(h.username==null){
	response.sendRedirect("");
	return;
}
StringBuffer par=new StringBuffer();
StringBuffer sql=new StringBuffer(" and submit_men="+DbAdapter.cite(h.username));
int pos=h.getInt("pos", 0);
par.append("?pos=");
sql.append(" and code like "+DbAdapter.cite("FT%"));
int size=10;

if("POST".equals(request.getMethod())){
	String act =h.get("act", "");
	int id=h.getInt("id", 0);
	Order order=Order.find(id);
	int status=h.getInt("status");
	String content=h.get("content");
	if("cancel".equals(act)){
		if(id>0){
		order.set("status", String.valueOf(3));
		order.set("cancel_man", h.username);
		order.set("cancel_time",new Date());
		out.print("<script>alert('取消订单成功！')</script>");
		}
	}
}
int count=Order.count(sql.toString());
sql.append(" order by status asc,submit_time desc");
SimpleDateFormat sf1 = new SimpleDateFormat("HH:mm");
Enumeration e= Order.find(sql.toString(), pos, size);
%>
<form action="?" method="post" name="form2">
<input type="hidden" name="act">
<input type="hidden" name="id">
<%if(e.hasMoreElements()){
	while(e.hasMoreElements()){
		  int id=(Integer)e.nextElement();
		  Order o=Order.find(id);
		  %>
		  <div class="olist">
				<div class="first">
		  <span id="time"><%=MT.f(o.getReserveTime())+" "+sf1.format(o.getBeginTime())+"-"+sf1.format(o.getEndTime()) %></span>
		  <span id="num"><%=o.getPersonNum() %>人</span>
		  <span id="price">￥<%=o.getTotalMoney() %></span>
		  </div>
		   <div class="cend">
		   <span class="subtime">下单时间:</span><span id="date"><%=MT.f(o.getSubmitTime()) %></span>
		   <span id="paytype"><%=Order.ORDER_PAYTYPE[o.getPayType()] %></span>
		   <span id="botn">
		   <% 
		   if(o.getStatus()==1&&o.getIsPay()==0){
			   out.print("<p class='status'>未付款</p>");
			   if(o.getPayType()==0){
				   out.print("<a href='' class='a1' >去结算</a> "); 
			   } 
			   out.print(" <a href='###' onclick=mt.act('cancel','"+o.getId()+"') class='a2'>取消订单</a>");
		   }else if(o.getStatus()==1&&o.getIsPay()==1){
			   out.print("<p class='status'>已付款</p>");
			   out.print(" <a href='###' onclick=mt.act('cancel','"+o.getId()+"')>取消订单</a>");
		   }else if(o.getStatus()==2&&o.getIsPay()==1){
			   out.print("<p class='status'>已完成</p>");
		   }else if(o.getStatus()==3){
			   out.print("<p class='status'>已取消</p>");
		   }
		   %>
		   </span>
		   </div>
		  </div>
		  <%
	  }
}else{
	out.print("暂无记录！");
}
  
%>
<div id="PageNum">
<%=new tea.htmlx.FPNL(h.language, par.toString(), pos, count,size) %>
<script> var as=document.getElementById('PageNum').getElementsByTagName('A'); for(var i=0;i<as.length;i++) {   if(/\d/.test(as[i].innerHTML))as[i].style.display='none'; } </script>
</div>
</form>
<script type="text/javascript">
mt.act=function(a,id){
	form2.act.value=a;
	form2.id.value=id;
	if(a=='cancel'){
		if(confirm("您确定取消订单吗？")){
			form2.submit();
		}
	}
}
</script>