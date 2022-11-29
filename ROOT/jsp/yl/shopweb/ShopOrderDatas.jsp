<%@page import="util.Config"%>
<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

String orderId = MT.dec(h.get("orderId"));
//根据订单id查询订单信息
ShopOrder so = ShopOrder.findByOrderId(orderId);
sql.append(" AND order_id="+DbAdapter.cite(orderId));
par.append("&orderId="+orderId);

int sum=ShopOrderData.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");

String nexturl = h.get("nexturl");

%><!DOCTYPE html><html><head>


<!-- <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
 --><script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" href="/tea/new/css/style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<style>
	.con-left .bd:nth-child(2){
		display:block;
	}
	.con-left .bd:nth-child(2) li:nth-child(1){
		font-weight: bold;
	}
	.right-tab td,.right-tab th{
		padding:0px 10px;
		text-align:left;
	}
	.con-left-list .tit-on1{color:#044694;}

</style>
</head>
<body>
<!-- <h1>订单详细</h1>
 -->
<%
int tpflag = 0;
String hdstr = "";
String tmstr = "";
int status = so.getStatus();
String statusContent = "";
if(status==0)
	  statusContent = "待付款";
else if(status==1)
	  statusContent = "待发货";
else if(status==2||status==3)
	  statusContent = "待收货";
else if(status==4)
	  statusContent = "已完成";
else if(status==5)
	  statusContent = "取消订单";

ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());
float price = so.getAmount().floatValue();
if(so.isLzCategory()){
	Profile profile = Profile.find(so.getMember());
	ArrayList sodList = ShopOrderData.find(" AND order_id="+Database.cite(so.getOrderId()),0,Integer.MAX_VALUE);
	if(sodList.size()>0){
		ShopOrderData sorderdata = (ShopOrderData)sodList.get(0); //订单详细
		if(profile.qualification==1 && so.isLzCategory()){
			price=sorderdata.getAmount().floatValue();
		}
		if(profile.membertype==2){//医院代理商价格
			price=sorderdata.getAgent_amount();
		}
	}
}
%>
<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
	<div class="con-left">
		<%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
	</div>
	<div class="con-right">
<table class="right-tab" border="1" cellspacing="0" style="margin:0px;">
<tr style="font-weight:bold;"><td colspan="4" align='left' style="font-size:15px;">订单信息</td></tr>
<tr>
	<td width="10%" align='right'>订单编号</td><td align='left'><%=MT.f(so.getOrderId()) %></td>
	<td align='right'>下单时间</td><td align='left'><%=MT.f(so.getCreateDate(),1) %></td>
</tr>
<tr>
	<td width="10%" align='right'>当前状态</td><td align='left'><%=MT.f(statusContent) %></td>
	<td width="10%" align='right'>支付方式</td><td align='left'><%out.print(so.getPayType()==1?"在线支付":"公司转账"); %></td>
</tr>
<%
int mypuid = ShopOrderData.findPuid(so.getOrderId());
	if(mypuid==Config.getInt("junan")){
		%>
		<tr>
			<td align='right'>是否调配</td><td align='left'><%= (so.getAllocate()==0?"否":"是") %></td>
			<%
				if(so.getAllocate()==1){
					out.print("<td align='right'>是否同意调配</td><td align='left'>"+(so.getAllocatetype()==0?"同意":"不同意")+"</td>");
				}else{
					out.print("<td colspan='2'></td>");
				}
			%>
		</tr>
		<%
	}
%>
<%
if(so.getStatus()==5)
{
%>
<tr>
	<td width="10%" align='right'>取消原因</td><td colspan='3' align='left'><%=MT.f(so.getCancelReason()) %></td>
</tr>
<%
}
%>
<tr style="font-weight:bold;"><td colspan="4" align='left' style='font-size:15px;'>收货人信息</td></tr>
<tr>
	<td nowrap align='right'>收货人姓名</td><td align='left'><%=MT.f(sod.getA_consignees())%></td>
	<td nowrap align='right'>手机号</td><td align='left'><%=MT.f(sod.getA_mobile())%></td>
