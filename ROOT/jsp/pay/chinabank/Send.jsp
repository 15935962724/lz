<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.net.*"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.admin.mov.*" %>
<%@ page import="tea.entity.admin.*" %>

<%request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?Node="+teasession._nNode);
  return;

}
Community communitys=Community.find(teasession._strCommunity);
String  money =null;//金额
String email =null;//用户
String order=null;//订单
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
}

/*******************************************************/


//初始化定义参数
String v_mid,key,v_url,v_oid,v_amount,v_moneytype,v_md5info;  //定义必须传递的参数变量

v_mid  = piobj.getMerchant();	// 商户号，这里为测试商户号20000400，替换为自己的商户号即可20396914
key    = piobj.getSafety();		// md5.9000.redcome.com
v_url = "http://"+request.getServerName()+":"+request.getServerPort()+piobj.getReturnurl();     // 商户自定义返回接收支付结果的页面  /jsp/pay/chinabank/Receive.jsp
// MD5密钥要跟订单提交页相同，如Send.asp里的 key = "test" ,修改""号内 test 为您的密钥
				  // test 如果您还没有设置MD5密钥请登陆我们为您提供商户后台，地址：https://merchant3.chinabank.com.cn/
// 登陆后在上面的导航栏里可能找到“资料管理”，在资料管理的二级导航栏里有“MD5密钥设置”
// 建议您设置一个16位以上的密钥或更高，密钥最多64位，但设置16位已经足够了
//****************************************


//以上三项需要商户修改
v_oid=order;//会员注册时候产生的订单


//v_oid=request.getParameter("trade");
//if(v_oid==null || v_oid.length()<1)
//{
//  Date currTime = new Date();
//  SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd-"+v_mid+"-hhmmss",Locale.US);
//  v_oid=sf.format(currTime);                        // 推荐订单号构成格式为 年月日-商户号-小时分钟秒
//}

Trade obj=Trade.find(v_oid);
if(obj.getPaystate()>0)
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("该订单已经支付过啦","UTF-8"));
  return;
}

v_amount=money;//request.getParameter("v_amount");	// 订单金额obj.getTotal().toString()
v_moneytype ="CNY";	                  				// 币种
v_md5info = "";								// 对拼凑串MD5私钥加密后的值

String text = v_amount+v_moneytype+v_oid+v_mid+v_url+key;   // 拼凑加密串
tea.entity.csvclub.encrypt.MD5 m = new tea.entity.csvclub.encrypt.MD5();
v_md5info =  m.getMD5ofStr(text);                      // 网银支付平台对MD5值只认大写字符串，所以小写的MD5值得转换为大写


//************以下几项与网上支付货款无关，建议不用**************
String v_rcvname,v_rcvaddr,v_rcvtel,v_rcvpost,v_rcvemail,v_rcvmobile;  //定义非必需参数

v_rcvname = obj.getLastName(teasession._nLanguage)+obj.getFirstName(teasession._nLanguage); //request.getParameter("v_rcvname");     // 收货人
v_rcvaddr = obj.getCity(teasession._nLanguage);// request.getParameter("v_rcvaddr");     // 收货地址
v_rcvtel = obj.getTelephone(teasession._nLanguage);// request.getParameter("v_rcvtel");      // 收货人电话
v_rcvpost = obj.getZip(teasession._nLanguage);//request.getParameter("v_rcvpost");     // 收货人邮编
v_rcvemail =email;// obj.getEmail();//request.getParameter("v_rcvemail");    // 收货人邮件
v_rcvmobile = "";//request.getParameter("v_rcvmobile");   // 收货人手机号

String v_ordername,v_orderaddr,v_ordertel,v_orderpost,v_orderemail,v_ordermobile;

v_ordername = v_rcvname;// request.getParameter("v_ordername");   // 订货人姓名
v_orderaddr = v_rcvaddr;//request.getParameter("v_orderaddr");   // 订货人地址
v_ordertel = v_rcvtel;//request.getParameter("v_ordertel");    // 订货人电话
v_orderpost = v_rcvpost;//request.getParameter("v_orderpost");   // 订货人邮编
v_orderemail = v_rcvemail;//request.getParameter("v_orderemail");  // 订货人邮件
v_ordermobile = v_rcvmobile;//request.getParameter("v_ordermobile"); // 订货人手机号

String remark1,remark2;

remark1 = request.getParameter("remark1");               //备注字段1
remark2 = request.getParameter("remark2");               //备注字段2


