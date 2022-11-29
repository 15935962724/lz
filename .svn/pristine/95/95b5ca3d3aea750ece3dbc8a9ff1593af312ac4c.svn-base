<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.text.MessageFormat" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.site.*" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Resource r=new Resource("/tea/resource/Workreport");

String tomember=request.getParameter("tomember");

%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "MsgOSendMessage")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<FORM name=form1 METHOD=POST ACTION="/servlet/NewMessage" ENCtype=multipart/form-data onSubmit="return(submitText(this.To, '<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')&&submitText(this.Subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>'));">
  <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
  <input type='hidden' name=community VALUE="<%=teasession._strCommunity%>">
  <input type='hidden' name=Message VALUE="0">
  <input type='hidden' name=Cc VALUE="">
  <input type='hidden' name=Bcc VALUE="">
    <input type='hidden' name=Hint VALUE="0">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "MemberId")%>:</td>
      <td><input type="TEXT" class="edit_input"  name=To VALUE="<%if(tomember!=null)out.print(tomember);%>" SIZE=40></td>
    </tr>
	      <tr>
        <td><%=r.getString(teasession._nLanguage, "Options")%>:</td>
        <td><input   type="CHECKBOX"  id=MsgOSendEmail name=MsgOSendEmail value=null>
          <%=r.getString(teasession._nLanguage, "MsgOSendEmail")%></td>
      </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
      <td><input type="TEXT" class="edit_input"  id=Subject  name=Subject VALUE="" SIZE=80 MAXLENGTH=255></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Content")%>:</td>
      <td><TEXTAREA id=Content  name=Content ROWS=16 COLS=80 ></TEXTAREA></td>
    </tr>
    <tr>
      <td></td>
      <td>
        <input type=SUBMIT VALUE="<%=r.getString(teasession._nLanguage, "CBSend")%>" ID="CBSend" CLASS="CB" onClick="">
</td>
    </tr>
  </table>

<SCRIPT>document.form1.To.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

