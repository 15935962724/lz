<%@page import="tea.entity.node.GolfOrder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
int goid = Integer.parseInt(teasession.getParameter("goid"));

GolfOrder goobj = GolfOrder.find(goid);
if(!goobj.isExists())//不存在 
{
	out.print("<script>alert('您支付的订单不存在!');window.close();</script>");
	return;
}else if(goobj.getIspay()==1)//已经支付过
{
	out.print("<script>alert('您支付的订单已经支付过!');window.close();</script>");
	return;
} 
StringBuffer sp = new StringBuffer();

sp.append("订单号：").append(goobj.getOrderno()).append("-");
sp.append("姓名：").append(goobj.getMembername()+"　");
sp.append("手机号：").append(goobj.getPhone()+"　");


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
String partner			=	"2088702105602214"; //支付宝合作伙伴id (账户内提取)
String key             =    "yfylsgs1licj174z8ify03dsqtdnry4b"; //支付宝安全校验码(账户内提取)
String body			= sp.toString(); //商品描述，推荐格式：商品名称（订单编号：订单编号）
String total_fee			= String.valueOf(goobj.getTotalprice());	//订单总价
String payment_type     = "1";//支付宝类型.1代表商品购买
String seller_email		= "13501369877";		 //卖家支付宝帐户
String subject			= "时尚高夫预定教练";			 //商品名称
String show_url        =  url;
String notify_url		= url+"/jsp/pay/alipay/alipay_notify.jsp";					//通知接收URL
String return_url		= url+"/jsp/pay/alipay/alipay_return.jsp";	//支付完成后跳转返回的网址URL
String ItemUrl=Payment.CreateUrl(paygateway,service,sign_type,out_trade_no,input_charset,partner,key,show_url,body,total_fee,payment_type,seller_email,subject,notify_url,return_url);
%> 

<body  onLoad="javascript:document.E_FORM.submit();"> 
<form action="<%=ItemUrl %>" method="POST" name="E_FORM">
  
</form>

</body>
</html>
