<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.SeqShop"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String orderId = h.get("orderId");
//根据订单id查询订单信息
ShopOrder so = ShopOrder.findByOrderId(orderId);

//根据订单id查询订单详情信息
List<ShopOrderData> sodList = ShopOrderData.find(" AND order_id="+DbAdapter.cite(orderId),0,Integer.MAX_VALUE);
ShopOrderData sd = sodList.get(0);

String nexturl = h.get("nexturl");
int flag=0;//是否展示确认退货按钮 1为展示
%><!DOCTYPE html><html><head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">

<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>
<title>申请退换货</title>

</head>
<body>
<%
String act=h.get("act");
/* if(request.getMethod().equals("POST")){
	if("yesexchange".equals(act)){
		ShopExchanged shopexchanged=ShopExchanged.findByOrderId(orderId);
		shopexchanged.set("exchangedstatus", "1");//服务商确认
		shopexchanged.set("exchangedtime", MT.f(new Date(),1));
		//out.print("<script>alert('"+nexturl+"');</script>");
		//积分和负数订单
		if(shopexchanged.type==1){
			ShopOrder so2 = ShopOrder.findByOrderId(shopexchanged.orderId);
			//退货减积分
			try{
				ShopOrderData sod = ShopOrderData.find(" AND order_id = "+Database.cite(shopexchanged.orderId)+" and product_id = "+shopexchanged.product_id, 0, 1).get(0);
				double prices = sod.getUnit() * shopexchanged.exchangednum;
				int status= ShopMyPoints.creatPoint(shopexchanged.member,"退货减积分"+(int)prices,(-(int)prices), null);
			}catch(Exception e){
				
			}
			//退货增加负数数量和负数金额的订单，同时记录当前时间
			//增加shoporder表记录
			ShopOrder neworder=ShopOrder.find(0);
			neworder.setOrderId("PO"+SeqShop.get());
			neworder.setMember(shopexchanged.member);
			neworder.setCreateDate(so2.getCreateDate());//旧订单的时间
			neworder.setStatus(7);
			neworder.setReturntime(new Date());
			neworder.setOldorderid(shopexchanged.orderId);
			neworder.setLzCategory(so2.isLzCategory());
			neworder.set();
			//增加shoporderdata表记录
			List<ShopOrderData> lstolddata=ShopOrderData.find(" and order_id = "+Database.cite(shopexchanged.orderId), 0, Integer.MAX_VALUE);
			if(lstolddata.size()>0){
				ShopOrderData olddata=lstolddata.get(0);//每个订单只有一种产品，所以只取一个
				double danjia=so2.getAmount()/olddata.getQuantity();
				//neworder.setAmount(-(danjia*sec.quantity));//设置订单的amount
				neworder.set("amount", String.valueOf(-(danjia*shopexchanged.exchangednum)));
				neworder.set("noinvoicenum", String.valueOf(-shopexchanged.exchangednum));//未开票数量也为负数
				ShopOrderData newdata=ShopOrderData.find(0);
				newdata.setOrderId(neworder.getOrderId());
				newdata.setProductId(olddata.getProductId());
				newdata.setUnit(olddata.getUnit());
				newdata.setQuantity(-shopexchanged.exchangednum);//负数的退货数量
				newdata.setAmount(-(olddata.getUnit()*shopexchanged.exchangednum));//负数的退货金额
				newdata.setCalibrationDate(olddata.getCalibrationDate());
				newdata.setActivity(olddata.getActivity());
				newdata.setAgent_price_s(olddata.getAgent_price_s());
				newdata.setAgent_price(olddata.getAgent_price());
				newdata.setAgent_amount(-(olddata.getAgent_price()*shopexchanged.exchangednum));//负数的开票金额
				newdata.set();
			}
			//增加ShopOrderDispatch表记录
			ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(neworder.getOrderId());
			ShopOrderDispatch sodold = ShopOrderDispatch.findByOrderId(shopexchanged.orderId);
			//添加收货人地址信息
			sod.setA_consignees(MT.f(sodold.getA_consignees()));
			sod.setA_address(MT.f(sodold.getA_address()));
			sod.setA_mobile(MT.f(sodold.getA_mobile()));
			sod.setA_hospital_id(sodold.getA_hospital_id());
			sod.setA_telphone(MT.f(sodold.getA_telphone()));
			sod.setA_zipcode(MT.f(sodold.getA_zipcode()));
			
			sod.setA_hospital(MT.f(sodold.getA_hospital())); 		//医院
			sod.setA_department(MT.f(sodold.getA_department()));	//科室
			sod.set();
		}
		out.print("<script>parent.mt.show('操作执行成功！',1,'"+nexturl+"');</script>");
		return;
	}
} */
%>
<header class="header"><!-- <a href="javascript:history.go(-1)"></a> -->申请退换货</header>

