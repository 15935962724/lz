<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
tea.entity.RV rv = teasession._rv;
int i = Integer.parseInt(request.getParameter("Reminder"));
Reminder reminder = Reminder.find(i);
int l = reminder.getNode();
Node node2 = Node.find(l);
String s1 = node2.getSubject(teasession._nLanguage);
java.util.Date date2 = reminder.getStartTime();
java.util.Date date3 = reminder.getStopTime();
Profile profile = Profile.find(rv._strV);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBAddToReminder")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name=foEdit METHOD=POST action="/servlet/EditReminder" onSubmit="return(submitInteger(this.Node, '<%=r.getString(teasession._nLanguage, "InvalidNodeNumber")%>'));">
  <input type='hidden' name=Reminder VALUE="<%=i%>">
  <input type='hidden' name=Node VALUE="<%=l%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><A href="/servlet/Node?node=<%=l%>"><%=getNull(s1)%></A> <%=r.getString(teasession._nLanguage, "Node")%>=<%=l%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "StartTime")%>:<%=new TimeSelection("Start", date2)%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "StopTime")%>:<%=new TimeSelection("Stop", date3)%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "DeltaTime")%>:
        <input type="TEXT" class="edit_input"  name=DeltaTime VALUE="<%=reminder.getDeltaTime()%>">
        <%=r.getString(teasession._nLanguage, "Days")%> --- <%=r.getString(teasession._nLanguage, "RepeatTimes")%>:
        <input type="TEXT" class="edit_input"  name=RepeatTimes VALUE="<%=reminder.getRepeatTimes()%>"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "DeltaTimeRepeatTimesUsageNote")%> </td>
    </tr>
    <tr>
      <td><br/></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "AlsoRemindVia")%>:</td>
    </tr>
    <tr>
      <td><input  id="CHECKBOX" type="CHECKBOX" name=ViaMessage value=null <%=getCheck((reminder.getOptions() & 2) != 0)%>>
        <%=r.getString(teasession._nLanguage, "ReminderOViaMessage")%></td>
    </tr>
    <tr>
      <td><input  id="CHECKBOX" type="CHECKBOX" name=ViaEmail value=null <%=getCheck((reminder.getOptions() & 4) != 0)%>>
        <%=r.getString(teasession._nLanguage, "ReminderOViaMessage")%>:
        <input type="TEXT" class="edit_input"  name=ToEmail VALUE="<%=reminder.getToEmail()%>"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Memo")%>:</td>
    </tr>
    <tr>
      <td><TEXTAREA name=Memo ROWS=8 COLS=60><%=HtmlElement.htmlToText(r.getString(teasession._nLanguage, reminder.getNote()))%></TEXTAREA>
      </td>
    </tr>
  </table>
  <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
</form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>



