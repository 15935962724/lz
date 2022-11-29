<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
if(teasession._rv == null)
{response.sendRedirect("/servlet/StartLogin");
return;}
 String s = teasession.getParameter("Member");
 %>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBPostFeedback")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">
<FORM name=foNew METHOD=POST action="/servlet/NewFeedback" ENCtype=multipart/form-data onSubmit="return(submitText(this.Subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>'));">
  <input type='hidden' name=Member VALUE="<%=s%>">
  <table cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Hint")%>:</td>
      <td><input   id="radio" type="radio" name=Hint VALUE=7 CHECKED>
        <IMG BORDER=0 SRC="/tea/image/hint/7.gif">
        <input   id="radio" type="radio" name=Hint VALUE=8>
        <IMG BORDER=0 SRC="/tea/image/hint/8.gif"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
      <td><input type="TEXT" class="edit_input"  name=Subject VALUE="" SIZE=70 MAXLENGTH=255></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
      <td COLSPAN=6><input type="file" name="Picture" class="edit_input"/>
        <input id="CHECKBOX" type="CHECKBOX" name=ClearPicture value=null>
        <%=r.getString(teasession._nLanguage, "Clear")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Voice")%>:</td>
      <td COLSPAN=6><input type="file" name="Voice" class="edit_input"/>
        <input id="CHECKBOX" type="CHECKBOX" name="ClearVoice" value=null>
        <%=r.getString(teasession._nLanguage, "Clear")%> <A HREF=/tea/html/0/recorder.html TARGET=_blank><%=r.getString(teasession._nLanguage, "Record")%></A></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "File")%>:</td>
      <td COLSPAN=6><input type="file" name="File" class="edit_input"/>
        <input id="CHECKBOX" type="CHECKBOX" name=ClearFile value=null>
        <%=r.getString(teasession._nLanguage, "Clear")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Content")%>:</td>
      <td><TEXTAREA name=Content ROWS=8 COLS=60 class="edit_input"></TEXTAREA></td>
    </tr>
  </table>
  <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
</FORM>
<SCRIPT>document.foNew.Subject.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage, request)%></div>
</body>
</html>

