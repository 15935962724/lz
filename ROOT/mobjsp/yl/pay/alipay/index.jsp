<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.yl.shop.ShopPackage"%>
<%
/* *
 *功能：手机网页支付接入页
 *版本：3.3
 *日期：2012-08-14
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。

 *************************注意*****************
 *如果您在接口集成过程中遇到问题，可以按照下面的途径来解决
 *1、商户服务中心（https://b.alipay.com/support/helperApply.htm?action=consultationApply），提交申请集成协助，我们会有专业的技术工程师主动联系您协助解决
 *2、商户帮助中心（http://help.alipay.com/support/232511-16307/0-16307.htm?sh=Y&info_type=9）
 *3、支付宝论坛（http://club.alipay.com/read-htm-tid-8681712.html）
 *如果不想使用扩展功能请把扩展功能参数赋空值。
 **********************************************
 */
%>
<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ page import="com.mobalipay.config.*"%>
<%@ page import="com.mobalipay.util.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.net.URLDecoder"%>
<%@page import="tea.entity.yl.shop.ShopProduct"%>
<%@page import="tea.entity.yl.shop.ShopOrderData"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.ShopOrder"%>
<%@page import="tea.entity.admin.Payinstall"%>
<%@page import="tea.entity.site.Community"%>
<%@page import="tea.entity.Http"%>
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
		<title>支付宝手机网页支付</title>
	</head>
	<%
		//支付宝网关地址
		String ALIPAY_GATEWAY_NEW = "http://wappaygw.alipay.com/service/rest.htm?";
		//返回格式
		String format = "xml";
		//必填，不需要修改
		
		//返回格式
		String v = "2.0";
		//必填，不需要修改
		
		//请求号
		String req_id = UtilDate.getOrderNum();
		//必填，须保证每次请求都是唯一
		
		//req_data详细信息
		
		//服务器异步通知页面路径
		String notify_url = url+"/mobjsp/yl/pay/alipay/alipay_notify.jsp";
		//需http://格式的完整路径，不能加?id=123这类自定义参数

		//页面跳转同步通知页面路径
		String call_back_url = url+"/mobjsp/yl/pay/alipay/alipay_return.jsp";
		//需http://格式的完整路径，不能加?id=123这类自定义参数，不能写成http://localhost/

		//操作中断返回地址
		String merchant_url = url+pobj2.getPayurl();
		//用户付款中途退出返回商户的地址。需http://格式的完整路径，不允许加?id=123这类自定义参数

		//卖家支付宝帐户
		String seller_email = pobj2.getPayeail();
		//必填

		//商户订单号
		String out_trade_no = orderid;
		//商户网站订单系统中唯一订单号，必填

		//订单名称
		String subject = goodname;
		//必填

		//付款金额
		String total_fee = "0.01";//String.valueOf(totalprices)
		//必填
		
		//请求业务参数详细
		String req_dataToken = "<direct_trade_create_req><notify_url>" + notify_url + "</notify_url><call_back_url>" + call_back_url + "</call_back_url><seller_account_name>" + seller_email + "</seller_account_name><out_trade_no>" + out_trade_no + "</out_trade_no><subject>" + subject + "</subject><total_fee>" + total_fee + "</total_fee><merchant_url>" + merchant_url + "</merchant_url></direct_trade_create_req>";
		//必填
		
		//////////////////////////////////////////////////////////////////////////////////
		
		//把请求参数打包成数组
		Map<String, String> sParaTempToken = new HashMap<String, String>();
		sParaTempToken.put("service", "alipay.wap.trade.create.direct");
		sParaTempToken.put("partner", AlipayConfig.partner);
		sParaTempToken.put("_input_charset", AlipayConfig.input_charset);
		sParaTempToken.put("sec_id", AlipayConfig.sign_type);
		sParaTempToken.put("format", format);
		sParaTempToken.put("v", v);
		sParaTempToken.put("req_id", req_id);
		sParaTempToken.put("req_data", req_dataToken);
		
		//建立请求
		String sHtmlTextToken = AlipaySubmit.buildRequest(ALIPAY_GATEWAY_NEW,"", "",sParaTempToken);
		//URLDECODE返回的信息
		sHtmlTextToken = URLDecoder.decode(sHtmlTextToken,AlipayConfig.input_charset);
		//获取token
		String request_token = AlipaySubmit.getRequestToken(sHtmlTextToken);
		//out.println(request_token);
		
		////////////////////////////////////根据授权码token调用交易接口alipay.wap.auth.authAndExecute//////////////////////////////////////
		
		//业务详细
		String req_data = "<auth_and_execute_req><request_token>" + request_token + "</request_token></auth_and_execute_req>";
		//必填
		
		//把请求参数打包成数组
		Map<String, String> sParaTemp = new HashMap<String, String>();
		sParaTemp.put("service", "alipay.wap.auth.authAndExecute");
		sParaTemp.put("partner", AlipayConfig.partner);
		sParaTemp.put("_input_charset", AlipayConfig.input_charset);
		sParaTemp.put("sec_id", AlipayConfig.sign_type);
		sParaTemp.put("format", format);
		sParaTemp.put("v", v);
		sParaTemp.put("req_data", req_data);
		
		//建立请求
		String sHtmlText = AlipaySubmit.buildRequest(ALIPAY_GATEWAY_NEW, sParaTemp, "get", "确认");
		out.println(sHtmlText);
	%>
	<body>
	</body>
</html>
