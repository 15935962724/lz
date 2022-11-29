<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="java.math.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="javax.mail.*" %>
<%@page import="javax.mail.internet.*" %>
<%@page import="tea.ui.*"%>
<%request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

Community c=Community.find(teasession._strCommunity);
final String user=c.getSmtpUser(); // smtp 简单邮件传输协议

if("POST".equals(request.getMethod()))
{
  String to=request.getParameter("to").trim();
  String from=request.getParameter("from").trim();
  String subject=request.getParameter("subject");
  String content=request.getParameter("content");

  final String pwd=c.getSmtpPassword();
  Properties properties = System.getProperties();
  // 简单应用一个 hashtable 表
  properties.put("mail.smtp.host", c.getSmtp());
  properties.put("mail.smtp.auth", "true");
  Session s = Session.getInstance(properties,new Authenticator()
  {
	public PasswordAuthentication getPasswordAuthentication()
	{
		return new PasswordAuthentication(user, pwd);
	}
  });
  try
  {
    MimeMessage mm = new MimeMessage(s);
    mm.setFrom(new InternetAddress(from));
    mm.addRecipient(Message.RecipientType.TO,new InternetAddress(to));
    mm.setSubject(subject,"UTF-8");
    mm.setContent(content,"text/html;charset=UTF-8");
    Transport.send(mm);
  }catch(Exception ex)
  {
    ex.printStackTrace();
  }
  response.sendRedirect("/jsp/info/Succeed.jsp");
  return;
}
%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

<form name="form1" method="post" action="?" onsubmit="return submitEmail(this.from,'无效-发件箱')&&submitEmail(this.to,'无效-收件箱')&&submitText(this.subject,'无效-主题')">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>发件箱</td>
      <td><input type="text" name="from" value="<%=user%>" /></td>
    </tr>
    <tr>
      <td>收件箱:</td>
      <td><input type="text" name="to" /></td>
    </tr>
    <tr>
      <td>主题</td>
      <td><input type="text" name="subject" /></td>
    </tr>
    <tr>
      <td>内容</td>
      <td><textarea name="content" cols="50" rows="8" ></textarea></td>
    </tr>
  </table>
  <input type="submit" value="提交" />
</form>

<div id="head6"><img height="6" src="about:blank" alt=""></div>
</body>
</html>
