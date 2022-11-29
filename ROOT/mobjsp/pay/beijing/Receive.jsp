<%@page import="tea.entity.admin.Payinstall"%>
<%@page import="tea.entity.westrac.Teamtregistration"%>
<%@page import="tea.entity.node.GolfOrder"%>
<%@page import="tea.entity.westrac.Eventregistration"%>
<%@page contentType="text/html; charset=UTF-8" language="java"%><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.ocean.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*" %><%@page import="java.util.Date" %><%@page import="com.capinfo.crypt.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
Calendar cal = Calendar.getInstance();
int day = cal.get(Calendar.DAY_OF_MONTH);
cal.set(Calendar.DATE,day+5);


//获取参数
String v_oid = request.getParameter("v_oid"); // 订单号/商户发送的v_oid定单编号;
String v_pstatus = request.getParameter("v_pstatus");//支付结果，1待处理（支付结果未确定）；20支付完成；30支付被拒绝；
String v_pstring = request.getParameter("v_pstring");//已提交（当v_pstatus=1时）；//支付完成（当v_pstatus=20时）；//失败原因（当v_pstatus=30时,字符串）；
String v_pmode = request.getParameter("v_pmode");//支付方式（字符串）；/支付方式（字符串）；
String v_md5info = request.getParameter("v_md5info");// char* text     拼串结果//          char* key     对称密钥v_md5info校验四个参数，拼接字符串的顺序为：v_oid，v_pstatus，v_pstring和v_pmode/
String v_amount = request.getParameter("v_amount");//订单总金额  订单实际支付金额//
String v_moneytype = request.getParameter("v_moneytype");//7．v_moneytype 订单实际支付币种//
String v_md5money = request.getParameter("v_md5money");//8．v_md5money=char* hmac_md5(char* text, char* key)//v_md5money效验两个参数，拼接字符串的顺序为：v_amount，v_moneytype
String v_sign = request.getParameter("v_sign");


String v_oid_s[]=v_oid.split("\\|_\\|");
String v_pstatus_s[] = v_pstatus.split("\\|_\\|");//支付结果，1待处理（支付结果未确定）；20支付完成；30支付被拒绝；
String v_pstring_s[] = v_pstring.split("\\|_\\|");//已提交（当v_pstatus=1时）；//支付完成（当v_pstatus=20时）；//失败原因（当v_pstatus=30时,字符串）；
String v_pmode_s[] = v_pmode.split("\\|_\\|");//支付方式（字符串）；/支付方式（字符串）；
String v_md5info_s[] = v_md5info.split("\\|_\\|");// char* text     拼串结果//          char* key     对称密钥v_md5info校验四个参数，拼接字符串的顺序为：v_oid，v_pstatus，v_pstring和v_pmode/
String v_amount_s[] = v_amount.split("\\|_\\|");//订单总金额  订单实际支付金额//
String v_moneytype_s[] = v_moneytype.split("\\|_\\|");//7．v_moneytype 订单实际支付币种//
String v_md5money_s[] = v_md5money.split("\\|_\\|");//8．v_md5money=char* hmac_md5(char* text, char* key)//v_md5money效验两个参数，拼接字符串的顺序为：v_amount，v_moneytype
String v_sign_s[] = v_sign.split("\\|_\\|");




//v_md5info校验四个参数，拼接字符串的顺序为：v_oid，v_pstatus，v_pstring和v_pmode/
//6．v_amount订单实际支付金额//
//7．v_moneytype 订单实际支付币种//
//8．v_md5money=char* hmac_md5(char* text, char* key)
//char* text     拼串结果
//           char* key     对称密钥
//v_md5money效验两个参数，拼接字符串的顺序为：v_amount，v_moneytype
String qs22=request.getQueryString();
System.out.print(qs22.toString());
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






//RSA验证
	String publicKey = application.getRealPath("/WEB-INF/lib/Public1024.key");
	String strSource = v_oid + v_pstatus + v_amount + v_moneytype;
	
try
{
   RSA_MD5 rsaMD5 = new RSA_MD5();

	int k = rsaMD5.PublicVerifyMD5(publicKey,v_sign,strSource);
	
	if(k==0){
		//out.println("验证成功");
    }
  else
  {
		out.println("验证失败");
        return;

  }
} catch (Exception e)
{
	  out.println("验证异常.\n" + e);
       return;
}






tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);

/*
订单信息处理
*/

//获取支付设置
Payinstall pobj = Payinstall.findpay(teasession._strCommunity,5);

//获取的订单号
int sid = Integer.parseInt(v_oid.substring(14,v_oid.length()));

