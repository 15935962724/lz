<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.ocean.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*" %><%@page import="java.util.Date" %>
<%@page import="com.capinfo.crypt.*" %>
<%@page import="java.net.URLDecoder"%>
<%@ page import="tea.entity.subscribe.*" %>
<%@ page import="tea.entity.admin.*" %>

<%

request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);


  String v_oid = request.getParameter("v_oid");
  String v_pmode = request.getParameter("v_pmode");
  String v_pstatus = request.getParameter("v_pstatus");
  String v_pstring = request.getParameter("v_pstring");
  String v_amount = request.getParameter("v_amount");
  String v_moneytype = request.getParameter("v_moneytype");
  String v_md5money = request.getParameter("v_md5money");
  String v_md5info = request.getParameter("v_md5info");
  String v_sign = request.getParameter("v_sign");
  
  if(request.getMethod().equals("GET"))
  { 
    String qs=request.getQueryString();
    if(qs==null)
    return;
    String param[]=qs.split("&");
    for(int i=0;i<param.length;i++)
    {
      if(param[i].startsWith("v_pmode="))
      {
        v_pmode=java.net.URLDecoder.decode(param[i].substring("v_pmode=".length()),"GBK");
      }else if(param[i].startsWith("v_pstring="))
      {
        v_pstring=java.net.URLDecoder.decode(param[i].substring("v_pstring=".length()),"GBK");
      }
    }
  }
  
  int poid = 0;
  if(v_oid.substring(14,v_oid.length()-2)!=null && v_oid.substring(14,v_oid.length()-2).length()>0)
  {
	  poid = Integer.parseInt(v_oid.substring(14,v_oid.length()-2));
  }
  PayOrder pobj = PayOrder.find(poid);
   
 tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);
//RSA验证
	String publicKey = application.getRealPath("/WEB-INF/lib/Public1024.key");
	String strSource = v_oid + v_pstatus + v_amount + v_moneytype;
%>
<html>
<body style="background-color:#DCF4DE">

<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<div class="paycon">
	<table  border="0" align="center" cellpadding="0" cellspacing="0"  id="zhifuleft">
		  <tr>
		  <td> 

<%

try  
{  
   RSA_MD5 rsaMD5 = new RSA_MD5();
  
	int k = rsaMD5.PublicVerifyMD5(publicKey,v_sign,strSource);
	if(k==0){
		
		
		if(pobj.getType()==3)//电子报套餐支付
		{
			 
			  PackageOrder pkobj = PackageOrder.find(pobj.getPayorder());
			  out.println("您的订单支付成功，订单号是：<font color=red>"+pobj.getPayorder()+"</font>,支付金额： "+pobj.getAmount());
			  
			  pobj.setPotype(1);
			  pobj.setPaytime(new Date());
				//
				
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
			  pobj.setPotype(1);
			  pobj.setPaytime(new Date());
				// 
			
			MobileOrder  mobj = MobileOrder.find(pobj.getPayorder());
			//激活 付款
			mobj.setType(1);
			mobj.setPaytime(new Date());
 

			Cookie cookie=new Cookie(String.valueOf(mobj.getNode()),"/"+mobj.getMobile()+"/"+mobj.getMobilecode()+"/"+mobj.getNode()+"/"+mobj.getCommunity()+"/");
			cookie.setMaxAge(60*60*24);//60*60*24一天
			cookie.setPath("/");
			response.addCookie(cookie);
			 out.println("<b>您的订单支付成功</b><br>订单号是：<font color=red>"+pobj.getPayorder()+"</font><br>支付金额： "+pobj.getAmount()); 
			 System.out.println("shoujizhif:"+pobj.getPayorder());
		}
		
	
    }
  else 
  {
		out.println("验证失败");
  }
} catch (Exception e)
{
	  out.println("验证异常.\n" + e);
}
%>

  </td>
	      </tr>
	      </table>
</div>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>



