<%@page import="tea.entity.order.Order"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="tea.entity.node.Book"%>
<%@page import="tea.entity.node.Node"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.sup.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}
String act=h.get("act","");
StringBuffer sql=new StringBuffer(),par=new StringBuffer();
int menuid=h.getInt("id");
par.append("?id="+menuid);
int status=h.getInt("status", 0);
if(status>0){
	sql.append(" and status="+status);
	par.append("&status="+status);
}
String community=h.get("community",h.community);
sql.append(" AND o.community = "+DbAdapter.cite(community));
par.append("&community="+community);
String code=h.get("code","");
if(code.length()>0)
{
  sql.append(" AND o.code LIKE "+DbAdapter.cite("%"+code+"%"));
  par.append("&code="+h.enc(code));
}
String submitmen=h.get("submitmen","");
if(submitmen.length()>0)
{
  sql.append(" AND o.submit_men LIKE "+DbAdapter.cite("%"+submitmen+"%"));
  par.append("&submitmen="+h.enc(submitmen));
}
Date beginDate=h.getDate("beginDate");
Date endDate=h.getDate("endDate");
if(beginDate!=null||endDate!=null)
{
  sql.append(" AND o.submit_time>="+DbAdapter.cite(beginDate)+" and o.submit_time<"+DbAdapter.cite(endDate));
  par.append("&beginDate="+beginDate+"&endDate="+endDate);
}
String beginmoney=h.get("beginmoney","");
String endmoney=h.get("endmoney","");
if(beginmoney.length()>0||endmoney.length()>0)
{
  sql.append(" AND o.total_money>="+DbAdapter.cite(beginmoney)+" and o.total_money<="+DbAdapter.cite(endmoney));
  par.append("&beginmoney="+beginmoney+"&endmoney="+endmoney);
}
String goodstitle=h.get("goodstitle","");
if(goodstitle.length()>0)
{
  sql.append(" and code in(select saleordercode from saleorderdedail where goodstitle like "+DbAdapter.cite("%"+goodstitle+"%")+")");
  par.append("&goodstitle="+h.enc(goodstitle));
}
int pos=h.getInt("pos");
par.append("&pos=");
int size=20;

int count=Order.count(sql.toString());
sql.append(" order by submit_time desc");
%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
</head>
<body>
<h1>订单列表</h1><!--列表-->
<div id="head6"><img height="6" src="about:blank"></div>

<!-- <h2>查询</h2> -->
<form name="form1" action="?" style="display:none" method="post">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="status" value="<%=status%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="td">订单编号：</td><td><input name="code" value=""/></td>
  <td class="td" >下单时间：</td><td><input name="beginDate" value="" id="time_c" style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_c');"/><img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');">至<input name="endDate" value="" id="time_d" style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_d');"/><img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');"></td>
  <td class="td" >订单总额：</td><td><input name="beginmoney" value="" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"/>至<input name="endmoney" value="" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"/></td>
</tr>
<tr>
  <td class="td">商品名称：</td><td><input name="goodstitle" value=""/></td>
  <td class="td">提交人：</td><td><input name="submitmen" value=""/></td>
 
  <td colspan="2"><input type='submit' value='查询' /></td>
</tr>
</table>
</form>
<script>
sup.hquery();
</script>

<%-- <h2>列表&nbsp;（<%=count%>） </h2> --%>
<form name="form2" action="/Orders.do" metdod="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="freight"/>
<input type="hidden" name="menuid" value=<%=menuid %>/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td></td>
  <td>序号</td>
  <td>订单编号</td>
		<td>提交时间</td>
		<td>收货人</td>
		<td>订单金额</td>
		<td>运费金额</td>
		<td>总金额</td>
		<td>订单状态</td>
		<td>操作</td>
</tr>
<%

