<%@page import="tea.entity.order.OrderDedail"%>
<%@page import="sun.jdbc.odbc.OdbcDef"%>
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
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM");
String act=h.get("act","");
StringBuffer sql=new StringBuffer(),par=new StringBuffer();
int menuid=h.getInt("id");
par.append("?id="+menuid);
int status=h.getInt("status", 0);
if(status>0){
	sql.append(" and status="+status);
}
sql.append(" and is_valid=0");
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
String[] TAB={"全部","未付款","已汇款"};
String[] SQL={""," AND isPay=0"," AND isPay=1"};
int pos=h.getInt("pos");
par.append("&pos=");
int size=20;
String code=h.get("code","");
if(code.length()>0)
{
  sql.append(" AND o.code LIKE "+DbAdapter.cite("%"+code+"%"));
  par.append("&code="+h.enc(code));
}
String customer=h.get("customer","");
if(customer.length()>0)
{
  sql.append(" AND o.customer LIKE "+DbAdapter.cite("%"+customer+"%"));
  par.append("&customer="+h.enc(customer));
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
String address=h.get("address","");
if(address.length()>0)
{
  sql.append(" and o.address like "+DbAdapter.cite("%"+address+"%"));
  par.append("&address="+h.enc(address));
}
if("POST".equals(request.getMethod())){
	if("pay".equals(act)){
		int oid=h.getInt("oid");
		Order o=Order.find(oid);
		o.set("ispay", o.getIsPay()==0?"1":"0");
	}else if("del".equals(act)){
		int oid=h.getInt("oid");
		Order o=Order.find(oid);
		o.delete();
	}
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
<!-- <div id="head6"><img height="6" src="about:blank"></div> -->

<!-- <h2>查询</h2> -->
<form name="form1" action="?"  method="post">
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
  <td class="td">邮寄地址：</td><td><input name="address" value=""/></td>
  <td class="td">姓名：</td><td><input name="customer" value=""/></td>
 
  <td colspan="2"><input type='submit' value='查询' /></td>
</tr>
</table>
</form>
<script>
//sup.hquery();
</script>

<%-- <h2>列表&nbsp;（<%=count%>） </h2> --%>
<form name="form2" action="?" method="POST">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="oid"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
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
		<td>姓名</td>
		<td>电话</td>
		<td>下单时间</td>
		<td>期刊月份</td>
		<td>份数</td>
		<td>邮寄地址</td>
		<td>是否需要发票</td>
		<td>订单金额</td>
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
		OrderDedail od=OrderDedail.findByOrderId(id).get(0);
  %>
  <tr>
    
    <td align="center"><%=i %></td>
    <td align="center"><a href="#" onclick=mt.act('view',"<%=o.getId() %>")><%=o.getCode() %></a></td>
		<td align="center"><%=MT.f(o.getCustomer()) %></td>
		<td align="center"><%=MT.f(o.getMobile()) %></td>
		<td align="center"><%=MT.f(o.getSubmitTime(),1)  %></td>
		<td align="center"><%=sdf.format(o.getBeginTime())+"至"+sdf.format(o.getEndTime()) %></td>
		<td align="center"><%=od.getNum() %></td>
		<td align="center"><%=o.getAddress() %></td>
		<td align="center"><%=o.getIsInvoive()==0?"否":"是" %></td>
		<td align="right"><%=o.getTotalMoney() %></td>
		<td align="center">
		<a href="#" onclick=mt.act('view',"<%=o.getId() %>")>订单明细</a>
		<%
		out.print("<a href='###' onclick=mt.act('pay',"+o.getId()+")>"+(o.getIsPay()==0?"设为已付款":"设为未付款")+"</a>");
		%>
        <a href="#" onclick=mt.act('del',"<%=o.getId() %>")>删除</a>
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
	form2.oid.value=id;
	if(a=='view'){
		mt.show("/jsp/jkjyzs/OrderView1.jsp?id="+id,1,"订单明细",610,520);
	}else{
		form2.submit();
	}
	}

setFreeze(document.getElementsByTagName('TABLE')[1],0,1);
</script>
</body>
</html>
