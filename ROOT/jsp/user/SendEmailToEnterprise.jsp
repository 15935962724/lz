<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

if(request.getParameter("send")!=null)
{
  String subject=request.getParameter("subject");
  String text=request.getParameter("text");
  String to=request.getParameter("addressee");
  try
  {
    tea.service.SendEmaily se=new tea.service.SendEmaily(teasession._strCommunity);
    se.sendEmail(to,subject,text);
  } catch (Exception _ex)
  {}
  String member[]=request.getParameterValues("member");
  tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
  try
  {
    for (int index = 0; index < member.length; index++)
    {
      dbadapter.executeUpdate("DELETE FROM Profile WHERE member="+dbadapter.cite(member[index]));
      tea.entity.member.Profile pf=tea.entity.member.Profile.find(member[index]);
      pf.delete(teasession._nLanguage);
      pf._cache.clear();

      ProfileEnterprise pe = ProfileEnterprise.find(member[index],teasession._strCommunity);
      pe.delete();

      ProfileJob pj=ProfileJob.find(member[index],teasession._strCommunity);
      pj.delete();
    }
  }finally
  {
    dbadapter.close();
  }

  String nexturl= request.getParameter("nexturl");
  if(nexturl==null)
  nexturl="/jsp/user/AuditingEnterprise.jsp?node="+teasession._nNode;

  response.sendRedirect("/jsp/info/Succeed.jsp");
  return;
}

String object[]=request.getParameterValues("members");
StringBuffer email=new StringBuffer();
StringBuffer member=new StringBuffer();
if(object!=null)
for(int index=0;index<object.length;index++)
{
  tea.entity.member.Profile pf=tea.entity.member.Profile.find(object[index]);
  email.append(pf.getEmail()+",");
  member.append(new tea.html.HiddenField("member",object[index]));
}

Resource r=new Resource();
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
<body>
<h1><%=r.getString(teasession._nLanguage, "Sendmail")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" method="post" action="<%=request.getRequestURI()%>"   onSubmit="return(submitText(this.addressee,'无效的收件人')&&submitText(this.subject,'无效主题')&&submitText(this.text, '无效内容'));">
    <input type="hidden" name="send" value="on" />
    <%=member%>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>收件人:</td>
    <td ><input disabled="disabled" name="aa" value="<%=email.toString()%>" type="text"  class="edit_input"  size="95">
      <input name="addressee" value="<%=email.toString()%>" type="hidden" >
    </td>
  </tr>
  <tr>
    <td>主题:</td>
    <td><input name="subject" type="text"  class="edit_input"  size="95"></td>
  </tr>
  <tr>
    <td>内容:</td>
    <td><textarea name="text" cols="80"   class="edit_input" rows="15"></textarea></td>
  </tr>
</table>
<input name="" type="submit"  CLASS="CB" value="发送">
<input type="button" value="返回" onclick="history.back();"/>
</form>
 <SCRIPT>document.form1.subject.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>

</body>
</html>

