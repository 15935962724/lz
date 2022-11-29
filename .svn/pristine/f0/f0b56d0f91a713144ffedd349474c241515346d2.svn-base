<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%@page import="com.capinfo.crypt.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.ui.*" %>
<%
TeaSession teasession=new TeaSession(request);

  String Plain = request.getParameter("Plain");
  String Signature = request.getParameter("Signature");
  String TranAbbr = request.getParameter("TranAbbr"); //交易缩写
  String AcqSsn = request.getParameter("AcqSsn"); //网关流水
  String MercDtTm = request.getParameter("MercDtTm"); //商户日期时间
  String TermSsn = request.getParameter("TermSsn"); //订单号
  String RespCode = request.getParameter("RespCode"); //响应码
  String TermCode = request.getParameter("TermCode"); //终端号
  String MercCode = request.getParameter("MercCode"); //商户号
  String TranAmt = request.getParameter("TranAmt"); //交易金额
  String SettDate = request.getParameter("SettDate"); //清算日期

  if(RespCode==null)
  {
    String s[]=Plain.split("[|]");
    for(int i=0;i<s.length;i++)
    {
      if(s[i].startsWith("RespCode="))
      {
        RespCode=s[i].substring("RespCode=".length());
      }else if(s[i].startsWith("TermSsn="))
      {
        TermSsn=s[i].substring("TermSsn=".length());
      }
    }
  }
  System.out.println("=================浦东发展银行======start==============");
  java.util.Enumeration e=request.getParameterNames();
  while(e.hasMoreElements())
  {
    String name=(String)e.nextElement();
    String value=request.getParameter(name);
    System.out.println(name+":"+value);
  }
  System.out.println("=================浦东发展银行==edn==================");

  boolean bool = com.csii.payment.client.core.MerchantSignVerify.merchantVerifyPayGate_ABA(Signature, Plain);


  %>
<html>
<head>
</head>
<body>
<%
  if (!bool)
  {
    out.print("校验失败");
  }else
  if ("00".equals(RespCode))
  {
    Trade obj=Trade.find(TermSsn);
    obj.setPaystate(1);
     Point.create(teasession._rv.toString(),Integer.parseInt(TranAmt));
    %>

    这里写支付成功界面

    <%
  }else
  {
    %>

    这里写支付失败<%="响应码:" + RespCode%>界面

    <%
  }
%>
</body>
</html>
