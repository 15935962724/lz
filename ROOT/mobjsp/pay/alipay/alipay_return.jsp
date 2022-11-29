<%@page import="tea.entity.admin.Payinstall"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.node.GolfOrder"%>
<%@page import="tea.entity.westrac.Teamtregistration"%>
<%@page import="tea.entity.westrac.Eventregistration"%>
<%@page import="mobcom.alipay.util.AlipayNotify"%>
<%
/* *
 功能：支付宝页面跳转同步通知页面
 版本：3.2
 日期：2011-03-17
 说明：
 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 该代码仅供学习和研究支付宝接口使用，只是提供一个参考。

 //***********页面功能说明***********
 该页面可在本机电脑测试
 可放入HTML等美化页面的代码、商户业务逻辑程序代码
 TRADE_FINISHED(表示交易已经成功结束，并不能再对该交易做后续操作);
 TRADE_SUCCESS(表示交易已经成功结束，可以对该交易做后续操作，如：分润、退款等);
 //********************************
 * */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Map"%>
<html>
  <head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>支付宝页面跳转同步通知页面</title>
  </head>
  <body>
<%
TeaSession teasession=new TeaSession(request);
String community = teasession._strCommunity;

//获取支付宝设置
Payinstall pobj = Payinstall.findpay(teasession._strCommunity,2);
	//获取支付宝GET过来反馈信息
	Map<String,String> params = new HashMap<String,String>();
	Map requestParams = request.getParameterMap();
	for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
		String name = (String) iter.next();
		String[] values = (String[]) requestParams.get(name);
		String valueStr = "";
		for (int i = 0; i < values.length; i++) {
			valueStr = (i == values.length - 1) ? valueStr + values[i]
					: valueStr + values[i] + ",";
		}
		//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
		valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
		params.put(name, valueStr);
	}

	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
	//商户订单号

	String cid = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");
	//支付宝交易号

	String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");

	//交易状态
	String result = new String(request.getParameter("result").getBytes("ISO-8859-1"),"UTF-8");

	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//
	
	//计算得出通知验证结果
	boolean verify_result = AlipayNotify.verifyReturn(params);
	Eventregistration  erobj = Eventregistration.find(Eventregistration.getErid(cid));
	Teamtregistration  tobj  = Teamtregistration.find(Teamtregistration.getErid(cid));
	GolfOrder goobj = GolfOrder.find(GolfOrder.getGoid(cid));
	if(verify_result){//验证成功
		//////////////////////////////////////////////////////////////////////////////////////////
		//请在这里加上商户的业务逻辑程序代码

		//——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
		
			//判断该笔订单是否在商户网站中已经做过处理
				//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
				//如果有做过处理，不执行商户的业务程序

		
		//该页面可做页面美工编辑
		
			//判断活动类型的支付
			if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/1/")!=-1  && erobj.getOrdering()!=null && erobj.getOrdering().indexOf("AC")!=-1)
			{
				
				
				erobj.setPatypeis(1);
			  	erobj.setPaytypetime(new Date());
			  	System.out.println("支付宝订单-类型：活动-支付成功！订单号："+cid);
			}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/2/")!=-1  && tobj.getOrdering()!=null && tobj.getOrdering().indexOf("TE")!=-1)
			{
				
				
				tobj.setPatypeis(1);
				tobj.setPaytypetime(new Date());
			  	System.out.println("支付宝订单-类型：球队-支付成功！订单号："+cid);
			}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/3/")!=-1  && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("GO")!=-1)
			{
				
				
				goobj.setIspay(1);
				goobj.setPaytime(new Date());
			  	System.out.println("支付宝订单-类型：球场-支付成功！订单号："+cid);
			}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/4/")!=-1  && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("CR")!=-1)
			{
				goobj.setIspay(1);
				goobj.setPaytime(new Date());
			  	System.out.println("支付宝订单-类型：教练-支付成功！订单号："+cid);
			}
		
		
		//该页面可做页面美工编辑
		out.println("<p class='suc'>支付成功,订单号 :"+cid+"</p>");
		out.println("<a href='/xhtml/folder/2712-1.htm'>查看我的订单</a>");
		//——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

		//////////////////////////////////////////////////////////////////////////////////////////
	}else{
		//该页面可做页面美工编辑
				out.println("<p class='fai'>支付失败,请联系网站管理员，我们会尽快处理</p>");
		  System.out.println("支付失败");
		  
		//判断活动类型的支付
				if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/1/")!=-1  && erobj.getOrdering()!=null && erobj.getOrdering().indexOf("AC")!=-1)
				{
					
					
					erobj.setPatypeis(2);
				  	erobj.setPaytypetime(new Date());
				  	System.out.println("支付宝订单-类型：活动-支付失败！订单号："+cid);
				}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/2/")!=-1  && tobj.getOrdering()!=null && tobj.getOrdering().indexOf("TE")!=-1)
				{
					
					
					tobj.setPatypeis(2);
					tobj.setPaytypetime(new Date());
				  	System.out.println("支付宝订单-类型：球队-支付失败！订单号："+cid);
				}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/3/")!=-1  && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("GO")!=-1)
				{
					
					
					goobj.setIspay(2);
					goobj.setPaytime(new Date());
				  	System.out.println("支付宝订单-类型：球场-支付失败！订单号："+cid);
				}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/4/")!=-1  && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("CR")!=-1)
				{
					goobj.setIspay(2);
					goobj.setPaytime(new Date());
				  	System.out.println("支付宝订单-类型：教练-支付失败！订单号："+cid);
				}
	}
%>
  </body>
</html>