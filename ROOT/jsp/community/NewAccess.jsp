<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/ui/member/community/Communities");
 String s =  request.getParameter("Community");
            if(!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(s)&&!teasession._rv.isManager(s))
            {
                 response.sendError(403);
                return;
            }


%>
<html>
<head>
<link href="/res/<%=s%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "NewAccess")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <table cellspacing="0" class="section">
    <tr>
      <td><FORM name=foNew METHOD=POST action="/servlet/NewAccess" onSubmit="return(submitText(this.Members,'<%=r.getString(teasession._nLanguage, "InvalidMemberIds")%>'));">
          <input type='hidden' name=Community VALUE="<%=s%>">
          <%=r.getString(teasession._nLanguage, "MemberId")%>:
          <input type="TEXT" class="edit_input"  name=Members>
          <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
        </FORM></td>
    </tr>
  </table>
  <SCRIPT>document.foNew.Members.focus();</SCRIPT>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>


