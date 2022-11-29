<%@page import="java.net.URLDecoder"%>
<%@page import="mobcom.alipay.util.UtilDate"%>
<%@page import="mobcom.alipay.config.AlipayConfig"%>
<%@page import="mobcom.alipay.util.AlipaySubmit"%>
<%@page import="tea.entity.westrac.Teamtregistration"%>
<%@page import="tea.entity.admin.Payinstall"%>
<%@ page  contentType="text/html; charset=UTF-8"%>
<%@page import="tea.entity.westrac.Eventregistration"%>
<%@page import="tea.entity.node.GolfOrder"%>
<%@ page import="tea.entity.csvclub.alipay.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.women.*" %> 
<% 
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
 
Community community=Community.find(teasession._strCommunity);
int regid = Integer.parseInt(teasession.getParameter("regid"));


StringBuffer sp = new StringBuffer();

boolean f = false;
boolean f2 = false;
//获取支付 设置中的数值
//判断是否有支付宝设置

Payinstall pobj = Payinstall.findpay(teasession._strCommunity,2);
float totalprices = 0f;//订单总价格
String goodname = "";// 商品名称
String order="";
if(pobj.isExists())
{
	
	Eventregistration erobj = Eventregistration.find(regid);
	Teamtregistration tobj = Teamtregistration.find(regid);
	GolfOrder goobj = GolfOrder.find(regid);//包含球场和教练订单信息
	
	
	//判断活动类型的支付
	if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/1/")!=-1 && erobj.getOrdering()!=null && erobj.getOrdering().indexOf("AC")!=-1)
	{
		
		order=erobj.getOrdering();
		sp.append("订单号：").append(erobj.getOrdering()).append("-");
		sp.append("姓名：").append(erobj.getMembername()+"　");
		sp.append("手机号：").append(erobj.getPhone()+"　");
		totalprices = erobj.getTotalprices();
		if(!erobj.isExists())
		{
			f = true;
		}else if(erobj.getPatypeis()==1)
		{
			f2 = true;
		}
		goodname = "时尚高夫活动订场";
	}else if (pobj.getUsename()!=null && pobj.getUsename().indexOf("/2/")!=-1 && tobj.getOrdering()!=null && tobj.getOrdering().indexOf("TE")!=-1)
	{
		//判断球队的支付
		order=tobj.getOrdering();
		sp.append("订单号：").append(tobj.getOrdering()).append("-");
		sp.append("姓名：").append(tobj.getMembername()+"　");
		sp.append("手机号：").append(tobj.getPhone()+"　");
	    totalprices = tobj.getTotalprices();
		if(!tobj.isExists())
		{
			f = true;
		}else if(tobj.getPatypeis()==1)
		{
			f2 = true;
		}
		goodname = "预定时尚高尔夫球队";
	}else if (pobj.getUsename()!=null && pobj.getUsename().indexOf("/3/")!=-1 && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("GO")!=-1)
	{
		//判断 球场预定
		order=goobj.getOrderno();
		sp.append("订单号：").append(goobj.getOrderno()).append("-");
		sp.append("姓名：").append(goobj.getMembername()+"　");
		sp.append("手机号：").append(goobj.getPhone()+"　");
	    totalprices = goobj.getTotalprice();
		if(!goobj.isExists())
		{
			f = true;
		}else if(goobj.getIspay()==1)
		{
			f2 = true;
		}
		goodname = "预定时尚高尔夫球场";
	}else if (pobj.getUsename()!=null && pobj.getUsename().indexOf("/4/")!=-1 && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("CR")!=-1)
	{
		//判断 教练预定
		order=goobj.getOrderno();
		sp.append("订单号：").append(goobj.getOrderno()).append("-");
		sp.append("姓名：").append(goobj.getMembername()+"　");
		sp.append("手机号：").append(goobj.getPhone()+"　");
	    totalprices = goobj.getTotalprice();
		if(!goobj.isExists())
		{
			f = true;
		}else if(goobj.getIspay()==1)
		{
			f2 = true;
		}
		goodname = "预定时尚高尔夫教练";
	}
} 

