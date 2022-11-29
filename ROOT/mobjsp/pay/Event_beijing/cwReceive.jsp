<%@page contentType="text/html; charset=GBK" language="java"%><%@page import="java.util.Date" %><%@page import="tea.ui.*" %><%@ page import="tea.entity.chinesewomen.*" %><%@page import="tea.entity.member.*"%><%@page import="com.capinfo.crypt.*"%><%
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
       String trade =  a_oid[i].substring(14,a_oid[i].length());
   		Subscribeto sobj = Subscribeto.find(trade);
	   
       System.out.println("延迟交易订单:;"+trade);//延迟交易订单:
		if("1".equals(a_pstatus[i]))
		{
			sobj.setPayint(1,new Date());
		}else
		{
			sobj.setPayint(2,new Date());
		}
	}
	out.print("sent");
}else
{
	out.print("error");
}
%>
