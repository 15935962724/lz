<%@page import="tea.entity.westrac.Eventregistration"%>
<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.security.*"%>
<%@ page import="com.capinfo.crypt.*"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%>
<%@ page import="java.math.*"%>
<%@ page import="tea.entity.ocean.*" %>
<%@ page import="tea.entity.admin.mov.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.node.*" %>

<%request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);


//首信易支付///////////////////////////////////////////////

int regid = Integer.parseInt(teasession.getParameter("regid"));

Eventregistration erobj = Eventregistration.find(regid);

if(!erobj.isExists())//不存在 
{
	out.print("<script>alert('您支付的订单不存在!');window.close();</script>");
	return;
}else if(erobj.getPatypeis()==1)//已经支付过
{
	out.print("<script>alert('您支付的订单已经支付过!');window.close();</script>");
	return;
} 

	//货币类型
	int mailarea = 0;//人民币


java.text.SimpleDateFormat sdf1 = new  java.text.SimpleDateFormat("yyyyMMdd");//-MM-dd HH:mm:ss
String
		v_mid		= "",	//商户号，在注册后会获得
		key         ="",
		v_rcvname	=  erobj.getMembername(),//收货人姓名
		v_rcvaddr	=  "",//收货人地址
		v_rcvtel	=  erobj.getPhone(),//收货人电话 
		v_rcvpost	= "",//收货人邮编
		v_amount	= String.valueOf(erobj.getTotalprices()),//订单 金额 v_to
		v_ymd		=  sdf1.format(erobj.getTimes()),//String.valueOf(poobj.getTimes()),//订单日期
		v_ordername	=  "",//订货人姓名
		v_orderstatus	= "1",//配货状态
		v_moneytype	= String.valueOf(mailarea),//币种 0 为人民币
		v_url	="http://"+request.getServerName()+":"+request.getServerPort()+"/jsp/pay/Event_beijing/Receive.jsp",  //支付完成后返回地址。此地址是支付完成后，订单信息实时的向这个地址做返回。返回参数详见接口文档第二部分。
		v_md5info= "",
		v_oid	= v_ymd+"-"+v_mid+"-"+regid;//订单号

		//字符参数加密
		Md5beijing md5 = new Md5beijing ( "" ) ;
		md5.hmac_Md5beijing(v_moneytype+v_ymd+v_amount+v_rcvname+v_oid+v_mid+v_url,key);
		byte b[]= md5.getDigest();
		String digestString = md5.stringify(b) ;
		v_md5info = digestString;
  //onload="form1.submit();"
 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>
</head>
<body onload="form1.submit();">
<form action="http://pay.beijing.com.cn/prs/user_payment.checkit" method="POST" name="form1" target="">
	<input type="hidden" name="v_mid" value="<%=v_mid%>">
	<input type="hidden" name="v_oid" value="<%=v_oid%>">
	<input type="hidden" name="v_rcvname" value="<%=v_rcvname%>">
	<input type="hidden" name="v_rcvaddr" value="<%=v_rcvaddr%>">
	<input type="hidden" name="v_rcvtel" value="<%=v_rcvtel%>">
	<input type="hidden" name="v_rcvpost" value="<%=v_rcvpost%>">
	<input type="hidden" name="v_amount" value="<%=v_amount%>">
	<input type="hidden" name="v_ymd" value="<%=v_ymd%>">
	<input type="hidden" name="v_orderstatus" value="<%=v_orderstatus%>">
	<input type="hidden" name="v_moneytype" value="<%=v_moneytype%>">
	<input type="hidden" name="v_url" value="<%=v_url%>">
	<input type="hidden" name="v_md5info" value="<%=v_md5info%>">
	<input type="hidden" value="支付">
</form>



</body>
</html>

