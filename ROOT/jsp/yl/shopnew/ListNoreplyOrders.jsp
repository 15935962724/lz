<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.member.Profile"%>
<%@ page import="util.Config" %><%


Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("id="+menu);

Integer puid = Config.getInt(h.get("puid"));
//int puid1 = h.getInt("puid1");

if(puid != null) {
	sql.append(" and puid=" + puid);
	par.append("&puid=" + h.get("puid"));
//	puid1=puid;
}

/*
if(puid1 > 0){
	sql.append(" and puid="+puid1);
}
*/

sql.append("AND status!=5 AND status!=6  AND status!=-5 ");
//sql.append(" and ((isclear is null or isclear=0)or( isclear =1 and so.order_id in(select orderid from invoicedata )))");
//按医院查询

String hname=h.get("hname","");
if(hname.length()>0){
	sql.append(" AND order_id in(select order_id from shopOrderDispatch where a_hospital like "+Database.cite("%"+hname+"%")+")");
	par.append("&hname="+h.enc(hname));
}
//按服务商查询

String pname=h.get("pname","");
if(pname.length()>0){
	
	sql.append(" AND member in(select profile from Profile where member like "+DbAdapter.cite("%"+pname+"%")+")");
	par.append("&pname="+h.enc(pname));
}
//按是否已催缴查询
int isurged=h.getInt("isurged",-1);
if(isurged==0){
	sql.append(" AND (isurgedreply = "+isurged+" or isurgedreply is null ) ");
	par.append("&isurged="+isurged);
}else if(isurged==1){
	sql.append(" AND isurgedreply = "+isurged);
	par.append("&isurged="+isurged);
}
//按订单编号查询
String order_id=h.get("order_id","");
if(order_id.length()>0){
	sql.append(" AND order_id like "+Database.cite("%"+order_id+"%"));
	par.append("&order_id="+order_id);
}
String[] TAB={"全部订单","已全部回款","部分回款","未回款","逾期未回款"};
//逾期未回款订单设为从开票日期起，超过一年还未回款的订单（只针对已完成开票的订单）
String[] SQL={" and status!=5 and status!=6 and (ishidden=0 or ishidden is null)"," AND matchnum = (select quantity from shoporderdata where so.order_id=order_id) and status!=5 and status!=6 and (ishidden=0 or ishidden is null) "," AND matchnum < (select quantity from shoporderdata where so.order_id=order_id) and matchnum > 0 and status!=5 and status!=6 and (ishidden=0 or ishidden is null) "," AND matchnum = 0 and status!=5 and status!=6 and (ishidden=0 or ishidden is null)"," AND order_id in(select orderid from invoicedata where invoiceid in(select id from invoice where status=2 and matchstatus!=2 and DATEDIFF(y, makeoutdate, GETDATE()) >=15))  and status!=5 and status!=6 and (ishidden=0 or ishidden is null) "};

int tab=h.getInt("tab",0);
par.append("&tab="+tab);

int pos=h.getInt("pos");
par.append("&pos=");


int size=20;

%><!DOCTYPE html><html><head>
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
	  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}

</script> 

<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>


