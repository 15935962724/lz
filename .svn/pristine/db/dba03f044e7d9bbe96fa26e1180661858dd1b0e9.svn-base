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
Payinstall pobj = Payinstall.findpay(2);
float totalprices = 0f;//订单总价格
String goodname = "";// 商品名称
if(pobj.isExists())
{
	//判断活动类型的支付
	if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/5/")!=-1)
	{
		Eventregistration erobj = Eventregistration.find(regid);
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
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
          <title>支付宝支付</title>
</head>
<%
Date Now_Date=new Date();
String paygateway	=	"https://www.alipay.com/cooperate/gateway.do?";	//'支付接口
String service      = "create_direct_pay_by_user";//快速付款交易服务
String sign_type       =   "MD5"; 
String out_trade_no		= Now_Date.toString();	//商户网站订单
String input_charset   =  "utf-8";
String partner			=	pobj.getMerchant().trim();//"2088702105602214"; //支付宝合作伙伴id (账户内提取)
String key             =    pobj.getSafety().trim();//"yfylsgs1licj174z8ify03dsqtdnry4b"; //支付宝安全校验码(账户内提取)
String body			= sp.toString(); //商品描述，推荐格式：商品名称（订单编号：订单编号）
String total_fee			=String.valueOf(totalprices);	//订单总价
String payment_type     = "1";//支付宝类型.1代表商品购买
String seller_email		= pobj.getPayeail();//"13501369877";		 //卖家支付宝帐户 
String subject			= goodname;//"时尚高夫活动订场";			 //商品名称
String show_url        =  url; 
String notify_url		= url+pobj.getProcessurl();//"/jsp/pay/Event_alipay/alipay_notify.jsp";					//通知接收URL
String return_url		= url+pobj.getReturnurl();//"/jsp/pay/Event_alipay/alipay_return.jsp";	//支付完成后跳转返回的网址URL

String ItemUrl=Payment.CreateUrl(paygateway,service,sign_type,out_trade_no,input_charset,partner,key,show_url,body,total_fee,payment_type,seller_email,subject,notify_url,return_url);

%> 

<body  onLoad="javascript:document.E_FORM.submit();"> 
<form action="<%=ItemUrl %>" method="POST" name="E_FORM">
  
</form>

</body>
</html>
