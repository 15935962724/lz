<%@page contentType="text/html; charset=GBK" language="java"%><%@page import="tea.ui.*" %><%@page import="tea.entity.member.*"%><jsp:useBean id="MD5" scope="request" class="encrypt.MD5"/><%
request.setCharacterEncoding("GBK");


TeaSession teasession=new TeaSession(request);
  //****************************************	// MD5密钥要跟订单提交页相同，如Send.asp里的 key = "test" ,修改""号内 test 为您的密钥
  // 如果您还没有设置MD5密钥请登陆我们为您提供商户后台，地址：https://merchant3.chinabank.com.cn/
  String key = "md5.9000.redcome.com";						// 登陆后在上面的导航栏里可能找到“资料管理”，在资料管理的二级导航栏里有“MD5密钥设置”
  // 建议您设置一个16位以上的密钥或更高，密钥最多64位，但设置16位已经足够了
  //****************************************

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


  String text = v_oid+v_pstatus+v_amount+v_moneytype+key; //拼凑加密串

  try
  {
    String v_md5 = MD5.getMD5ofStr(text).toUpperCase();

    System.out.println("网银  结果:"+v_pstatus+"\t订单:"+v_oid+"\t验证:"+v_md5.equals(v_md5str));
    if (v_md5.equals(v_md5str))
    {
      out.print("ok"); //告诉服务器已经正确接收以及验证参数正确，要求停止发送

      if ("20".equals(v_pstatus))
      {
        // 支付成功，商户 根据自己业务做相应逻辑处理
        // 此处加入商户系统的逻辑处理（例如判断金额，判断支付状态，更新订单状态等等）......

        Trade obj=Trade.find(v_oid);
        obj.setPaystate(1);
          Point.create(teasession._rv.toString(),Integer.parseInt(v_amount));
      }
    }else
    {
      out.print("error");//校验失败,请求重发
    }
  }catch(Exception ex)
  {
    ex.printStackTrace();
  }
%>
