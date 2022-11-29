<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.admin.Payinstall"%>
<%@page import="tea.entity.node.GolfOrder"%>
<%@page import="tea.entity.westrac.Teamtregistration"%>
<%@page import="tea.entity.westrac.Eventregistration"%>
<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>

<%
// read post from PayPal system and add 'cmd'
TeaSession teasession=new TeaSession(request);
String community = teasession._strCommunity;
Enumeration en = request.getParameterNames();
String str = "cmd=_notify-validate";
while(en.hasMoreElements()){
String paramName = (String)en.nextElement();
String paramValue = request.getParameter(paramName);
str = str + "&" + paramName + "=" + URLEncoder.encode(paramValue);
}

// post back to PayPal system to validate
// NOTE: change http: to https: in the following URL to verify using SSL (for increased security).
// using HTTPS requires either Java 1.4 or greater, or Java Secure Socket Extension (JSSE)
// and configured for older versions.
//URL u = new URL("https://www.paypal.com/cgi-bin/webscr");
URL u = new URL("https://www.paypal.com/cgi-bin/webscr");
URLConnection uc = u.openConnection();
uc.setDoOutput(true);
uc.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
PrintWriter pw = new PrintWriter(uc.getOutputStream());
pw.println(str);
pw.close();

BufferedReader in = new BufferedReader(
new InputStreamReader(uc.getInputStream()));
String res = in.readLine();
in.close();

// assign posted variables to local variables

String itemNumber = request.getParameter("item_number");//订单号

System.out.println("支付订单:"+res+"--订单号："+itemNumber);
//判断支付类型
Payinstall pobj = Payinstall.findpay(teasession._strCommunity,6);
  
Eventregistration  erobj = Eventregistration.find(Eventregistration.getErid(itemNumber));
Teamtregistration  tobj = Teamtregistration.find(Teamtregistration.getErid(itemNumber));
GolfOrder goobj = GolfOrder.find(GolfOrder.getGoid(itemNumber));

if(res.equals("VERIFIED")) {//已验证
	
	
	
	//判断活动类型的支付
		if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/1/")!=-1  && erobj.getOrdering()!=null && erobj.getOrdering().indexOf("AC")!=-1)
		{
			
	  	  	erobj.setPatypeis(1); 
	  	  	erobj.setPaytypetime(new Date());
	  	    System.out.println("支付宝-类型：活动--订单延迟--成功--订单：："+itemNumber); 	
		}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/2/")!=-1 && tobj.getOrdering()!=null && tobj.getOrdering().indexOf("TE")!=-1)
		{
			
			tobj.setPatypeis(1);
			tobj.setPaytypetime(new Date());
	  	    System.out.println("支付宝-类型：球队--订单延迟--成功--订单：："+itemNumber); 	
		}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/3/")!=-1  && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("GO")!=-1)
	{
		
		
		goobj.setIspay(1);
		goobj.setPaytime(new Date());
	  	System.out.println("支付宝订单-类型：球场-订单延迟--成功！订单号："+itemNumber);
	}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/4/")!=-1  && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("CR")!=-1)
	{
		
		
		goobj.setIspay(1);
		goobj.setPaytime(new Date());
	  	System.out.println("支付宝订单-类型：教练-订单延迟-支付成功！订单号："+itemNumber);
	}
	
	
	
	
}
else if(res.equals("INVALID")) {//无效
	 System.out.println("订单延迟修改信息失败");
	  
	//判断活动类型的支付
		if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/1/")!=-1  && erobj.getOrdering()!=null && erobj.getOrdering().indexOf("AC")!=-1)
		{
			
	  	  	erobj.setPatypeis(2); 
	  	  	erobj.setPaytypetime(new Date());
	  	    System.out.println("支付宝-类型：活动--订单延迟---失败-订单：："+itemNumber); 	
		}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/2/")!=-1 && tobj.getOrdering()!=null && tobj.getOrdering().indexOf("TE")!=-1)
		{
			
			tobj.setPatypeis(2);
			tobj.setPaytypetime(new Date());
	  	    System.out.println("支付宝-类型：球队--订单延迟--失败-订单：："+itemNumber); 	
		}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/3/")!=-1  && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("GO")!=-1)
		{
			
			
			goobj.setIspay(2);
			goobj.setPaytime(new Date());
		  	System.out.println("支付宝订单-类型：球场-订单延迟---失败！订单号："+itemNumber);
		}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/4/")!=-1  && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("CR")!=-1)
		{
			
			
			goobj.setIspay(2);
			goobj.setPaytime(new Date());
		  	System.out.println("支付宝订单-类型：教练-订单延迟---失败！订单号："+itemNumber);
		}
}
else {//错误的
// error
}
%>