<div class='radiusBox newlist wSpan'>
<ul class="seachr">
<li class='bold'>申请退换货</li>
<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="orderId"/>
<input type="hidden" name="status"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="act"/>

<li><span>粒子活度：</span><%= sd.getActivity()+" X "+ sd.getQuantity()%></li>
<li><span>校准时间：</span><%=MT.f(sd.getCalibrationDate()) %></li>
<%
	ShopExchanged se0 = ShopExchanged.findByOrderId(orderId);
	if(se0.status==2){
		List<SetExchangedRecord> record=SetExchangedRecord.find(" and exchangeid="+se0.id, 0, Integer.MAX_VALUE);
		if(record.size()>0){
			%>
			<li><span>申请退货数量：</span><%=MT.f(se0.quantity) %></li>
			<li><span>实际退货数量：</span><%=MT.f(se0.exchangednum) %></li>
			<%
		}
	}else if(se0.status==1){
		
			%>
			<li><span>申请退货数量：</span><%=MT.f(se0.quantity) %></li>
			<li><span>实际退货数量：</span><%=MT.f(se0.quantity) %></li>
			<%
		
	}else if(se0.status==0&&se0.id>0){
		out.print("<li><span>申请退货数量：</span>"+MT.f(se0.quantity)+"</li>");
	}
%>

<%
if(so.getStatus()==4){
	out.println("<li>");
    ShopExchanged se = ShopExchanged.findByOrderId(orderId);
    if(se.id>0){
    	if(se.status==0){
    		out.println("正在进行中");
    	}else if(se.status==1){
     		out.println("已完成");
     	}else if(se.status==2){
     		List<SetExchangedRecord> record=SetExchangedRecord.find(" and exchangeid="+se.id, 0, Integer.MAX_VALUE);
  		  	  if(se.status==2&&record.size()>0){
	  			  flag=1;
	  			  if(se.exchangedstatus==1||se.exchangedstatus==2){
	  				  flag=0;
	  			  }
	  			  out.println("已修改退货数量");
	  		  }else{
	  			  out.println("已拒绝");
	  		  }
     	}
     		
	}else{
		//out.println("<button type='button' class='returnbtn' value='申请退换货' onClick=\"mt.act('refund','"+MT.enc(orderId)+"','"+MT.enc(t.getId())+"');\">申请退换货</button>");
		out.println("<button type='button' class='returnbtn' value='申请退换货' onClick=\"mt.act('refund','"+orderId+"');\">申请退换货</button>");
	}
	if(flag==1){
		out.println("<button type='button' class='returnbtn' onClick=\"mt.act('yesexchange','"+orderId+"');\">确认退货数量</button>");
	}

	out.println("</li>");
}
%>

</ul>
</div>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,oid,did)
{
  if(a=='refund')
  {
	  //ShopExchangedAdd.jsp
	  //parent.location="/xhtml/folder/14111211-1.htm?oid="+oid+"&did="+did;
	  parent.location="/mobjsp/yl/shopweb/ShopExchangedAdd_wx.jsp?oid="+oid;//+"&did="+did;
  }else(a=='yesexchange')
  {
	  form2.action="/ShopExchangeds.do";
	  form2.act.value=a;
	  form2.orderId.value=oid;
	  form2.submit();
	  
  }
};
//mt.fit();
</script>
</body>
</html>
