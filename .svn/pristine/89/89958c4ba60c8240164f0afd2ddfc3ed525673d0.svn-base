<%@page import="tea.entity.node.GolfOrder"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.westrac.Teamtregistration"%>
<%@page import="tea.entity.westrac.Eventregistration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="tea.entity.csvclub.alipay.*"%>
<%@page import="tea.entity.women.*" %>

<%@page import="tea.entity.admin.Payinstall"%>
<%@page import="tea.entity.westrac.Eventregistration"%>

<%

TeaSession teasession=new TeaSession(request);
String community = teasession._strCommunity;

//获取支付宝设置
Payinstall pobj = Payinstall.findpay(teasession._strCommunity,2);


String partner = pobj.getMerchant().trim();//"2088702105602214"; //partner合作伙伴id（必须填写）
String privateKey = pobj.getSafety().trim();//"yfylsgs1licj174z8ify03dsqtdnry4b"; //partner 的对应交易安全校验码（必须填写）

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
for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) 
{
  String name = (String) iter.next();
  String[] values = (String[]) requestParams.get(name);
  String valueStr = "";
  for (int i = 0; i < values.length; i++) 
  {
    valueStr = (i == values.length - 1) ? valueStr + values[i]: valueStr + values[i] + ",";
  }
  params.put(name, valueStr);
}

String mysign = SignatureHelper.sign(params, privateKey);
    String b = request.getParameter("body");
	String cid = b.substring(0,b.indexOf("-")).replaceAll("订单号：","").trim();
	Eventregistration  erobj = Eventregistration.find(Eventregistration.getErid(cid));
	Teamtregistration  tobj = Teamtregistration.find(Teamtregistration.getErid(cid));
	GolfOrder goobj = GolfOrder.find(GolfOrder.getGoid(cid));

if (mysign.equals(request.getParameter("sign")) && responseTxt.equals("true") )
{
	
  //判断活动类型的支付
  		if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/1/")!=-1  && erobj.getOrdering()!=null && erobj.getOrdering().indexOf("AC")!=-1)
  		{
  			
  	  	  	erobj.setPatypeis(1); 
  	  	  	erobj.setPaytypetime(new Date());
  	  	    System.out.println("支付宝-类型：活动--订单延迟--成功--订单：："+cid); 	
  		}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/2/")!=-1 && tobj.getOrdering()!=null && tobj.getOrdering().indexOf("TE")!=-1)
  		{
  			
  			tobj.setPatypeis(1);
  			tobj.setPaytypetime(new Date());
  	  	    System.out.println("支付宝-类型：球队--订单延迟--成功--订单：："+cid); 	
  		}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/3/")!=-1  && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("GO")!=-1)
		{
			
			
			goobj.setIspay(1);
			goobj.setPaytime(new Date());
		  	System.out.println("支付宝订单-类型：球场-订单延迟--成功！订单号："+cid);
		}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/4/")!=-1  && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("CR")!=-1)
		{
			
			
			goobj.setIspay(1);
			goobj.setPaytime(new Date());
		  	System.out.println("支付宝订单-类型：教练-订单延迟-支付成功！订单号："+cid);
		}
  		
}
else
{
  System.out.println("订单延迟修改信息失败");
  
//判断活动类型的支付
	if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/1/")!=-1  && erobj.getOrdering()!=null && erobj.getOrdering().indexOf("AC")!=-1)
	{
		
  	  	erobj.setPatypeis(2); 
  	  	erobj.setPaytypetime(new Date());
  	    System.out.println("支付宝-类型：活动--订单延迟---失败-订单：："+cid); 	
	}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/2/")!=-1 && tobj.getOrdering()!=null && tobj.getOrdering().indexOf("TE")!=-1)
	{
		
		tobj.setPatypeis(2);
		tobj.setPaytypetime(new Date());
  	    System.out.println("支付宝-类型：球队--订单延迟--失败-订单：："+cid); 	
	}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/3/")!=-1  && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("GO")!=-1)
	{
		
		
		goobj.setIspay(2);
		goobj.setPaytime(new Date());
	  	System.out.println("支付宝订单-类型：球场-订单延迟---失败！订单号："+cid);
	}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/4/")!=-1  && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("CR")!=-1)
	{
		
		
		goobj.setIspay(2);
		goobj.setPaytime(new Date());
	  	System.out.println("支付宝订单-类型：教练-订单延迟---失败！订单号："+cid);
	}
}
%>
