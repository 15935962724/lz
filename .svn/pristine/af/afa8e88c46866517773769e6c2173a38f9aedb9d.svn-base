<%@page import="tea.entity.node.GolfOrder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="tea.entity.csvclub.alipay.*"%>
<%@page import="tea.entity.women.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>
  </title>
</head>
<body>
<%
String partner = "2088702105602214"; //partner合作伙伴id（必须填写）
String privateKey = "yfylsgs1licj174z8ify03dsqtdnry4b"; //partner 的对应交易安全校验码（必须填写）
String alipayNotifyURL = "https://www.alipay.com/cooperate/gateway.do?service=notify_verify"
+ "&partner="
+ partner
+ "&notify_id="
+ request.getParameter("notify_id");
String sign=request.getParameter("sign");
//获取支付宝ATN返回结果，true是正确的订单信息，false 是无效的
String responseTxt = CheckURL.check(alipayNotifyURL);

Map params = new HashMap();
//获得POST 过来参数设置到新的params中
Map requestParams = request.getParameterMap();
for (Iterator iter = requestParams.keySet().iterator(); iter
.hasNext();) {
  String name = (String) iter.next();
  String[] values = (String[]) requestParams.get(name);
  String valueStr = "";
  for (int i = 0; i < values.length; i++) {
    valueStr = (i == values.length - 1) ? valueStr + values[i]
    : valueStr + values[i] + ",";
  }
  params.put(name, valueStr);
}
String mysign = tea.entity.csvclub.alipay.SignatureHelper_return.sign(params, privateKey);

//打印，收到消息比对sign的计算结果和传递来的sign是否匹配
 	String b = request.getParameter("body");
  	String cid = b.substring(0,b.indexOf("-")).replaceAll("订单号：","").trim();
  	//修改订单信息
  	      GolfOrder goobj = GolfOrder.find(GolfOrder.getGoid(cid));
//支付成功
if (mysign.equals(request.getParameter("sign")) && responseTxt.equals("true") ){

  //out.println("success");
  //out.println(params.get("body"));//测试时候用，可以删除
  //	out.println(params.get("body"));
  //out.println("显示订单信息");
  	//out.println(responseTxt);
 

  	
	goobj.setIspay(1);
	goobj.setPaytime(new Date());
	
  	System.out.println("支付宝订单-支付成功！订单号："+cid);

%>
 支付成功,订单号 :<%=cid %>
<% 	
}
else
{
  out.println("支付失败");
  System.out.println("支付失败");
	
	
}


%>
</body>
</html>
