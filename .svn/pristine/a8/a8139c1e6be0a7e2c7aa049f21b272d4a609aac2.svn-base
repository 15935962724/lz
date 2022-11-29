<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.yl.shop.ShopPackage"%>
<%@page import="tea.entity.yl.shop.ShopProduct"%>
<%@page import="tea.entity.yl.shop.ShopOrderData"%>
<%@page import="com.alipay.util.AlipaySubmit"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.ShopOrder"%>
<%@page import="tea.entity.admin.Payinstall"%>
<%@page import="tea.entity.site.Community"%>
<%@page import="tea.entity.Http"%>
<%@ page  contentType="text/html; charset=UTF-8"%>

<% 
request.setCharacterEncoding("UTF-8");

Http h=new Http(request);
Community community=Community.find(h.community);
String orderid=h.get("orderid");
StringBuffer sp = new StringBuffer();

//判断是否有支付宝设置

Payinstall pobj2 = Payinstall.findpay(2);
double totalprices = 0;//订单总价格
String goodname = "";// 商品名称
ArrayList list= ShopOrder.find(" and member="+h.member+" and order_id="+DbAdapter.cite(orderid),0,1);
if(list.size()>0){
	ShopOrder so=(ShopOrder)list.get(0);
	totalprices=so.getAmount();
	ArrayList list2= ShopOrderData.find(" and order_id="+DbAdapter.cite(orderid), 0, 2);
	if(list2.size()>0){
		ShopOrderData sod=(ShopOrderData)list2.get(0);
		ShopProduct spd=ShopProduct.find(sod.getProductId());
		if(spd.isExist){
			goodname =spd.name[1];
		}else{
			ShopPackage spage = ShopPackage.find(sod.getProductId());
			goodname="[套装]"+MT.f(spage.getPackageName());
		}
		if(list2.size()>1)goodname+="等多件";
	}
	if(so.getStatus()!=0&&so.getStatus()!=4){
		out.print("<script>alert('您的订单已经支付!');window.close();</script>");
		return;
	}
	sp.append("订单号：").append(orderid).append("-");
	sp.append("姓名：").append(so.getMember()+"　");
	sp.append("手机号：").append("　");
}else{
	out.print("<script>alert('您支付的订单不存在!');window.close();</script>");
	return;
}

String url = "http://"+request.getServerName()+":"+request.getServerPort();


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<meta HTTP-EQUIV="Expires" CONTENT="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>支付宝支付</title>
</head>

<script>

</script>
<%
Date Now_Date=new Date();
String paygateway	=	"https://www.alipay.com/cooperate/gateway.do?";	//'支付接口
String service      = "create_direct_pay_by_user";//快速付款交易服务
String sign_type       =   "MD5"; 
String out_trade_no		= orderid;	
String input_charset   =  "utf-8";
String partner			=	pobj2.getMerchant().trim();//"2088702105602214"; //支付宝合作伙伴id (账户内提取)
String key             =    pobj2.getSafety().trim();//"yfylsgs1licj174z8ify03dsqtdnry4b"; //支付宝安全校验码(账户内提取)
String body			= sp.toString(); //商品描述，推荐格式：商品名称（订单编号：订单编号）
String total_fee			="0.01";//String.valueOf(totalprices);	//订单总价
String payment_type     = "1";//支付宝类型.1代表商品购买
String seller_email		= pobj2.getPayeail();//"13501369877";		 //卖家支付宝帐户 
String subject			= goodname;//商品名称
String show_url        =  url; 
String notify_url		= url+pobj2.getProcessurl();//"/jsp/pay/Event_alipay/alipay_notify.jsp";					//通知接收URL
String return_url		= url+pobj2.getReturnurl();//"/jsp/pay/Event_alipay/alipay_return.jsp";	//支付完成后跳转返回的网址URL
//防钓鱼时间戳
String anti_phishing_key = "";
//若要使用请调用类文件submit中的query_timestamp函数

//客户端的IP地址
String exter_invoke_ip = "";
//非局域网的外网IP地址，如：221.0.0.1
//String ItemUrl=Payment.CreateUrl(paygateway,service,sign_type,out_trade_no,input_charset,partner,key,show_url,body,total_fee,payment_type,seller_email,subject,notify_url,return_url);
//把请求参数打包成数组
		Map<String, String> sParaTemp = new HashMap<String, String>();
		sParaTemp.put("service",service);
      sParaTemp.put("partner", partner);
      sParaTemp.put("_input_charset","utf-8");
		sParaTemp.put("payment_type", payment_type);
		sParaTemp.put("notify_url", notify_url);
		sParaTemp.put("return_url", return_url);
		sParaTemp.put("seller_email", seller_email);
		sParaTemp.put("out_trade_no", out_trade_no);
		sParaTemp.put("subject", subject);
		sParaTemp.put("total_fee", total_fee);
		sParaTemp.put("body", body);
		sParaTemp.put("show_url", show_url);
		sParaTemp.put("anti_phishing_key", anti_phishing_key);
		sParaTemp.put("exter_invoke_ip", exter_invoke_ip);
		
		//建立请求
		String sHtmlText = AlipaySubmit.buildRequest(sParaTemp,"get","确认");
		out.println(sHtmlText);
%> 

<body  onLoad="E_FORM.submit();"> 
</body>
</html>
