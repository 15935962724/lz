<%@page import="tea.entity.westrac.Teamtregistration"%>
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

boolean f = false;
boolean f2 = false;
//获取支付 设置中的数值
//判断是否有首信易支付设置

Payinstall pobj = Payinstall.findpay(teasession._strCommunity,5);
float totalprices = 0f;//订单总价格
String goodname = "";// 商品名称
String membername="";//姓名
String phone = "";//手机号
Date times = new Date();
if(pobj.isExists())
{
	
	Eventregistration erobj = Eventregistration.find(regid);
	Teamtregistration tobj = Teamtregistration.find(regid);
	GolfOrder goobj = GolfOrder.find(regid);//包含球场和教练订单信息
	
	
	//判断活动类型的支付
	if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/1/")!=-1 && erobj.getOrdering()!=null && erobj.getOrdering().indexOf("AC")!=-1)
	{
		membername = erobj.getMembername();
		phone = erobj.getPhone();
		totalprices = erobj.getTotalprices();
		if(!erobj.isExists())
		{
			f = true;
		}else if(erobj.getPatypeis()==1)
		{
			f2 = true;
		}
		goodname = "时尚高夫活动订场";
		times = erobj.getTimes();
	}else if (pobj.getUsename()!=null && pobj.getUsename().indexOf("/2/")!=-1 && tobj.getOrdering()!=null && tobj.getOrdering().indexOf("TE")!=-1)
	{
		//判断球队的支付
		
		membername = tobj.getMembername();
		phone = tobj.getPhone();
	    totalprices = tobj.getTotalprices();
		if(!tobj.isExists())
		{
			f = true;
		}else if(tobj.getPatypeis()==1)
		{
			f2 = true;
		}
		goodname = "预定时尚高尔夫球队";
		times = tobj.getTimes();
	}else if (pobj.getUsename()!=null && pobj.getUsename().indexOf("/3/")!=-1 && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("GO")!=-1)
	{
		//判断 球场预定
		
		membername = goobj.getMembername();
		phone = goobj.getPhone();
	    totalprices = goobj.getTotalprice();
		if(!goobj.isExists())
		{
			f = true;
		}else if(goobj.getIspay()==1)
		{
			f2 = true;
		}
		goodname = "预定时尚高尔夫球场";
		times = goobj.getOrdertime();
	}else if (pobj.getUsename()!=null && pobj.getUsename().indexOf("/4/")!=-1 && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("CR")!=-1)
	{
		//判断 教练预定
		
		membername = goobj.getMembername();
		phone = goobj.getPhone();
	    totalprices = goobj.getTotalprice();
		if(!goobj.isExists())
		{
			f = true;
		}else if(goobj.getIspay()==1)
		{
			f2 = true;
		}
		goodname = "预定时尚高尔夫教练";
		times = goobj.getOrdertime();
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


//货币类型
int mailarea = 0;//人民币


java.text.SimpleDateFormat sdf1 = new  java.text.SimpleDateFormat("yyyyMMdd");//-MM-dd HH:mm:ss
String
		v_mid		= pobj.getMerchant().trim(),	//商户号，在注册后会获得
		key         =pobj.getSafety().trim(),
		v_rcvname	=  membername,//收货人姓名
		v_rcvaddr	=  "",//收货人地址
		v_rcvtel	=  phone,//收货人电话 
		v_rcvpost	= "",//收货人邮编
		v_amount	=String.valueOf(totalprices),//订单 金额 v_to
		v_ymd		=  sdf1.format(times),//String.valueOf(poobj.getTimes()),//订单日期
		v_ordername	=  "",//订货人姓名
		v_orderstatus	= "1",//配货状态
		v_moneytype	= String.valueOf(mailarea),//币种 0 为人民币
		v_url	=url+pobj.getReturnurl(),  //支付完成后返回地址。此地址是支付完成后，订单信息实时的向这个地址做返回。返回参数详见接口文档第二部分。
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