/*
		StringBuffer param=new StringBuffer("https://pay3.chinabank.com.cn/PayGate");
		param.append("?v_mid=").append(v_mid);
		param.append("&v_md5info=").append(v_md5info);
		param.append("&v_oid=").append(URLEncoder.encode(v_oid,"GBK"));
		param.append("&v_amount=").append(URLEncoder.encode(v_amount,"GBK"));
		param.append("&v_moneytype=").append(URLEncoder.encode(v_moneytype,"GBK"));
		param.append("&v_url=").append(URLEncoder.encode(v_url,"GBK"));

		param.append("&remark1=").append(URLEncoder.encode(remark1,"GBK"));
		param.append("&remark2=").append(URLEncoder.encode(remark2,"GBK"));

		param.append("&v_rcvname=").append(URLEncoder.encode(v_rcvname,"GBK"));
		param.append("&v_rcvaddr=").append(URLEncoder.encode(v_rcvaddr,"GBK"));
		param.append("&v_rcvtel=").append(URLEncoder.encode(v_rcvtel,"GBK"));
		param.append("&v_rcvpost=").append(URLEncoder.encode(v_rcvpost,"GBK"));
		param.append("&v_rcvemail=").append(URLEncoder.encode(v_rcvemail,"GBK"));
		param.append("&v_rcvmobile=").append(URLEncoder.encode(v_rcvmobile,"GBK"));

		param.append("&v_ordername=").append(URLEncoder.encode(v_ordername,"GBK"));
		param.append("&v_orderaddr=").append(URLEncoder.encode(v_orderaddr,"GBK"));
		param.append("&v_ordertel=").append(URLEncoder.encode(v_ordertel,"GBK"));
		param.append("&v_orderpost=").append(URLEncoder.encode(v_orderpost,"GBK"));
		param.append("&v_orderemail=").append(URLEncoder.encode(v_orderemail,"GBK"));
		param.append("&v_ordermobile=").append(URLEncoder.encode(v_ordermobile,"GBK"));

		response.sendRedirect(param.toString());
*/


%>

<!--以下信息为标准的 HTML 格式 + JAVA 语言 拼凑而成的 网银在线 支付接口标准演示页面 -->

<html>


<body onLoad="javascript:document.E_FORM.submit()">




<form action="https://pay3.chinabank.com.cn/PayGate" method="POST" name="E_FORM">

  <!--以下几项为网上支付重要信息，信息必须正确无误，信息会影响支付进行！-->

  <input type="hidden" name="v_md5info"    value="<%=v_md5info%>" size="100">
  <input type="hidden" name="v_mid"        value="<%=v_mid%>">
  <input type="hidden" name="v_oid"        value="<%=v_oid%>">
  <input type="hidden" name="v_amount"     value="<%=v_amount%>">
  <input type="hidden" name="v_moneytype"  value="<%=v_moneytype%>">
  <input type="hidden" name="v_url"        value="<%=v_url%>">


  <!--以下几项项为网上支付完成后，随支付反馈信息一同传给信息接收页，在传输过程中内容不会改变,如：Receive.asp -->

  <input type="hidden"  name="remark1" value="<%=remark1%>">
  <input type="hidden"  name="remark2" value="<%=remark2%>">

  <!--以下几项与网上支付货款无关，只是用来记录客户信息，可以不用，使用和不使用都不影响支付 -->

	<input type="hidden"  name="v_rcvname"      value="<%=v_rcvname%>">
	<input type="hidden"  name="v_rcvaddr"      value="<%=v_rcvaddr%>">
	<input type="hidden"  name="v_rcvtel"       value="<%=v_rcvtel%>">
	<input type="hidden"  name="v_rcvpost"      value="<%=v_rcvpost%>">
	<input type="hidden"  name="v_rcvemail"     value="<%=v_rcvemail%>">
	<input type="hidden"  name="v_rcvmobile"    value="<%=v_rcvmobile%>">

	<input type="hidden"  name="v_ordername"    value="<%=v_ordername%>">
	<input type="hidden"  name="v_orderaddr"    value="<%=v_orderaddr%>">
	<input type="hidden"  name="v_ordertel"     value="<%=v_ordertel%>">
	<input type="hidden"  name="v_orderpost"    value="<%=v_orderpost%>">
	<input type="hidden"  name="v_orderemail"   value="<%=v_orderemail%>">
	<input type="hidden"  name="v_ordermobile"  value="<%=v_ordermobile%>">

  </form>




</body>
</html>
