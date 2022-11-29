<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.resource.Resource"  %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.service.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX").add("/tea/ui/node/type/sms/EditUser");

String sn;
Enumeration e=DNS.findByCommunity(teasession._strCommunity);
if(!e.hasMoreElements())
{
	response.sendRedirect("/jsp/info/Alert.jsp?community="+teasession._strCommunity+"&info="+ java.net.URLEncoder.encode("没有找到该社区下的域名.","UTF-8"));
	return;
}
sn=(String)e.nextElement();

Community c=Community.find(teasession._strCommunity);

if(request.getMethod().equals("POST"))
{
	String firstname=request.getParameter("firstname");
	String member=request.getParameter("member");
	String job=request.getParameter("job");
	String telephone=request.getParameter("telephone");

	String organization=request.getParameter("organization");
	String country=request.getParameter("country");
	
	if(Profile.isExisted(member))
	{
		response.sendRedirect("/jsp/info/Alert.jsp?community="+teasession._strCommunity+"&info="+ java.net.URLEncoder.encode("用户已存在.<a href=\"javascript:history.back();\">"+r.getString(teasession._nLanguage, "Tautology")+"</A>","UTF-8"));
		return;
	}
	StringBuffer password=new StringBuffer();
	Random ra=new Random();
	for(int i=0;i<6;i++)
	{
		int j=ra.nextInt(62);
		if(j>35)
			j=j+97-36;
		else if(j>9)
			j=j+65-10;
		else 
			j=j+48;
		password.append((char)j);
	}
	Profile.create(member,teasession._strCommunity,password.toString());

	//援权
	Communitytrial ct=Communitytrial.find(teasession._strCommunity);
	AdminUsrRole.create(teasession._strCommunity,member,"/"+ct.getRole()+"/","/",ct.getUnit(),0);
	

	String url="http://"+sn+"/servlet/Login?community="+teasession._strCommunity+"&LoginType=0&LoginId="+member+"&Password="+password.toString()+"&nexturl=/jsp/admin/Frame.jsp";
	String login="http://"+sn+"/servlet/StartLogin?community="+teasession._strCommunity+"&nexturl=/jsp/admin/Frame.jsp";
	
	StringBuffer content=new StringBuffer();
	content.append("欢迎您访问 ").append(c.getName(teasession._nLanguage)).append("!<br/>");
	content.append("已附上您的密码。<br/><br/>");
	content.append(firstname).append(" 先生/小姐，您好！<br/><br/>");
	content.append("我们很高兴您决定试用 ").append(c.getName(teasession._nLanguage)).append(" 产品 - 市场上最好的按需 CRM 解决方案。<br/><br/>");
	content.append("用户名：").append(member).append("<br/>");
	content.append("临时密码：").append(password.toString()).append("<br/><br/>");
	content.append("单击 <a href=").append(url).append(">").append(url).append("</a> 可以立即登录。如果您在单击此链接时遇到问题，请转到 <a href=").append(login).append(" >").append(login).append("</a> ,手动输入您的用户名，并复制和粘贴您的临时密码，因为它区分大小写，而且某些数字和字母可能看上去相似。<br/><br/>");
	content.append("密码提示<br/>");
	content.append("- 登录并设置新密码后，您就不能再次使用临时密码。<br/><br/>");
	content.append("再次感谢您访问 ").append(c.getName(teasession._nLanguage));
	
	SendEmaily se=new SendEmaily(teasession._strCommunity);
	se.sendEmail(member,c.getName(teasession._nLanguage)+" 登陆确认",content.toString());
	
	response.sendRedirect("/jsp/info/Succeed.jsp?community="+teasession._strCommunity+"&info="+ java.net.URLEncoder.encode("试用申请成功.密码已发送到"+member,"UTF-8"));//+"&nexturl="+java.net.URLEncoder.encode("http://"+c.getSmtp(),"UTF-8")
	return;
}


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onload="form1.firstname.focus();">
<h1>免费试用</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<form name="form1" action="?" method="post" onSubmit="return submitText(form1.firstname,'<%=r.getString(teasession._nLanguage, "InvalidFirstName")%>')&&submitEmail(form1.member,'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>')&&submitText(form1.job,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')&&submitText(form1.telephone,'<%=r.getString(teasession._nLanguage, "InvalidTelephone")%>')&&submitText(form1.organization,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')">
  <input type=hidden name=community value="<%=teasession._strCommunity%>">
  <h2>关于您</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td>姓名:</td>
      <td><input name="firstname" type="text" size=30></td>
      <td>电子邮件:</td>
      <td><input name="member" type="text" size=30></td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td>职务:</td>
      <td><input name="job" type="text" size=30></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td>电话:</td>
      <td><input name="telephone" type="text" size=30></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>

  <br>
  <h2>您的公司</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td>公司:</td>
      <td><input name="organization" type="text" size=30></td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td>国家/地区:</td>
      <td><%=new tea.htmlx.CountrySelection("country",teasession._nLanguage)%></td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td></td>
      <td><input type="submit"  value="提交">
        <input type="reset" value="重置"></td>
    </tr>
  </table>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
