<%@page contentType="text/html;charset=GBK" %><%@page import="java.math.*" %><%@page import="tea.entity.member.*" %><%@page import="java.net.*" %><%@page import="tea.entity.util.*"%><%@page import="tea.db.DbAdapter"%><%@page import="java.text.*"%><%@page import="java.util.*"%><%request.setCharacterEncoding("UTF-8");


String trade=request.getParameter("trade");

Trade obj=Trade.find(trade);

SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddhhmmss");

String transName="IPER",
TranAbbr="IPER",
MercDtTm=sdf.format(obj.getTime()), //"20070816175500",//商户日期时间
TermSsn=trade,//"200710231230",//订单号
MercCode="990108120011501",//商户号
TermCode="00000000",//终端号
TranAmt=obj.getTotal().toString(),//"11.02",//交易金额
Remark1="备注1",//交易备注1
Remark2="备注2",//交易备注2
MercUrl="http://"+request.getServerName()+":"+request.getServerPort()+"/jsp/pay/spdb/Receive.jsp";//MercUrl

String Plain="TranAbbr="+TranAbbr+"|MercDtTm="+MercDtTm+"|TermSsn="+TermSsn+"|OsttDate=|OacqSsn=|MercCode="+MercCode+"|TermCode="+TermCode+"|TranAmt="+TranAmt+"|Remark1="+URLEncoder.encode(Remark1,"GBK")+"|Remark2="+URLEncoder.encode(Remark2,"GBK")+"|MercUrl="+URLEncoder.encode(MercUrl,"GBK");

String Signature=com.csii.payment.client.core.MerchantSignVerify.merchantSignData_ABA(Plain);


%>
<html>
<body onload="form1.submit();">
<form name="form1" action=http://61.165.70.4/payment/main method="post">
<input type=hidden name=transName value="<%=TranAbbr%>">
<input type=hidden name=Plain value="<%=Plain%>">
<input type=hidden name=Signature value="<%=Signature%>">

<input type=hidden name=MercDtTm value="<%=MercDtTm%>">
<input type=hidden name=TermSsn value="<%=TermSsn%>">
<input type=hidden name=MercCode value="<%=MercCode%>">
<input type=hidden name=TermCode value="<%=TermCode%>">
<input type=hidden name=TranAmt value="<%=TranAmt%>">
<input type=hidden name=Remark1 value="<%=Remark1%>">
<input type=hidden name=Remark2 value="<%=Remark2%>">
<input type=hidden name=MercUrl value="<%=MercUrl%>">

<input type=hidden value=支付>
</form>
</body>
</html>
