<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.subscribe.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.resource.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.entity.subscribe.*" %>
<%@page import="tea.entity.member.SMSMessage"%>
<%@page import="tea.service.SMS" %>
<%@page import="java.math.BigDecimal"%>



<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache"); 
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

String act = teasession.getParameter("act");
String nexturl = teasession.getParameter("nexturl");

if("mobilecode".equals(act))//判断短信确认码
{
	String mobile = teasession.getParameter("mobile");
	String mobilecode=teasession.getParameter("mobilecode");
	System.out.println(mobile+":"+mobilecode+":"+teasession._nNode);
	
	if(!MobileOrder.isMobilecode(mobile,mobilecode,teasession._nNode))
	{
		out.print("您输入的短信确认码不正确，请重新输入!");
		
	}
	return;
}else if("vertify".equals(act))// 判断验证码
{
	 String sv = (String) session.getAttribute("sms.vertify"); 
     String vertify = request.getParameter("vertify");
     if(vertify != null)
     {
         if(!vertify.trim().equals(sv))
         {
         	 session.removeAttribute("vertify");//退出session
           	out.print("您输入的附加码不正确，请重新输入!");
         	 return;
         }
     }
}else if("mobile".equals(act))//手机产生验证码
{
	String mobile = teasession.getParameter("mobile");
	Random random = new Random();
	String sRand="";
	for (int i=0;i<8;i++){
	    String rand=String.valueOf(random.nextInt(10));
	    sRand+=rand;
	}
    System.out.println(sRand); 
	
    BigDecimal amount = new BigDecimal("2");
    
    MobileOrder.create(mobile,sRand,teasession._nNode,teasession._strCommunity,amount);
    
	String i =   SMSMessage.create(teasession._strCommunity,mobile,mobile,teasession._nLanguage,"您的电子报短信确认码是："+sRand);
	   System.out.println(i);
	   
	   
	   
	   
	   response.sendRedirect("/jsp/general/subscribe/Mobilepay2.jsp?node="+teasession._nNode+"&act=mobile&mobile="+mobile);
	   return;
}else if("Againmobile".equals(act))//重新发送手机
{
	String mobile = teasession.getParameter("mobile");
	Random random = new Random();
	String sRand="";
	for (int i=0;i<8;i++){
	    String rand=String.valueOf(random.nextInt(10));
	    sRand+=rand;
	}
	 System.out.println("---重新发送确认码--"); 
    System.out.println(sRand); 
	 
    BigDecimal amount = new BigDecimal("2");
    MobileOrder.create(mobile,sRand,teasession._nNode,teasession._strCommunity,amount);
    
	String i =   SMSMessage.create(teasession._strCommunity,mobile,mobile,teasession._nLanguage,"您的电子报短信确认码是："+sRand);
	   System.out.println(i);
	   out.print("短信确认码 发送成功!");
	   return;
}else if("f_sub_delete".equals(act))//删除
{
	String chk_subidString [] = teasession.getParameterValues("checkbox_subid");
	String next_str ="成功删除";

	if(chk_subidString!=null)
	{
		for(int i = 0;i<chk_subidString.length;i++)
		{
			MobileOrder mobj = MobileOrder.find(chk_subidString[i]);
			if(mobj.getType()==3)//删除已经过期的
			{
				mobj.delete();
			}else
			{
				next_str = "抱歉!您删除的记录里面有未过期或没有激活的记录,\\n系统只能删除过期记录!";
				mobj.delete();
			}
		
		}
	}
       
		 out.print("<script  language='javascript'>alert('"+next_str+"');window.location.href='"+nexturl+"';</script> ");
         return;
}else if("f_sub_jh".equals(act))//激活
{
	String chk_subidString [] = teasession.getParameterValues("checkbox_subid");
	String next_str ="成功激活";

	if(chk_subidString!=null)
	{ 
		for(int i = 0;i<chk_subidString.length;i++)
		{
			MobileOrder mobj = MobileOrder.find(chk_subidString[i]);
			if(mobj.getType()==0)//
			{
				mobj.setType(1);
				mobj.setPaytime(new Date());
			
				
			}else
			{
				next_str = "抱歉!您激活的记录里面有过期或已经激活的记录,\\n系统只能激活没有过期记录!";
			}
		
		}
	}
       
		 out.print("<script  language='javascript'>alert('"+next_str+"');window.location.href='"+nexturl+"';</script> ");
         return;
}else if("Mobilepay_f_submit2".equals(act))//短信确认码激活
{
	String mobilecode = teasession.getParameter("mobilecode");
	int f = MobileOrder.isMobilecode(mobilecode,teasession._nNode);
	if(f==-1)
	{
		out.println("短信确认码【"+mobilecode+"】不存在，请您重新获取!");
	}else if(f==0)
	{
		out.println("短信确认码【"+mobilecode+"】还没有支付，请您尽快支付!");
	}else if(f==3)
	{
		out.println("短信确认码【"+mobilecode+"】已经过期，请您重新获取!");
	}else if(f==1)
	{
		
		MobileOrder mobj = MobileOrder.find(MobileOrder.getMobileOrder(mobilecode,teasession._nNode));
		//简历cookie
			 
		 long dqTimes=mobj.getMaturitytimes().getTime();
    	 long ddTimes =new Date().getTime();
    			long ss=(dqTimes-ddTimes)/(1000); //共计秒数
    			//int MM = (int)ss/60; //共计分钟数 
	     Cookie cookie=new Cookie(String.valueOf(mobj.getNode()),"/"+mobj.getMobile()+"/"+mobilecode+"/"+teasession._nNode+"/"+teasession._strCommunity+"/");
		cookie.setMaxAge((int)ss);//60*60*24一天
		// System.out.println((int)ss+"----"+(60*60*24));
		cookie.setPath("/");
		response.addCookie(cookie);
		out.println("激活成功!");
		System.out.println("Coolie激活成功"+mobj.getNode());
		
	} 
	
}
	
	

%>


