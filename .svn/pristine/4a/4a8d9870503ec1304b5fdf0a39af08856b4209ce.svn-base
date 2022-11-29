<%@page contentType="text/html; charset=GBK" language="java"%>
<%@page import="java.net.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="java.security.*"%>
<%@page import="encrypt.MD5"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.math.*"%>
<%@page import="tea.entity.site.*" %>
<%request.setCharacterEncoding("GBK");TeaSession teasession=new TeaSession(request);
/**
 * @Description: 快钱网关接口范例
 * @Copyright (c) 上海快钱信息服务有限公司
 * @version 2.0
 */
	String merchant_key ="58459662officebi";		///商户密钥

	String merchant_id = (String)request.getParameter("merchant_id");			///获取商户编号
	String orderid = (String)request.getParameter("orderid");		///获取订单编号
	String amount = (String)request.getParameter("amount");	///获取订单金额
	String dealdate = (String)request.getParameter("date");		///获取交易日期
	String succeed = (String)request.getParameter("succeed");	///获取交易结果,Y成功,N失败
	String mac = (String)request.getParameter("mac");		///获取安全加密串
	String merchant_param = (String)request.getParameter("merchant_param");		///获取商户私有参数

	String couponid = (String)request.getParameter("couponid") ;		///获取优惠券编码
	String couponvalue = (String)request.getParameter("couponvalue") ;		///获取优惠券面额

	///生成加密串,注意顺序
	String ScrtStr = "merchant_id=" + merchant_id + "&orderid=" + orderid + "&amount=" + amount + "&date=" + dealdate + "&succeed=" + succeed + "&merchant_key=" + merchant_key;
	 MD5 md5 = new MD5();
	String mymac = md5.getMD5ofStr(ScrtStr);


	String v_result="失败";
	if(!mymac.equals(mac))
    {
      System.out.println("快钱:签名错误");
      return;
    }
    System.out.println("快钱: 订单:"+orderid+"\t结果:"+succeed);
    if ("Y".equals(succeed))///支付成功
    {
		v_result="成功";

		Trade obj=Trade.find(orderid);
        obj.setPaystate(1);
         Point.create(teasession._rv.toString(),Integer.parseInt(amount));
     }else
     {		///支付失败


     }

%>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en" >
<html>
	<head>
		<title>快钱99bill</title>
		<meta http-equiv="content-type" content="text/html; charset=gb2312" />
	</head>
<sty>
	<body style="background-color:#DCF4DE">
<style>
*{font-size:14px}
img{border:0px}
#zhifuok{margin-left:20px}
#zhifuok td{padding:3px 10px;color:#000;margin-left:40px}
#zhifuleft{background-image: url(http://www.gouwuxiang.com/res/9000gw/u/0708/070812054.jpg);
	background-position: left middle;
	background-repeat: no-repeat;border-right:1px solid #ccc}
</style>
		<div align="center" style="margin-top;100px">

		<table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
		  <tr>
		  <td width="300" id="zhifuleft"> <div align="center">　　　　　　恭喜您,订单提交成功!<br>
            <br>
            <br>
		  </div>
	      <div style="text-align:center; margin:2px 0px;">　　<a  onclick="javascript:window.close(); return false;" href="#"><img src="http://www.gouwuxiang.com/res/9000gw/u/0708/070812055.jpg"></a></div></td>
		  <td width="250">
		<table width="250" border="0" cellpadding="0" cellspacing="0" id="zhifuok"><tr >
			  <td colspan="2" style="color:#419E4E"><b>支付信息：<br>
			  </b></td>
		  </tr>
			<tr >
				<td width="131">订单编号:</td>
			  <td width="169" ><%=orderid%></td>
			</tr>
			<tr >
				<td>订单金额:</td>
			  <td ><%=amount%></td>
			</tr>
			<tr >
				<td>支付结果:</td>
			  <td ><%=v_result%></td>
			</tr>

	  </table></td></tr></table>
	</div>

	</body>
</html>
