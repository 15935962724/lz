<%@page import="tea.entity.westrac.Teamtregistration"%>
<%@page import="tea.entity.westrac.Eventregistration"%>
<%@page import="tea.entity.site.Community"%>
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
<%
request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);
 
Community community=Community.find(teasession._strCommunity);
int regid = Integer.parseInt(teasession.getParameter("regid"));
out.println("<link href='/tea/ym/black/ymPrompt.css' rel='stylesheet'type='text/css'>");
out.println("<script type='text/javascript' language='javascript' src='/tea/ym/ymPrompt.js'></script>");


StringBuffer sp = new StringBuffer();

boolean f = false;
boolean f2 = false;
//获取支付 设置中的数值
//判断是否有支付宝设置

Payinstall pobj = Payinstall.findpay(teasession._strCommunity,6);
float totalprices = 0f;//订单总价格
String goodname = "";// 商品名称
String ordering = "";//订单
if(pobj.isExists())
{
	
	Eventregistration erobj = Eventregistration.find(regid);
	Teamtregistration tobj = Teamtregistration.find(regid);
	GolfOrder goobj = GolfOrder.find(regid);//包含球场和教练订单信息
	
	
	//判断活动类型的支付
	if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/1/")!=-1 && erobj.getOrdering()!=null && erobj.getOrdering().indexOf("AC")!=-1)
	{
		
		
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
		ordering= erobj.getOrdering();
	}else if (pobj.getUsename()!=null && pobj.getUsename().indexOf("/2/")!=-1 && tobj.getOrdering()!=null && tobj.getOrdering().indexOf("TE")!=-1)
	{
		//判断球队的支付
		
		sp.append("订单号：").append(tobj.getOrdering()).append("-");
		sp.append("姓名：").append(tobj.getMembername()+"　");
		sp.append("手机号：").append(tobj.getPhone()+"　");
	    totalprices = tobj.getTotalprices();
		if(!tobj.isExists())
		{
			f = true;
		}else if(tobj.getPatypeis()==1)
		{
			f2 = true;
		}
		goodname = "预定时尚高尔夫球队";
		ordering= tobj.getOrdering();
	}else if (pobj.getUsename()!=null && pobj.getUsename().indexOf("/3/")!=-1 && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("GO")!=-1)
	{
		//判断 球场预定
		
		sp.append("订单号：").append(goobj.getOrderno()).append("-");
		sp.append("姓名：").append(goobj.getMembername()+"　");
		sp.append("手机号：").append(goobj.getPhone()+"　");
	    totalprices = goobj.getTotalprice();
		if(!goobj.isExists())
		{
			f = true;
		}else if(goobj.getIspay()==1)
		{
			f2 = true;
		}
		goodname = "预定时尚高尔夫球场";
		ordering= goobj.getOrderno();
	}else if (pobj.getUsename()!=null && pobj.getUsename().indexOf("/4/")!=-1 && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("CR")!=-1)
	{
		//判断 教练预定
		
		sp.append("订单号：").append(goobj.getOrderno()).append("-");
		sp.append("姓名：").append(goobj.getMembername()+"　");
		sp.append("手机号：").append(goobj.getPhone()+"　");
	    totalprices = goobj.getTotalprice();
		if(!goobj.isExists())
		{
			f = true;
		}else if(goobj.getIspay()==1)
		{
			f2 = true;
		}
		goodname = "预定时尚高尔夫教练";
		ordering= goobj.getOrderno();
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
//PayPal///////////////////////////////////////////////

//货币类型
String mailarea = "CNY";//人民币--CNY
/*
if(sobj.getMailarea()==1 || sobj.getMailarea()==4){
	mailarea = "USD";//美元
}else if(sobj.getMailarea()==2){
	mailarea = "EUR";// 欧元
}else if(sobj.getMailarea()==3)
{
	mailarea="GBP";//英镑	
} 
*/ 
String url = "http://"+request.getServerName()+":"+request.getServerPort();
String  v_url_f =url+pobj.getProcessurl();
String  v_url	=url+pobj.getReturnurl();  //支付完成后返回地址。此地址是支付完成后，订单信息实时的向这个地址做返回。返回参数详见接口文档第二部分。

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>

</head>

<body onload="ymPrompt.win({message:'<br><center>Submit...</center>',title:'',width:'300',height:'50',titleBar:false});paypal.submit();">

<!-- https://www.paypal.com/cgi-bin/webscr -->
	<form name="paypal" action="https://www.paypal.com/cgi-bin/webscr" method="post"> 
    <input type="hidden" name="cmd" value="_xclick"> 
    <input type="hidden" name="business" value="<%=pobj.getMerchant().trim()%>"><!--这里填写你的paypal账户email order@womenofchina.cn--> 
    <input type="hidden" name="item_name" value="Order No.<%=ordering %> from http://<%=request.getServerName() %>"><!--这里填写客户订单的一些相关信息，当客户连到paypal网站付款的时候将看到这些信息--> 
    <input type="hidden" name="item_number" value="<%=ordering %>">
    <input type="hidden" name="quantity" value="1"><!-- 数量 -->
       
    <input type="hidden" name="amount" value="<%=totalprices %>"><!--订单的总金额信息--> 
    <input type="hidden" name="currency_code" value="<%=mailarea %>"><!--订单总金额对应的货币类型 ,客户可以用其他币种来付款,比如这里订单币种是美元USD,客户可以用欧元EUR来付款,由paypal根据当前汇率自动实现币种之间的换算 -->    
   
    <input type="hidden" name="notify_url"  value="<%=v_url_f %>">
    
    <input type="hidden" name="return" value="<%=v_url %>"> 
    <!--这里告诉paypal付款的通信url,即当客户付款后调用这个url通知系统-->  
</form>



</body>
</html>