</head>
<body>
<h1>未回款订单</h1>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<div class="radiusBox">
<table cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='5'>查询</td></tr>
</thead>
<tr>
<td>订单编号：<input type="text" name="order_id"  value="<%=order_id %>"/>
	  
  </td>
  <td>医院：<input type="text" name="hname" id="hname" value="<%=hname %>"/>
	<input id="hospitalsel" onclick="mt.show('/jsp/yl/shopnew/Selhospital_shop.jsp',1,'选择医院',500,500)" type="button" value="请选择"/>  
  </td>
	<%--<%
		if(puid == null){
	%>
	<td nowrap="">厂商：
		<select name="puid1">
			<option>请选择</option>
			<%
				List<ProcurementUnit> puList = ProcurementUnit.find("", 0, 10);
				for (int i = 0; i < puList.size(); i++) {
					out.print("<option "+(puid1==puList.get(i).getPuid()?"selected='selected'":"")+" value='"+puList.get(i).getPuid()+"'>"+puList.get(i).getName()+"</option>");
				}
			%>
		</select>
	</td>
	<%
		}
	%>--%>
  <td>服务商：<input type="text" name="pname" id="pname" value="<%=pname %>"/>
	<input id="hospitalsel" onclick="mt.show('/jsp/yl/shopnew/SelProfile_shop.jsp',1,'选择服务商',500,500)" type="button" value="请选择"/>  
  </td>
  <td>是否已催缴：
  	<select name="isurged" >
  	
  		<option value="-1" <%=isurged==-1?"selected":"" %>>请选择</option>
  		<option value="0" <%=isurged==0?"selected":"" %>>否</option>
  		<option value="1" <%=isurged==1?"selected":"" %>>是</option>
  	</select>  
  </td>
  <td><input type="submit" class="button" value="查询"/></td>
  
</tr>
</table>
</div>
</form>

<%out.print("<div class='switch'>");
for(int i=0;i<TAB.length;i++)
{ 
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"（"+ShopOrder.count(sql.toString()+SQL[i])+"）</a>");
}
out.print("</div>");
%>
<form name="form2" action="/Invoices.do" method="post" target="_ajax">

<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="id" value="<%=menu %>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="orderid" />
<div class='radiusBox mt15'>
<table  id="" cellspacing="0" class='newTable'>
<tr>
  
  <th>序号</th>
  <th>订单编号</th>
  <th>服务商</th>
  <th>医院</th>
	<th>厂商</th>
  <th>订单数量</th>
  <th>订单金额</th>
  <th>下单时间</th>
  <th>开票数量</th>
  <th>开票金额</th>
  <!-- <th>发票号</th>
  <th>回款编号</th> -->
  <th>是否已催缴</th>
  <th>操作</th>
  
