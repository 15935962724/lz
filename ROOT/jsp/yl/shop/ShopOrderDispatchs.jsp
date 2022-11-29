<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%>
<%@page import="java.text.SimpleDateFormat" %>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

if(h.isIllegal())
{
  out.println("非法操作！");
  return;
}

int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer();
par.append("?id="+menu);

//sql.append(" AND isLzCategory=0");// AND isLzCategory=1
//par.append("&isLzCategory=0");//&isLzCategory=1

String order_id=h.get("order_id","");
if(order_id.length()>0)
{
  sql.append(" AND so.order_id LIKE "+Database.cite("%"+order_id+"%"));
  par.append("&order_id="+h.enc(order_id));
}

Date time0=h.getDate("time0");
if(time0!=null)
{
  sql.append(" AND so.createDate>"+DbAdapter.cite(time0));
  par.append("&createDate="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND so.createDate<"+DbAdapter.cite(time1));
  par.append("&createDate="+MT.f(time1));
}

/* String username=h.get("username","");
if(username.length()>0)
{
  sql.append(" AND ml.lastname+ml.firstname LIKE "+Database.cite("%"+username+"%"));
  par.append("&username="+h.enc(username));
} */

String member=h.get("member","");
if(member.length()>0)
{
  sql.append(" AND m.member LIKE "+Database.cite("%"+member+"%"));
  par.append("&member="+h.enc(member));
}

String company=h.get("company","");
if(company.length()>0)
{
  sql.append(" AND sod.n_company LIKE "+Database.cite("%"+company+"%"));
  par.append("&company="+h.enc(company));
}

String consignees=h.get("consignees","");
if(consignees.length()>0)
{
  sql.append(" AND sod.n_consignees LIKE "+Database.cite("%"+consignees+"%"));
  par.append("&consignees="+h.enc(consignees));
}

String[] TAB={"全部发票","未开具发票","已开具发票","退货重开发票"};
String[] SQL={" AND so.invoiceStatus!=0"," AND (so.invoiceStatus=1 or so.invoiceStatus=2)"," AND so.invoiceStatus=3"," AND se.type = 1 "};

int tab=h.getInt("tab",0);
par.append("&tab="+tab);

int pos=h.getInt("pos");
par.append("&pos=");



%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
</head>
<body>
<h1>发票管理</h1>

<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<div class="radiusBox">
<table cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='3'>查询</td></tr>
</thead>
<tr>
  <td>订单编号:<input name="order_id" value="<%=MT.f(order_id)%>"/></td>
  <td>用户名:<input name="member" value="<%=MT.f(member)%>"/></td>
  <td class='bornone'>订单时间:<input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/>  至  <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date"/></td>
</tr>
<tr>
  <td>开票单位:<input name="company" value="<%=MT.f(company)%>"/></td>
  <td>发票接收人:<input name="consignees" value="<%=MT.f(consignees)%>"/></td>
  <td class='bornone'><button class="btn btn-primary" type="submit">查询</button>
</tr>
</table>
</div>
</form>
<%out.print("<div class='switch'>");
for(int i=0;i<TAB.length;i++)
{ 
  //out.print("<a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"（"+ShopOrder.count(sql.toString()+SQL[i])+"）</a>");
	out.print("<a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"</a>");
}
out.print("</div>");
%>
<form name="form2" action="/ShopOrderDispatchs.do" method="post" target="_ajax">
<input type="hidden" name="dispatch"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="id" value="<%=menu %>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="invoiceStatus" value="3"/>
<input type="hidden" name="orderId" value=""/>
<div class='radiusBox mt15'>
<table id="" cellspacing="0" class='newTable'>
<tr>
  <th width='60'>序号</th>
  <th>订单编号</th>
  <th>用户名</th>
  <th>下单时间</th>
  <th>索要发票时间</th>
  <th>开票单位</th>
  <th>发票接收人</th>
  <th>发票签收人</th>
  <th>数量</th>
  <th>活度</th>
  <!-- <th>状态</th> -->
  <th>操作</th>
</tr>
<%
sql.append(SQL[tab]);
int lizinum=0,othernum=0;
int sum=ShopOrder.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append(" order by so.askinvoicedate desc,createDate desc");
  Iterator it=ShopOrder.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
	  ShopOrder t = (ShopOrder)it.next();
	  ShopOrderDispatch sod=ShopOrderDispatch.findByOrderId(t.getOrderId());
	  
	//根据订单id查询订单详情信息
	  List<ShopOrderData> list = ShopOrderData.find(" AND order_id="+DbAdapter.cite(t.getOrderId()),0,Integer.MAX_VALUE);
	  ShopOrderData orderData = ShopOrderData.find(0);
	  if(null != list && list.size() > 0)
		  orderData = list.get(0);
	  /* String uname = MT.f(Profile.find(t.getMember()).getName(h.language));
      if(uname.trim()==null||uname.trim().equals("")||uname.trim().length()<1){
    	  uname = Profile.find(t.getMember()).member;
      } */
      String uname = MT.f(Profile.find(t.getMember()).member);
      
      int status = t.getStatus();
      String statusContent = "";
      if(status==0)
    	  statusContent = "未付款";
      else if(status==1)
    	  statusContent = "确认发货";
      else if(status==2)
    	  statusContent = "未出库";
      else if(status==3)
    	  statusContent = "已出库";
      else if(status==4)
    	  statusContent = "已完成";
      else if(status==5)
    	  statusContent = "已取消";
      
  %>
  <tr>
    <td><%=i%></td>
    <td class="orderId"><button type="button" class="btn btn-link" onclick="mt.act('data','<%=t.getOrderId()%>')"><%=t.getOrderId()%></button></td>
    <td><%=uname%></td>
    <td><%=MT.f(t.getCreateDate(),1)%></td>
    <td><%=MT.f(t.getAskInvoiceDate(),1) %></td>
    <td><%=MT.f(sod.getN_company())%></td>
    <td><%=MT.f(sod.getN_consignees())%></td>
    <%
        if(MT.f(sod.getSign_user_openid())!=""){
    %>
    <td><%=MT.f(Profile.getMemberByOpenId(sod.getSign_user_openid()))%></td>
    <%   	
        }else{
    %>
    <td></td>
    <%
        }
    %>
    
    <td><%=orderData.getQuantity()%></td>
    <td><%=orderData.getActivity()%></td>
    <%-- <td><%=statusContent%></td> --%>
    <td>
    <%
    	if(t.getInvoiceStatus()==1||t.getInvoiceStatus()==2)
    	{
    		out.print("<button type='button' class='btn btn-link' onclick=\"mt.act('invoice',"+sod.getId()+")\">开具发票</button>");
    		if(t.getInvoiceStatus()==2)
        		out.print("<button type='button' class='btn btn-link' onclick=\"mt.act('submitInvoice',"+sod.getId()+")\">完成</button>");
    	}else if(t.getInvoiceStatus()==3)
    	{
    		if(tab == 3){
	    		ShopExchanged se = ShopExchanged.findByOrderId(t.getOrderId());
	    		if(se.id > 0){
	    			if("".equals(MT.f(sod.getN_invoiceNoNew())))
	    				out.print("<button type='button' class='btn btn-link' onclick=\"mt.act('invoice_edit',"+sod.getId()+")\">开具发票</button>");
	    			else
	    				out.print("<button type='button' class='btn btn-link' onclick=\"mt.act('invoice_edit',"+sod.getId()+")\">查看</button>");
	    		}
    		}else{
    			out.print("<button type='button' class='btn btn-link' onclick=\"mt.act('print',"+sod.getId()+")\">打印</button>");
    			out.print("<button type='button' class='btn btn-link' onclick=\"mt.act('view',"+sod.getId()+")\">查看发票</button>");
    		}
    	}
    	out.print("<button type='button' class='btn btn-link' onclick=\"mt.act('submitInvoice_qx',"+sod.getId()+")\">取消开票</button>");
    %>
    	
    	
    </td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>

</div>
</form>
<div class='center mt15'><button class="btn btn-primary" type="button" onclick="dcorder()">导出</button></div>

<form action="/ShopOrders.do" name="form9"  method="post" target="_ajax" >
	<input name="act" value="exp_invoice" type="hidden" />
	<input name="category" value="2" type="hidden" />
	<input type='hidden' name="sql" value="<%= sql.toString() %>" />
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id)
{
  form2.act.value=a;
  form2.dispatch.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='invoice')
  {
    form2.action='/jsp/yl/shop/ShopOrderDispatchInvoice.jsp';form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='submitInvoice')
  {
	 mt.show("确定完成开票吗？",2);
	 mt.ok=function(){
		 form2.act.value='wancheng';
			form2.invoiceStatus.value='3';
			form2.submit();
	 }
  }else if(a=='submitInvoice_qx')
  {
	  mt.show("确定取消开票吗？",2);
	 mt.ok=function(){
		 form2.act.value='submitInvoice';
		 //取消开票，退回到索要发票
		 form2.invoiceStatus.value = '0';
		 form2.submit();
	 }
	
  }else if(a=='view')
  {
	form2.action='/jsp/yl/shop/ShopOrderDispatchView.jsp';form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='print'){
	  form2.action='/jsp/yl/shop/ShopOrderDispatchPrint.jsp';form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='invoice_edit'){
	  mt.show("/jsp/yl/shop/ShopInvoiceEdit.jsp?id="+id,2,"添加新的发票号",500,220);
  }else if(a=="data"){
	  form2.orderId.value=id;
	  form2.action=("/jsp/yl/shop/ShopOrderDatas.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }
};

function dcorder(){
	form9.submit();
}
</script>
</body>
</html>
