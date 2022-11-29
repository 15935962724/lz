<%@page contentType="text/html; charset=GBK" language="java"%>
<%@page import="java.net.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="java.security.*"%>
<%@page import="tea.entity.csvclub.encrypt.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.math.*"%>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.admin.mov.*" %>
<%@page import="tea.entity.admin.*" %>
<%request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?Node="+teasession._nNode);
  return;

}

String money =null;//订单金额
String email =null;//用户
String order=null;//订单
String FirstName = null;//支付人姓名
String goodsname =null;
int idpay=0;
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

//String _strTrade=memberorder;//request.getParameter("trade");


 Payinstall piobj = Payinstall.findpay(idpay);//支付方式的设置表
if(pay>0){//用户的订单
  MemberOrder moobj = MemberOrder.find(memberorder);//用户注册成功的订单表
  MemberType mtobj = MemberType.find(moobj.getMembertype()); //会员类型表
  MemberPay mpobj = MemberPay.find(moobj.getPayid());//会员注册要缴费的 缴费表
  Profile p = Profile.find(moobj.getMember());

  money=mpobj.getPaymoney().toString();
  Profile pobj = Profile.find(moobj.getMember());
  FirstName = pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage);
  goodsname = mtobj.getMembername();
  email=p.getEmail();
  order=memberorder;
//  Membername=mtobj.getMembername();
//  Caption=mtobj.getCaption();
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
  FirstName = obj.getLastName(teasession._nLanguage)+obj.getFirstName(teasession._nLanguage);

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
  goodsname=sb.toString();
   // Caption="暂无描述";
}





//Trade obj=Trade.find(_strTrade);
//if(obj.getPaystate()>0)
//{
//  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("此订单已经支付啦","UTF-8"));
//  return;
//}

/**
 * @Description: 快钱网关接口范例
 * @Copyright (c) 上海快钱信息服务有限公司
 * @version 2.0
 */

 String merchant_id =piobj.getMerchant();// "889907080270896500";	///商户编号
 String merchant_key = piobj.getSafety();//"58459662officebi";		///商户密钥
 String amount= money;//obj.getTotal().toString();   //订单金额
 String curr = "1";		///货币类型,1为人民币
 String isSupportDES = "2";	///是否安全校验,2为必校验,推荐

 String merchant_url = "http://"+request.getServerName()+":"+request.getServerPort()+piobj.getReturnurl(); //"http://"+request.getServerName()+":"+request.getServerPort()+"/jsp/pay/99bill/Receive.jsp";///支付结果返回地址
 String pname = FirstName;//obj.getLastName(teasession._nLanguage)+obj.getFirstName(teasession._nLanguage);		///支付人姓名
 String commodity_info = goodsname;//"";		///商品信息
 String merchant_param = "";		///商户私有参数
 String pemail=email;//obj.getEmail();		///传递email到快钱网关页面
 String pid="";		///代理/合作伙伴商户编号

 ///生成加密串,注意顺序
 String ScrtStr = "merchant_id=" + merchant_id + "&orderid=" + order + "&amount="+ amount+ "&merchant_url=" + merchant_url + "&merchant_key=" + merchant_key;
 MD5 md5 = new MD5();
 String mac = md5.getMD5ofStr(ScrtStr.toString());

%>

<!doctype html public "-//w3c//dtd html 4.0 transitional//en" >
<html>
	<head>
		<title>快钱99bill</title>
		<meta http-equiv="content-type" content="text/html; charset=gb2312" >
	</head>
<BODY onload="frm.submit();">

		<form name="frm" method="post" action="https://www.99bill.com/webapp/receiveMerchantInfoAction.do">
			<input name="merchant_id" type="hidden" value="<%=merchant_id%>">
			<input name="orderid"  type="hidden" value="<%=order%>">
			<input name="amount"  type="hidden" value="<%=amount%>">
			<input name="currency"  type="hidden" value="<%=curr%>">
			<input name="isSupportDES"  type="hidden" value="<%=isSupportDES%>">
			<input name="mac"  type="hidden" value="<%=mac%>">

			<input name="merchant_url"  type="hidden"  value="<%=merchant_url%>">
			<input name="pname"  type="hidden" value="<%=java.net.URLEncoder.encode(pname)%>">
			<input name="commodity_info"  type="hidden"  value="<%=java.net.URLEncoder.encode(commodity_info)%>">
			<input name="merchant_param" type="hidden"  value="<%=merchant_param%>">

			<input name="pemail" type="hidden"  value="<%=pemail%>">
			<input name="pid" type="hidden"  value="<%=pid%>">

			<input type="hidden" value="快钱支付">
		</form>

</BODY>
</HTML>
