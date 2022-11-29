<%@page contentType="text/html; charset=GBK" language="java"%>
<jsp:useBean id="MD5" scope="request" class="encrypt.MD5"/>
<%
request.setCharacterEncoding("GBK");

//获取参数
	   String v_oid = request.getParameter("v_oid");		// 订单号
	 String v_pmode = request.getParameter("v_pmode");		// 支付方式中文说明，如"中行长城信用卡"
   String v_pstatus = request.getParameter("v_pstatus");	// 支付结果，20支付完成；30支付失败；
   String v_pstring = request.getParameter("v_pstring");	// 对支付结果的说明，成功时（v_pstatus=20）为"支付成功"，支付失败时（v_pstatus=30）为"支付失败"
	String v_amount = request.getParameter("v_amount");		// 订单实际支付金额
 String v_moneytype = request.getParameter("v_moneytype");	// 币种
	String v_md5str = request.getParameter("v_md5str");		// MD5校验码
	 String remark1 = request.getParameter("remark1");		// 备注1
	 String remark2 = request.getParameter("remark2");		// 备注2

  //****************************************	// MD5密钥要跟订单提交页相同，如Send.asp里的 key = "test" ,修改""号内 test 为您的密钥
  // 如果您还没有设置MD5密钥请登陆我们为您提供商户后台，地址：https://merchant3.chinabank.com.cn/
  String key = "md5.9000.redcome.com";						// 登陆后在上面的导航栏里可能找到“资料管理”，在资料管理的二级导航栏里有“MD5密钥设置”
  // 建议您设置一个16位以上的密钥或更高，密钥最多64位，但设置16位已经足够了
  //****************************************

  String text = v_oid+v_pstatus+v_amount+v_moneytype+key;

  try
  {
    String v_md5 = MD5.getMD5ofStr(text).toUpperCase();
    if (v_md5.equals(v_md5str))
    {
      if ("30".equals(v_pstatus))
      {
        System.out.print("网银:支付失败");
      }else if ("20".equals(v_pstatus))
      {

      }
    }else
    {
      System.out.println("网银:校验码未通过，不是银行传递回来的参数");
      return;
    }
  }catch(Exception ex)
  {
    ex.printStackTrace();
  }
%>


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
		<table width="250" border="0" cellpadding="0" cellspacing="0" id="zhifuok">
        <TBODY>
          <TR>
            <TD>MD5校验码:<%=v_md5str%></TD>
          </TR>
          <TR>
            <TD> 订单号:<%=v_oid%></TD>
          </TR>
          <TR>
            <TD> 支付卡种:<%=v_pmode%></TD>
          </TR>
          <TR>
            <TD> 支付结果:<%=v_pstring%></TD>
          </TR>
          <TR>
            <TD> 支付金额:<%=v_amount%></TD>
          </TR>
          <TR>
            <TD> 支付币种:<%=v_moneytype%></TD>
          </TR>
        </TBODY>
      </TABLE>
</td></tr></table>
	</div>

	</body>