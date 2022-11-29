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
}
String community=h.get("community",h.community);
sql.append(" AND o.community = "+DbAdapter.cite(community));
par.append("&community="+community);
String org=h.get("org","");
if(org.length()>0)
{
  sql.append(" AND ml.organization LIKE "+DbAdapter.cite("%"+org+"%"));
  par.append("&org="+h.enc(org));
}
int tab=h.getInt("tab");
par.append("&tab="+tab);

//String[] TAB={"全部","内部专家","外部专家"};
String[] TAB={"全部","等待计算运费","待汇款","已汇款","已确认汇款","已发货","已收货","已完成","已取消"};
String[] SQL={""," AND status=1"," AND status=2"," AND status=3"," AND status=4"," AND status=5"," AND status=6"," AND status=7"," AND status=8"};
int pos=h.getInt("pos");
par.append("&pos=");
int size=20;
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
int count=Order.count(sql.toString());

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
<input type="hidden" name="tab" value="<%=tab%>"/>
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
<form name="form2" action="?" metdod="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<input type="hidden" name="menuid" value=<%=menuid %>/>
<%
out.print("<div class='switch'>");
for(int i=0;i<TAB.length;i++)
{ 
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"（"+Order.count(sql.toString()+SQL[i])+"）</a>");
}
out.print("</div>");
%>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">

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
sql.append(SQL[tab]);

int sum=Order.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='20' align='center'>暂无记录!</td></tr>");
}else
{
	sql.append(" order by status asc,submit_time desc");
  Enumeration e = Order.find(sql.toString(),pos,size);
	for (int i = pos+1; e.hasMoreElements(); i++) {
		int id = ((Integer) e.nextElement()).intValue();
		Order o = Order.find(id);
  %>
  <tr>
    
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
		<%-- <%
		if(o.getStatus()==1){out.print("<a href='#' onclick=mt.act('fill','"+o.getId()+"')>填运费</a>");}
		else if(o.getStatus()==3){out.print("<a href='#' onclick=mt.act('fillin','"+o.getId()+"')>确认汇款</a>");}
		else if(o.getStatus()==4){out.print("<a href='#' onclick=mt.act('fillin','"+o.getId()+"')>发货</a>");}
		else if(o.getStatus()==6){out.print("<a href='#' onclick=mt.act('confirm','"+o.getId()+"')>完成</a>");}
		if(o.getStatus()!=8){out.print("<a href='#' onclick=mt.act('cancel','"+o.getId()+"')>取消订单</a>");}
		%> --%>

		</td>
  </tr>
  <%
  }
  out.print("<td colspan='20' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,size));
}%>
</table>
</form>
<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id){
	form2.act.value=a;
	form2.id.value=id;
	if(a=='view'){
		mt.show("/jsp/book/OrderView1.jsp?id="+id,1,"订单明细",610,590);
	}
	}

setFreeze(document.getElementsByTagName('TABLE')[1],0,1);
</script>
</body>
</html>
