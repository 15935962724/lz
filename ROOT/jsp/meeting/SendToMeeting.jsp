<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
String s = teasession.getParameter("To");r.add("/tea/ui/member/meeting/SendToMeeting");
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "SendToMeeting")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
  <FORM name=foSend METHOD=POST action="/servlet/SendToMeeting" ENCtype=multipart/form-data onSubmit="this.Text.value=this.Buffer.value;this.Buffer.value='';return(true);">
    <input type='hidden' name=To VALUE="<%=s%>">
<input type='hidden' name=Text VALUE="<%=s%>">

    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Text")%>:</td><td><input type="TEXT" class="edit_input"  name="Buffer" VALUE="" SIZE=60 MAXLENGTH=255>
          <input type=SUBMIT name="Submit" class="edit_button" id="edit_submit" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>" onClick="this.form.Buffer.focus();">
          <input type=BUTTON name="HangUp" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "HangUp")%>" onClick="window.location='/servlet/HangUpMeeting'"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Picture")%>:</td><td COLSPAN=6><input type="file" name="Picture" class="edit_input"/>
          <input  id="CHECKBOX" type="CHECKBOX" name=ClearPicture value=null>
          <%=r.getString(teasession._nLanguage, "Clear")%></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Voice")%>:</td><td COLSPAN=6><input type="file" name="Voice" class="edit_input"/>
          <input  id="CHECKBOX" type="CHECKBOX" name="ClearVoice" value=null>
          <%=r.getString(teasession._nLanguage, "Clear")%> <A HREF=/tea/html/0/recorder.html TARGET=_blank><%=r.getString(teasession._nLanguage, "Record")%></A></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "File")%>:</td><td COLSPAN=6><input type="file" name="File" class="edit_input"/>
          <input  id="CHECKBOX" type="CHECKBOX" name=ClearFile value=null>
          <%=r.getString(teasession._nLanguage, "Clear")%></td>
      </tr>
    </table>
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</html>