</tr>
<tr>
	<td nowrap align='right'>固定电话</td><td align='left'><%=MT.f(sod.getA_telphone())%></td>
	<td nowrap align='right'>邮编</td><td align='left'><%=MT.f(sod.getA_zipcode())%></td>
</tr>
<tr>
	<td nowrap align='right'>地址</td><td colspan="3" align='left'><%=MT.f(sod.getA_address())%></td>
</tr>

<%
if(so.getStatus()==3||so.getStatus()==4)
{
	ShopOrderExpress soe = ShopOrderExpress.findByOrderId(so.getOrderId());
	if(soe.time!=null)
	{
%>
<tr style="font-weight:bold;"><td colspan="4" align='left'>发货信息</td></tr>
<tr>
	<td nowrap align='right'>快递单号</td><td colspan="3" align='left'><%=MT.f(soe.express_code)%></td>
</tr>
<tr>
	<td nowrap align='right'>销售编号</td><td align='left'><%=MT.f(soe.NO1)%></td>
	<td nowrap align='right'>生产批号</td><td align='left'><%=MT.f(soe.NO2)%></td>
</tr>
<tr>
	<%
		if(Config.getInt("junan")!=mypuid){
			%>
	<td nowrap align='right'>有效期</td><td align='left'><%=MT.f(soe.vtime)%></td>
	<%
		}
	%>
	<td nowrap align='right'>发货日期</td><td align='left'><%=MT.f(soe.time)%></td>
</tr>
<tr>
	<td nowrap align='right'>发件人</td><td align='left'><%=MT.f(soe.person)%></td>
	<td  nowrap align='right'>联系电话</td><td align='left'><%=MT.f(soe.mobile)%></td>
</tr>
	<%
		if(MT.f(soe.express_img).length()>0){

			String imgsr = "";
			if(MT.f(soe.express_img).length()>0){
				String[] imgarr=soe.express_img.split(",");
				for(int i=0;i<imgarr.length;i++){
					Attch attch=Attch.find(Integer.parseInt(imgarr[i]));
					imgsr=attch.path;
				}
			}

			out.print("<tr><td nowrap align='right'>快递图片：</td><td align='left' colspan='3'><img src='"+imgsr+"' width='300px' height='300px' ></td></tr>");
		}

	%>
<%
	}
}
%>

<tr style="font-weight:bold;"><td colspan="4" align='left' style="font-size:15px;">发票信息</td></tr>
<tr>
	<td >开票单位</td><td align='left' colspan="3">
	<%
	out.print(ProcurementUnit.findName(so.getPuid()));
	%></td>
</tr>
<%
if(so.getInvoiceStatus()==3)
{
	ShopOrderExpress seo=ShopOrderExpress.findByOrderId(orderId);
%>
<tr>
	<td nowrap align='right'>开票状态</td><td align='left'>已开具</td>
	<td nowrap align='right'>开票金额</td><td align='left'><%= price%></td>
</tr>
<tr>
	<td nowrap align='right'>发票单号</td><td align='left'><%=MT.f(sod.getN_invoiceNo())%></td>
	<td nowrap align='right'>快递单号</td><td align='left'><%=MT.f(sod.getN_expressNo())%></td>
</tr>
<%
}else
{
%>
<tr>
	<td nowrap align='right'>开票状态</td><td align='left'>未开具</td>
	<td nowrap align='right'>开票金额</td><td align='left'><%= price%></td>
</tr>
<%
}
%>
<tr>
	<td nowrap align='right'>开票单位</td><td align='left'><%=MT.f(sod.getN_company())%></td>
	<td nowrap align='right'>发票接收人</td><td align='left'><%=MT.f(sod.getN_consignees())%></td>
</tr>
<tr>
	<td nowrap align='right'>联系电话</td><td align='left'><%=MT.f(sod.getN_telphone())%></td>
	<td nowrap align='right'>地址</td><td align='left'><%=MT.f(sod.getN_address())%></td>
</tr>

<tr style="font-weight:bold;"><td colspan="4" align='left' style='font-size:15px;'>订单备注</td></tr>
<tr><td colspan="4" align='left'><%out.print(so.getUserRemarks()==null||so.getUserRemarks().length()<1?"无":MT.f(so.getUserRemarks())); %></td></tr>

