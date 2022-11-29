<%@page contentType="text/html;charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");
tea.resource.Resource r=new tea.resource.Resource();
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);

if(request.getMethod().equals("POST"))
{
  String subject=request.getParameter("subject");
  String text=request.getParameter("text");//new String(request.getParameter("text").getBytes("ISO-8859-1"));
  String s5=request.getParameter("to");
  int k = tea.entity.member.Message.create(teasession._strCommunity,null, community.getEmail(), 0, 0, 2, 0, teasession._nLanguage, subject, text,null,null,"",null,s5,"", "", null, null, 0, 0);
  try
  {
    tea.service.Robot.activateRoboty(teasession._nNode,k);
  } catch (Exception _ex)
  {}
  response.sendRedirect("/jsp/user/EjMember.jsp?node="+teasession._nNode);
  return;
}
StringBuffer mail=new StringBuffer();
String value[]=request.getParameterValues("mail");
if(value!=null)
for(int index=0;index<value.length;index++)
{
  if(value[index].length()>0)
  mail.append(value[index]+",");
}
%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/tea/CssJs/<%=community._strCommunity%>.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Sendmail")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name="form1" method="post" action="" onsubmit="return submitText(this.to,'收件人不能为空')&&submitText(this.subject,'主题不能为空')&&submitText(this.text,'内容不能为空')">
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>收件人</td>
      <td><input name="to" type="text" size="80" value="<%=mail.toString()%>"></td>
    </tr>
    <tr>
      <td>主题</td>
      <td><input name="subject" type="text" size="80"></td>
    </tr>
    <tr>
      <td>内容</td>
      <td><textarea name="text" cols="70"  rows="6"></textarea></td>
</tr>
</table>
<input type="submit" value="发送"><input type="reset" value="重置">
</form>
 <div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