Eventregistration  erobj = Eventregistration.find(sid);
Teamtregistration  tobj  = Teamtregistration.find(sid);
GolfOrder goobj = GolfOrder.find(sid);

String orderstring = "";


%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>
交易成功
</title>
</head>
<body  id="bodynone2">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>


          <form  name="form1" action="?" method="get" enctype="multipart/form-data">
          <input   type="hidden"  name="act"  value="OceanSuccess">
          <table id="tableSuccess">
            <tr><td rowspan="2" class="td01"><%if
            ("1".equals(v_pstatus))
            {
            	System.out.println("支付提交");
            } else if ("20".equals(v_pstatus))
            {
               
            	//判断活动类型的支付
        		if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/1/")!=-1  && erobj.getOrdering()!=null && erobj.getOrdering().indexOf("AC")!=-1)
        		{
        			
        			
        			erobj.setPatypeis(1);
        		  	erobj.setPaytypetime(new Date());
        		  	System.out.println("支付宝订单-类型：活动-支付成功！订单号："+erobj.getOrdering());
        		  	orderstring = erobj.getOrdering();
        		}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/2/")!=-1  && tobj.getOrdering()!=null && tobj.getOrdering().indexOf("TE")!=-1)
        		{
        			
        			
        			tobj.setPatypeis(1);
        			tobj.setPaytypetime(new Date());
        		  	System.out.println("支付宝订单-类型：球队-支付成功！订单号："+tobj.getOrdering());
        		  	orderstring = tobj.getOrdering();
        		}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/3/")!=-1  && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("GO")!=-1)
        		{
        			
        			
        			goobj.setIspay(1);
        			goobj.setPaytime(new Date());
        		  	System.out.println("支付宝订单-类型：球场-支付成功！订单号："+goobj.getOrderno());
        		  	orderstring = goobj.getOrderno();
        		}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/4/")!=-1  && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("CR")!=-1)
        		{
        			goobj.setIspay(1);
        			goobj.setPaytime(new Date());
        		  	System.out.println("支付宝订单-类型：教练-支付成功！订单号："+goobj.getOrderno());
        			orderstring = goobj.getOrderno();
        		}else
        		{
        			System.out.println("没有找到具体支付设置方式，请检查");
        		}
             	 
				

            }else if ("30".equals(v_pstatus))
            {
            	//判断活动类型的支付
        		if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/1/")!=-1  && erobj.getOrdering()!=null && erobj.getOrdering().indexOf("AC")!=-1)
        		{
        			
        			
        			erobj.setPatypeis(2);
        		  	erobj.setPaytypetime(new Date());
        		  	System.out.println("支付宝订单-类型：活动-支付失败--订单号："+erobj.getOrdering());
        		}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/2/")!=-1  && tobj.getOrdering()!=null && tobj.getOrdering().indexOf("TE")!=-1)
        		{
        			
        			
        			tobj.setPatypeis(2);
        			tobj.setPaytypetime(new Date());
        		  	System.out.println("支付宝订单-类型：球队-支付失败--订单号："+tobj.getOrdering());
        		}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/3/")!=-1  && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("GO")!=-1)
        		{
        			goobj.setIspay(2);
        			goobj.setPaytime(new Date());
        		  	System.out.println("支付宝订单-类型：球场-支付失败--订单号："+goobj.getOrderno());
        		}else if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/4/")!=-1  && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("CR")!=-1)
        		{
        			goobj.setIspay(2);
        			goobj.setPaytime(new Date());
        		  	System.out.println("支付宝订单-类型：教练-支付失败--订单号："+goobj.getOrderno());
        		}
				 System.out.println("支付失败"+sid);

            }
            %></td>
            </tr>
<tr>
  <td class="td03"><%if
  ("1".equals(v_pstatus))
  {
    %>
您的资金已提交，请等待工作人员进行支付确认！<BR>
    <%
    } else if ("20".equals(v_pstatus))
    {

      %>
      <div class="Payno1">
      您好：<br>
请牢记您的订单编号：<%=	orderstring %><!--，相关信息已经发送到您的邮箱zhangsan@sina.com，请注意查收。--></div>
<div class="Payno2"><!--，相关信息已经发送到您的邮箱zhangsan@sina.com，请注意查收。--></div>　
      <%
      }else if ("30".equals(v_pstatus))
      {
        %>
				交易失败，请重新申请！
        <%
        }%></td>
        </tr>
          </table>
        <div class="CloseButton">
<input type="button" value="关闭" onClick="window.close();" />
</div>
          </form>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>

