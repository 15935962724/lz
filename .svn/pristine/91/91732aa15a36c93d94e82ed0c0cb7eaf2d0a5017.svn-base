<%@page import="tea.entity.yl.shop.ShopMyPoints"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.entity.yl.shop.ShopOrder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mobalipay.util.*"%>
<%@ page import="com.mobalipay.config.*"%>
<%
Http h=new Http(request);
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

String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");

//支付宝交易号

String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");

//交易状态
String result = new String(request.getParameter("result").getBytes("ISO-8859-1"),"UTF-8");

	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//

	if(AlipayNotify.verifyReturn(params)){//验证成功
		//////////////////////////////////////////////////////////////////////////////////////////
			
		out.println("支付成功");	//请不要修改或删除

		//////////////////////////////////////////////////////////////////////////////////////////
	}else{//验证失败
		out.println("支付失败");
	}
%>
