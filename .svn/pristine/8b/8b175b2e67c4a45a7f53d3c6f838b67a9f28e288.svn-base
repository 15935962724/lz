<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
 <%@page import="tea.entity.member.*"%>
  <%@page import="tea.entity.RV"%>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
String act=request.getParameter("act");
if(act.equals("send")){
String mobile=request.getParameter("mobile");
String verify = String.valueOf((int) (Math.random() * 10000));
application.setAttribute("verify_" + mobile,verify);
 
if(mobile.length()!=11)
{out.print("请输入正确的手机号！");
	}else{
out.print("验证码已发送！");
SMSMessage.create(teasession._strCommunity,mobile,mobile,1,"您申请的手机校验码为“" + verify + "”,请在页面中提交校验码完成下载！");
}
}else if(act.equals("verify")){
	String mobile=request.getParameter("mobile");
	String verify = request.getParameter("verify");
	String servercode=(String)application.getAttribute("verify_" + mobile);
	if(verify.equals(servercode))
	{  out.print("短信已发送！");
	 RV rv = new RV("webmaster");
		SMSMessage.create(teasession._strCommunity,mobile,mobile,1,"软件下载地址为：http://lvyou.westrac.com.cn/recruitment.apk");
		Logs.create("westrac", rv, 98, 0, "mobiledown/"+mobile);
	}else
		out.print("验证码输入错误！");
}

%>