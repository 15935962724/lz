<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.entity.yl.shop.ShopMyPoints"%>
<%@page import="tea.entity.yl.shop.ShopOrder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.alipay.util.*"%>
<%@ page import="com.alipay.config.*"%>
<%
	//获取支付宝POST过来反馈信息
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
		//valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
		params.put(name, valueStr);
	}
	
	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
	//商户订单号

	String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");

	//支付宝交易号

	String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");

	//交易状态
	String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");

	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//

	if(AlipayNotify.verify(params)){//验证成功
		//////////////////////////////////////////////////////////////////////////////////////////
		//请在这里加上商户的业务逻辑程序代码

		//——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
		
		if(trade_status.equals("TRADE_FINISHED")||trade_status.equals("TRADE_SUCCESS")){
			ShopOrder so=ShopOrder.findByOrderId(out_trade_no);
			if(!so.isPayment()&&so.getAmount()==Double.valueOf(request.getParameter("total_fee"))){//
				so.setPayment(true);
				so.setStatus(1);
				so.setPayTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("gmt_payment")));
				so.setPayment(2);
				so.set();
				ShopMyPoints.setPoints(out_trade_no, h.member);	
			}
			//out.print("用户"+h.member+"交易金额："+request.getParameter("total_fee")+"交易单号："+out_trade_no+(Double.valueOf(request.getParameter("total_fee"))==0.01));
		}

		//——请根据您的业务逻辑来编写程序（以上代码仅作参考）——
			
		out.println("success");	//请不要修改或删除

		//////////////////////////////////////////////////////////////////////////////////////////
	}else{//验证失败
		out.println("fail");
	}
%>