if(f)//不存在 
{
	out.print("<script>alert('您支付的订单不存在!');window.close();</script>");
	return;
}else if(f2)//已经支付过
{
	out.print("<script>alert('您支付的订单已经支付过!');window.close();</script>");
	return;
} 
String url = "http://"+request.getServerName()+":"+request.getServerPort();


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></script>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
<script LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></script>
<script LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<meta HTTP-EQUIV="Expires" CONTENT="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>支付宝支付</title>
</head>

<script>
 
	function f_sub()
	{
		ymPrompt.win({message:'<br><center>信息已经提交成功,正转向支付宝支付,请耐心等待...</center>',title:'',width:'300',height:'50',titleBar:false});
		E_FORM.submit();
	}
</script>
<%
Date Now_Date=new Date();
//返回格式
//支付宝网关地址
		String ALIPAY_GATEWAY_NEW = "http://wappaygw.alipay.com/service/rest.htm?";

		////////////////////////////////////调用授权接口alipay.wap.trade.create.direct获取授权码token//////////////////////////////////////
		
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
		String notify_url = url+pobj.getProcessurl();;
		//需http://格式的完整路径，不能加?id=123这类自定义参数

		//页面跳转同步通知页面路径
		String call_back_url = url+"xhtml/folder/5071-1.htm";
		//需http://格式的完整路径，不能加?id=123这类自定义参数，不能写成http://localhost/

		//操作中断返回地址
		String merchant_url = "http://127.0.0.1:8080/WS_WAP_PAYWAP-JAVA-UTF-8/xxxxxx.jsp";
		//用户付款中途退出返回商户的地址。需http://格式的完整路径，不允许加?id=123这类自定义参数
String out_trade_no		= order;	//商户网站订单
String input_charset   =  "utf-8";
String partner			=	pobj.getMerchant().trim();//"2088702105602214"; //支付宝合作伙伴id (账户内提取)
String key             =    pobj.getSafety().trim();//"yfylsgs1licj174z8ify03dsqtdnry4b"; //支付宝安全校验码(账户内提取)
String body			= sp.toString(); //商品描述，推荐格式：商品名称（订单编号：订单编号）
String total_fee			=String.valueOf(totalprices);	//订单总价
String payment_type     = "1";//支付宝类型.1代表商品购买
String seller_email		= pobj.getPayeail();//"13501369877";		 //卖家支付宝帐户 
String subject			= goodname;//"时尚高夫活动订场";			 //商品名称
String show_url        =  url; 
//String notify_url		= url+pobj.getProcessurl();//"/jsp/pay/Event_alipay/alipay_notify.jsp";					//通知接收URL
String return_url		= url+pobj.getReturnurl();//"/jsp/pay/Event_alipay/alipay_return.jsp";	//支付完成后跳转返回的网址URL
//防钓鱼时间戳
String anti_phishing_key = "";
//若要使用请调用类文件submit中的query_timestamp函数
//请求业务参数详细
		String req_dataToken = "<direct_trade_create_req><notify_url>" + notify_url + "</notify_url><call_back_url>" + call_back_url + "</call_back_url><seller_account_name>" + seller_email + "</seller_account_name><out_trade_no>" + out_trade_no + "</out_trade_no><subject>" + subject + "</subject><total_fee>" + total_fee + "</total_fee><merchant_url>" + merchant_url + "</merchant_url></direct_trade_create_req>";
		//必填

//客户端的IP地址
String exter_invoke_ip = "";
//非局域网的外网IP地址，如：221.0.0.1
//String ItemUrl=Payment.CreateUrl(paygateway,service,sign_type,out_trade_no,input_charset,partner,key,show_url,body,total_fee,payment_type,seller_email,subject,notify_url,return_url);
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

<body  onLoad="f_sub();"> 
</body>
</html>
