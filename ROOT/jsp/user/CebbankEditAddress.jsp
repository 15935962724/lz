<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/member/profile/EditAddress");
r.add("/tea/ui/util/SignUp1");
if(!teasession._rv.isReal())
            {
              response.sendError(403);
              return;
            }

            tea.entity.member.Profile profile;
            String memeber=teasession._rv._strR;
             profile = tea.entity.member.Profile.find(memeber);

if(request.getMethod().equals("POST"))
{
  String Email=request.getParameter("Email");
  String FirstName=request.getParameter("FirstName");
  String LastName=request.getParameter("LastName");
  boolean sex="1".equals(request.getParameter("sex"));

  profile.setEmail(Email);
  profile.setFirstName(FirstName,teasession._nLanguage);
  profile.setLastName(LastName,teasession._nLanguage);
  profile.setSex(sex);
  response.sendRedirect("/jsp/info/Succeed.jsp");
  return;
}

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBEditAddress")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <FORM name=foEdit METHOD=POST action="/jsp/user/CebbankEditAddress.jsp" onSubmit="return(submitText(this.FirstName,'<%=r.getString(teasession._nLanguage, "InvalidFirstName")%>')&&submitEmail(this.Email,'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>'));">
    <%
String nexturl=request.getParameter("nexturl");
if(nexturl!=null&&!nexturl.equals("null"))
out.println("<input type=hidden name=nexturl value="+nexturl+" />");
%>
<input type="hidden" name="community" value="<%=node.getCommunity()%>"/>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <TD><%=getNull(r.getString(teasession._nLanguage, "MemberId"))%>:</TD>
        <td><%=memeber%></td>

      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "FirstName")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=FirstName VALUE="<%=profile.getFirstName(teasession._nLanguage)%>" SIZE=20 MAXLENGTH=20></td>

      </tr>
      <tr>
       <TD><%=r.getString(teasession._nLanguage, "LastName")%>:</TD>
<td>
<input type="TEXT" class="edit_input"  name=LastName VALUE="<%=profile.getLastName(teasession._nLanguage)%>" SIZE=20 MAXLENGTH=20>
        </td></tr>
            <tr>
        <TD><%=r.getString(teasession._nLanguage, "Sex")%>:</TD>
        <td>
        <select class="BigSelect" name="sex">
          <option value="1" selected><%=r.getString(teasession._nLanguage, "Man")%></option>
          <option value="0" <%if(!profile.isSex())out.print(" selected ");%>><%=r.getString(teasession._nLanguage, "Woman")%></option>
        </select>


        </td>
      </tr>
      <tr>
      <TD><%=getNull(r.getString(teasession._nLanguage, "EmailAddress"))%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Email VALUE="<%=profile.getEmail()%>" SIZE=40 MAXLENGTH=40></td>
</tr>
    </table>

    <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </FORM>
  <SCRIPT>document.foEdit.Email.focus();</SCRIPT>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage, request)%></div>

</body>
</html>

