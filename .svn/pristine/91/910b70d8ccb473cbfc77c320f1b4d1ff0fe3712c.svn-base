<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.net.*"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.admin.mov.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.csvclub.alipay.*"%>
<%@page import="tea.entity.csvclub.encrypt.*" %>

<%request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?Node="+teasession._nNode);
  return;

}
Community communitys=Community.find(teasession._strCommunity);
String  money =null;//金额
String email =null;//用户email
String order=null;//订单
String FirstName=null;
String times =null;
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
  email=p.getEmail();
  order=memberorder;
  FirstName=p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage);
  times = moobj.getTimesToString();
}

if(payid>0)//商品的订单
{
  String trade = teasession.getParameter("trade");
  order=trade;
  Trade obj=Trade.find(trade);
  Profile p = Profile.find(obj.getCustomer().toString());
 // if(p.getEmail()!=null && p.getEmail().length()>0){
   if(obj.getEmail()!=null && obj.getEmail().length()>0){
    email =obj.getEmail();
  }else
  {
    email = "zhang_js521@126.com";
  }
  money=obj.getTotal().toString();
  FirstName=obj.getLastName(teasession._nLanguage)+obj.getFirstName(teasession._nLanguage);
  times = obj.getTimeToString2();
}

/*******************************************************/

Trade obj=Trade.find(order);
if(obj.getPaystate()>0)
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("硕丫支","UTF-8"));
  return;
}


String	c_mid		= "1016064",	//1000447袒牛注
c_pass		= "gouwuxiang89",//"654321",商户自己的支付密钥
c_order		= order,//订单号
c_name		= FirstName,//obj.getLastName(teasession._nLanguage)+obj.getFirstName(teasession._nLanguage),
c_address	= "1",//obj.getAddress(teasession._nLanguage),
c_tel		= "1",//obj.getTelephone(teasession._nLanguage),
c_post		= "1",//obj.getZip(teasession._nLanguage),
c_email		= email,//obj.getEmail(),
c_orderamount   =money,//obj.getTotal().toString(),金额
c_ymd		=times,//obj.getTimeToString2(),
c_moneytype	= "0",
c_retflag	= "1",
c_paygate	= "0",
c_returl	= "http://"+request.getServerName()+":"+request.getServerPort()+piobj.getReturnurl(),//"http://"+request.getServerName()+":"+request.getServerPort()+"/jsp/pay/cncard/GetPayNotify.jsp",//;jsessionid="+session.getId(),//+"?community"+teasession._strCommunity,
c_memo1		= "",
c_memo2		= "",
notifytype	= "1",
c_language	= "0",

c_signstr       = "";

/*
Calendar cal = Calendar.getInstance();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
c_ymd=formatter.format(cal.getTime());
*/

MD5 md5 = new MD5();
c_signstr = c_mid + c_order + c_orderamount + c_ymd + c_moneytype + c_retflag + c_returl + c_paygate + c_memo1 + c_memo2 + notifytype + c_language +  c_pass;
c_signstr = md5.getMD5ofStr(c_signstr).toLowerCase();

/*
StringBuffer param=new StringBuffer("https://www.cncard.net/purchase/getorder.asp");
param.append("?c_mid=").append(c_mid);
param.append("&c_order=").append(c_order);
param.append("&c_name=").append(URLEncoder.encode(c_name,"GBK"));
param.append("&c_address=").append(URLEncoder.encode(c_address,"GBK"));
param.append("&c_post=").append(URLEncoder.encode(c_post,"GBK"));
param.append("&c_email=").append(URLEncoder.encode(c_email,"GBK"));
param.append("&c_orderamount=").append(c_orderamount);
param.append("&c_ymd=").append(c_ymd);
param.append("&c_moneytype=").append(c_moneytype);
param.append("&c_retflag=").append(c_retflag);
param.append("&c_paygate=").append(c_paygate);
param.append("&c_returl=").append(URLEncoder.encode(c_returl,"GBK"));
param.append("&c_memo1=").append(URLEncoder.encode(c_memo1,"GBK"));
param.append("&c_memo2=").append(URLEncoder.encode(c_memo2,"GBK"));
param.append("&notifytype=").append(notifytype);
param.append("&c_language=").append(c_language);
param.append("&c_signstr=").append(c_signstr);

response.sendRedirect(param.toString());
*/


%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>

<body onLoad="form1.submit();">



<!--https://www.cncard.net/purchase/getorder.asp  https://www.cncard.com/purchase/cnpaygate/testport/port_test11.asp-->

<form action="https://www.cncard.net/purchase/getorder.asp" method="POST" name="form1" target="">
	<input type="hidden" name="c_mid" value="<%=c_mid%>">
	<input type="hidden" name="c_order" value="<%=c_order%>">
	<input type="hidden" name="c_name" value="<%=c_name%>">
	<input type="hidden" name="c_address" value="<%=c_address%>">
	<input type="hidden" name="c_tel" value="<%=c_tel%>">
	<input type="hidden" name="c_post" value="<%=c_post%>">
	<input type="hidden" name="c_email" value="<%=c_email%>">
	<input type="hidden" name="c_orderamount" value="<%=c_orderamount%>">
	<input type="hidden" name="c_ymd" value="<%=c_ymd%>">
	<input type="hidden" name="c_moneytype" value="<%=c_moneytype%>">
	<input type="hidden" name="c_retflag" value="<%=c_retflag%>">
	<input type="hidden" name="c_paygate" value="<%=c_paygate%>">
	<input type="hidden" name="c_returl" value="<%=c_returl%>">
	<input type="hidden" name="c_memo1" value="<%=c_memo1%>">
	<input type="hidden" name="c_memo2" value="<%=c_memo2%>">
	<input type="hidden" name="notifytype" value="<%=notifytype%>">
	<input type="hidden" name="c_language" value="<%=c_language%>">
	<input type="hidden" name="c_signstr" value="<%=c_signstr%>">
	<input type="hidden" value=" -> 支">
</form>


</body>
</html>
