<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="tea.entity.csvclub.alipay.*"%>

<%

String partner = "2088001505650066"; //partner合作伙伴id（必须填写）
String privateKey = "r2ssfxtmbltx8odm78fanj2g5upgcp1g"; //partner 的对应交易安全校验码（必须填写）
String alipayNotifyURL = "https://www.alipay.com/cooperate/gateway.do?service=notify_verify"+ "&partner="+ partner+ "&notify_id="+ request.getParameter("notify_id");

//获取支付宝ATN返回结果，true是正确的订单信息，false 是无效的
String responseTxt = CheckURL.check(alipayNotifyURL);

Map params = new HashMap();
//获得POST 过来参数设置到新的params中
Map requestParams = request.getParameterMap();
for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
  String name = (String) iter.next();
  String[] values = (String[]) requestParams.get(name);
  String valueStr = "";
  for (int i = 0; i < values.length; i++) {
    valueStr = (i == values.length - 1) ? valueStr + values[i]:valueStr + values[i] + ",";
  }
  params.put(name, valueStr);
}

String mysign = SignatureHelper.sign(params, privateKey);

if (mysign.equals(request.getParameter("sign")) && responseTxt.equals("true") ){
  out.println("success");
}
else
{
  out.println("fail");
}
%>