</tr>
<%
sql.append(SQL[tab]);
String urgedpids="";//用于催缴形成记录,服务商id
//赋值urgedpids
List<ShopOrder> lstorder0=ShopOrder.find(sql.toString(), 0, Integer.MAX_VALUE);
for(int i=0;i<lstorder0.size();i++){
	ShopOrder order=lstorder0.get(i);
	int mid=order.getMember();
	  if(urgedpids.indexOf(String.valueOf(mid))==-1){
		  urgedpids+=mid+",";
	  }
	  
}
int sum=ShopOrder.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='11' align='center'>暂无记录!</td></tr>");
}else
{
 
  List<ShopOrder> lstorder=ShopOrder.find(sql.toString(), pos, size);
  for(int i=0;i<lstorder.size();i++)
  {
	  ShopOrder order=lstorder.get(i);
	  int p= order.getMember();
	  Profile profile=Profile.find(p);//
	  ShopOrderDispatch dispatch=ShopOrderDispatch.findByOrderId(order.getOrderId());
	  int hid=dispatch.getA_hospital_id();
	  ShopHospital hospital=ShopHospital.find(hid);//医院
	  List<ShopOrderData> lstdata=ShopOrderData.find(" and order_id="+Database.cite(order.getOrderId()), 0, Integer.MAX_VALUE);
	  int ordernum=0;//订单数量
	  double orderamount=0;//订单金额
	  if(lstdata.size()>0){
		  ShopOrderData data=lstdata.get(0);
		  ordernum=data.getQuantity();
		  orderamount=data.getAmount();
	  }
	  //发票号
	  String invoicenos="";
	  List<InvoiceData> lstindata=InvoiceData.find(" and orderid="+Database.cite(order.getOrderId()), 0, Integer.MAX_VALUE);
	  for(int j=0;j<lstindata.size();j++){
		  InvoiceData indata=lstindata.get(j);
		  int invoiceid=indata.getInvoiceid();
		  Invoice invoice=Invoice.find(invoiceid);
		  String no=invoice.getInvoiceno();
		  if(invoicenos!=""&&invoicenos.indexOf(no)==-1){
			  if(j==lstindata.size()-1){
				  invoicenos+=no;
			  }else{
				  invoicenos+=no+",";
			  }
		  }
	  }
	  
	  //回款id
	  String replyids="";
	  for(int j=0;j<lstindata.size();j++){
		  InvoiceData indata=lstindata.get(j);
		  int invoiceid=indata.getInvoiceid();
		  Invoice invoice=Invoice.find(invoiceid);
		  int inid=invoice.getId();
		  List<BackInvoice> lstback=BackInvoice.find(" and invoiceid like "+Database.cite("%"+inid+"%")+" and status = 1 ", 0, Integer.MAX_VALUE);
		  if(lstback.size()>0){
			  BackInvoice back=lstback.get(0);
			  String reply=back.getReplyid();
			  replyids+=reply;
		  }
		  
		  
	  }
	  //回款编号
	  String replynos="";
	  /*if(replyids.length()>0){
		  String replynoarr[]=replynos.split(",");
		  for(int j=0;j<replynoarr.length;j++){
			 int re=Integer.parseInt(replynoarr[j]);
			 ReplyMoney replymoney=ReplyMoney.find(re);
			 String code=replymoney.getCode();
			 if(j==replynoarr.length-1){
				 replynos+=code;
			 }else{
				 replynos+=code+",";
			 }
		  }
	  }*/
	  
%>
<tr>
	
	<td><%=i+1 %></td>
	<td><%=MT.f(order.getOrderId()) %></td>
	<td><%=MT.f(profile.member) %></td>
	<td><%=MT.f(hospital.getName()) %></td>
	<td><%=MT.f(ProcurementUnit.findName(puid))%></td>
	<td><%=ordernum %></td>
	<td><%=MT.f(orderamount) %></td>
	<td><%=MT.f(order.getCreateDate(),1) %></td>
	<td><%=order.getIsinvoicenum() %></td>
	<%-- <td><%=MT.f(order.getIsinvoiceamount()) %></td>
	<td><%=invoicenos %></td> --%>
	<td><%=replynos %></td>
	<td><%=order.getIsurgedreply()==0?"否":"<span style='color:red'>是</span>" %></td>
	<td>
		<a href="javascript:mt.act('data',<%=order.getId() %>)">查看</a>
		
	</td>
</tr>
<%
  }
  if(sum>20)out.print("<tr class='fenye'><td colspan='12' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</div>
</form>
<div class='center mt15'><button class="btn btn-primary" type="button" onclick="dcorder()">导出</button>&nbsp;&nbsp;
<%
	if(tab==4){
%>
<button class="btn btn-primary" type="button" onclick="urgednoreply('<%=urgedpids %>')">形成催缴名单</button>
<%
	}
%>
</div>
<form action="/ShopOrders.do" name="form3"  method="post" target="_ajax" >
	<input name="act" value="exp_noreply" type="hidden" />
	
	
		<input type='hidden' name="sql" value="<%= sql.toString() %>" />
</form>
<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,invoiceid)
{
  form2.act.value=a;
  form2.orderid.value=invoiceid;
  if(a=='data')
  {
	  form2.action="/jsp/yl/shopnew/NoReplyOrderDatas.jsp";
	  form2.target='_self';form2.method='get';form2.submit();
	  
  }else if(a=='confirm'){
	  form2.action="/jsp/yl/shopnew/InvoiceMakeout_caiwu.jsp";
	  form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='show'){
	  form2.action="/jsp/yl/shopnew/InvoiceShow.jsp";
	  form2.target='_self';form2.method='get';form2.submit();
  }
};

mt.receive=function(v,n,h){
  

document.getElementById("hname").value=v;
};

mt.receive2=function(v,n,h){
	  

	document.getElementById("pname").value=v;
	};
	
function dcorder(){
		
		form3.submit();
	}
	
function urgednoreply(pids){
	  mt.show('/jsp/yl/shopnew/ListurgedReply.jsp?pids='+pids,1,'逾期未回款催缴名单',800,500);
}
</script>
</body>
</html>
