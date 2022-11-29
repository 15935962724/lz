<%@page import="tea.db.DbAdapter"%>
<%@page import="util.DateUtil"%>
<%@page import="java.math.BigDecimal"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="util.CommonUtils" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@ page import="util.Config" %><%

Http h=new Http(request,response);
CommonUtils utils = new CommonUtils();
	int qywxMember = h.getInt("qywxMember");
	if(qywxMember>0){
		h.member = qywxMember;
	}
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
String act=h.get("act");
int soeid=h.getInt("soeid");
int type=h.getInt("type");
String oid=h.get("orderId");

String nexturl = h.get("nexturl");

ShopOrder order = ShopOrder.findByOrderId(oid);


ShopOrderExpress seo=ShopOrderExpress.find(soeid);
if(request.getMethod().equals("POST")){
	if("yes".equals(act)){
		//order.set("status","3");
		order.set("status","-5");//复核通过后改变状态，变为待出库
		//发送短信给同辐出库管理员
		String user = Profile.find(h.member).getMember();
		ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+order.getPuid(),0,1);
		if(list.size() > 0){
			ShopSMSSetting sms = list.get(0);
			if(MT.f(sms.dck)!=""){
				List<String> mobiles = ShopSMSSetting.getUserMobile(sms.dck);
				if(!"".equals(MT.f(mobiles.toString())))
					SMSMessage.create("Home", user, mobiles.toString(), h.language, order.getOrderId()+"订单已入库，请出库！");
			}
		}
		/* //按照之前出库完成的通知
		//出厂信息
		ShopOrderExpress soe = ShopOrderExpress.findByOrderId(order.getOrderId());
		//订单附加
		ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(order.getOrderId());
		String querySql = " AND order_id="+DbAdapter.cite(order.getOrderId());
	  	List<ShopOrderData> sodList = ShopOrderData.find(querySql,0,Integer.MAX_VALUE);
	  	ShopOrderData odata = sodList.size() > 0 ?sodList.get(0):ShopOrderData.find(0);
		//获取短信内容
		String content = utils.getSms_content("ckwc");
		content = utils.replace(content, "", order.getOrderId(), soe.express_code, "",sod.getA_hospital(),sod.getA_consignees(),odata.getQuantity()+"");
		String user = Profile.find(h.member).getMember();
		//出库
		ArrayList<ShopSMSSetting> list = ShopSMSSetting.find("",0,1);
		if(list.size() > 0){
			ShopSMSSetting sms = list.get(0);
			List<String> mobiles = ShopSMSSetting.getUserMobile(sms.ckwc);
			if(!"".equals(MT.f(mobiles.toString())))
				SMSMessage.create(h.community, user, mobiles.toString(), h.language, content);
		}
		Profile pro = Profile.find(order.getMember());
		if(!"".equals(MT.f(pro.mobile,"")))
			SMSMessage.create(h.community, user, pro.mobile, h.language, content);
		
		//给收货人发送短信
		SMSMessage.create(h.community, user, sod.getA_mobile(), h.language, content); */
		
		out.print("<script>parent.mt.show('操作成功',1,'"+h.get("nexturl")+"')</script>");
		return;
	}else if("no".equals(act)){
		order.set("status","-4");//复核未通过
		seo.set("fuhereason", h.get("reason"));
		//发送短信给出库初审管理员和上海出库管理员
		String user = Profile.find(h.member).getMember();
		int mypuid = order.getPuid();//默认开票单位
		//查看开票单位 不是同辐
		if(Config.getInt("tongfu")==order.getPuid()){
			mypuid = ShopOrderData.findPuid(order.getOrderId());
		}

		ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+mypuid,0,1);
		//ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+order.getPuid(),0,1);
		if(list.size() > 0){
			ShopSMSSetting sms = list.get(0);
			if(MT.f(sms.ckcs)!=""){
				List<String> mobiles = ShopSMSSetting.getUserMobile(sms.ckcs);//发给出库初审管理员
				if(!"".equals(MT.f(mobiles.toString())))
					SMSMessage.create("Home", user, mobiles.toString(), h.language, order.getOrderId()+"订单的出库信息与检验报告不符，未通过入库审核，请等待上海出库管理员修改后再次审核！");
			}
			if(MT.f(sms.ckjgtz)!=""){
				List<String> mobiles2 = ShopSMSSetting.getUserMobile(sms.ckjgtz);//发给上海出库管理员
				if(!"".equals(MT.f(mobiles2.toString())))
					SMSMessage.create("Home", user, mobiles2.toString(), h.language, order.getOrderId()+"订单的出库信息与检验报告不符，未通过入库审核，请修改！");
			}
		}
		out.print("<script>parent.mt.show('操作成功',1,'"+h.get("nexturl")+"')</script>");
		return;
	}
	
}
List<ShopOrderData> sodList = ShopOrderData.find(" AND order_id="+DbAdapter.cite(oid),0,Integer.MAX_VALUE);
ShopOrderData t = sodList.get(0);
ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(oid);

