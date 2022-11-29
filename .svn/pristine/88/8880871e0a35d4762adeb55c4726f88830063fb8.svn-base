<%@page import="tea.entity.order.Order"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="tea.entity.node.Book"%>
<%@page import="tea.entity.node.Node"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.sup.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.admin.*"%>
<script src="/tea/mt.js" type="text/javascript"></script>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}
String act=h.get("act","");

	int oid=h.getInt("oid", 0);
	Order order=Order.find(oid);
	if("FCaudit".equals(act)){
		
		int state=h.getInt("state", 0);
		if(oid>0){
			order.set("cancel_man", h.username);
			order.set("cancel_time",new Date());
			order.set("status", String.valueOf(state));
			out.print("<script>mt.show('操作成功！');</script>");
		}
	}else if("FCdel".equals(act)){
		if(oid>0){
			order.set("invalid_date",new Date());
			order.set("is_valid", String.valueOf(1));
			out.print("<script>mt.show('操作成功！');</script>");
		}
	}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();
int menuid=h.getInt("id");
par.append("?id="+menuid);
String community=h.get("community",h.community);
sql.append(" AND o.community = "+DbAdapter.cite(community)+" and code like "+DbAdapter.cite("FC%")+" and is_valid=0");
par.append("&community="+community);
int status=h.getInt("status", 0);
if(status>0){
	sql.append(" and status="+status);
}
int pos=h.getInt("pos");
par.append("&pos=");
int size=20;

int tab=h.getInt("tab");
par.append("&tab="+tab);

//String[] TAB={"全部","内部专家","外部专家"};
String[] TAB={"全部","未审核","已通过","未通过"};
String[] SQL={""," AND status=1"," AND status=2"," AND status=3"};
String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND o.customer LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}
String mobile=h.get("mobile","");
if(mobile.length()>0)
{
  sql.append(" AND o.mobile LIKE "+DbAdapter.cite("%"+mobile+"%"));
  par.append("&mobile="+h.enc(mobile));
}

int count=Order.count(sql.toString());

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>

<script src="/tea/city.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
</head>
<body>
<h1>订单列表</h1><!--列表-->
<!-- <h2>查询</h2> -->
<form name="form1" action="?"  method="POST">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="td">姓名：</td><td><input name="name" value=""/></td>
  <td class="td">联系电话：</td><td><input name="mobile" value=""/></td>
 
  <td colspan="2"><input type='submit' value='查询' /></td>
</tr>
</table>
</form>
<script>
sup.hquery();
</script>

<%-- <h2>列表&nbsp;（<%=count%>） </h2> --%>
<form name="form2" action="?" metdod="post">
<input type="hidden" name="id" value="<%=menuid %>"/>
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="oid"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="state"/>


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
	    <td>姓名</td>
	    <td>联系电话</td>
	    <td>预约日期</td>
	    <td>预约时间</td>
		<td>下单时间</td>
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
	SimpleDateFormat sdf=new SimpleDateFormat("HH:mm");
  Enumeration e = Order.find(sql.toString(),pos,size);
	for (int i = pos+1; e.hasMoreElements(); i++) {
		int id = ((Integer) e.nextElement()).intValue();
		Order o = Order.find(id);
  %>
  <tr>
    
    <td align="center"><%=i %></td> 
    <td align="center"><%=o.getCustomer() %></td>
    <td align="center"><%=o.getMobile() %></td>
    <td align="center"><%=MT.f(o.getReserveTime()) %></td>
    <td align="center"><%=sdf.parse("12:00").before(o.getBeginTime())?"上午":"下午" %></td>
	<td align="center"><%=MT.f(o.getSubmitTime()) %></td>
		
		<td align="center">
		<%
		if(o.getStatus()==1){
			out.print("<a href='###' onclick=mt.naudit('FCaudit','"+o.getId()+"')>审核</a>");
		}
		%>
		<a href='###' onclick=mt.act('FCdel','<%=o.getId() %>')>删除</a>
		</td>
  </tr>
  <%
  }
  if(tab==2){
	  out.print("<td><a href='###' onclick=mt.act('excel','"+tab+"')>导出EXCEL</a></td>");
  }
  out.print("<td colspan='20' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,size));
}%>
</table>
</form>
<script>
form2.nexturl.value=location.pathname+location.search;
mt.naudit=function(b,id)
{   
	form2.act.value=b;
	form2.oid.value=id;
  
  mt.show("<form name='form4'><table><tr><td nowrap>状态：</td><td><input name='state' type='radio' value='2' id='state_2' onclick='mt.nreason(this)' /><label for='state_2'>通过</label>　<input name='state' type='radio' value='3' id='state_3' onclick='mt.nreason(this)' /><label for='state_3'>不通过</label></table></form>",2,"审核");
  $('state_'+(b==3?3:2)).click();
  mt.ok=function()
  {
    form2.state.value=mt.value(form4.state);
    form2.submit();
  };
};
mt.nreason=function(t,b)
{
  var tr=t.parentNode.parentNode.nextSibling;
  tr.style.display=t.value=='2'?"none":"";
};
mt.act=function(a,id){
	form2.act.value=a;
	form2.oid.value=id;
	
	if(a=='FCdel'){
		mt.show("您确定要删除吗？",2);
		mt.ok=function(){
			form2.submit();
		}
	}else if(a=='excel'){
		form2.action="/Orders.do";
		form2.state.value=id;
		form2.submit();
	}
	}

setFreeze(document.getElementsByTagName('TABLE')[1],0,1);
</script>
</body>
</html>
