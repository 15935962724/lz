<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.ui.*"%><%@ page import="tea.db.DbAdapter"%><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

tea.entity.RV rv = teasession._rv;

Resource r=new Resource("/tea/ui/member/Glance");

java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy.MM.dd hh:mm");

int i = Reminder.count(rv);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" ></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Reminders")+"( "+i+" )"%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<div id="PathDiv"><%=TeaServlet.hrefGlance(rv) + ">" + new tea.html.Anchor("/servlet/Profile", r.getString(teasession._nLanguage, "Profile")) + ">" + r.getString(teasession._nLanguage, "Reminders")%></div>

<FORM name=foDelete METHOD=GET action="/servlet/DeleteReminders">

<%
if(i != 0)
{%>

            <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr ID=tableonetr>
        <td></td>
        <td><%=r.getString(teasession._nLanguage, "Subject")%></td>
        <td><%=r.getString(teasession._nLanguage, "StartTime")%></td>
        <td><%=r.getString(teasession._nLanguage, "StopTime")%></td>
        <td><%=r.getString(teasession._nLanguage, "DeltaTime")%>(<%=r.getString(teasession._nLanguage, "Days")%>)</td>
        <td><%=r.getString(teasession._nLanguage, "RepeatTimes")%></td>
        <td><%=r.getString(teasession._nLanguage, "Memo")%></td>
		<td></td>
      </tr>
      <%
      for(java.util.Enumeration enumeration = Reminder.find(rv); enumeration.hasMoreElements();)
      {
        int j = ((Integer)enumeration.nextElement()).intValue();
        Reminder reminder = Reminder.find(j);
        int k = reminder.getNode();
        Node node = Node.find(k);
        String s = node.getSubject(teasession._nLanguage);
%>
 <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
        <td><input  id="CHECKBOX" type="CHECKBOX" name=Reminders VALUE="<%=j%>"></td>
        <%if(s==null){%>
        <td>&nbsp;</td><%}else{%>
        <td><A href="/servlet/Node?node=<%=k%>"><%=s%></A> </td>
        <%}%>
        <td><%=sdf.format(reminder.getStartTime()) %>
        <td><%=sdf.format(reminder.getStopTime())%>
        <td><%=reminder.getDeltaTime()%>
        <td><%=reminder.getRepeatTimes()%>
        <td><%=r.getString(teasession._nLanguage, reminder.getNote())%>
        <td><input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" ID="CBEdit" CLASS="CB" onClick="window.open('/servlet/EditReminder?Reminder=<%=j%>', '_self');">
        <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID="CBDelete" CLASS="CB" onClick="window.open('/servlet/DeleteReminder?Reminder=<%=j%>', '_self');"></td>
      </tr>
      <%}
%>
    </table>
    <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID="CBDelete" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteSelected")%>')){window.open('javascript:foDelete.submit();', '_self');}">
    <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDeleteAll")%>" ID="CBDeleteAll" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteAll")%>')){window.open('/servlet/DeleteAllReminders', '_self');}">
<%
            }%>
  <input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="window.open('/servlet/NewReminder', '_self');">
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>

</html>