</table>
<style>
	.tab1 td,.tab1 th{
		text-align:center;
	}
</style>
<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="orderId"/>
<input type="hidden" name="status"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="act"/>
<table class="right-tab tab1" border="1" cellspacing="0" style="margin-top:20px;">
<tr id="tableonetr">
<th>商品厂商</th>
  <th>商品编号</th>
  <th>商品图片</th>
  <th>商品名称</th>
  <!-- <td>商品单价</td> -->
  <th>开票价格</th>
  <th>商品数量</th>
</tr>
<%
if(sum<1){
	out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else{
	Profile pf = Profile.find(so.getMember());
	  //根据订单id查询订单详情信息
	  Iterator it=ShopOrderData.find(sql.toString(),pos,Integer.MAX_VALUE).iterator();
	  for(int i=1;it.hasNext();i++){
	  ShopOrderData t=(ShopOrderData)it.next();
	  //判断product_id是否商品的id，如果不是则为套装id；最后产品或套装中的商品存入list中
      int product_id=t.getProductId();
      ShopProduct sp = ShopProduct.find(product_id);
      ShopPackage spage = new ShopPackage(0);
      List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
      String pname = "";
      if(t.getExpectedActivity()!=0){
    	  tpflag = 1;
      }
      hdstr = MT.f(t.getExpectedActivity());
      tmstr = MT.f(t.getExpectedDelivery());
      boolean isSell = false;
	  if(sp.isExist){
		  pname=sp.name[1];
		  if(t.getActivity()!=null&&!t.getActivity().equals("")){
			  ShopCategory sc = ShopCategory.find(sp.category);
			  pname += "&nbsp;<span style='color:red;'>【"+MT.f(sc.attribute)+"："+t.getActivity()+"】</span>";
		  }
		  if(sp.state==0)
			  isSell = true;
	  }else{
		  spage = ShopPackage.find(product_id);
		  pname="[套装]"+MT.f(spage.getPackageName());
		  ShopProduct s = ShopProduct.find(spage.getProduct_id());
		  if(s.state==0)
			  isSell = true;
		  spagePList.add(0,s);
		  String [] sarr = spage.getProduct_link_id().split("\\|");
		  for(int m=1;m<sarr.length;m++){
			  spagePList.add(m,ShopProduct.find(Integer.parseInt(sarr[m])));
		  }
	  }
	  ProcurementUnit pu1 = ProcurementUnit.find(sp.puid);
	  out.println("<tr><td>"+MT.f(pu1.getName())+"</td>");
		  out.println("<td align='center'>");
		  if(sp.isExist)
			  out.println(sp.yucode);
		  out.println("</td>");
		  out.println("<td align='center'>");
		  if(sp.isExist&&sp.picture!=null&sp.picture.length()>0)
			  out.println("<img src='"+MT.f(sp.getPicture('b'))+"' onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/>");
		  out.println("</td>");
		  out.println("<td style='text-align:left;'>"+pname);
		  if(t.getCalibrationDate()!=null&&!t.getCalibrationDate().equals("")){
			  if(Config.getInt("xinke")==sp.puid){
				  out.println("&nbsp;<span style='color:red;'>【校准时间："+MT.f(t.getCalibrationDate())+"】</span>");
			  }
		  }
		  out.println("</td>");
		  if(pf.getMembertype()==2){
			  if(so.isLzCategory()){
			  	//out.println("<td align='center' class='redsize'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getAgent_price_s(),2)+"</td>");
			  	out.println("<td align='center' class='redsize'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getAgent_price(),2)+"</td>");
			  }else{
				  //out.println("<td align='center' class='redsize'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getUnit(),2)+"</td>");
				  out.println("<td align='center' class='redsize'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getUnit(),2)+"</td>");
			  }
		  }else{
		  	//out.println("<td align='center' class='redsize'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getUnit(),2)+"</td>");
		  	out.println("<td align='center' class='redsize'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getUnit(),2)+"</td>");
		  }
		  out.println("<td align='center'>"+t.getQuantity()+"</td>");
		  out.println("</tr>");
		  
		  if(!sp.isExist){
			  for(int n=0;n<spagePList.size();n++){
				    ShopProduct s1 = spagePList.get(n);
				    String s1name = s1.name[1];
				    out.println("<tr class='tzP'><td style='text-align:center;'>"+s1.yucode+"</td>");
			    	out.println("<td style='text-align:center;'>");
			    	if(s1.picture!=null&s1.picture.length()>0)
			    		out.println("<a href='/html/folder/14110010-1.htm?product="+s1.product+"' target='_blank'><img src='"+MT.f(s1.getPicture('b'))+"' alt="+s1.name[1]+" onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/></a>");
			    	out.println("</td>");
			    	
			    	out.println("<td style='text-align:left;'>"+s1name+"</td>");
			    	//out.println("<td style='text-align:center;text-decoration:line-through;'><span style='font-size:13px;'>&yen;</span>"+MT.f(s1.price,2)+"</td>");
			    	out.println("<td>&nbsp;</td>");
			    	out.println("<td style='text-align:center;'>"+t.getQuantity()+"</td>");
			    	out.println("</tr>");
	  	  	  }
		  }
	  }
}
%>
	<tr><td colspan="6" style="text-align:right !important;" class='tagsize'>
		<%-- 商品总价：<span>&yen&nbsp;<%=MT.f((double)so.getAmount(),2)%></span>&nbsp;&nbsp;&nbsp;&nbsp; --%>
		开票金额：<span>&yen&nbsp;<%=price%></span>
	</td></tr>

</table>

<%
if(Config.getInt("junan")==mypuid){
	
	%>
	<table class="right-tab" border="1" cellspacing="0" style="margin-top:20px;">
<tr style="font-weight:bold;"><td colspan="4" align='left' style="font-size:15px;">调配信息</td></tr>
<tr>
	<td width="10%" align='right'>是否已调配</td><td align='left'><%= (tpflag==0?"否":"是") %></td>
</tr>
<%
	if(tpflag==1){
		%>
		<tr>
	<td width="10%" align='right'>校准时间</td><td align='left'><%= tmstr %></td>
</tr>
<tr>
	<td width="10%" align='right'>粒子活度</td><td align='left'><%= hdstr %></td></tr>
		<%
	}
%>
</table>
	<%
	
	List<StockOperation> solist = StockOperation.find(" AND oid = "+so.getId()+" AND type = 5 AND isRetreat = 0 ",0, Integer.MAX_VALUE);
	
	%>
	<table class="right-tab tab1" border="1" cellspacing="0" style="margin-top:20px;">
	<tr style="font-weight:bold;"><td colspan="6" style="text-align:left;font-size:15px;">库存信息</td></tr>
		<tr id="tableonetr">
		<th >序号</th>
		  <th >购买活度</th>
		  <th>质检号</th>
		  <th>批号</th>
		  <th>购买数量</th>
		  <th>有效期</th>
		</tr>
		<%
		if(solist.size()==0){
			out.print("<tr><td colspan='6' style='text-align:center;'>暂无记录</td></tr>");
		}else{
			for(int i=0;i<solist.size();i++){
				StockOperation son = solist.get(i);
				ProductStock pss = ProductStock.find(son.getPsid());
				out.print("<tr>");
				out.print("<td>"+(i+1)+"</td>");
				out.print("<td>"+son.getActivity()+"</td>");
				out.print("<td>"+pss.getQuality()+"</td>");
				out.print("<td>"+pss.getBatch()+"</td>");
				out.print("<td>");
				out.print(son.getAmount()+son.getReserve());
				out.print("</td>");
				out.print("<td>"+son.getValid()+"</td>");
				out.print("</tr>");
			}
		}
		%>
	</table>
	<%
	
}
%>

<br/>
	<div class="center text-c pd20">
		<button class="btn btn-default" type="button" onclick="printView('<%=MT.enc(orderId)%>')">打印预览</button>
	</div>
<%-- <button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button> --%>
</form>
	</div>
</div>
<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,oid,did)
{
  if(a=='refund')
  {
	  location.href="/jsp/yl/shopweb/ShopExchangedAdd.jsp?oid="+oid+"&did="+did;
  }
};

function printView(orderId){
	 window.open("/html/folder/14110866-1.htm?orderId="+orderId);
};
mt.fit();
</script>
</body>
</html>
