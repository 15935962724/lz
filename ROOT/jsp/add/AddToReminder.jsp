<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
tea.entity.RV rv = teasession._rv;

            int i = 0;

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBAddToReminder")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%
String s = request.getParameter("URI");//getRequestURI();
                boolean flag = s.endsWith("AddToReminder");
                boolean flag1 = s.substring(s.lastIndexOf("/") + 1).equals("NewReminder");
                if(flag)
                {
                    if(Reminder.isExisted(rv, teasession._nNode))
                    {
                        int l = Reminder.find(rv, teasession._nNode);
%>
        <%=r.getString(teasession._nLanguage, "AlreadyInReminders")%>
    <tr>
      <td><A HREF="/servlet/NewReminder"><%=r.getCommandImg(teasession._nLanguage, "New")%></A> <A href="/servlet/EditReminder?Reminder=<%=l%>"><%=r.getCommandImg(teasession._nLanguage, "Edit")%></A> <A href="/servlet/Reminders"><%=r.getCommandImg(teasession._nLanguage, "EditAll")%></A> <%=new Languages(teasession._nLanguage,request)%>
        <%                     return;
                    }
                    i = teasession._nNode;
                }
                if(flag1)
                    i = 0;
%>
        <FORM name=foNew METHOD=POST action="/servlet/AddToReminder" onSubmit="return(submitInteger(this.Node, '<%= r.getString(teasession._nLanguage, "InvalidNodeNumber")%>'));">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td><%=r.getString(teasession._nLanguage, "Node")%>:
                <input type="TEXT" class="edit_input"  name=Node VALUE="<%=i%>"></td>
            </tr>
            <tr>
              <td><%
                Date date2 = new Date(System.currentTimeMillis());
                Date date3 = new Date(System.currentTimeMillis() + 0x19bfcc00L);
%>
                <%=r.getString(teasession._nLanguage, "StartTime")%>: <%=new TimeSelection("Start", date2)%>
            <tr>
              <td><%=r.getString(teasession._nLanguage, "StopTime")%>: <%=new TimeSelection("Stop", date3)%>
            <tr>
              <td><%=r.getString(teasession._nLanguage, "DeltaTime")%>:
                <input type="TEXT" class="edit_input"  name=DeltaTime VALUE=0 >
                <%=r.getString(teasession._nLanguage, "Days")%> --- <%=r.getString(teasession._nLanguage, "RepeatTimes")%>:
                <input type="TEXT" class="edit_input"  name=RepeatTimes VALUE=0></td>
            </tr>
            <tr>
              <td><%=r.getString(teasession._nLanguage, "DeltaTimeRepeatTimesUsageNote")%>
            <tr>
              <td>
            <tr>
              <td><%=r.getString(teasession._nLanguage, "AlsoRemindVia")%>:
            <tr>
              <td><input id="CHECKBOX"  id="CHECKBOX" type="CHECKBOX" name=ViaMessage CHECKED>
                <%=r.getString(teasession._nLanguage, "ReminderOViaMessage")%></td>
            </tr>
            <tr>
              <td><input id="CHECKBOX"  id="CHECKBOX" type="CHECKBOX" name=ViaEmail value=null CHECKED>
                <%=r.getString(teasession._nLanguage, "ReminderOViaEmail")%>:
                <%
                tea.entity.member.Profile profile = tea.entity.member.Profile.find(rv._strV);
%>
                <input type="TEXT" class="edit_input"  name=ToEmail VALUE="<%=profile.getEmail()%>" SIZE=30></td>
            </tr>
            <tr>
              <td><%=r.getString(teasession._nLanguage, "Memo")%>:</td>
            </tr>
            <tr>
              <td><TEXTAREA name=Memo ROWS=8 COLS=60></TEXTAREA></td>
            </tr>
          </table>
          <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
        </FORM></td>
    </tr>
  </table>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</html>



