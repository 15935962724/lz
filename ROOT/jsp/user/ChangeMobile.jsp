<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%r.add("/tea/ui/member/profile/EditAddress");
if(!teasession._rv.isReal())
            {
                 response.sendError(403);
                return;
            }
            Profile profile = Profile.find(teasession._rv._strR);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "RejiggerHandset")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">

  <FORM name=foEdit METHOD=POST ACTION="UpdateMobile.jsp" onSubmit="return(submitText(this.FirstName,'<%=r.getString(teasession._nLanguage, "InvalidFirstName")%>')&&submitText(this.LastName, '<%=r.getString(teasession._nLanguage, "InvalidLastName")%>')&&submitEmail(this.Email,'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>'));">
    <fieldset>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "MemberId")%>:</TD>
        <td><%=teasession._rv._strR%></td>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "mobile1")%>:</TD>
        <td COLSPAN=3> <input type="TEXT" class="edit_input"  name=Mobile VALUE="<%=profile.getMobile()%>" SIZE=40 MAXLENGTH=40>
        </td>
      </tr>
    </table>
	</fieldset>
    <input type=SUBMIT class="edit_button" id="edit_submit" VALUE="<%=r.getString(teasession._nLanguage, "CBSubmit")%>">
  </FORM>
  <%--=r.getString(teasession._nLanguage, "Receive")--%>
   <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>


</body>
</html>

