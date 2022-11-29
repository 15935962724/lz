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
String community=h.get("community",h.community);
sql.append(" AND o.community = "+DbAdapter.cite(community)+" and code like "+DbAdapter.cite("FT%"));
par.append("&community="+community);
int status=h.getInt("status", 0);
if(status>0){
	sql.append(" and status="+status);
}
int ispay=h.getInt("ispay", 100);
if(ispay<100){
	sql.append(" and ispay="+ispay);
}
int pos=h.getInt("pos");
par.append("&pos=");
int size=20;
String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND o.customer LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}
String code=h.get("code","");
if(code.length()>0)
{
  sql.append(" AND o.code LIKE "+DbAdapter.cite("%"+code+"%"));
  par.append("&code="+h.enc(code));
}
String paytype=h.get("paytype","");
if(paytype.length()>0)
{
  sql.append(" AND o.paytype = "+paytype);
  par.append("&paytype="+paytype);
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
  sql.append(" AND o.reserveTime>="+DbAdapter.cite(beginDate)+" and o.reserveTime<"+DbAdapter.cite(endDate));
  par.append("&beginDate="+beginDate+"&endDate="+endDate);
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
<!-- <h2>查询</h2> -->
<form name="form1" action="?"  method="post">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="td">订单编号：</td><td><input name="code" value=""/></td>
  <td class="td" >预约时间：</td><td><input name="beginDate" value="" id="time_c" style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_c');"/><img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');">至<input name="endDate" value="" id="time_d" style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_d');"/><img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');"></td>
  <!-- <td class="td" >下单时间：</td><td><input name="beginDate" value="" id="time_c" style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_c');"/><img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');">至<input name="endDate" value="" id="time_d" style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_d');"/><img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');"></td>
  
  <td class="td">提交人：</td><td><input name="submitmen" value=""/></td> -->
 <td class="td">姓名：</td><td><input name="name" value=""/></td>
 <td class="td">支付方式：</td><td>
 <select name="paytype">
 <option value="">-----</option>
 <option value="0">在线支付</option>
 <option value="1">现场支付</option>
 </select>
 </td>
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

<input type="hidden" name="menuid" value=<%=menuid %>/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">

	    <td>序号</td>
	    <td>订单编号</td>
	    <td>预约日期</td>
	    <td>预约时间</td>
	    <td>人数</td>
	    <td>金额</td>
	    <td>姓名</td>
	    <td>联系电话</td>
	    <td>支付方式</td>
		<td>下单时间</td>
		<td>操作</td>
</tr>
<%

int sum=Order.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='20' align='center'>暂无记录!</td></tr>");
}else
{
	sql.append(" order by status asc,submit_time desc");
	SimpleDateFormat sdf=new SimpleDateFormat("HH:mm");
  Enumeration e = Order.find(sql.toString(),pos,size);
	for (int i = pos+1; e.hasMoreElements(); i++) {
		int id = ((Integer) e.nextElement()).intValue();
		Order o = Order.find(id);
  %>
  <tr>
    
    <td align="center"><%=i %></td>
    <td align="center"><a href="#" onclick=mt.act('view',"<%=o.getId() %>")><%=o.getCode() %></a></td>
    <td align="center"><%=MT.f(o.getReserveTime()) %></td>
    <td align="center"><%=sdf.format(o.getBeginTime())+"-"+sdf.format(o.getEndTime()) %></td>
    <td align="center"><%=o.getPersonNum() %></td>
    <td align="right"><%=o.getTotalMoney() %></td>
    <td align="center"><%=o.getCustomer() %></td>
    <td align="center"><%=o.getMobile() %></td>
		<td align="center"><%=Order.ORDER_PAYTYPE[o.getPayType()] %></td>
		<td align="center"><%=MT.f(o.getSubmitTime()) %></td>
		
		<td align="center">
		<%
		if(o.getStatus()==1&&o.getPayType()==0){
			out.print("<a href='###' onclick=mt.act('Fcomf','"+o.getId()+"')>确认到场（确认付款）</a>");
			out.print("<a href='###' onclick=mt.act('Fcancel','"+o.getId()+"')>取消</a>");
		}else if(o.getStatus()==1&&o.getIsPay()==1&&o.getPayType()==1){
			out.print("<a href='###' onclick=mt.act('Fcomf','"+o.getId()+"')>确认到场</a>");
			out.print("<a href='###' onclick=mt.act('Fcancel','"+o.getId()+"')>取消</a>");
		}else if(o.getStatus()==1&&o.getIsPay()==0&&o.getPayType()==1){
			out.print("<a href='###' onclick=mt.act('Fcancel','"+o.getId()+"')>取消</a>");
		}
		%>
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
	form2.act.value=a;
	form2.id.value=id;
	
	if(a=='Fcancel'){
		mt.show("您确定要取消本次订单吗？",2);
		mt.ok=function(){
			form2.submit();
		}
	}else if(a=='Fcomf'){
		mt.show("确认该用户到场消费？",1);
		mt.ok=function(){
			form2.submit();
		}
	}
	}

setFreeze(document.getElementsByTagName('TABLE')[1],0,1);
</script>
</body>
</html>