if(count<1)
{
  out.print("<tr><td colspan='20' align='center'>暂无记录!</td></tr>");
}else
{
	
  Enumeration e = Order.find(sql.toString(),pos,size);
	for (int i = pos+1; e.hasMoreElements(); i++) {
		int id = ((Integer) e.nextElement()).intValue();
		Order o = Order.find(id);
  %>
  <tr>
    <td align="center"><input type="checkbox" name="experts" value=""/></td>
    <td align="center"><%=i %></td>
    <td align="center"><a href="#" onclick=mt.act('view',"<%=o.getId() %>")><%=o.getCode() %></a></td>
		<td align="center"><%=MT.f(o.getSubmitTime(),1) %></td>
		<td align="center"><%=o.getCustomer() %></td>
		<td align="right"><%=o.getTotalMoney() %></td>
		<td align="right"><%=o.getStatus()==1?"<font color='#FFA500'>计算运费中..</font>":o.getFreight() %></td>
		<td align="right"><%=o.getTotalMoney().add(o.getFreight()) %></td>
		<td align="center"><%=Order.ORDER_STATE1[o.getStatus()] %></td>
		<td align="center">
		<a href="#" onclick=mt.act('view',"<%=o.getId() %>")>订单明细</a>
		<%
		if(o.getStatus()==1){out.print("  <a href='#' onclick=mt.act('fill','"+o.getId()+"')>填运费</a>");}
		else if(o.getStatus()==3){out.print("  <a href='#' onclick=mt.act('query','"+o.getId()+"','"+o.getMoneyOrder()+"')>查询汇款单</a>   <a href='#' onclick=mt.act('remittance','"+o.getId()+"')>确认汇款</a>");}
		else if(o.getStatus()==4){out.print("  <a href='#' onclick=mt.act('delivery','"+o.getId()+"')>发货</a>");}
		else if(o.getStatus()==6){out.print("  <a href='#' onclick=mt.act('confirm','"+o.getId()+"')>完成</a>");}
		if(o.getStatus()!=8&&o.getStatus()!=7){out.print("  <a href='#' onclick=mt.act('cancel','"+o.getId()+"')>取消订单</a>");}
		%>

		</td>
  </tr>
  <%
  }
  out.print("<tr><td><input type='checkbox' onclick='mt.select(form2.experts,checked)' id='sel'/><label for='sel'>全选</label>");
  out.print("<td colspan='20' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, count,size));
}%>
</table>
</form>
<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,c){
	form2.act.value=a;
	form2.id.value=id;
	if(a=='view'){
		mt.show("/jsp/book/OrderView1.jsp?id="+id,1,"订单明细",600,590);
	}
	if(a=='cancel'){
		mt.show("您确定要取消本次订单吗？",2);
		mt.ok=function(){
			form2.submit();
		}
	}
	if(a=='query'){
		mt.show('汇款单号为'+c,1);
		
	}
	if(a=='remittance'){
		mt.show("请仔细确认客户付款与本次订单总额相符后再点击确定！",2);
		mt.ok=function(){
			form2.submit();
		}
		
	}
	if(a=='delivery'){
		mt.show("请确认已经给客户发货后再点击确定！",2);
		mt.ok=function(){
			form2.submit();
		}
	}
	if(a=='fill'){
		mt.show("<form name='form4'>运费:<input type='text' name='freight' value='0.00' onfocus=\"if(value=='0.00') {value=''}\" onblur=\"if (value=='') {value='0.00'}\" onkeyup=\"if(isNaN(value))execCommand('undo')\" onafterpaste=\"if(isNaN(value))execCommand('undo')\"></form>",2,"填写运费");
		mt.ok=function(){
			form2.freight.value=form4.freight.value;
			form2.submit();
		}
	}
	if(a=='confirm'){
		mt.show("您确定要完成订单吗？",2);
		mt.ok=function(){
			form2.submit();
		}
	}
}

setFreeze(document.getElementsByTagName('TABLE')[1],0,1);
</script>
</body>
</html>
