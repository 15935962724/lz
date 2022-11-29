<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.security.*"%>
<%@ page import="com.capinfo.crypt.*"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%>
<%@ page import="java.math.*"%>
<%@ page import="tea.entity.csvclub.alipay.*"%>
<%@ page import="tea.entity.csvclub.encrypt.*" %>
<%@ page import="tea.entity.admin.mov.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.ocean.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);


int ids = 0;
if(teasession.getParameter("ids")!=null && teasession.getParameter("ids").length()>0)
{
  ids = Integer.parseInt(teasession.getParameter("ids"));
}
Ocean oce= Ocean.find(ids);

//首信易支付///////////////////////////////////////////////
String  money =null;//金额
String email =null;//用户
String order= null;//订单
String card = null;
card = teasession.getParameter("card");
order  = teasession.getParameter("order");
email = teasession.getParameter("email");
money=teasession.getParameter("money");
money=String.valueOf(oce.getMoney());
//money="0.01";
boolean falg = Ocean.iscard(card," and orderstatic >0 ");
int idpay=0;
if(falg)
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("此订单已经支付啦","UTF-8"));
  return;
}
final java.text.DecimalFormat df2 = new java.text.DecimalFormat("00");
final java.text.DecimalFormat df4 = new java.text.DecimalFormat("0000");
Calendar   calendarSys=new   java.util.GregorianCalendar();
//取当前时间
java.util.Date   d   =   new   java.util.Date(System.currentTimeMillis());
calendarSys.setTime(d);
//转换后，取年，月，日
int   year=calendarSys.get(Calendar.YEAR);
int   month=calendarSys.get(Calendar.MONTH);
int   aDate=calendarSys.get(Calendar.DATE);
//这里转化为你想用的格式

String datastr=year+df2.format(month+1)+df2.format(aDate);


///////////////////////////对方参数设置
String
v_mid		= "2486",	//商户号，在注册后会获得
key             ="bjsea20090116wz",//
v_amount	= String.valueOf(money),////金额
v_rcvname	= "北京海洋馆",//obj.getLastName(teasession._nLanguage)+obj.getFirstName(teasession._nLanguage),
v_rcvaddr	= oce.getAddress(),//obj.getAddress(teasession._nLanguage),
v_rcvtel	= oce.getMobile(),//obj.getTelephone(teasession._nLanguage),
v_rcvpost	= oce.getZip(),//obj.getZip(teasession._nLanguage),
v_ymd		= datastr,//obj.getTimeToString2(),
v_orderstatus	= "0",
v_ordername	= "北京海洋馆",//v_rcvname,
v_moneytype	= "0",//币种 0 为人民币
v_url	="http://"+request.getServerName()+":"+request.getServerPort()+"/jsp/pay/hybeijing/Receive.jsp", //"http://"+request.getServerName()+":"+request.getServerPort()+"/jsp/pay/beijing/Receive.jsp",//;jsession="+session.getId()+"?community="+teasession._strCommunity,
v_md5info= "",
v_oid	= oce.getBeijingorder();//订单号
//tea.entity.csvclub.encrypt.MD5 m = new tea.entity.csvclub.encrypt.MD5();


Md5beijing md5 = new Md5beijing ( "" ) ;
md5.hmac_Md5beijing(v_moneytype+v_ymd+v_amount+v_rcvname+v_oid+v_mid+v_url,key);
byte b[]= md5.getDigest();
String digestString = md5.stringify(b) ;
v_md5info = digestString;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
  <title></title>
</head>
<body onload="form1.submit();">
<form action="http://pay.beijing.com.cn/prs/user_payment.checkit" method="POST" name="form1" target="">
<input type="hidden" name="v_mid" value="<%=v_mid%>"><!--商户编号-->
<input type="hidden" name="v_oid" value="<%=v_oid%>"><!--订单编号-->
<input type="hidden" name="v_rcvname" value="<%=v_rcvname%>"><!--收货人姓名-->
<input type="hidden" name="v_rcvaddr" value="<%=v_rcvaddr%>"><!--收货人地址-->
<input type="hidden" name="v_rcvtel" value="<%=v_rcvtel%>"><!--收货人电话-->
<input type="hidden" name="v_rcvpost" value="<%=v_rcvpost%>"><!--收货人邮编-->
<input type="hidden" name="v_amount" value="<%=v_amount%>"><!--订单总金额-->
<input type="hidden" name="v_ymd" value="<%=v_ymd%>"><!--订单产生日期-->
<input type=hidden name=v_ordername value="<%=v_ordername%>">  <!--订货人姓名-->
<input type="hidden" name="v_orderstatus" value="<%=v_orderstatus%>"><!--配货状态-->
<input type="hidden" name="v_moneytype" value="<%=v_moneytype%>"><!--币种,0为人民币,1为美元-->
<input type="hidden" name="v_url" value="<%=v_url%>"><!--订单产生日期-->
<input type="hidden" name="v_md5info" value="<%=v_md5info%>"><!--订单数字指纹1630dc083d70a1e8af60f49c143a7b95-->
<input type="hidden" value="支付">
</form>
</body>
</html>
