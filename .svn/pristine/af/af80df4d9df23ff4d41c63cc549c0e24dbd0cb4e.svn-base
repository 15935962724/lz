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
<%@ page import="tea.entity.subscribe.*" %>
<%

request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);


//支付中转表
int poid = 0;
if(teasession.getParameter("poid")!=null && teasession.getParameter("poid").length()>0)
{
	poid = Integer.parseInt(teasession.getParameter("poid"));
}
//支付设置表
int payid = 0;
if(teasession.getParameter("payid")!=null && teasession.getParameter("payid").length()>0)
{
	payid = Integer.parseInt(teasession.getParameter("payid"));
}
if(poid==0 || payid==0)
{
	out.print("<script>alert('订单参数出错，请与管理员联系');window.close();</script>");
	return;
}

PayOrder pobj = PayOrder.find(poid);

Payinstall piobj = Payinstall.find(payid);

  
 

	//首信易支付///////////////////////////////////////////////
	if(pobj.getPotype()==1)
	{ 
		out.print("<script>alert('这个订单已经支付过了，订单不能重复支付，如有问题请与管理员联系');window.close();</script>");
		return;
	}

String v_mid =piobj.getMerchant();		//商户编号，签约由易支付分配。250是测试商户编号。
String MD5Key=piobj.getSafety(); //MD5Key,签约后由商户自定义一个16位的数字字母组合作为密钥，发到huangyi@payeasenet.com.说明商户编号，公司名称和密钥。

String ddate = new SimpleDateFormat("ss").format(Calendar.getInstance().getTime());

String ddate1= new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());
String v_oid = ddate1+"-"+v_mid+"-"+String.valueOf(poid)+ddate;  //订单编号，订单编号的格式:yyyymmdd-v_mid-流水号。流水号可以按照自己的订单规则生成，但是要保证每一次提交，订单号是唯一值，否则会出错

String v_rcvname = piobj.getMerchant(); //收货人姓名，建议用商户编号代替。
String v_rcvaddr = piobj.getMerchant(); //收货人姓名，可以用常量
String v_rcvtel = "";  	//收货人电话，可以用常量
String v_rcvpost = "";					//收货人邮编，可以用常量 
String v_amount ="0.01";//String.valueOf(pobj.getMarketprice()); //订单金额
String v_ymd = ddate1;        //订单日期
String v_orderstatus = "1";		//配货状态，0-未配齐，1-已配齐。 
String v_ordername = "";  //订货人姓名，可以用常量
String v_moneytype = "0";  //币种。0-人民币，1-美元。
String v_url="http://"+request.getServerName()+":"+request.getServerPort()+piobj.getReturnurl();  //支付完成后返回地址。此地址是支付完成后，订单信息实时的向这个地址做返回。返回参数详见接口文档第二部分。
 
 
//MD5算法 
 //MD5算法
  Md5 md5 = new Md5 ("") ;
  md5.hmac_Md5(v_moneytype+v_ymd+v_amount+v_rcvname+v_oid+v_mid+v_url,MD5Key) ;
  byte b[]= md5.getDigest();
  String digestString = md5.stringify(b) ;
String v_md5info = digestString;

%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<body onLoad="javascript:document.E_FORM.submit();"> 
<form action="http://pay.beijing.com.cn/prs/user_payment.checkit" method="POST" name="E_FORM">
  <input type="hidden" name="v_md5info" size="100"  value="<%=v_md5info%>">
	<input type="hidden" name="v_mid" value="<%=v_mid%>">
	<input type="hidden" name="v_oid" value="<%=v_oid%>">
	<input type="hidden" name="v_rcvname" value="<%=v_rcvname%>">
	<input type="hidden" name="v_rcvaddr" value="<%=v_rcvaddr%>">
	<input type="hidden" name="v_rcvtel" value="<%=v_rcvtel%>">
	<input type="hidden" name="v_rcvpost" value="<%=v_rcvpost%>">
	<input type="hidden" name="v_amount" value="<%=v_amount%>">
	<input type="hidden" name="v_ymd"  value="<%=v_ymd%>">
	<input type="hidden" name="v_orderstatus"  value="<%=v_orderstatus%>">
	<input type="hidden" name="v_ordername"  value="<%=v_ordername%>">
	<input type="hidden" name="v_moneytype"  value="<%=v_moneytype%>">
	<input type="hidden" name="v_url" value="<%=v_url%>">
</form>
</body> 
</html>