%><!DOCTYPE html><html><head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/res/jquery-1.11.1.min.js" type="text/javascript"></script>
</head>
<body>
<h1>出厂信息</h1>


<form name="form1" id="form1" action="?" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return checked(this)">
<input type="hidden" name="orderId" value="<%=oid%>"/>
<input type="hidden" name="soeid" value="<%=soeid%>"/>
<input type="hidden" name="type" value="<%=type%>"/>
<input type="hidden" name="act" value="fushen"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="serveridwai" id="serveridwai" value="<%=MT.f(seo.images) %>"/>
	<input type="hidden" name="qywxMember" value="<%=qywxMember%>" />
<input type="hidden" name="reason" />
<div class='radiusBox newlist'>
<ul>
	    <li class="bold" data-resourelist="shouhuo" data-slideup="up">订单基本信息</li>
		<li><span>医院：</span><%=MT.f(sod.getA_hospital())%></li>
		<li><span>活度：</span><%=t.getActivity() %></li>
	    
	    <li><span>数量：</span><%=t.getQuantity() %></li>
	    <li><span>校准日期：</span><%=MT.f(t.getCalibrationDate()) %></li>
		
		
	</ul>
	<ul>
		<li class="bold" data-resourelist="beizhu" data-slideup="up">订单备注 </li>
	   
			<li style="color:red"><%out.print(order.getUserRemarks()==null||order.getUserRemarks().length()<1?"无":MT.f(order.getUserRemarks())); %></li>
	    
	</ul>
	<ul>
	    <li class="bold" data-resourelist="shouhuo" data-slideup="up">出厂信息</li>
		<li><span>销售编号：</span><%=MT.f(seo.NO1)%></li>
		<li><span>生产批号：</span><%=MT.f(seo.NO2)%></li>
	    
	    <li><span>有效期：</span><%=MT.f(seo.vtime)==""?DateUtil.addMonth(MT.f( order.getCreateDate()), 5):MT.f(seo.vtime)%></li>
	    <li><span>发货日期：</span><%=MT.f(seo.time,1)%></li>
		<li><span>运单号：</span><%=MT.f(seo.express_code)%></li>
		<li><span>发件人：</span><%=MT.f(seo.person)%></li>
		<li><span>联系电话：</span><%=MT.f(seo.mobile)%></li>
		<li><span>图片：</span>
		<div id="canvasDiv" >
     <%
     	if(MT.f(seo.images).length()>0){
     		String[] imgarr=seo.images.split(",");
     		for(int i=0;i<imgarr.length;i++){
     			Attch attch=Attch.find(Integer.parseInt(imgarr[i]));
     			String imgsr=attch.path;
     %>
     <img src="<%=imgsr %>" width="300px" height="300px">
     <%
     		}
     	}
     %>
     </div>
		</li>
		<%
  	if(MT.f(seo.fuhereason).length()>0&&order.getStatus()==-4){
  %>
  <li><span>入库拒绝原因：</span><%=MT.f(seo.fuhereason) %></li>
  <%
  	}
  %>
		
		
	<li>
			 <%
 	if(order.getStatus()==-2){
 %>
    
    <button class="btn btn-default" type="button" onclick="mt.act('yes')">入库通过</button>
    <button class="btn btn-default" type="button" onclick="mt.act('no')">入库不通过</button>
    
 <%
 	}
 %>  
			    	
			    	<button class="btn btn-default" type="button" onclick="history.back();">返回</button>
			    </li>
		</div>
</form>	
		</div>


<script>

mt.act=function(a)
{
  form1.act.value=a;
  
  if(a=='yes')
  {
    mt.show('你确定入库通过吗？',2,'form1.submit()');
  }else if(a=='no')
  {
	//mt.show("<textarea></textarea>");
	//mt.show('你确定审核不通过吗？',2,'form1.submit()');
	 mt.show("<textarea id='_q' cols='28' rows='5'></textarea>",2,"拒绝原因");
	  mt.ok=function()
	  {
	    var v=document.getElementById("_q").value;
		if(v==''||v=='undefined')return;
		
		form1.reason.value = v;
		form1.submit();
		
	  }
  }
}
</script>
</body>
</html>
