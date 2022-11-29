<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.ocean.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*" %><%@page import="java.util.Date" %>
<%@page import="com.capinfo.crypt.*" %>
<%@page import="java.net.URLDecoder"%>
<%@ page import="tea.entity.subscribe.*" %>

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
  String pkorder = v_oid.substring(14,v_oid.length()-2); 
  PackageOrder pobj = PackageOrder.find(pkorder);
 
 tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);
//RSA验证
	String publicKey = application.getRealPath("/WEB-INF/lib/Public1024.key");
	String strSource = v_oid + v_pstatus + v_amount + v_moneytype;
%>
<html>
<body style="background-color:#DCF4DE">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
	<table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
		  <tr>
		  <td width="300" id="zhifuleft"> <div align="center">

<%

try  
{ 
   RSA_MD5 rsaMD5 = new RSA_MD5();
  
	int k = rsaMD5.PublicVerifyMD5(publicKey,v_sign,strSource);
	if(k==0){
		out.println("交易成功");
		//
		
		pobj.set("type",1);
		//修改支付方式
		pobj.set("paymanner",2);//	在线支付 2
		//修改支付名称
		pobj.setPayname(pobj.PAYNAME_TYPE[2]);
		//修改付款时间
		pobj.setPaytime(new Date());
		
		pobj.set("effect",1);//修改生效状态
		pobj.setActivatimet(new Date());//修改激活时间
		pobj.setSubtime(pkorder);//修改套餐阅读有效期
		System.out.println("支付订单pkorder:"+pkorder);
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

<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>



