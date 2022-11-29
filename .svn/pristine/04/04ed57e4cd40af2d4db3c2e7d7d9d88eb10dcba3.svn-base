<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Resource r=new Resource("/tea/ui/member/email/EditEmailBox").add("/tea/ui/member/message/MessageFolders").add("/tea/ui/member/message/Messages").add("/tea/ui/member/email/EmailBoxs").add("/tea/ui/member/contact/CGroups");
int s =Integer.parseInt(  request.getParameter("emailbox"));
String s2 = "";
int i = 110;
String s4 = "";
String s6 = "";
String s8 = "";
String smtpserver="";
int smtpport=25;
int l = 0;
EmailBox emailbox = EmailBox.find(s);

s2 = emailbox.getPop3Server();
i = emailbox.getPop3Port();
smtpserver=emailbox.getSmtpServer();
smtpport=emailbox.getSmtpPort();
s4 = emailbox.getPop3User();
s8 = emailbox.getPop3Passwd();
l = emailbox.getPop3Options();


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onload="try{foEdit.EmailBox.focus(); }catch(e){ foEdit.Pop3Server.focus(); }">
<h1><%=r.getString(teasession._nLanguage, "EmailBox")%></h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>


<FORM name=foEdit METHOD="POST" action="/servlet/EditEmailBox" onSubmit="return(submitEmail(this.EmailBox,'<%=r.getString(teasession._nLanguage, "InvalidEmailBox")%>'));">
<input type=hidden name="community" value="<%=teasession._strCommunity%>">
<input type='hidden' name="emailbox" VALUE="<%=s%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</td>
<td><input type="TEXT" class="edit_input"  name="email" value="<%=MT.f(emailbox.getEmail())%>" SIZE=40></td>

  <tr>
    <td><%=r.getString(teasession._nLanguage, "SmtpServer")%>:</td>
    <td><input type="TEXT" class="edit_input"  name="smtpserver" VALUE="<%=MT.f(smtpserver)%>" SIZE=30 MAXLENGTH=40></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "SmtpPort")%>:</td>
    <td><input type="TEXT" class="edit_input"  name="smtpport" VALUE="<%=smtpport%>" mask="int"></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Pop3Server")%>:</td>
    <td><input type="TEXT" class="edit_input"  name=Pop3Server VALUE="<%=MT.f(s2)%>" SIZE=30 MAXLENGTH=40></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Pop3Port")%>:</td>
    <td><input type="TEXT" class="edit_input"  name=Pop3Port VALUE="<%=i%>" mask="int"></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Pop3User")%>:</td>
    <td><input type="TEXT" class="edit_input"  name=Pop3User VALUE="<%=MT.f(s4)%>" SIZE=30 MAXLENGTH=40></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Pop3Pass")%>:</td>
    <td><input name=Pop3Passwd type=PASSWORD class="edit_input" VALUE="<%=MT.f(s8)%>" SIZE=30 MAXLENGTH=20></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Options")%>:</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name=Pop3OAutoCheck value=null <%if((l & 4) != 0)out.print(" CHECKED ");%>><%=r.getString(teasession._nLanguage, "Pop3OAutoCheck")%></td>
  </tr>
  <tr>
    <td colspan="2"><input type=SUBMIT value="<%=r.getString(teasession._nLanguage, "CBSubmit")%>" id="CBSubmit" class="CB" onClick="">
      <input type="button" value="<%=r.getString(teasession._nLanguage, "CBBack")%>" onclick="history.back();"/>
    </td></tr>
</table>
</FORM>

<div id="head6"><img height="6" src="about:blank" alt=""></div>
<%--   <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>
