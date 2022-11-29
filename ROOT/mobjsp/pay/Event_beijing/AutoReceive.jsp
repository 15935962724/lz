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
		 int poid = 0;
		  if(v_oid.substring(14,v_oid.length()-2)!=null && v_oid.substring(14,v_oid.length()-2).length()>0)
		  {
			  poid = Integer.parseInt(v_oid.substring(14,v_oid.length()-2));
		  }
		  PayOrder pobj = PayOrder.find(poid);
		
		

       
    
       System.out.println("延迟交易订单:;"+pobj.getPayorder());//延迟交易订单:
		if("1".equals(a_pstatus[i]))
		{
			if(pobj.getType()==3)//电子报套餐支付
			{
				 
				  PackageOrder pkobj = PackageOrder.find(pobj.getPayorder());
				
				  
				  pobj.setPotype(1);
				  pobj.setPaytime(new Date());
					pkobj.set("type",1); 
					//修改支付方式
					pkobj.set("paymanner",2);//	在线支付 2
					//修改支付名称
					pkobj.setPayname(pkobj.PAYNAME_TYPE[2]);
					//修改付款时间
					pkobj.setPaytime(new Date());
					
					pkobj.set("effect",1);//修改生效状态 
					pkobj.setActivatimet(new Date());//修改激活时间
					pkobj.setSubtime(pobj.getPayorder());//修改套餐阅读有效期
					System.out.println("电子报套餐支付订单:"+pobj.getPayorder());
				  
			}else if(pobj.getType()==4)//手机支付
			{
				
				MobileOrder  mobj = MobileOrder.find(pobj.getPayorder());
				  pobj.setPotype(1);
				  pobj.setPaytime(new Date());
					//
				//激活 付款
				mobj.setType(1);
				mobj.setPaytime(new Date());
	 

				Cookie cookie=new Cookie(String.valueOf(mobj.getNode()),"/"+mobj.getMobile()+"/"+mobj.getMobilecode()+"/"+mobj.getNode()+"/"+mobj.getCommunity()+"/");
				cookie.setMaxAge(60*60*24);//60*60*24一天
				cookie.setPath("/");
				response.addCookie(cookie);
				 out.println("您的订单支付成功，订单号是：<font color=red>"+pobj.getPayorder()+"</font>,支付金额： "+pobj.getAmount()); 
				 System.out.println("shoujizhif:"+pobj.getPayorder());
			}
		}else
		{
          System.out.println("支付失败");
		}
	}
	out.print("sent");
}else
{
	out.print("error");
}
%>
