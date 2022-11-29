<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="tea.entity.csvclub.alipay.*"%>
<%@ page import="java.util.*"%>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.admin.mov.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.admin.mov.*" %>
<%@ page import="tea.entity.member.*"%>
<%request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
String  money =null;//金额
String email =null;//用户
String order=null;//订单
String Membername=null;//商品名称
String Caption=null;//商品描述

int idpay=0;
/******************自己的方法调用*************************/

String memberorder = teasession.getParameter("memberorder");
int pay = 0;
if(teasession.getParameter("pay")!=null && teasession.getParameter("pay").length()>0)
{
  pay = Integer.parseInt(teasession.getParameter("pay"));
  idpay=pay;
}
int payid =0;
if(teasession.getParameter("payid")!=null && teasession.getParameter("payid").length()>0)
{
  payid = Integer.parseInt(teasession.getParameter("payid"));
  idpay=payid;
}

 Payinstall piobj = Payinstall.findpay(idpay);//支付方式的设置表
if(pay>0){//用户的订单
  MemberOrder moobj = MemberOrder.find(memberorder);//用户注册成功的订单表
  MemberType mtobj = MemberType.find(moobj.getMembertype()); //会员类型表
  MemberPay mpobj = MemberPay.find(moobj.getPayid());//会员注册要缴费的 缴费表
  Profile p = Profile.find(moobj.getMember());

  money=mpobj.getPaymoney().toString();
 // email=p.getEmail();
  order=memberorder;
  Membername=mtobj.getMembername();
  Caption=mtobj.getCaption();
}

if(payid>0)//商品的订单
{
  String trade = teasession.getParameter("trade");
  order=trade;
  Trade obj=Trade.find(trade);
  Profile p = Profile.find(obj.getCustomer().toString());
  if(p.getEmail()!=null && p.getEmail().length()>0){
    email = p.getEmail();
  }else
  {
    email = "zhang_js521@126.com";
  }
  money=obj.getTotal().toString();

  StringBuffer sb = new StringBuffer();
  Enumeration e=TradeItem.findByTrade(trade);
  for(int i=0;e.hasMoreElements();++i)
  {
    int ti=((Integer)e.nextElement()).intValue();
    TradeItem ti_obj=TradeItem.find(ti);
    sb.append(ti_obj.getSubject());
    if(i>0)
       sb.append(",");

  }
    Membername=sb.toString();
    Caption="暂无描述";
}


/*******************************************************/

//
//String subjects = teasession.getParameter("subject");
//String total_fees = teasession.getParameter("total_fee");


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>支付宝支付</title>
</head>
<%
Date Now_Date=new Date();

String out_trade_no		= order;	      //商户网站订单Now_Date.toString()
String partner			= piobj.getMerchant(); //支付宝合作伙伴id (账户内提取)2088001505650066
String key                      = piobj.getSafety();   //支付宝安全校验码(账户内提取)r2ssfxtmbltx8odm78fanj2g5upgcp1g
String seller_email		= piobj.getPayeail();		  //卖家支付宝帐户csvclub@csvclub.org

String body			    = Caption; //商品描述
String total_fee		= money; //订单总价
String subject			= Membername;          //商品名称

String paygateway	="https://www.alipay.com/cooperate/gateway.do?";	//'支付接口
String service          ="create_direct_pay_by_user";//快速付款交易服务
String sign_type        ="MD5";
String input_charset    ="utf-8";
String payment_type     ="1";//支付宝类型.1代表商品购买
String show_url         ="www.sina.com.cn";//商品名称的连接

String notify_url		= "http://"+request.getServerName()+":"+request.getServerPort()+piobj.getProcessurl();	//通知接收URL /jsp/pay/alipay_notify.jsp
String return_url		= "http://"+request.getServerName()+":"+request.getServerPort()+piobj.getReturnurl();	//支付完成后跳转返回的网址URL /jsp/pay/alipay_return.jsp

String ItemUrl=Payment.CreateUrl(paygateway,service,sign_type,out_trade_no,input_charset,partner,key,show_url,body,total_fee,payment_type,seller_email,subject,notify_url,return_url);
%>
<%--
<a href="<%=ItemUrl%>">
<img src="/res/it-services/u/0807/08074355.gif" border="0" alt="" ></a>
<body>
--%>
<body onLoad="javascript:document.E_FORM.submit()">

<form action="<%=ItemUrl%>" method="POST" name="E_FORM">
  </form>
</body>
</html>
