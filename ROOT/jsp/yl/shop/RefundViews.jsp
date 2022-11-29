<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
StringBuilder sql=new StringBuilder(),par=new StringBuilder();

int menu=h.getInt("id");
par.append("?menu="+menu);

sql.append(" AND state>0");

int state=h.getInt("state");

int s=h.getInt("s",state);
if(s>0)
{
  sql.append(" AND r.tstate="+s);
  par.append("&s="+s);
}

sql.append(" AND state = 5");

int pos=h.getInt("pos");
par.append("&pos=");


int sum=Trade.count(sql.toString());


%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>退货管理 </h1>




<h2>列表</h2>
<form action="/Refunds.do" method="post" target="_ajax" name="form2">
<input type="hidden" name="trade"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="tstate"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>订单编号</td>
  <td>订单商品</td>
  <td>收货人</td>
  <td>订单金额</td>
  <td>下单时间</td>
  <td>订单状态</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=Trade.find(sql.toString(),pos,20).iterator();
  for(int j=1+pos;it.hasNext();j++)
  {
    Trade t=(Trade)it.next();
    StringBuilder sb=new StringBuilder();
    Iterator ii=Item.findByTrade(t.trade).iterator();
    while(ii.hasNext())
    {
      Item i=(Item)ii.next();
      sb.append(Product.find(i.product).getAnchor('t')+" ");
    }
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=j%></td>
    <td><%=MT.f(t.code)%></td>
    <td><%=sb.toString()%></td>
    <td><%=MT.f(t.aname)%></td>
    <td>￥<%=MT.f(t.actually)+"<br/>"+Trade.PPAYMENT_TYPE[t.ppayment]%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td><%=MT.f(Trade.STATE_TYPE,t.state)%></td>
    <td>
    <%
    Refundview rv = Refundview.find(t.tstateid);
    if(state==1){
    	out.print("<a href=javascript:f_act('showmes','"+rv.rcont+"')>查看退款原因</a>");
    	out.print("&nbsp;<a href=javascript:f_act('up',"+t.trade+")>审核</a>");
    }else if(state==2){
    	out.print("&nbsp;<a href=javascript:f_act('tstate',"+t.trade+")>确认退款</a>");
    }else 
    if(rv.rid!=0){
    	out.print("<a href=javascript:f_act('showhistory',"+t.trade+")>退款流程</a>");
    }
    %>
    </td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.act.value=a;
  form2.trade.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='view')
  {
    form2.action='/jsp/yl/shop/TradeView.jsp';form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='showmes'){
	  mt.show(id,1,"申请退款");
  }else if(a=='up'){
	  mt.show('/jsp/yl/shop/RefundsUp.jsp?trade='+id+"&nexturl="+form2.nexturl.value,0,'审核',450,300);
  }else if(a=='tstate'){
	  mt.show("确认要退款吗？",2);
	  mt.ok=function()
	  {
		  form2.tstate.value=4;
		  form2.submit();
	  }
  }else if(a=='showhistory'){
	  mt.show('/jsp/yl/shop/ShowHistory.jsp?trade='+id,0,'历史',450,300);
  }
}
</script>

</body>
</html>
