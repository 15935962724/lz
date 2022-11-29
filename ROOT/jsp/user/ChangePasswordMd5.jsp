<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
//if(teasession._rv==null)
//{
  //  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  //  return;
  //}
  String member = "";
  if(teasession.getParameter("member")!= null && teasession.getParameter("member").length()>0)
  {
    member = teasession.getParameter("member");

  }

  //if(!teasession._rv.isReal())
  //{
    //  response.sendError(403);
    //  return;
    //}

    Resource r=new Resource("/tea/ui/member/profile/ChangePassword");
    %>
    <html>
      <head>
        <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
        <script src="/tea/tea.js" type="text/javascript"></script>
        <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
          <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
            <META HTTP-EQUIV="Expires" CONTENT="0">
      </head>
      <body>
      <h1><%=r.getString(teasession._nLanguage, "ChangePassword")%></h1>
      <div id="head6"><img height="6" src="about:blank"></div>
        <FORM name=foChange METHOD=POST action="/servlet/ChangePassword" onSubmit="return((submitIdentifier(this.Password,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>')&&submitEqual(this.Confirm,this.Password,'<%=r.getString(teasession._nLanguage, "InvalidConfirmPassword")%>'));">
          <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>

          <input type="hidden" name="action" value="ChangePasswordMd5"/>
          <input type="hidden" name="member" value="<%=member%>">
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <TD><%=r.getString(teasession._nLanguage, "MemberId")%>:</TD>
              <td><%=member%></td>

            </tr>
            <tr>
              <TD>Email:</TD>
              <td><input type="text" name="email"  value="" /></td>

            </tr>



            <tr>
              <TD><%=r.getString(teasession._nLanguage, "NewPassword")%>:</TD>
              <td><input type="password" class="edit_input" name="Password"></td>
                <TD><%=r.getString(teasession._nLanguage, "ConfirmNewPassword")%>:</TD>
                <td><input type=PASSWORD class="edit_input" name=Confirm></td>
            </tr>
          </table>
          <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
        </FORM>
        <SCRIPT>document.foChange.OldPassword.focus();</SCRIPT>
        <div id="head6"><img height="6" src="about:blank"></div>
          <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage, request)%></div>


      </body>
    </html>

