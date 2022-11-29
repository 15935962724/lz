<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.security.*"%>
<%@ page import="encrypt.MD5"%>
<%@ page import="tea.entity.member.*"%>
<%@page import="tea.ui.*" %>
<%
TeaSession teasession=new TeaSession(request);
	String c_mid			= request.getParameter("c_mid")		;
	String c_order			= request.getParameter("c_order")	;
	String c_orderamount	= request.getParameter("c_orderamount");
	String c_ymd			= request.getParameter("c_ymd")		;
	String c_transnum		= request.getParameter("c_transnum");
	String c_succmark		= request.getParameter("c_succmark");
	String c_moneytype		= request.getParameter("c_moneytype");
	String c_cause			= request.getParameter("c_cause")	;
	String c_memo1			= request.getParameter("c_memo1")	;
	String c_memo2			= request.getParameter("c_memo2")	;
	String c_signstr		= request.getParameter("c_signstr")	;

	String c_pass		= "gouwuxiang89";//商户自己的支付密钥

	//---对支付通知信息进行MD5加密
	MD5 md5 = new MD5();
	String srcStr = c_mid + c_order + c_orderamount + c_ymd + c_transnum + c_succmark + c_moneytype + c_memo1 + c_memo2 + c_pass;
	String r_signstr = md5.getMD5ofStr(srcStr).toLowerCase();

    System.out.println("云网  结果:"+c_succmark+"\t订单:"+c_order);


	//String cncardIP=request.getRemoteAddr();
	//在此可对请求IP地址进行校对。

	//---校验商户网站对通知信息的MD5加密的结果和云网支付网关提供的MD5加密结果是否一致
	//---在此也可以进行商户号，支付金额等信息进行校对，这由开发者自己来定。
	if (!r_signstr.equals(c_signstr))
	{
      System.out.println("云网: 签名验证失败");
      out.print("签名验证失败");
	}else
	{
      if("Y".equals(c_succmark))
      {
        out.print("<result>1</result><reURL>http://"+request.getServerName()+":"+request.getServerPort()+"/jsp/pay/cncard/get_user.jsp</reURL>");//;jsessionid="+session.getId()+"
        //在此进行数据操作。
        Trade obj=Trade.find(c_order);
        obj.setPaystate(1);
          Point.create(teasession._rv.toString(),Integer.parseInt(c_orderamount));
      }
	}


%>
