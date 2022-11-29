<%@page import="tea.entity.westrac.Teamtregistration"%>
<%@page import="tea.entity.node.GolfOrder"%>
<%@page import="tea.entity.westrac.Eventregistration"%>
<%@page contentType="text/html; charset=GBK" language="java"%><%@page import="tea.ui.*" %><%@page import="tea.entity.member.*"%><%@page import="com.capinfo.crypt.*"%><%@ page import="tea.entity.subscribe.*" %>
<%@ page import="tea.entity.admin.*" %><%@page import="java.util.Date" %><%
request.setCharacterEncoding("GBK");
TeaSession teasession=new TeaSession(request);

//获取参数
int v_count = Integer.parseInt(request.getParameter("v_count"));
String v_oid = request.getParameter("v_oid"); // 订单号
String v_pmode = request.getParameter("v_pmode");
String v_pstatus = request.getParameter("v_pstatus");
String v_pstring = request.getParameter("v_pstring");
String v_amount = request.getParameter("v_amount");
String v_moneytype = request.getParameter("v_moneytype");

String v_mac = request.getParameter("v_mac");
String v_md5money = request.getParameter("v_md5money");
String v_sign = request.getParameter("v_sign");

String text = v_oid + v_pstatus + v_amount + v_moneytype + v_count; //拼凑加密串

//首信公钥文件
String publicKey = application.getRealPath("/WEB-INF/lib/Public1024.key");

//公钥验证
RSA_MD5 rsaMD5 = new RSA_MD5();
int k = rsaMD5.PublicVerifyMD5(publicKey, v_sign, text);

System.out.println("首信易: 订单:"+v_oid+"\t验证:"+(k==0));//首信易: 订单: \t验证




if (k == 0)
{
	String a_oid[]=v_oid.split("\\|_\\|");
	String a_pmode[]=v_pmode.split("\\|_\\|");
	String a_pstatus[]=v_pstatus.split("\\|_\\|");
	String a_pstring[]=v_pstring.split("\\|_\\|");
	for(int i=0;i<v_count;i++)
    {
		 int sid = 0;
		  if(v_oid.substring(14,v_oid.length()-2)!=null && v_oid.substring(14,v_oid.length()-2).length()>0)
		  {
			  sid = Integer.parseInt(v_oid.substring(14,v_oid.length()-2));
		  }
				/*
				订单信息处理
				*/
				//获取支付设置
				Payinstall pobj = Payinstall.findpay(teasession._strCommunity,5);
				
				
				
				Eventregistration  erobj = Eventregistration.find(sid);
				Teamtregistration  tobj  = Teamtregistration.find(sid);
				GolfOrder goobj = GolfOrder.find(sid);
		
		  		String orderstring = "";
		

       
    
				 
    	   
    	   
		if("1".equals(a_pstatus[i]))
		{
			//判断活动类型的支付
    		if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/1/")!=-1  && erobj.getOrdering()!=null && erobj.getOrdering().indexOf("AC")!=-1)
    		{
    			
    			
    			erobj.setPatypeis(1);
    		  	erobj.setPaytypetime(new Date());
    		  	System.out.println("支付宝订单-类型：活动-延迟交易成功--订单："+erobj.getOrdering());
    		  	orderstring = erobj.getOrdering();
    		}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/2/")!=-1  && tobj.getOrdering()!=null && tobj.getOrdering().indexOf("TE")!=-1)
    		{
    			
    			
    			tobj.setPatypeis(1);
    			tobj.setPaytypetime(new Date());
    		  	System.out.println("支付宝订单-类型：球队-延迟交易成功--订单："+tobj.getOrdering());
    		  	orderstring = tobj.getOrdering();
    		}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/3/")!=-1  && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("GO")!=-1)
    		{
    			
    			
    			goobj.setIspay(1);
    			goobj.setPaytime(new Date());
    		  	System.out.println("支付宝订单-类型：球场-延迟交易成功--订单："+goobj.getOrderno());
    		  	orderstring = goobj.getOrderno();
    		}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/4/")!=-1  && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("CR")!=-1)
    		{
    			goobj.setIspay(1);
    			goobj.setPaytime(new Date());
    		  	System.out.println("支付宝订单-类型：教练-延迟交易成功--订单："+goobj.getOrderno());
    			orderstring = goobj.getOrderno();
    		}
			
    		
		}else
		{
			//判断活动类型的支付
    		if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/1/")!=-1  && erobj.getOrdering()!=null && erobj.getOrdering().indexOf("AC")!=-1)
    		{
    			
    			
    			erobj.setPatypeis(2);
    		  	erobj.setPaytypetime(new Date());
    		  	System.out.println("支付宝订单-类型：活动-延迟交易失败--订单号："+erobj.getOrdering());
    		}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/2/")!=-1  && tobj.getOrdering()!=null && tobj.getOrdering().indexOf("TE")!=-1)
    		{
    			
    			
    			tobj.setPatypeis(2);
    			tobj.setPaytypetime(new Date());
    		  	System.out.println("支付宝订单-类型：球队-延迟交易失败--订单号："+tobj.getOrdering());
    		}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/3/")!=-1  && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("GO")!=-1)
    		{
    			
    			
    			goobj.setIspay(2);
    			goobj.setPaytime(new Date());
    		  	System.out.println("支付宝订单-类型：球场-延迟交易失败--订单号："+goobj.getOrderno());
    		}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/4/")!=-1  && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("CR")!=-1)
    		{
    			goobj.setIspay(2);
    			goobj.setPaytime(new Date());
    		  	System.out.println("支付宝订单-类型：教练-延迟交易失败--订单号："+goobj.getOrderno());
    		}
			 System.out.println("延迟交易支付失败"+sid);
		}
	}
	out.print("sent");
}else
{
	out.print("error");
}
%>
