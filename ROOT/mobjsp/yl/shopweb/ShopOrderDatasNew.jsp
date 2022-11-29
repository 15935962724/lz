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
		Profile profile1 = Profile.find(h.member);
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

%><!DOCTYPE html>
		<html>
		<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,user-scalable=0">
		<title>粒子订单</title>


		<!-- <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
		--><script src="/tea/mt.js" type="text/javascript"></script>
		<script src="/jsp/sup/sup.js" type="text/javascript"></script>
		<script src="/tea/view.js" type="text/javascript"></script>
		<script src="/tea/jquery-1.11.1.min.js"></script>
		<link rel="stylesheet" href="/tea/mobhtml/m-style.css">
		<script src="/tea/new/js/jquery.min.js"></script>
		<script src="/tea/new/js/superslide.2.1.js"></script>
		<script src="/tea/yl/mtDiag.js"></script>

		</head>
		<style>
		.order-sq{float:right;color:#f25f1c;cursor: pointer;}
		</style>
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

		<div class="body">
		<div class="detail-list">
		<p class="detail-tit ft16">订单信息<em class='order-sq'>收起</em></p>
		<ul class="ft14">
		<li>
		<span class="list-spanr3 fl-left">订单编号：</span>
		<span class="list-spanr fl-left"><%=MT.f(so.getOrderId()) %></span>
		</li>
		<li>
		<span class="list-spanr3 fl-left">下单时间：</span>
		<span class="list-spanr fl-left"><%=MT.f(so.getCreateDate(),1) %></span></li>
		<li>
		<span class="list-spanr3 fl-left">当前状态：</span>
		<span class="list-spanr fl-left" ><%=MT.f(statusContent) %></span>
		</li>
		<li>
		<span class="list-spanr3 fl-left">支付方式：</span>
		<span class="list-spanr fl-left"><%out.print(so.getPayType()==1?"在线支付":"公司转账"); %></span>
		</li>
			<%
				int mypuid = ShopOrderData.findPuid(so.getOrderId());
				if(mypuid==Config.getInt("junan")){
			%>
		<li>
		<span class="list-spanr3 fl-left">是否调配：</span>
		<span class="list-spanr fl-left"><%= (so.getAllocate()==0?"否":"是") %></span>
		</li>
			<%
					if(so.getAllocate()==1){
						out.print("<li><span class=\"list-spanr3 fl-left\">支付方式：</span><span class=\"list-spanr fl-left\">"+(so.getAllocatetype()==0?"同意":"不同意")+"</span></li>");
					}else{

					}
				%>

			<%
				}
			%>
			<%
				if(so.getStatus()==5)
				{
			%>
		<li>
		<span class="list-spanr3 fl-left">取消原因</span><span class="list-spanr fl-left"><%=MT.f(so.getCancelReason()) %></span>
		</li>
			<%
				}
			%>
		</ul>
		</div>
		<div class="detail-list">
		<p class="detail-tit ft16">收货人信息<em class='order-sq'>收起</em></p>
		<ul class="ft14">

		<li>
		<span class="list-spanr3 fl-left">收件人：</span>
		<span class="list-spanr fl-left"><%=MT.f(sod.getA_consignees())%></span>
		</li>
		<li>
		<span class="list-spanr3 fl-left">联系电话：</span>
		<span class="list-spanr fl-left"><%=MT.f(sod.getA_mobile())%></span>
		</li>
		<li>
		<span class="list-spanr3 fl-left">固定电话：</span>
		<span class="list-spanr fl-left"><%=MT.f(sod.getA_telphone())%></span>
		</li>
		<li>
		<span class="list-spanr3 fl-left">邮编：</span>
		<span class="list-spanr fl-left"><%=MT.f(sod.getA_zipcode())%></span>
		</li>
		<li>
		<span class="list-spanr3 fl-left">地址：</span>
		<span class="list-spanr fl-left"><%=MT.f(sod.getA_address())%></span>
		</li>
		</ul>
		</div>
			<%
		if(so.getStatus()==3||so.getStatus()==4)
		{
			ShopOrderExpress soe = ShopOrderExpress.findByOrderId(so.getOrderId());
			if(soe.time!=null)
			{
	%>
		<div class="detail-list">
		<p class="detail-tit ft16">发货信息<em class='order-sq'>收起</em></p>
		<ul class="ft14">
		<li>
		<span class="list-spanr3 fl-left">快递单号：</span>
		<span class="list-spanr fl-left"><%=MT.f(soe.express_code)%></span>
		</li>
		<li>
		<span class="list-spanr3 fl-left">销售编号：</span>
		<span class="list-spanr fl-left"><%=MT.f(soe.NO1)%></span>
		</li>
		<li>
		<span class="list-spanr3 fl-left">生产批号：</span>
		<span class="list-spanr fl-left"><%=MT.f(soe.NO2)%></span>
		</li>
			<%
				if(Config.getInt("junan")!=mypuid){
			%>
		<li>
		<span class="list-spanr3 fl-left">有效期：</span>
		<span class="list-spanr fl-left"><%=MT.f(soe.vtime)%></span>
		</li>
			<%
				}
			%>
		<li>
		<span class="list-spanr3 fl-left">发货日期：</span>
		<span class="list-spanr fl-left"><%=MT.f(soe.time)%></span>
		</li>
		<li>
		<span class="list-spanr3 fl-left">发件人：</span>
		<span class="list-spanr fl-left"><%=MT.f(soe.person)%></span>
		</li>
		<li>
		<span class="list-spanr3 fl-left">联系电话：</span>
		<span class="list-spanr fl-left"><%=MT.f(soe.mobile)%></span>
		</li>
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

					out.print("<li><span class='list-spanr3 fl-left'>快递图片：</span><span class='list-spanr fl-left'><img src='"+imgsr+"' width='300px' height='300px' ></span></li>");
				}

			%>
		</ul>
		</div>
			<%
			}
		}
	%>
		<div class="detail-list">
		<p class="detail-tit ft16">发票信息<em class='order-sq'>收起</em></p>
		<ul class="ft14">
		<li>
		<span class="list-spanr3 fl-left">开票单位：</span>
		<span class="list-spanr fl-left"><%
					out.print(ProcurementUnit.findName(so.getPuid()));
				%></span>
		</li>
			<%
				if(so.getInvoiceStatus()==3)
				{
					ShopOrderExpress seo=ShopOrderExpress.findByOrderId(orderId);
			%>
		<li>
		<span class="list-spanr3 fl-left">开票状态：</span>
		<span class="list-spanr fl-left">已开具</span></li>
		<li>
		<span class="list-spanr3 fl-left">开票金额：</span>
		<span class="list-spanr fl-left" ><%= price%></span>
		</li>
		<li>
		<span class="list-spanr3 fl-left">发票单号：</span>
		<span class="list-spanr fl-left" ><%=MT.f(sod.getN_invoiceNo())%></span>
		</li>
		<li>
		<span class="list-spanr3 fl-left">快递单号：</span>
		<span class="list-spanr fl-left" ><%=MT.f(sod.getN_expressNo())%></span>
		</li>
			<%
			}else
			{
			%>
		<li>
		<span class="list-spanr3 fl-left">开票状态：</span>
		<span class="list-spanr fl-left" >未开具</span>
		</li>
		<li>
		<span class="list-spanr3 fl-left">开票金额：</span>
		<span class="list-spanr fl-left" ><%= price%></span>
		</li>
			<%
				}
			%>
		<li>
		<span class="list-spanr3 fl-left">开票单位：</span>
		<span class="list-spanr fl-left"><%=MT.f(sod.getN_company())%></span>
		</li>
		<li>
		<span class="list-spanr3 fl-left">发票接收人：</span>
		<span class="list-spanr fl-left"><%=MT.f(sod.getN_consignees())%></span>
		</li>
		<li>
		<span class="list-spanr3 fl-left">联系电话：</span>
		<span class="list-spanr fl-left"><%=MT.f(sod.getN_telphone())%></span>
		</li>
		<li>
		<span class="list-spanr3 fl-left">地址：</span>
		<span class="list-spanr fl-left"><%=MT.f(sod.getN_address())%></span>
		</li>
		</ul>
		</div>
		<div class="detail-list">
		<p class="detail-tit ft16">订单备注<em class='order-sq'>收起</em></p>

		<p class="detail-bz"><%if(profile1.getMembertype()==1||profile1.getMembertype()==0){
		    out.print("无");%></p>
		<%}else {
			out.print(so.getUserRemarks()==null||so.getUserRemarks().length()<1?"无":MT.f(so.getUserRemarks())); %></p>
		<%}%>
		</div>
		<div class="detail-list">
		<p class="detail-tit ft16">商品信息<em class='order-sq'>收起</em></p>
		<table class="detail-tab" border="1">
			<%
				if(sum<1){
					out.print("<tr><td colspan='2' align='center'>暂无记录!</td></tr>");
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
						out.println("<tr><td class=td1>商品厂商</td><td>"+MT.f(pu1.getName())+"</td></tr>");
						out.println("<tr><td class=td1>商品编号</td><td>");
						if(sp.isExist)
							out.println(sp.yucode);
						out.println("</td></tr>");
						out.println("<tr><td class=td1>商品图片</td><td>");
						if(sp.isExist&&sp.picture!=null&sp.picture.length()>0)
							out.println("<a  target='_blank'><img src='"+MT.f(sp.getPicture('b'))+"'  onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/></a>");
						out.println("</td></tr>");
						out.println("<tr><td class=td1>开票名称</td><td>"+pname);
						if(t.getCalibrationDate()!=null&&!t.getCalibrationDate().equals("")){
							if(Config.getInt("xinke")==sp.puid){
								out.println("&nbsp;<span style='color:red;'>【校准时间："+MT.f(t.getCalibrationDate())+"】</span>");
							}
						}
						out.println("</td></tr>");
						if(pf.getMembertype()==2){
							if(so.isLzCategory()){
								//out.println("<td align='center' class='redsize'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getAgent_price_s(),2)+"</td>");
								out.println("<tr><td class=td1>开票价格</td><td class='redsize'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getAgent_price(),2)+"</td></tr>");
							}else{
								//out.println("<td align='center' class='redsize'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getUnit(),2)+"</td>");
								out.println("<tr><td class=td1>开票价格</td><td class='redsize'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getUnit(),2)+"</td></tr>");
							}
						}else{
							//out.println("<td align='center' class='redsize'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getUnit(),2)+"</td>");
							out.println("<tr><td class=td1>开票价格</td><td class='redsize'><span style='font-size:13px;'>&yen;</span>"+MT.f((double)t.getUnit(),2)+"</td></tr>");
						}
						out.println("<tr><td class=td1>数量</td><td>"+t.getQuantity()+"</td></tr>");

						if(!sp.isExist){
							/*for(int n=0;n<spagePList.size();n++){
								ShopProduct s1 = spagePList.get(n);
								String s1name = s1.name[1];
								out.println("<tr class='tzP'><td style='text-align:center;'>"+s1.yucode+"</td>");
								out.println("<td style='text-align:center;'>");
								if(s1.picture!=null&s1.picture.length()>0)
									out.println("<a href='/html/folder/14110010-1.htm?product="+s1.product+"' target='_blank'><img src='"+MT.f(s1.getPicture('b'))+"'  onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/></a>");
								out.println("</td>");

								out.println("<td style='text-align:left;'>"+s1name+"</td>");
								//out.println("<td style='text-align:center;text-decoration:line-through;'><span style='font-size:13px;'>&yen;</span>"+MT.f(s1.price,2)+"</td>");
								out.println("<td>&nbsp;</td>");
								out.println("<td style='text-align:center;'>"+t.getQuantity()+"</td>");
								out.println("</tr>");
							}*/
						}
					}
				}
			%>
		<tr><td class=td1>开票金额</td>
		<%-- 商品总价：<span>&yen&nbsp;<%=MT.f((double)so.getAmount(),2)%></span>&nbsp;&nbsp;&nbsp;&nbsp; --%>
		<td><span>&yen&nbsp;<%=price%></span>
		</td></tr>
		</table>
		</div>
		</div>


			<%
if(Config.getInt("junan")==mypuid){

	%>
		<div class="detail-list">
		<p class="detail-tit ft16">调配信息</p>
		<ul class="ft14">
		<li>
		<span class="list-spanr3 fl-left">是否已调配：</span>
		<span class="list-spanr fl-left" ><%= (tpflag==0?"否":"是") %></span>
		</li>
			<%
			if(tpflag==1){
		%>
		<li>
		<span class="list-spanr3 fl-left">校准时间：</span>
		<span class="list-spanr fl-left" ><%= tmstr %></span>
		</li>
		<li>
		<span class="list-spanr3 fl-left">粒子活度：</span>
		<span class="list-spanr fl-left" ><%= hdstr %></span>
		</li>
			<%
			}
		%>
		</ul>
		</div>
			<%

	List<StockOperation> solist = StockOperation.find(" AND oid = "+so.getId()+" AND type = 5 AND isRetreat = 0 ",0, Integer.MAX_VALUE);

%>
		<div class="detail-list">
		<p class="detail-tit ft16">库存信息</p>
		<table class="detail-tab" border="1">
			<%
			if(solist.size()==0){
				out.print("<tr><td colspan='2' style='text-align:center;'>暂无记录</td></tr>");
			}else{
				for(int i=0;i<solist.size();i++){
					StockOperation son = solist.get(i);
					ProductStock pss = ProductStock.find(son.getPsid());
					//out.print("<tr><td class=td1></td><td>"+(i+1)+"</td></tr>");
					out.print("<tr><td class=td1>购买活度</td><td>"+son.getActivity()+"</td></tr>");
					out.print("<tr><td class=td1>质检号</td><td>"+pss.getQuality()+"</td></tr>");
					out.print("<tr><td class=td1>批号</td><td>"+pss.getBatch()+"</td></tr>");
					out.print("<tr><td class=td1>购买数量</td><td>");
					out.print(son.getAmount()+son.getReserve());
					out.print("</td></tr>");
					out.print("<tr><td class=td1>有效期</td><td>"+son.getValid()+"</td></tr>");

				}
			}
		%>
		</table>
		</div>

			<%
	
}
%>

		<br/>

		<%-- <button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button> --%>
		</form>
		</div>
		</div>
		<script>
		$('.order-sq').click(function(){
			if($(this).parent().next().is(":hidden")){
				$(this).html('收起');
				$(this).parent().next().slideDown();
			}else if($(this).parent().next().is(":visible")){
				$(this).html('展开');
				$(this).parent().next().slideUp();
			}
		})

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
