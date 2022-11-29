<%@page import="tea.entity.node.GolfOrder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="tea.entity.csvclub.alipay.*"%>
<%@page import="tea.entity.women.*" %>

<%
String partner = "2088002417476575"; //partner合作伙伴id（必须填写） 
String privateKey = "5rn2jwqecdw80cacox1hecbmqnmxcffv"; //partner 的对应交易安全校验码（必须填写）
String alipayNotifyURL = "https://www.alipay.com/cooperate/gateway.do?service=notify_verify"
+ "&partner="
+ partner
+ "&notify_id="
+ request.getParameter("notify_id");

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

String mysign = SignatureHelper.sign(params, privateKey);


if (mysign.equals(request.getParameter("sign")) && responseTxt.equals("true") ){
	String b = request.getParameter("body");
  	String cid = b.substring(0,b.indexOf("-")).replaceAll("订单号：","").trim();
  	//修改订单信息
  	  
    GolfOrder goobj = GolfOrder.find(GolfOrder.getGoid(cid));
    goobj.setIspay(1);
	goobj.setPaytime(new Date());
	
  	System.out.println("支付宝-订单延迟："+cid); 
}
else
{
  out.println("fail");
}
%>
